-- Database: sysasistencia
-- Schema: public

SET search_path TO public;

-- /**
--  * @nombre  sysasis_reporteasistencia_lugar_x_dia
--  * @author  lucero_fenix Tyrone Lucero <tyrone.lucero@gmail.com>
--  * @depends : tabla sysasis_registro, tabla lugares (codger), procedure sysasis_calculohoras_ficha_x_dia
--  * @description EXPONE UN RESUMEN POR DIA DE LAS HORAS DE ENTRADA Y SALIDA, LAS HORAS LABORADAS, EN UN SOLO SITIO DE TODOS LOS TRABAJADORES EN UNA SOLA LINEA
--  * @param lugar : lugar donde se registraron todos los trabajadores en el dia a consultar
--  * @param fecha : fecha de interes de aistencia quE se le calcularan las horas
-- */
CREATE OR REPLACE FUNCTION sysasis_reporteasistencia_lugar_x_dia(
	fecha 		DATE, 		-- se introduce fecha
	lugar		VARCHAR		-- el lugar donde se efectuarala busqueda
	)

RETURNS TABLE (he VARCHAR, hd VARCHAR, hr VARCHAR,hs VARCHAR,ht VARCHAR, fichaje VARCHAR )  
AS  $$
DECLARE
		cont	INTEGER:=0; 	-- lleva la cuenta delos registros 
		i		INTEGER:=0;		-- control iteraciones
	BEGIN
		        RETURN QUERY SELECT 
					(substring('00' || horaentrada  FROM char_length('00' || horaentrada  )-2+1)||':' || substring('00' || minuentrada  FROM char_length('00' || minuentrada )-2+1))::VARCHAR AS he,
					(substring('00' || horadescanso FROM char_length('00' || horadescanso )-2+1)||':' || substring('00' || minudescanso FROM char_length('00' || minudescanso)-2+1))::VARCHAR AS hd,
					(substring('00' || horareincor  FROM char_length('00' || horareincor  )-2+1)||':' || substring('00' || minureincor  FROM char_length('00' || minureincor )-2+1))::VARCHAR AS hr,
					(substring('00' || horasalida   FROM char_length('00' || horasalida   )-2+1)||':' || substring('00' || minusalida   FROM char_length('00' || minusalida  )-2+1))::VARCHAR AS hs,
					(SELECT sysasis_calculohoras_ficha_x_dia(fecha,sysasis_registro.cod_ficha))::VARCHAR AS ht,
					(cod_ficha || ', ' || (
						SELECT CASE WHEN (SELECT count(des_nombre) FROM sysasis_fichas WHERE cod_ficha=sysasis_registro.cod_ficha)<1 THEN 'Sin nombre registrado'
						ELSE (SELECT des_nombre || ' ' || des_apellido FROM sysasis_fichas WHERE cod_ficha=sysasis_registro.cod_ficha)
						END
					))::VARCHAR AS fichaje
					FROM sysasis_registro WHERE cod_lugar =lugar AND fec_registro=fecha;
END;
$$
   LANGUAGE 'plpgsql' ;

select * FROM sysasis_reporteasistencia_lugar_x_dia('2013-07-15', '113')
