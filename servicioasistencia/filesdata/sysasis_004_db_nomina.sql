DROP TABLE IF EXISTS sysasis_nomina;
CREATE TABLE sysasis_nomina (
  cod_nomina           VARCHAR(20) NOT NULL,
  tipnom               VARCHAR(20),
  des_nomina           VARCHAR(80),
  fec_actualizacion    DATE DEFAULT now(),
  cod_usuasys          VARCHAR(20) DEFAULT 'systemas',
  PRIMARY KEY (cod_nomina ));

INSERT INTO sysasis_nomina( cod_nomina, tipnom, des_nomina) 
SELECT (substring('000' || tipnom FROM char_length('000' || tipnom)-3+1)) AS cod_nomina, tipnom, nomina FROM consolidadoespecial GROUP BY tipnom, nomina ORDER BY cod_nomina;

SELECT * FROM sysasis_nomina;