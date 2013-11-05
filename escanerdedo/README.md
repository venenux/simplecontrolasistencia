# escanerdedo.c
===============

Dado el manejo de la libreria "libfprint" no es sencillo, se opto por separar la captura de la huella, 
el backend captura la huella, y coloca los archivos necesario en disco (he aqui su punto negativo: 
operaciones I/O).

## Invocacion y funcionamiento
-----------------------------

Tiene cuatro funciones especificas, y funciona en dos tipos de modo (respecto la salida).

#### Modos de funcionamiento

* normal : al efectuar cualquier operacion, escupe en la salida de consola informacion preformateada.

    escanerdedo  
    [dispositivo]  
    nombre=Digital Persona U.are.U 4000/4000B/4500  
    id=0002  
    tipo=00000000  
    [archivos]  
    ruta=.fprint/prints/0002/00000000/  
    nombreimagen=noencontrado.pgm  
    rutafiledata=.fprint/prints/0002/00000000/1  


* interfaz/interface : agregando "interface" a la invocacion, escupe informacion sin formato alguno.


    escanerdedo interfaz  
    Digital Persona U.are.U 4000/4000B/4500  
    0002  
    00000000  
    .fprint/prints/0002/00000000/  
    noencontrado.pgm  
    .fprint/prints/0002/00000000/1  


#### Funciones de invocacion

* path/ruta : al añadirle esto a la linea de comandos, el programa solo mostrara la ruta de donde se 
guardan los datos y salira con codigo error exitoso.
* enroll/enrolar : al añadir esto a la linea de comandos, el programa encendera el dispositivo de 
escaneo de huella para **captar y registrar** una huella dactilar, el resultado sera almacenado en la 
ruta especificada por la funcion "path" o "ruta" descrita anteriormente.
* verify/verificar : al añadir esto a la linea de comandos, el programa encendera el dispositivo de 
escaneo de huella para **verificar y comprobar** la huella dactilar  **previa**, debe estar el 
resultado previo de la captacion almacenado en la ruta especificada por la funcion "path" o "ruta" 
descrita anteriormente.
* finger/dedo : al agregar esto a cualquiera de las dos funciones anteriores en la linea de comandos, 
se le estara especificando que dedo se esta corroborando o captando: 1 es pulgar a 5 meñique y asi.


    escanerdedo verify nombreimagen ~/mydedo.pgm dedo 3  
    [archivos]  
    ruta=.fprint/prints/0002/00000000/ 
    nombreimagen=/home/systemas/mydedo.pgm  
    rutafiledata=.fprint/prints/0002/00000000/3  
    [error]  
    salida=-2  

#### Respuestas en la salida

* 0 : exitoso
* -2 : invalido, ejemplo se intenta verificar y no se ha captado huella aun (hoy hay ningun archivo de 
huella dactialr en la ruta)
* -1 : configuracion invalida o ruta invalidad.
* otro : error de libreria, revisar libfprint.

## Funcionamiento tecnico:
--------------------------

Se empleo llamadas sencillas a la libreria libfprint, simplemente se realizan cuatro fases, 
verificacion, reconocimiento, trabajo encomentado (verificar, enrolar o mostrar), y clausura.

* Verificacion: se realiza llamada a open de la libreria, si error, el programa no sigue, igual da 
error si esta enlazado dinamicamente.
* reconocimiento: una vez cargada la libreria se accede y abre el dispositivo, se verifica sus 
capacidades, y este soportado, responda y en caso exito prosige, sino devuelve error y sale.
* encomendacion: aqui segun los comandos o argumentos añadidos a la linea de comandos, se realiara la 
logica de las lineas subyacentes.
* clausura: en cualquier caso se intenta cerrar tanto el dispositivo asi como destruir el espacio en 
ram y la inicializacion de la libreria liberando todo componente empleado.


