
DROP TABLE IF EXISTS asistencia_usuarios_aps_export ; -- para exportar usuarios que interactuan con nomina sin restricciones
CREATE TABLE asistencia_usuarios_aps_export (
  usuario VARCHAR(20) NOT NULL , -- usuario del sistema correspondiente a la tienda/tiponomina
  password VARCHAR(20) NOT NULL DEFAULT 'S' , -- clave en texto claro..
  tiponomina VARCHAR(20) NULL , -- numero de nomina que pertenece, en el antiguo es el nombre de la db
  descripcion VARCHAR(80) NULL , -- generalmente deberia ser abrebiatura del ubicacion (nombre de galpon/tienda)
  modulo VARCHAR (20) NULL,  -- no documentado, parche de lso enteipadores
  Totalizador VARCHAR(20) NULL,  -- no documentado, parche de lso enteipadores
  GeneradorTxt VARCHAR(20) NULL,  -- no documentado, parche de lso enteipadores
  PEstancia VARCHAR(20) NULL,  -- no documentado, parche de lso enteipadores
  fec_actualizacion DATE NOT NULL, -- fecha en que se altero los datos de esta tabla por ultima vez
  cod_usuario VARCHAR(20) NULL DEFAULT 'systemas' , -- codigo/usuario que altero los datos por ultima vez
  PRIMARY KEY (usuario,tiponomina) ); -- posiblemente puede existir mismo usuario atendiendo dos nominas... 


DROP TABLE IF EXISTS asistencia_usuarios_tiendas_export; -- para exportar usuarios pichacheros sin privilegios sino poquitos...
CREATE TABLE asistencia_usuarios_tiendas (
  usuario VARCHAR(20) NOT NULL , -- usuario del sistema correspondiente a la tienda/tiponomina
  password VARCHAR(20) NOT NULL DEFAULT 'S' , -- clave en texto claro..
  tiponomina VARCHAR(20) NULL , -- numero de nomina que pertenece, en el antiguo es el nombre de la db
  descripcion VARCHAR(80) NULL , -- generalmente deberia ser abrebiatura del ubicacion (nombre de galpon/tienda)
  fec_actualizacion DATE NOT NULL, -- fecha en que se altero los datos de esta tabla por ultima vez
  cod_usuario VARCHAR(20) NULL DEFAULT 'systemas' , -- codigo/usuario que altero los datos por ultima vez
  PRIMARY KEY (usuario,tiponomina) ); -- posiblemente puede existir mismo usuario atendiendo dos nominas... 


DROP TABLE IF EXISTS ConsolidadoTemp_export; -- exportacion de personal (aprox 36mil registros enpromedio deberia venir)
CREATE TABLE ConsolidadoTemp_export (
  TIPNOM  VARCHAR(60)  DEFAULT NULL, -- tipo de nomina o nombre de DB en sain a que pertenece
  CODSUC  VARCHAR(60)  DEFAULT NULL, -- codgo interno 
  CODGER  VARCHAR(60)  DEFAULT NULL, -- codigo de la gerencia a la cual le trabaja, su descripcion es unidad
  CODDEP  VARCHAR(60)  DEFAULT NULL, -- codigo del departamento en saint altenece
  FICHA VARCHAR(10) NULL DEFAULT NULL, -- cedula sin el simbolo de nacionalidad
  NOMBRES VARCHAR(60) NULL DEFAULT NULL, -- nombre
  APELLIDOS VARCHAR(60) NULL DEFAULT NULL, -- apellido
  NOMBREEGEO1 VARCHAR(60) NULL DEFAULT NULL, -- 
  ESTADO VARCHAR(60) NULL DEFAULT NULL, -- activo, inactivo, suspendido, vacaciones
  Modalidad VARCHAR(60) NULL DEFAULT NULL, -- casa, base, periodo prueba, temporal
  Turno VARCHAR(60) NULL DEFAULT NULL, -- manana tarde noche, fin semana... 
  Cedula VARCHAR(12) NULL DEFAULT NULL, -- cedula con el simbolo de nacionalidad separado popr guion
  Cedu  VARCHAR(60)  DEFAULT NULL, -- ?¿?¿? cedula? otro teipe
  ApeNomC VARCHAR(60) NULL DEFAULT NULL, -- "eso es pa unos repoltes" egun el enteipador veloz
  fec_actualizacion DATE NOT NULL, -- fecha en que se altero los datos de esta tabla por ultima vez
  cod_usuario VARCHAR(20) NULL DEFAULT 'systemas' , -- codigo/usuario que altero los datos por ultima vez
  PRIMARY KEY (FICHA,TIPNOM) ); -- posiblemente puede existir mismo usuario atendiendo dos nominas... 

DROP TABLE IF EXISTS asistencia_saint; --Tabla donde se guardan las asistencias diarias de todo el personal 
CREATE TABLE asistencia_saint(
  ficha varchar (10) NULL default NULL, -- ficha es la cedula en saint 
  codger integer NULL default NULL, -- codigo de ubicacion saint
  fecha_asistencia DATE NULL default NULL, -- fecha del dia de la asistencias 
  estado_asist integer  NULL default NULL, -- estado en que se encuentra el empleado asistente, inasistente, 1/2 dia.
  auto serial NOT NULL, -- indice autonumerico que solo sirver para eliminaciones masivas
  workin integer NULL default NULL, -- hora de entrada al trabajo en formato militar 
  lunchout integer NULL default NULL, -- hora de salida al almuerzo en formato militar
  luchin integer NULL default NULL, -- hora de regreso de almuerzo en formato militar
  workout integer NULL default NULL, -- hora de salida del trabajo
  tipo_nomina varchar (10) NULL default NULL, -- tipo de nomina a la que pertenece el trabajador.
  PRIMARY KEY(ficha,codger,fecha_asistencia) -- llave primaria
  );
