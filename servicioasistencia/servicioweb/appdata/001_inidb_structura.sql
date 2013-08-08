-- Area_Trabajo: campos codger y unidad.
DROP TABLE IF EXISTS PUBLIC.sysasis_areatrabajo;
CREATE TABLE public.sysasis_areatrabajo(
  cod_areatrabajo VARCHAR(20) NOT NULL , -- codger, codigo en saint que identifica  la gerencia
  codger VARCHAR(20) , -- codger, tal caul viene de saint sin agregacion de ceros izquierda
  des_areatrabajo VARCHAR(80) NOT NULL , -- unidad, departamento/rama a que pertenece 
  fec_actualizacion DATE DEFAULT NOW() , -- fecha en que se altero los datos de esta tabla por ultima vez
  cod_usuasys VARCHAR(20) DEFAULT 'systemas', -- codigo/usuario que altero los datos por ultima vez
  PRIMARY KEY (cod_areatrabajo) );
--Responsable: campos codsuc y compania.
DROP TABLE IF EXISTS PUBLIC.sysasis_responsable;
CREATE TABLE PUBLIC.sysasis_responsable (
  cod_responsable VARCHAR(20) NOT NULL , -- codsuc, codigo en saint que identifica  la sucursal
  codsuc VARCHAR(20) , -- codsuc, tal caul viene de saint sin agregacion de ceros izquierda
  des_responsable VARCHAR(80) NOT NULL , -- compania,compañia donde trabaja 
  fec_actualizacion DATE DEFAULT NOW() , -- fecha en que se altero los datos de esta tabla por ultima vez
  cod_usuasys VARCHAR(20) DEFAULT 'systemas', -- codigo/usuario que altero los datos por ultima vez
  PRIMARY KEY (cod_responsable) );
--Grupo_regional: campos coddir y gerencia.
DROP TABLE IF EXISTS PUBLIC.sysasis_gruporegional;
CREATE TABLE PUBLIC.sysasis_gruporegional(
  cod_gruporegional VARCHAR(20) NOT NULL , -- coddir,codigo en saint que identifica  la región 
  coddir VARCHAR(20) , -- coddir, tal caul viene de saint sin agregacion de ceros izquierda
  des_gruporegional VARCHAR(80) NOT NULL , -- gerencia, gerencia a al cual pertenece el empleado 
  fec_actualizacion DATE DEFAULT NOW() , -- fecha en que se altero los datos de esta tabla por ultima vez
  cod_usuasys VARCHAR(20) DEFAULT 'systemas', -- codigo/usuario que altero los datos por ultima vez
  PRIMARY KEY (cod_gruporegional) );
--Modo_Trabajo_empresa: campos coddep y modalidad.
DROP TABLE IF EXISTS PUBLIC.sysasis_modotrabajo;
CREATE TABLE PUBLIC.sysasis_modotrabajo(
  cod_modotrabajo VARCHAR(20) NOT NULL , --coddep, codigo en saint que identifica  el departamento
  coddep VARCHAR(20) , -- coddep, tal caul viene de saint sin agregacion de ceros izquierda
  des_modotrabajo VARCHAR(80) NOT NULL , -- modalidad, departamento/rama a que pertenece 
  fec_actualizacion DATE DEFAULT NOW() , -- fecha en que se altero los datos de esta tabla por ultima vez
  cod_usuasys VARCHAR(20) DEFAULT 'systemas', -- codigo/usuario que altero los datos por ultima vez
  PRIMARY KEY (cod_modotrabajo) );
--Cargo: campos codcargo y cargo.
DROP TABLE IF EXISTS public.sysasis_cargo;
CREATE TABLE PUBLIC.sysasis_cargo(
  cod_cargo VARCHAR(20) NOT NULL , --codcargo, codigo en saint que identifica como se codifica el cargo
  codcargo  VARCHAR(20) , -- codcargo, tal caul viene de saint sin agregacion de ceros izquierda
  des_cargo VARCHAR(80) NOT NULL , -- cargo, cargo del empleado 
  fec_actualizacion DATE DEFAULT NOW() , -- fecha en que se altero los datos de esta tabla por ultima vez
  cod_usuasys VARCHAR(20) DEFAULT 'systemas', -- codigo/usuario que altero los datos por ultima vez
  PRIMARY KEY (cod_cargo) );

-- tabla de registros del horario de trabajo, es usada para enviar a OP y registrar los horarios laborados
DROP TABLE IF EXISTS registros2013.sysasis_registro;
-- tabla de registros del horario de trabajo, es usada para enviar a OP y registrar los horarios laborados
CREATE  TABLE  registros2013.sysasis_registro (
  cod_ficha VARCHAR(20) NOT NULL , -- ficha/cedula/id del trabajador NOTA ESTE NO ES CI , en VNZ es CI
  cod_lugar VARCHAR(20) NOT NULL DEFAULT 'vacio', -- sobrenombre de la tienda, ejemplo quemaito, chacaito, arca, laidys
  fec_registro DATE NOT NULL, -- fecha del registro de dia a laborar
  cod_gerencia VARCHAR(20) NOT NULL , -- unidad de gerencia (tienda) de su ultima actividad
  num_contador INTEGER NOT NULL DEFAULT 0, -- contador de fotos, si va a distintos lugares debe marcar salida
  horaentrada INTEGER DEFAULT 0, -- hora de entrada del dia
  minuentrada INTEGER DEFAULT 0, -- minuto de entrada en dicha hora
  horadescanso INTEGER DEFAULT 0, -- hora de descanso del dia
  minudescanso INTEGER DEFAULT 0, -- minuto de descanso en dicha respectiva hora
  horareincor INTEGER DEFAULT 0, -- hora que se reincorpora del descanso
  minureincor INTEGER DEFAULT 0, -- minuto de reincorporacion de dicha hora
  horasalida INTEGER DEFAULT 0, -- hora de salida del dia laborado
  minusalida INTEGER DEFAULT 0, -- minuto de salida de dich hora
  hex_fotocara BYTEA NULL, -- foto del empleado
  hex_huelladactilar BYTEA NULL , -- huella dactilar tomada
  fec_actualizacion DATE NULL DEFAULT now(), -- fecha en que se altero los datos de esta tabla por ultima vez
  cod_usuasys VARCHAR(20) NULL DEFAULT 'systemas', -- codigo/usuario que altero los datos por ultima vez
  PRIMARY KEY (cod_ficha, cod_lugar, fec_registro, cod_gerencia) );
  -- NOTA: cod_gerencia es codger en saint, pero cod_lugar es la tienda
  -- si el personal es muy movido, tendra registros en distintas ubicaciones, 
  -- el ubicacion ayuda a descartar duplicados. esto amerita tener un SP que maneje los datos
  -- la expotacio se realizara en un vista que colocara el calculo de las horas y  
  -- estos registros "dispersos" (ejemplo, entro en castellana, su primera salida debe ser de castellana antes de ir a otro lado)
  -- diferencia entre registro no puede ser menor a 1/3 hora y mayor a 6 horas CUANDO SEAN SELLOS DISTINTOS

﻿DROP TABLE IF EXISTS sysasis_fichas ;

-- tabla de los usuarios/mensajeria/correo, sean trabajadores o de sistema, ambos son usuarios, solo que trabajadores no tendran clave
CREATE TABLE sysasis_fichas
(
  cod_ficha VARCHAR(20) NOT NULL, -- para el futuro es apellido+inicialnombre (prietol)
  ide_sesion VARCHAR(20) NOT NULL, -- nombre session que debe ser igual al sistema d emensajeria
  cod_perfil VARCHAR(20) NULL, -- para futuro perfil asociado
  cod_geren VARCHAR(20) NULL, -- para futuro gerencia a que responde
  cod_admin VARCHAR(20) NULL, -- para futuro responsabilidad a que responde
  cod_clave VARCHAR(20) NULL, -- para futuro, clave para iniciar session
  fec_actualizacion DATE NULL , -- fecha en que se altero los datos de esta tabla por ultima vez
  cod_usuasys VARCHAR(20) NULL , -- codigo/usuario que altero los datos por ultima vez
  PRIMARY KEY (ide_sesion) );


