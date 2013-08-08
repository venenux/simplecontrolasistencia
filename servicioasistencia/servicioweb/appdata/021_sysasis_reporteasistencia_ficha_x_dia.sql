-- Database: sysasistencia
-- Schema: public

SET search_path TO public;

-- /**
--  * @nombre  sysasis_reporteasistencia_ficha_x_dia
--  * @author  lucero_fenix Tyrone Lucero <tyrone.lucero@gmail.com>
--  * @depends : tabla sysasis_registro, tabla lugares (codger), procedure sysasis_calculohoras_ficha_x_luga
--  * @description EXPONE UN REPORTE DE HORAS Y LUGARES DONDE TRQABAJO UN USUARIO POR UNA FECHA EN ESPECIFICA
--  * @param ficha : la identificacion del trabjador, ci en Venezuela
--  * @param fecha : fecha de interes de aistencia qu se le calcularan las horas
--  */
CREATE OR REPLACE FUNCTION sysasis_reporteasistencia_ficha_x_dia(
	fecha 	DATE,		 -- se introduce fecha
	ficha 	VARCHAR		 -- ficha o identificacion del trabajador
	)

RETURNS TABLE (he VARCHAR, hd VARCHAR, hr VARCHAR,hs VARCHAR,ht VARCHAR, sitio VARCHAR )  
AS  $$
DECLARE
		cont			INTEGER:=0;		 -- lleva la cuenta delos registros 
		i				INTEGER:=0;		 -- control iteraciones
		codigos 		VARCHAR ARRAY;	 --  guardo los codigos aqui 
BEGIN
		-- cuento los registros de ese trabajador
		cont:=(SELECT COUNT(*) FROM sysasis_registro WHERE fec_registro=fecha AND cod_ficha=ficha); 
		-- ahora hago un array con los códigos de los lugares registrados en ese dia
		FOR i IN 1..cont  LOOP
			codigos[i]:= (SELECT cod_lugar 	FROM sysasis_registro  WHERE fec_registro=fecha AND cod_ficha=ficha ORDER BY horaentrada OFFSET i-1 LIMIT 1);
		END LOOP;-- fin del ciclo para obtener los codigos
		-- ahora los proceso de manera individual... ? 
		FOR i IN 1..cont  LOOP
			RETURN QUERY SELECT 
				(substring('00' || horaentrada  FROM char_length('00' || horaentrada )-2+1)|| ':' || substring('00' || minuentrada   FROM char_length('00' || minuentrada)-2+1) )::VARCHAR AS he,
				(substring('00' || horadescanso FROM char_length('00' || horadescanso)-2+1)|| ':' || substring('00' ||minudescanso FROM char_length('00' || minudescanso)-2+1) )::VARCHAR AS hd,
				(substring('00' || horareincor  FROM char_length('00' || horareincor )-2+1)|| ':' || substring('00' || minureincor    FROM char_length('00' || minureincor )-2+1) )::VARCHAR AS hr,
				(substring('00' || horasalida   FROM char_length('00' || horasalida  )-2+1)||':' || substring('00'  || minusalida      FROM char_length('00' || minusalida )-2+1 ) )::VARCHAR AS hs,
				(SELECT sysasis_calculohoras_ficha_x_luga(fecha,ficha,codigos[i]))::VARCHAR AS ht,
				(SELECT des_areatrabajo FROM sysasis_areatrabajo WHERE codger = sysasis_registro.cod_lugar )::VARCHAR AS Sitio
				FROM sysasis_registro WHERE cod_ficha =ficha AND fec_registro= fecha ORDER BY horaentrada OFFSET i-1 LIMIT 1 ;
		END LOOP;-- fin del ciclo
END;
$$
   LANGUAGE 'plpgsql' ;

SELECT * FROM sysasis_reporteasistencia_ficha_x_dia('2013-07-15', '14')
