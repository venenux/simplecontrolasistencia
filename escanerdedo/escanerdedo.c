/*
 * Copyright (c) 2013 PICCORO Lenz McKAY <mckaygerhard@gmail.com>
 * escanerdedo.c backend for enroll or verify per one finger at time
 * the purpose its to put in filesystem the data as offer to 
 * then a fronend will catch this and link agains one id per user.
 * 
 * This software are permit to copy and modify only if this header copyright
 * its include complety and cited the original author as original maker.
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fprint.h>	/* inclusion de libfprint, ojo deben tener el repo venenux y libfprint-dev instalado */
#include <sys/types.h>	/* inclusion para manejo de ids de dispositivos */

#define DIR_MIO_JODA 0750
typedef int bool;
#define TRUE 1
#define FALSE 0

/** main tiene soporte de argumentos, se usara para manejo de linea de comandos mas adelante */
int main(int argc, char **argv)
{
	char *nombreimagen = "noencontrado.pgm";
	char *numerodedo = "1"; /* LEFT THUMB ; pulgar izquierdo */
	int operacion = 0;
	bool interfaz = FALSE;
	bool dummy = FALSE;
	bool dejarpasar = FALSE;

	int devresult = 1; /* usaremos esto para marcar el estado de nuestro dispositivo usandose */
	int prg_sts = 1; /* estado en que se esta el programa, asume todo malo, se verifica en el camino todo */

	devresult = fp_init();/* inicializacion de la libreria, carga de objetos y corroboracion de dispositivos posibles */
	if ( devresult < 0 ) /* libreria mal enlazada o no esta instalado libfprint, instalarla con aptitude install libfprint-dev */
	{
		fprintf(stderr,"error");
		exit (99);
	}

/*	fp_set_debug (3);  */

	int argnm; /* manejo excluyente de argumentos, cada argumento es independiente, no dependiente */
	for(argnm = 1; argnm < argc; argnm++) /* variables de argumentos desde main */
	{
		if( strcmp(argv[argnm],"help") == 0 || strcmp(argv[argnm],"ayuda") == 0) /* imprime ayuda */
			operacion = -1;
		if( strcmp(argv[argnm],"identify") == 0 || strcmp(argv[argnm],"identificar") == 0) /* escupe a consola que hay y como estara */
			operacion = 0;
		if( strcmp(argv[argnm],"enroll") == 0 || strcmp(argv[argnm],"enrolar") == 0) /* si pasa enroll la operacion se define en 1 para "operacion" */
			operacion = 1;
		if( strcmp(argv[argnm],"verify") == 0 || strcmp(argv[argnm],"verificar") == 0) /* si pasa verify la operacion se define en 2 para "operacion" */
			operacion = 2;
		if( strcmp(argv[argnm],"image") == 0 || strcmp(argv[argnm],"nombreimagen") == 0 ) /* si pasa image el siguiente es el nombre de esta*/
			nombreimagen = argv[argnm+1];
		if( strcmp(argv[argnm],"finger") == 0 || strcmp(argv[argnm],"dedo") == 0 ) /* si pasa image el siguiente es el nombre de esta*/
			numerodedo = argv[argnm+1];
		if( strcmp(argv[argnm],"path") == 0 || strcmp(argv[argnm],"ruta") == 0) /* imprime ruta en una sola linea */
			operacion = 3;
		if( strcmp(argv[argnm],"frontend") == 0 || strcmp(argv[argnm],"interfaz") == 0) /* imprime info por linea, la info sale en mismo orden que sin interfaz, pero sin adornos */
			interfaz = TRUE;
		if( strcmp(argv[argnm],"dummy") == 0 || strcmp(argv[argnm],"postizo") == 0) /* modo engaño, emula un dispositivo, en realidad devuelve siempre evirifado/enrolado exitoso */
			dummy = TRUE;
		if( strcmp(argv[argnm],"dummysts") == 0 || strcmp(argv[argnm],"postizoest") == 0) /* si modo engaño, con el siguiente argumento se le dice si aceptado o rechazado */
			dejarpasar = argv[argnm+1];
	}/* me paseo por los argumentos pasados, y asigno setgun la palabra encontrada */

	int dedousado = LEFT_THUMB; /* por defecto usamos/asignamos a libfprint dedo pulgar izquierdo */
	if( strcmp(numerodedo,"1") == 0) dedousado = LEFT_THUMB;
	if( strcmp(numerodedo,"2") == 0) dedousado = LEFT_INDEX;
	if( strcmp(numerodedo,"3") == 0) dedousado = LEFT_MIDDLE;
	if( strcmp(numerodedo,"4") == 0) dedousado = LEFT_RING;
	if( strcmp(numerodedo,"5") == 0) dedousado = LEFT_LITTLE;
	if( strcmp(numerodedo,"6") == 0) dedousado = RIGHT_THUMB;
	if( strcmp(numerodedo,"7") == 0) dedousado = RIGHT_INDEX;
	if( strcmp(numerodedo,"8") == 0) dedousado = RIGHT_MIDDLE;
	if( strcmp(numerodedo,"9") == 0) dedousado = RIGHT_RING;
	if( strcmp(numerodedo,"10") == 0) dedousado = RIGHT_LITTLE;

	

	struct fp_dscv_dev **dispositivosposibles; /* arreglo de estrucutra que representa dispositivos scaners */
	dispositivosposibles = fp_discover_devs (); /* invoco libfprint a que busque los readers de dedos */
	if ( !dispositivosposibles ) /* libreria enlazada pero usb de computadora malo, o no encontro dispositovos conectados */
		exit (1);


	struct fp_dscv_dev *disposivouno; /* estructura que define dispositivo valido */
	if ( dummy == FALSE )
	{
		disposivouno = dispositivosposibles[0]; /* seleccionado el primer dispositivo de todos los encontrados */
		if ( !disposivouno ) /*libreria enlazada, usb bueno, pero dispositivo 1 no valido, o el seleccionado primero no sirve */
			dummy = TRUE;
	}

	struct fp_dev *dispositivo; /* representar el dispositivo a manejar en el codigo */
	if ( dummy == FALSE )
	{
		dispositivo = fp_dev_open (disposivouno); /* representacion del dispositivo usandose */
		if ( !dispositivo ) /* dispositivo encontrado, pero esta bloqueado, libusb no maneja asincronos eventos */
			dummy = TRUE;
	}

	struct fp_driver *dvc; /* abstraccion especifica del dispositivo, en el OS */
	if ( dummy == FALSE )
	{
		dvc = fp_dscv_dev_get_driver ( disposivouno ); /* identificacion del dispositivo (opcional) */
		fp_dscv_devs_free( dispositivosposibles ); /* ya tengo el scaner, limpio el bus usb con toda la info anterior recopilada */
	}

	uint16_t dvcid;
	char dvcidname[32];		/* este se requiere despues, para detectar la ruta de guardado de data */
	if ( dummy == FALSE )
	{
		dvcid = fp_driver_get_driver_id (dvc); /* obtenemos el id del "driver" del dispositivo */
		sprintf (dvcidname, "%04X", dvcid); /* el formato para el id del driver es de 4 digitos en la ruta*/
	}
	else
		sprintf (dvcidname, "%04X", 99); /* el formato para el id del driver es de 8 digitos en la ruta*/

	uint32_t dvcnu;
	char dvcidtype[64];		/* este se requiere despues, para detectar sub ruta de guardado de data */
	if ( dummy == FALSE )
	{
		dvcnu = fp_dev_get_devtype (dispositivo); /* obtenemos el id del tipo de dispositivo */
		sprintf (dvcidtype, "%08X", dvcnu); /* el formato para el id del driver es de 8 digitos en la ruta*/
	}
	else
		sprintf (dvcidtype, "%08X", 99); /* el formato para el id del driver es de 8 digitos en la ruta*/

	unsigned char *dvcname; /* para informamos el nombre, id y devtype del dispositivo si encontramos uno */
	if ( dummy == FALSE )
		dvcname = fp_driver_get_full_name(dvc); /* opcional: ver el nombre del scaner humanamente */
	else
		dvcname = "Dummy/Falso Quien carizo eres tu finger/dedo scaner 0000";

	struct fp_print_data *data_deo_tempo = NULL; /* reservo otro lugarcito para datos de manejo */
	int r_img; /* usado para flag de resultado del operacion de imagen */
	int r_dat; /* usado para flag status de resultado operacion data */	


	if ( operacion == -1 ) /* opcion saber como usar esta vaina */
	{
		fprintf(stderr, "uso: <comando> <accion> [nombreimagen [<ruta_comp_con_nombreimagen>.pgm]] [dedo <numero>]  [postizo [postizoest]]\n");
		fprintf(stderr, "usage: <command> <action> [image [<abs_path_with_imagename>.pgm]] [finger <number>] [dummy [dummysts TRUE/FALSE]]\n");
		fprintf(stderr, "\n");
		fprintf(stderr, "actions: enroll, verify, path, frontend\n");
		fprintf(stderr, "acciones: enrolar, verificar, ruta, interfaz\n");
		fprintf(stderr, "finger: 1 Lefth thum to 5 lefth little and so right\n");
		fprintf(stderr, "dedo: 1 izqu pulgar a 5 izqu pequeño y asi derecha\n");
		fprintf(stderr, "\n");
		fprintf(stderr, "escanerdedo v 1.0 for simpleasistencia on VenenuX, made by PICCORO Lenz MCKAY\n");
		exit(prg_sts);
	}

	if ( operacion == 3 ) /* opcion saber la ruta del id de la db del dispositivo */
		if ( interfaz )
			fprintf(stderr,".fprint/prints/%s/%s/",dvcidname, dvcidtype);
		else
			fprintf(stderr,"[archivos]\nruta=.fprint/prints/%s/%s/\n",dvcidname, dvcidtype);
	

	if ( operacion == 0 || operacion == 1 || operacion == 2 )/* dependiendo de la operacion, definimos que vamos a hacer */
	{
		prg_sts=0; /* si pido 0 o 1, sale con exito siempre, sino cambia esta variable a un error*/

		if ( operacion == 0 ) /* opcion quiero info del dispositivo */
			if ( interfaz )
				fprintf(stderr,"%s\n%s\n%s\n", dvcname, dvcidname, dvcidtype );
			else
				fprintf(stderr, "[dispositivo]\nnombre=%s\nid=%s\ntipo=%s\n", dvcname, dvcidname, dvcidtype );
		
		if ( operacion == 0 || operacion == 1 || operacion == 2 ) /* opcion info completa en el resto de las operaciones */
			if ( interfaz )
				fprintf(stderr,".fprint/prints/%s/%s/\n%s\n.fprint/prints/%s/%s/%d\n",dvcidname, dvcidtype,nombreimagen, dvcidname, dvcidtype, dedousado);
			else
				fprintf(stderr,"[archivos]\nruta=.fprint/prints/%s/%s/\nnombreimagen=%s\nrutafiledata=.fprint/prints/%s/%s/%d\n",dvcidname, dvcidtype,nombreimagen, dvcidname, dvcidtype, dedousado);
		
		if ( operacion == 1 && dummy == FALSE )
		{
			do /* metemos un bucle para que espere por el escaneo una vez prendido */
			{
				struct fp_img *img = NULL; /* reservo un lugar para manejar la imagen, una fotico de la victima */

					/* enrollar=guardar huella despues de almacenarla, por ende chekeo r_img */
				r_img = fp_enroll_finger_img ( dispositivo, &data_deo_tempo, &img ); /* en este punto se enciende el dispositivo  */
				if ( r_img < 0 )
				{
					if ( interfaz )
						fprintf(stderr,"%d",r_img);
					else
						fprintf(stderr,"[error]\nsalida=%d\n",r_img);
					exit(r_img);
				}
				r_dat = fp_print_data_save ( data_deo_tempo, dedousado );
				if(img) /* despues de escanear, libfprint maneja el device, si guardo algo, img no es nulo */
				{
					fp_img_save_to_file ( img, nombreimagen);
					fp_img_free (img);
					if ( interfaz == FALSE )
						fprintf(stderr,"[imagen]\nnombre=%s\n",nombreimagen);
				}
				/* la variable img, su ubicacion en ram tendra datos y no sera nula si todo fue bien */
				/* r guarda el resultado de la operacion, haya escaneado o no la imagen */
				switch (r_img)
				{
					case FP_ENROLL_COMPLETE:
						if ( interfaz )
							fprintf(stderr,"TRUE\n0\n");
						else
							fprintf(stderr, "[enroll]\nstatus=TRUE\n[error]\nsalida=0\n");
						prg_sts = 0;
						break;
					default: /* hay mas casos pero por motivos didacticos estos son suf */
						prg_sts = r_img;
						if ( interfaz )
							fprintf(stderr,"FALSE\n%d\n",r_img);
						else
							fprintf(stderr, "[enroll]\nstatus=FALSE\n[error]\nsalida=%d\n",r_img);
						break;
				}
				if(r_dat<0) 
				{
					fp_print_data_free ( data_deo_tempo );
					fp_dev_close(dispositivo);
					fp_exit ();
				}

			}
			while( r_img!= FP_ENROLL_COMPLETE ); /* el dispositivo estara esperando el dedo hasta exito o el break del case */
		}
		if ( operacion == 1 && dummy == TRUE )
		{
			if ( interfaz )
				fprintf(stderr,"TRUE\n0\n");
			else
				fprintf(stderr, "[imagen]\nnombre=%s\n[enroll]\nstatus=TRUE\n[error]\nsalida=0\n",nombreimagen);
			prg_sts = 0;
		}

		if ( operacion == 2 && dummy == FALSE )
		{
			do
			{
				struct fp_img *img = NULL; /* reservo un lugar para manejar la imagen, una fotico de la victima */

				/* verificar=retomar huella despues de almacenarla, por ende chekeo r_dat */
				r_dat = fp_print_data_load ( dispositivo, dedousado, &data_deo_tempo );
				if ( r_dat != 0 )
				{
					if ( interfaz )
						fprintf(stderr,"%d\n",r_dat);
					else
						fprintf(stderr,"[error]\nsalida=%d\n",r_dat);
					exit(r_dat);
				}
				r_img = fp_verify_finger_img ( dispositivo, data_deo_tempo, &img ); /* verifico .fprint/<id>/<device>/CUALQUIERDEDO */
				/* la variable img, su ubicacion en ram tendra datos y no sera nula si todo fue bien */
				/* r guarda el resultado de la operacion, haya escaneado o no la imagen */
				if(img) /* despues de escanear, libfprint maneja el device, si guardo algo, img no es nulo */
				{
					fp_img_save_to_file ( img, nombreimagen);
					fp_img_free (img);
					if ( interfaz == FALSE )
						fprintf(stderr,"[imagen]\nnombre=%s\n",nombreimagen);
				}
				switch (r_img)
				{
					case FP_VERIFY_MATCH:
						prg_sts = 0;
						if ( interfaz )
							fprintf(stderr,"TRUE\n0\n");
						else
							fprintf(stderr, "[verify]\nstatus=TRUE\n[error]\nsalida=0\n");
						break;
					default: /* hay mas casos pero por motivos didacticos estos son suf */
						prg_sts = r_img;
						if ( interfaz )
							fprintf(stderr,"FALSE\n%d\n",r_img);
						else
							fprintf(stderr, "[verify]\nstatus=FALSE\n[error]\nsalida=%d\n",r_img);
						break;
				}
				if(r_dat<0) 
				{
					fp_print_data_free ( data_deo_tempo );
					fp_dev_close(dispositivo);
					fp_exit ();
				}
			}
			while(0);
		}
		if ( operacion == 2 && dummy == TRUE )
		{
			if ( interfaz )
				fprintf(stderr,"TRUE\n0\n");
			else
				fprintf(stderr, "[imagen]\nnombre=%s\n[verify]\nstatus=TRUE\n[error]\nsalida=0\n",nombreimagen);
			prg_sts = 0;
		}

	}

	if ( dummy == FALSE )
		fp_dev_close(dispositivo);

	fp_exit ();	/* salida */
	
	return (prg_sts);

}
