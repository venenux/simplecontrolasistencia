
DROP TABLE IF EXISTS sysasis_lugar;
CREATE TABLE sysasis_lugar(
  cod_lugar          VARCHAR(20) NOT NULL,
  cod_ip             VARCHAR(20),
  codger             VARCHAR(20),
  des_lugar          VARCHAR(80),
  fec_actualizacion  DATE DEFAULT now(),
  cod_usuasys        VARCHAR(20),
  PRIMARY KEY (cod_lugar)
);

INSERT INTO sysasis_lugar( cod_lugar,codger,des_lugar) 
SELECT (substring('000' || codger FROM char_length('000' || codger)-3+1)) AS cod_lugar, codger, ubicacion FROM consolidadoespecial GROUP BY codger, ubicacion ORDER BY cod_lugar;

SELECT * FROM sysasis_lugar;