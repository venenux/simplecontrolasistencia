Simple Control de Asistencia
============================

Introduccion y descripcion
--------------------------

Control, simple, de asistencia, descentralizado, en X windows.

Notese estas 3 palabras:
* control
* simple
* asistencia
Agrege esta palabra clave:
* descentralizado

Ningun sistema en el mercado es simple, que controle, y menos de asistencias; 
esto es logico, no justifica el dinero que cobran las empresas.
Ninguno es descentralizado, sino como se cobrarian las licencias o 
en el mejor de los casos, tienen mucha depndencias en motores de base de datos 
lo que ayuda a justificar consultoria y cobros en soporte tecnico externo.


More info/Mas info
------------------

En la wiki, tambien resumido en este archivo:

Main laguaje are spanish/Lenguaje principal es español.

* [docs/README.md] (docs/README.md)

Instrucciones de Desarrollo
--------------------------

Para usar el gui en gambas3 (scanersimplegui.class ) :

1. `mkdir ~/Devel & cd ~/Devel`
2. `git clone https://github.com/venenux/simplecontrolasistencia.git; cd simplecontrolasistencia` 
3. `aptitude install gambas3`
4. abra el ide `gambas3`
5. busque el proyecto, esto solo con encontrar el directorio donde descargo este fuente
6. revise el codigo, debe cambiar la ruta del ejecutable en la funcion "scan_dedo_imagen" 
6.1. cambielo por la ruta exacta donde esta el compilado anterior de c
7. en "proyecto" puede generar un tarbal o ejecutable gambas

**NOTA:** para usar el captahuella se requiere el subdirectorio `scanerdedo` tener compilado el ejecutable, para mas informacion acerca del programa que capta la huella `scanerdedo` visite el proyecto https://github.com/venenux/scanersimple

Caracteristicas
---------------

* tolerante a fallos, puede caerse o apagarse o tumbarse, 
  siempre levantara desde donde quedo, dado no depende de 
  un pesado y stupido motor externo e base de datos, abstrayendo 
  su simplicidad al maximo
* guarda en base de datos local, lo qu lo hace simple, 
  dado implica que cualquier imbecil en el sitio puede inicarsele 
  si no dipone de internet o red, que copie el archvio y lo entrege, 
  sea por correo, por usbdrive, o clocandolo en una intranet.
* trabaja autonomamente, indeendiente de sistema central, 
  lo que significa que siempre seguira funcionando, no importando 
  si nadie le da mantenimiento, seguira administrandose solo, guardando 
  el hitorico dia por dia, segun los ultimos datos de usuarios/trabajadores 
  sin excusas por parte de estos, ya que algun dia se revisaran estos
  registros.


Componentes
------------------------

1) escanerdedo

Linea de comandos, actua como capturador de la huella dactilar, 
es el principal componente, si bien no el mas usable y comodo; 
captura la huella, asi como verifica la misma, esto siempre 
informa de las operaciones realizadas a la salida estandar de error.
Para mas informacion visite el proyecto original https://github.com/venenux/scanersimple 
del cual se basa este pequeño programa `scanerdedo`.

2) interfaztomarasistencia

Cliente grafico, programa que maneja ordenadamente segun la captura dactilar, 
es el componente que interactua con el usurio/trabajador, con opcion de foto; 
emplea la linea de comandos, y opcionalmente un camara web de maenra auxiliar; 
toma la foto y la data de la huella dactilar mediante la informacion 
que le suministra la linea de comandos, y l administra en DB local, 
el usuario siempre mete su id, y mediante esto busca en la DB, 
encontrado la data del id, coloca este en disco donde la libreria espera encontrar, 
invoca la linea de comandos y con a data en su lugar verifica segun el id, 
terminado, remueve la dta del lugar y sigue con otro id.
La camara web y la foto son en caso de que no este un dispositivo escaner 
por lo que se emul este y se emplea la foto con auditoria, permitiendo 
que el proceso de asistencia nunca se detenga.

3) administradorasistencia

Interfaz (web?) grafica, los datos del cliente grafico se envian a un nodo, 
en este nodo estara un servicio de base de datos postgres/mariadb, y 
un programa grafico que toma los archivos exportados y lo procesa dentro, 
este programa emite reportes simples y prepara expotaciones hacia otros sistemas.


Estatus:
========

Listo:
* linea de comandos, modo emulado y retorno de infomacin en toda operacion.
* interfaz grafica, modo camara listo, modo escanedo aun no teminado, replicacion en progreso

Por terminar:
* interfaz grafica, modo replicacion y administracion para enrolamiento
* interfaz adminisracion: falta todo, pero el sistema puede funcionar sin el exportando a saint a mano.


Requisitos e instalacion
=======================

requisitos de software:
-----------------------

os:
* debian, venos o arch, sin multiarch o sin multiarquitectura
* linux, kernel 2.6.30 como minimo con soporte v4l2

linea de comandos:
* libc6 >= 2.6.3
* libfprint >= 0.5.0

interfaz grafica:
* gambas3 >= 3.4.0
* libfprint >= 0.5.0
* bash >= 3.1
* v4l2
* gstreamer >= 0.10.29
* sqlite >= 3.5
* archivo dummy en /tmp

interfa administrativa
* postgresql >= 9.1
* bash >= 3.1


requisitos de hardware:
-----------------------

* cpu x86: intel o geode x86, se uso especialmente un daruma MT1000
* escaner dactilar (escaner finger print), preferible U.are.U serie 4XXX
* camara web, cualquier camara compatible con v4l2 solamente


Instalacion
-----------

en la raiz del proyecto:
make all
esto colocara el comando backend y la interfaz en la raiz

para usarlos, el comendo backend autodetecta el hardware, si no hay hardware, lo emula
la interfaz autodetecta camara y su backend, si algo falla lo deberia notificar.

la interfaz llama el backend comando en /usr/bin, sino en su raiz de proyecto, 
la interfaz llama el backend y trata de escanear la huella, al mismo tiempo que tira una foto, 
el dispositivo al escanear la huella crea los ficheros y la interfaz los manipula,
verifica la ruta, y si esta en modo emulacion creo no crea el directorio asi que revisar esto.
