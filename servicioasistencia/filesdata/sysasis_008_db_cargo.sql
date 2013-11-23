DROP TABLE IF EXISTS sysasis_cargo;
CREATE TABLE sysasis_cargo
(
  cod_cargo VARCHAR(20) NOT NULL,
  codcar       VARCHAR(20),
  des_cargo VARCHAR(80) NOT NULL,
  fec_actualizacion DATE DEFAULT now(),
  cod_usuasys VARCHAR(20) DEFAULT 'systemas',
  PRIMARY KEY (cod_cargo )
);
INSERT INTO sysasis_cargo( cod_cargo,codcar,des_cargo) 
SELECT (substring('000' || codcar FROM char_length('000' || codcar)-3+1)),codcar ,cargo  FROM consolidadoespecial WHERE trim(codcar) <> '1' GROUP BY codcar, cargo ORDER BY codcar;
SELECT * from sysasis_cargo;