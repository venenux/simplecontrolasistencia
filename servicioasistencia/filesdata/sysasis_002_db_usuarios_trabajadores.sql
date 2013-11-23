DROP TABLE IF EXISTS public.sysasis_fichas ;
DROP TABLE IF EXISTS public.sysasis_ficha ;
CREATE TABLE sysasis_ficha
(
  cod_ficha      VARCHAR(20) NOT NULL, -- para el futuro es apellido+inicialnombre (prietol)
  ide_sesion     VARCHAR(80) NULL DEFAULT '', -- nombre session que debe ser igual al sistema d emensajeria
  cod_perfil     VARCHAR(20) NULL DEFAULT '001', --  para futuro perfil asociado
  cod_admin      VARCHAR(20) NULL DEFAULT NULL, -- para futuro responsabilidad a que responde
  cod_clave      VARCHAR(80) NULL, --  para futuro, clave para iniciar session
  cod_nomina     VARCHAR(80) NULL,  -- nomina a la que pertenece si hay varias manejadas sitintas
  cod_responsable VARCHAR(80) NULL, -- responsable social o codigo empresa codsuc a que le trabaja
  cod_geren      VARCHAR(20) NULL, --  para futuro gerencia a que responde
  cod_departamento VARCHAR(20) NULL, -- codigo codvp o departamento en que trabaja para la organizacion
  cod_grupo      VARCHAR(80) NULL,  -- region en la cual labora del pais dicha vict.. err digo el trabajador/usuario
  cod_lugar      VARCHAR(80) NULL,  -- codigo del lugar de trabajo del vict.. err digo trabajador/usuario
  cod_cargo      VARCHAR(80) NULL,  -- codigo del cargo que ostenta la vict.. err digo trabajador/usuario
  cod_cuenta     VARCHAR(80) NULL,  -- numero de cuenta nomina del trabajador
  cod_cuentaex   VARCHAR(80) NULL,  -- numero de cuenta extra si tiene otro
  cod_rif        VARCHAR(80) NULL,  -- rif personal si aplica
  des_nombre     VARCHAR(80) NULL,  -- ambos nombres del usuario o trabajador
  des_apellido   VARCHAR(80) NULL,  -- ambos apellidos del usuarios o trabajador
  des_direccion  VARCHAR(80) NULL,  -- direccion del trabajador para emergencias en caso suceso
  des_sexo       VARCHAR(80) NULL,  -- sexo lamentablemente viene en forma descriptiva en vez de un codigo asociado.. que basura
  des_estado     VARCHAR(80) NULL,  -- estado que viene del sistema nomina, una basura ya que no es identificado sino descrito como "Inactivo" "Activo" etc...
  des_jornada    VARCHAR(80) NULL,  -- tjornada campo combinado de otros de la db de nomina, especifico de algunas empresas
  des_otro       VARCHAR(80) NULL,  -- campo extra para uso adicional si es necesario
  des_primaria   VARCHAR(80) NULL,  -- campo extra para uso futuro reservado
  des_secundaria VARCHAR(80) NULL,  -- campo extra para uso futuro reservado
  des_id         VARCHAR(80) NULL,  -- cedula o licencia, identificacion en su pais, cada pais usa un id por ejemplo en Vnzla es cedula de identidad como V-1423423
  fec_nacimiento VARCHAR(80) NULL,  -- fecha en que ingreso a la organizacion
  fec_ingreso    VARCHAR(80) NULL,  -- fecha en que ingreso a la organizacion
  fec_retiro     VARCHAR(80) NULL,  -- fecha en que se retiro, ojo no es la misma en que finaliza siempre,, puede haya renunciado
  fec_fincontrato VARCHAR(80) NULL,  -- fecha en que se terminaba sus obligaciones con la empresa
  fec_actualizacion DATE NULL DEFAULT now(), -- fecha en que se altero los datos de esta tabla por ultima vez
  cod_usuasys    VARCHAR(20) NULL DEFAULT 'systemas', -- codigo/usuario que altero los datos por ultima vez
  PRIMARY KEY (cod_ficha) );


INSERT 
    INTO sysasis_ficha
        ( 
        cod_ficha,ide_sesion,cod_perfil,
        cod_admin,cod_clave,
        cod_nomina,cod_responsable,cod_geren,
        cod_departamento,cod_grupo,
        cod_lugar,cod_cargo,cod_cuenta,cod_cuentaex,cod_rif,
        des_nombre,des_apellido,des_direccion,
        des_sexo, des_estado,
        des_jornada,des_id, 
        fec_nacimiento, fec_ingreso, fec_retiro, fec_fincontrato
        ) 
    SELECT 
        consol.ficha,username,'998',
        NULL, mesg.password,
        consol.tipnom,consol.codsuc,'',
        consol.codvp,'',
        consol.codger,consol.codcar,consol.ncuenta,NULL,NULL,
        consol.nombres,consol.apellidos,NULL,
        consol.sexo,consol.estado,
        consol.tjornada,consol.cedula,
        consol.fnacimiento,consol.fingreso,consol.fretiro,consol.fincontrato
      FROM consolidadoespecial AS consol
      LEFT JOIN users AS mesg 
        ON ((substring('0000000000' || consol.ficha FROM char_length('0000000000' || consol.ficha)-10+1))=(substring('0000000000' || mesg.password FROM char_length('0000000000' || mesg.password)-10+1)))
        WHERE consol.ficha NOT LIKE '81981937'
      ORDER BY consol.ficha
      

