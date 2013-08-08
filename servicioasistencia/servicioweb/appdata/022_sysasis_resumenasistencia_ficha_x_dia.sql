-- Database: sysasistencia
-- Schema: public

SET search_path TO public;

-- /**
--  * @nombre  sysasis_resumenasistencia_ficha_x_dia
--  * @author  lucero_fenix Tyrone Lucero <tyrone.lucero@gmail.com>
--  * @depends : tabla sysasis_registro, tabla lugares (codger), procedure sysasis_calculohoras_ficha_x_dia
--  * @description EXPONE UN RESUMEN DE LAS HORAS DE ENRADA Y SALIDA, ASI COMO LAS LABORADAS, EN VARIOS O UN SITIO, ES UNA SOLA LINEA
--  * @param ficha : la identificacion del trabjador, ci en Venezuela
--  * @param fecha : fecha de interes de aistencia qu se le calcularan las horas
--  */
CREATE OR REPLACE FUNCTION sysasis_resumenasistencia_ficha_x_dia(
	fecha 	DATE,		 -- se introduce fecha
	ficha 	VARCHAR		 -- ficha o identificacion del trabajador
	)

RETURNS TABLE (he VARCHAR, hd VARCHAR, hr VARCHAR,hs VARCHAR,ht VARCHAR, sitio VARCHAR )  
AS  $$
DECLARE
		cont			INTEGER:=0;		 -- lleva la cuenta delos registros 
		i				INTEGER:=0;		 --control iteraciones
		horamastemprana	INTEGER:=0;
		minumastemprana	INTEGER:=0;
		horamastarde	INTEGER:=0;
		minumastarde	INTEGER:=0;
		temporal		INTEGER:=0;
		temporal2		INTEGER:=0;
BEGIN
		-- cuento los registros de ese trabajador
		cont:=(SELECT COUNT(*) FROM sysasis_registro WHERE fec_registro=fecha AND cod_ficha=ficha); 
		-- ahora los proceso de manera individual... ? 
		IF cont = 1 THEN
			RETURN QUERY SELECT 
					(substring('00' || horaentrada    FROM char_length('00' ||   horaentrada)-2+1)|| ':' || substring('00' || minuentrada   FROM char_length('00' || minuentrada)-2+1) )::VARCHAR AS he,
					(substring('00' || horadescanso FROM char_length('00' || horadescanso)-2+1)|| ':' || substring('00' ||minudescanso FROM char_length('00' || minudescanso)-2+1) )::VARCHAR AS hd,
					(substring('00' || horareincor     FROM char_length('00' || horareincor    )-2+1)|| ':' || substring('00' || minureincor    FROM char_length('00' || minureincor )-2+1) )::VARCHAR AS hr,
					(substring('00' || horasalida       FROM char_length('00' ||  horasalida     )-2+1)||':' || substring('00'  || minusalida      FROM char_length('00' || minusalida )-2+1 ) )::VARCHAR AS hs,
					(SELECT sysasis_calculohoras_ficha_x_dia(fecha, ficha) )::VARCHAR AS ht,
					(SELECT des_areatrabajo FROM sysasis_areatrabajo WHERE codger = sysasis_registro.cod_lugar)::VARCHAR AS sitio
					FROM sysasis_registro WHERE cod_ficha =ficha AND fec_registro= fecha;
		ELSE
			horamastemprana := (SELECT MIN(horaentrada) FROM sysasis_registro  WHERE cod_ficha =ficha AND fec_registro= fecha)::INTEGER;
			minumastemprana := (SELECT MIN(minuentrada) FROM sysasis_registro where horaentrada=horamastemprana AND cod_ficha =ficha AND fec_registro= fecha)::INTEGER;
			-- AVERIGUAR CUAL ES EL LA HORA MAS TARDE
			temporal := (SELECT MAX(horasalida) FROM sysasis_registro WHERE cod_ficha =ficha AND fec_registro= fecha)::INTEGER;
			minumastarde := (SELECT MAX(minusalida) FROM sysasis_registro where horasalida=horamastarde AND cod_ficha =ficha AND fec_registro= fecha)::INTEGER;
			IF temporal  = 0 THEN
				temporal := (SELECT MAX(horareincor) FROM sysasis_registro WHERE cod_ficha =ficha AND fec_registro= fecha)::INTEGER;
				minumastarde := (SELECT MAX(minureincor) FROM sysasis_registro where horareincor=horamastarde AND cod_ficha =ficha AND fec_registro= fecha)::INTEGER;
				IF temporal = 0 THEN
					temporal := (SELECT MAX(horadescanso) FROM sysasis_registro WHERE cod_ficha =ficha AND fec_registro= fecha)::INTEGER;
					minumastarde := (SELECT MAX(minudescanso) FROM sysasis_registro where horadescanso=horamastarde AND cod_ficha =ficha AND fec_registro= fecha)::INTEGER;
				ELSE
					temporal2 := (SELECT MAX(horadescanso) FROM sysasis_registro WHERE cod_ficha =ficha AND fec_registro= fecha)::INTEGER;
					IF temporal > temporal2 THEN
						horamastarde = temporal;
					ELSE
						horamastarde = temporal2;
					END IF;
				END IF;
			ELSE
				temporal2 := (SELECT MAX(horareincor) FROM sysasis_registro WHERE cod_ficha =ficha AND fec_registro= fecha)::INTEGER;
				IF temporal > temporal2 THEN
					horamastarde = temporal;
				ELSE
					horamastarde = temporal2;
				END IF;
			END IF;
			
			RETURN QUERY SELECT 
				(substring('00' || horamastemprana    FROM char_length('00' ||   horamastemprana)-2+1)|| ':' || substring('00' || minumastemprana   FROM char_length('00' || minumastemprana)-2+1) )::VARCHAR AS he,
				'00:00'::VARCHAR AS hd,
				'00:00'::VARCHAR AS hr,
				(substring('00' || horamastarde FROM char_length('00' || horamastarde)-2+1)|| ':' || substring('00' ||minumastarde FROM char_length('00' || minumastarde)-2+1) )::VARCHAR AS hs,
				(SELECT sysasis_calculohoras_ficha_x_dia(fecha, ficha) )::VARCHAR AS ht,
				'Varios'::VARCHAR AS sitio;
		END IF;
END;
$$
   LANGUAGE 'plpgsql' ;

select * FROM sysasis_resumenasistencia_ficha_x_dia('2013-07-15', '14')
