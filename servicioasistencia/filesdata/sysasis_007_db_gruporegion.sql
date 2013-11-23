
DROP TABLE IF EXISTS sysasis_grupo;
CREATE TABLE sysasis_grupo (
    cod_grupo         VARCHAR(20) NOT NULL,
    coddir            VARCHAR(20),
    des_grupo         VARCHAR(80),
    fec_actualizacion DATE DEFAULT now(),
    cod_usuasys       VARCHAR(20) DEFAULT 'systemas',
    PRIMARY KEY (cod_grupo)
);


INSERT INTO sysasis_grupo( cod_grupo,coddir,des_grupo) 
SELECT (substring('000' || coddir FROM char_length('000' || coddir)-3+1)), coddir, gerencia FROM consolidadoespecial WHERE trim(coddir) <> '' AND gerencia <> '' GROUP BY coddir, gerencia ORDER BY coddir;



INSERT INTO sysasis_grupo (cod_grupo, coddir, des_grupo, fec_actualizacion, cod_usuasys) VALUES ('000', '0', NULL, '2013-07-30 00:00:00', 'systemas');
INSERT INTO sysasis_grupo (cod_grupo, coddir, des_grupo, fec_actualizacion, cod_usuasys) VALUES ('001', '1', NULL, '2013-07-30 00:00:00', 'systemas');
INSERT INTO sysasis_grupo (cod_grupo, coddir, des_grupo, fec_actualizacion, cod_usuasys) VALUES ('100', '100', 'Administración', '2013-07-30 00:00:00', 'systemas');
INSERT INTO sysasis_grupo (cod_grupo, coddir, des_grupo, fec_actualizacion, cod_usuasys) VALUES ('110', '110', 'Adm-Barquisimeto', '2013-07-30 00:00:00', 'systemas');
INSERT INTO sysasis_grupo (cod_grupo, coddir, des_grupo, fec_actualizacion, cod_usuasys) VALUES ('200', '200', 'Operaciones', '2013-07-30 00:00:00', 'systemas');
INSERT INTO sysasis_grupo (cod_grupo, coddir, des_grupo, fec_actualizacion, cod_usuasys) VALUES ('003', '3', NULL, '2013-07-30 00:00:00', 'systemas');
INSERT INTO sysasis_grupo (cod_grupo, coddir, des_grupo, fec_actualizacion, cod_usuasys) VALUES ('300', '300', 'Proyectos Publicitarios', '2013-07-30 00:00:00', 'systemas');
INSERT INTO sysasis_grupo (cod_grupo, coddir, des_grupo, fec_actualizacion, cod_usuasys) VALUES ('400', '400', 'Rutas del Caribe', '2013-07-30 00:00:00', 'systemas');
INSERT INTO sysasis_grupo (cod_grupo, coddir, des_grupo, fec_actualizacion, cod_usuasys) VALUES ('500', '500', 'M.C.T.', '2013-07-30 00:00:00', 'systemas');
INSERT INTO sysasis_grupo (cod_grupo, coddir, des_grupo, fec_actualizacion, cod_usuasys) VALUES ('006', '6', NULL, '2013-07-30 00:00:00', 'systemas');
INSERT INTO sysasis_grupo (cod_grupo, coddir, des_grupo, fec_actualizacion, cod_usuasys) VALUES ('600', '600', 'Ventas', '2013-07-30 00:00:00', 'systemas');
INSERT INTO sysasis_grupo (cod_grupo, coddir, des_grupo, fec_actualizacion, cod_usuasys) VALUES ('700', '700', 'Tiendas Región Capital', '2013-07-30 00:00:00', 'systemas');
INSERT INTO sysasis_grupo (cod_grupo, coddir, des_grupo, fec_actualizacion, cod_usuasys) VALUES ('705', '705', 'Tiendas Región Central', '2013-07-30 00:00:00', 'systemas');
INSERT INTO sysasis_grupo (cod_grupo, coddir, des_grupo, fec_actualizacion, cod_usuasys) VALUES ('710', '710', 'Tiendas Región Falcon Zulia', '2013-07-30 00:00:00', 'systemas');
INSERT INTO sysasis_grupo (cod_grupo, coddir, des_grupo, fec_actualizacion, cod_usuasys) VALUES ('715', '715', 'Tiendas Región Occidental', '2013-07-30 00:00:00', 'systemas');
INSERT INTO sysasis_grupo (cod_grupo, coddir, des_grupo, fec_actualizacion, cod_usuasys) VALUES ('720', '720', 'Tiendas Región Oriental', '2013-07-30 00:00:00', 'systemas');
INSERT INTO sysasis_grupo (cod_grupo, coddir, des_grupo, fec_actualizacion, cod_usuasys) VALUES ('725', '725', 'Tiendas Región Andina', '2013-07-30 00:00:00', 'systemas');


