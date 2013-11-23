
-- tabla fuente, exportacion desde nomina, si se requiere, 
-- esta tabla es una fuente, de la cual se sacan datos 
-- desde otros sistemas de nomina
DROP TABLE IF EXISTS consolidadoespecial;
CREATE TABLE IF NOT EXISTS consolidadoespecial
(
    ficha         VARCHAR(60) NOT NULL,
    cedula        VARCHAR(60) NULL,
    apenom        VARCHAR(60) NULL,
    apenomc       VARCHAR(60) NULL,
    nombres       VARCHAR(60) NULL,
    apellidos     VARCHAR(60) NULL,
    compania      VARCHAR(60) NULL,
    gerencia      VARCHAR(60),
    departamento  VARCHAR(60) NULL, -- antiguamete "unidad" 
    ubicacion     VARCHAR(60) NULL,
    fnacimiento   VARCHAR(60) NULL,
    sexo          VARCHAR(60) NULL,
    modalidad     VARCHAR(60) NULL,
    codcar        VARCHAR(60) NULL,
    cargo         VARCHAR(60) NULL,
    sueldo        VARCHAR(60) NULL,
    estado        VARCHAR(60) NULL,
    vacaciones    VARCHAR(60) NULL,
    suspendido    VARCHAR(60) NULL,
    fingreso      VARCHAR(60) NULL,
    fretiro       VARCHAR(60) NULL,
    fincontrato   VARCHAR(60) NULL,
    tjornada      VARCHAR(60) NULL,
    fcobro        VARCHAR(60) NULL,
    ncuenta       VARCHAR(60) NULL,
    turno         VARCHAR(60) NULL,
    nomina        VARCHAR(60) NULL,
    grupo         VARCHAR(60) NULL,
    tipnom        VARCHAR(60) NULL,
    codvp         VARCHAR(60) NULL,
    codger        VARCHAR(60) NULL,
    coddep        VARCHAR(60) NULL,
    coddir        VARCHAR(60) NULL,
    codsuc        VARCHAR(60) NULL,
    PRIMARY KEY (ficha)
);


DROP TABLE IF EXISTS public.sysasis_fichas ;
CREATE TABLE sysasis_fichas
(
  cod_ficha VARCHAR(20) NOT NULL, -- para el futuro es apellido+inicialnombre (prietol)
  ide_sesion VARCHAR(80) NOT NULL, -- nombre session que debe ser igual al sistema d emensajeria
  cod_perfil VARCHAR(20) NULL, -- para futuro perfil asociado
  cod_geren VARCHAR(20) NULL, -- para futuro gerencia a que responde
  cod_admin VARCHAR(20) NULL, -- para futuro responsabilidad a que responde
  cod_clave VARCHAR(80) NULL, -- para futuro, clave para iniciar session
  des_nombre VARCHAR(80) NULL,
  des_apellido VARCHAR(80) NULL,
  fec_actualizacion DATE NULL DEFAULT now(), -- fecha en que se altero los datos de esta tabla por ultima vez
  cod_usuasys VARCHAR(20) NULL DEFAULT 'systemas', -- codigo/usuario que altero los datos por ultima vez
  PRIMARY KEY (ide_sesion) );
  



/*************************************/

--
-- TOC entry 175 (class 1259 OID 68413)
-- Dependencies: 1957 1958 8
-- Name: consolidadotemp_export; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE personal_export (
    tipnom VARCHAR(60) DEFAULT NOT NULL,
    codsuc VARCHAR(60),
    coddir VARCHAR(60),
    codvp VARCHAR(60),
    codger VARCHAR(60),
    coddep VARCHAR(60),
    compania VARCHAR(60),
    gerencia VARCHAR(60),
    departamento VARCHAR(60),
    unidad VARCHAR(60),
    modalidad VARCHAR(60),
    ficha VARCHAR(60) DEFAULT NOT NULL,
    cedula VARCHAR(60),
    estado VARCHAR(60),
    sexo VARCHAR(60),
    antiguedad VARCHAR(120),
    categoria VARCHAR(60),
    codcargo VARCHAR(60),
    cargo VARCHAR(60),
    fnacimiento VARCHAR(60),
    lugarnac VARCHAR(60),
    fingreso VARCHAR(60),
    tipocontrato VARCHAR(60),
    fincontrato VARCHAR(60),
    fretiro VARCHAR(60),
    fr_ivss VARCHAR(60),
    motivoliq VARCHAR(60),
    nomina VARCHAR(60),
    nombres VARCHAR(60),
    apellidos VARCHAR(60),
    grupo VARCHAR(160),
    nombreegeo1 VARCHAR(60),
    fsvacac VARCHAR(60),
    frvacac VARCHAR(60),
    fssuspen VARCHAR(60),
    frsuspen VARCHAR(60),
    turno VARCHAR(60),
    fec_actualizacion DATE DEFAULT now(),
    cod_usuario VARCHAR(20),
PRIMARY KEY (cod_ficha, cod_ger)
);


--
-- TOC entry 172 (class 1259 OID 68041)
-- Dependencies: 1953 1954 8
-- Name: sysasis_cargo; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sysasis_cargo (
    cod_cargo VARCHAR(20) NOT NULL,
    codcargo VARCHAR(20),
    des_cargo VARCHAR(80) NOT NULL,
    fec_actualizacion DATE DEFAULT now(),
    cod_usuasys VARCHAR(20) DEFAULT 'systemas'
);


--
-- TOC entry 174 (class 1259 OID 68367)
-- Dependencies: 1955 1956 8
-- Name: sysasis_fichas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sysasis_fichas (
    cod_ficha VARCHAR(20) NOT NULL,
    ide_sesion VARCHAR(80) NOT NULL,
    cod_perfil VARCHAR(20),
    cod_geren VARCHAR(20),
    cod_admin VARCHAR(20),
    cod_clave VARCHAR(80),
    des_nombre VARCHAR(80),
    des_apellido VARCHAR(80),
    fec_actualizacion DATE DEFAULT now(),
    cod_usuasys VARCHAR(20) DEFAULT 'systemas'::VARCHAR
);


--
-- TOC entry 176 (class 1259 OID 68712)
-- Dependencies: 8
-- Name: sysasis_grupo; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sysasis_grupo (
    cod_grupo VARCHAR(20) NOT NULL,
    coddir VARCHAR(20),
    des_grupo VARCHAR(80),
    fec_actualizacion timestamp without time zone,
    cod_usuasys VARCHAR(20)
);


--
-- TOC entry 178 (class 1259 OID 68752)
-- Dependencies: 8
-- Name: sysasis_lugar; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sysasis_lugar (
    cod_lugar VARCHAR(20) NOT NULL,
    cod_ip VARCHAR(20),
    codger VARCHAR(20),
    des_lugar VARCHAR(80),
    fec_actualizacion timestamp without time zone,
    cod_usuasys VARCHAR(20)
);


--
-- TOC entry 177 (class 1259 OID 68738)
-- Dependencies: 8
-- Name: sysasis_modo; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sysasis_modo (
    cod_modo VARCHAR(20) NOT NULL,
    coddep VARCHAR(20),
    des_modo VARCHAR(80),
    fec_actualizacion timestamp without time zone,
    cod_usuasys VARCHAR(20)
);


--
-- TOC entry 179 (class 1259 OID 68801)
-- Dependencies: 8
-- Name: sysasis_nomina; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sysasis_nomina (
    cod_nomina VARCHAR(20),
    tipnom VARCHAR(20),
    des_nomina VARCHAR(80)
);


--
-- TOC entry 168 (class 1259 OID 67946)
-- Dependencies: 1939 1940 1941 1942 1943 1944 1945 1946 1947 1948 1949 1950 8
-- Name: sysasis_registro; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sysasis_registro (
    cod_ficha VARCHAR(20) NOT NULL,
    cod_lugar VARCHAR(20) DEFAULT 'vacio'::VARCHAR NOT NULL,
    fec_registro DATE NOT NULL,
    cod_gerencia VARCHAR(20) NOT NULL,
    num_contador INTEGER DEFAULT 0 NOT NULL,
    horaentrada INTEGER DEFAULT 0,
    minuentrada INTEGER DEFAULT 0,
    horadescanso INTEGER DEFAULT 0,
    minudescanso INTEGER DEFAULT 0,
    horareincor INTEGER DEFAULT 0,
    minureincor INTEGER DEFAULT 0,
    horasalida INTEGER DEFAULT 0,
    minusalida INTEGER DEFAULT 0,
    hex_fotocara bytea,
    hex_huelladactilar bytea,
    fec_actualizacion DATE DEFAULT now(),
    cod_usuasys VARCHAR(20) DEFAULT 'systemas'::VARCHAR
);


--
-- TOC entry 171 (class 1259 OID 68020)
-- Dependencies: 1951 1952 8
-- Name: sysasis_responsable; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sysasis_responsable (
    cod_responsable VARCHAR(20) NOT NULL,
    codsuc VARCHAR(20),
    des_responsable VARCHAR(80) NOT NULL,
    fec_actualizacion DATE DEFAULT now(),
    cod_usuasys VARCHAR(20) DEFAULT 'systemas'::VARCHAR
);




--
-- TOC entry 1970 (class 2606 OID 68422)
-- Dependencies: 175 175 175 1978
-- Name: consolidadotemp_export_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY consolidadotemp_export
    ADD CONSTRAINT consolidadotemp_export_pkey PRIMARY KEY (tipnom, ficha);


--
-- TOC entry 1966 (class 2606 OID 68047)
-- Dependencies: 172 172 1978
-- Name: sysasis_cargo_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sysasis_cargo
    ADD CONSTRAINT sysasis_cargo_pkey PRIMARY KEY (cod_cargo);


--
-- TOC entry 1968 (class 2606 OID 68373)
-- Dependencies: 174 174 1978
-- Name: sysasis_fichas_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sysasis_fichas
    ADD CONSTRAINT sysasis_fichas_pkey PRIMARY KEY (ide_sesion);


--
-- TOC entry 1972 (class 2606 OID 68716)
-- Dependencies: 176 176 1978
-- Name: sysasis_grupo_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sysasis_grupo
    ADD CONSTRAINT sysasis_grupo_pkey PRIMARY KEY (cod_grupo);


--
-- TOC entry 1976 (class 2606 OID 68756)
-- Dependencies: 178 178 1978
-- Name: sysasis_lugar_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sysasis_lugar
    ADD CONSTRAINT sysasis_lugar_pkey PRIMARY KEY (cod_lugar);


--
-- TOC entry 1974 (class 2606 OID 68742)
-- Dependencies: 177 177 1978
-- Name: sysasis_modo_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sysasis_modo
    ADD CONSTRAINT sysasis_modo_pkey PRIMARY KEY (cod_modo);


--
-- TOC entry 1962 (class 2606 OID 67965)
-- Dependencies: 168 168 168 168 168 1978
-- Name: sysasis_registro_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sysasis_registro
    ADD CONSTRAINT sysasis_registro_pkey PRIMARY KEY (cod_ficha, cod_lugar, fec_registro, cod_gerencia);


--
-- TOC entry 1964 (class 2606 OID 68026)
-- Dependencies: 171 171 1978
-- Name: sysasis_responsable_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sysasis_responsable
    ADD CONSTRAINT sysasis_responsable_pkey PRIMARY KEY (cod_responsable);


--
-- TOC entry 1981 (class 0 OID 0)
-- Dependencies: 168
-- Name: sysasis_registro; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE sysasis_registro FROM PUBLIC;
REVOKE ALL ON TABLE sysasis_registro FROM systemas;
GRANT ALL ON TABLE sysasis_registro TO systemas;
GRANT ALL ON TABLE sysasis_registro TO PUBLIC;


-- Completed on 2013-11-08 09:12:57 VET

--
-- PostgreSQL database dump complete
--

