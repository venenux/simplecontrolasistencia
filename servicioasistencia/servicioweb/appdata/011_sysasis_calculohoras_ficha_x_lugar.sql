-- Database: sysasistencia
-- Schema: public

SET search_path TO public;

-- /**
--  * @nombre  sysasis_calculohoras_ficha_x_luga
--  * @author  lucero_fenix Tyrone Lucero <tyrone.lucero@gmail.com>
--  * @description FUNCION CALCULA HORAS TRABAJADAS POR UN LUGAR EN UN DIA POR UN TRABAJADOR
--  * @depends : tabla sysasis_registros
--  * @param ficha : la identificacion del trabjador, ci en Venezuela
--  * @param fecha : fecha de interes de aistencia qu se le calcularan las horas
--  * @param lugar : codigo "codger" del lugar o gerenci al cual se le desea ver horas laboradas
--  */
CREATE OR REPLACE FUNCTION sysasis_calculohoras_ficha_x_luga(
	fecha   DATE,		-- se introduce fecha
	ficha	VARCHAR,	-- se introduce cedula/identificacion
	lugar	VARCHAR 	-- lugar (codigo codger)
	)
RETURNS VARCHAR AS $$
DECLARE
-- mejor variables que un array
 hora_e		INTEGER;  -- guarda cada  hora entrada 
 hora_s		INTEGER;  -- guarda cada  hora salida
 hora_d		INTEGER;  -- guarda hora de descanso 
 hora_r		INTEGER;  -- guarda hora re ingreso 
 minut_e	INTEGER;   -- guarda minutos hora re ingreso
 minut_d	INTEGER;   -- guarda minutos hora descanso 
 minut_r	INTEGER;  -- guarda minutos hora reicorporacion   
 minut_s	INTEGER;  -- guarda minutos hora salida
  -------------*********************--------------------------------	
 cont_r		INTEGER:=0;	-- para contar registros
 sumahora	INTEGER:=0;	-- acumula todas las horas
 sumahora2  INTEGER:=0;	-- hora usada para el descanso -SE RESTA-
 suma_min	INTEGER:=0;	-- acumula los minutos
 sumatotal	INTEGER:=0;	-- horas  contadas 
 minutos1	INTEGER:=0;	-- minutos entre la entrada y el descanso
 minutos2	INTEGER:=0;	-- minutos entre reicorporacion y salida
 i			INTEGER:=0;	-- para controlar loop  
 flag_m	INTEGER:=0;	-- se enciende si alguna hora es cero (inexistente)
 flag_t	INTEGER:=0;	-- se enciende si alguna hora es cero (inexistente)
 horaf		VARCHAR;	-- guardará el cast de las horas 
 min_f		VARCHAR;	-- guardará el cast minutos
 calculo_h	VARCHAR;	-- RESULTADO DE SALIDA
 aux		INTEGER;	-- RESIDUO
 temporal	INTEGER;	-- para hacer positivo el tiepo es un vector
BEGIN
	-- limpieza
	ficha = trim(ficha);
	lugar = trim(lugar);
	--IF lugar = '%' then lugar = null; END IF;
	-- fich por ahora es 8 caracteres/digitos, hacer autocompletado:
	--ficha = substring('00000000' || ficha FROM char_length('00000000' || ficha)-8+1);
	-- buscar en la bd el empleado especifico en la fecha dada y contar sus registros
	cont_r := (SELECT count(*) FROM sysasis_registro WHERE cod_ficha = ficha AND fecha = fec_registro AND cod_lugar LIKE lugar);
	FOR i IN 1..cont_r LOOP --cargo los arreglos 
		flag_m:= 0; 
		flag_t:= 0; 
		hora_d  := (SELECT horadescanso FROM sysasis_registro WHERE cod_ficha = ficha AND fecha = fec_registro AND cod_lugar LIKE lugar OFFSET i-1 LIMIT 1);
		hora_e  := (SELECT horaentrada FROM sysasis_registro WHERE cod_ficha = ficha AND fecha = fec_registro AND cod_lugar LIKE lugar OFFSET i-1 LIMIT 1)::INTEGER;
		hora_s  := (SELECT horasalida FROM sysasis_registro WHERE cod_ficha = ficha AND fecha = fec_registro AND cod_lugar LIKE lugar OFFSET i-1 LIMIT 1);
		hora_r  := (SELECT horareincor FROM sysasis_registro WHERE cod_ficha = ficha AND fecha = fec_registro AND cod_lugar LIKE lugar OFFSET i-1 LIMIT 1);
		minut_e := (SELECT minuentrada FROM sysasis_registro WHERE cod_ficha = ficha AND fecha = fec_registro AND cod_lugar LIKE lugar OFFSET i-1 LIMIT 1);
		minut_d := (SELECT minudescanso FROM sysasis_registro WHERE cod_ficha = ficha AND fecha = fec_registro AND cod_lugar LIKE lugar OFFSET i-1 LIMIT 1);
		minut_r := (SELECT minureincor FROM sysasis_registro WHERE cod_ficha = ficha AND fecha = fec_registro AND cod_lugar LIKE lugar OFFSET i-1 LIMIT 1);
		minut_s := (SELECT minusalida FROM sysasis_registro WHERE cod_ficha = ficha AND fecha = fec_registro AND cod_lugar LIKE lugar OFFSET i-1 LIMIT 1);
		-- tengo que verificar cuantas horas hay entre la entrada y la salida descanso
		IF ((hora_d* hora_e)= 0) THEN
			flag_m:=1; 
		END IF;
		 -- tengo que verificar cuantas horas hay entre la reincoporación y la salida 
		IF ((hora_s* hora_r)= 0) THEN
			flag_t:=1; 
		END IF;
		IF (flag_m= 0) THEN
			sumahora := sumahora  + (hora_d-hora_e); -- si no se activa el flag
			temporal := minut_d-minut_e;
			IF (temporal < 0) THEN
				temporal:= temporal * -1;				
			END IF; 
			minutos1 := minutos1 + temporal;
			IF (sumahora < 0) THEN
				sumahora := sumahora * -1;				
			END IF; 
		END IF;
		IF (flag_t=0) THEN
			sumahora2:= sumahora2 + (hora_s-hora_r);
			temporal := minut_s-minut_r;
			IF (minutos2 < 0) THEN
				temporal:=temporal * -1;	
			END IF;  
			minutos2 := minutos2 + temporal;
			IF (sumahora2 < 0) THEN
				sumahora2:=sumahora2 * -1;	
			END IF; 
		END IF;
	END LOOP; 
		
	sumatotal:= sumahora  + sumahora2;
	suma_min := minutos1  + minutos2;
	--quizas esto no sea necesario... PERO YA ME CURÉ EN SALUD
	IF suma_min>60 THEN
		sumatotal:=sumatotal + (suma_min/60);-- / trunca a entero
		aux:=suma_min;
		suma_min:= aux % 60; -- estos son los minutos que quedan	   
	END IF; 
	-- hacer cast para transformar a cadena
	horaf	 :=  substring('00' || sumatotal FROM char_length('00' || sumatotal)-2+1);
	min_f	 := substring('00' || suma_min FROM char_length('00' || suma_min)-2+1);
	-- verifico que  horaf tenga al menos dos caracteres si no relleno con 0
	calculo_h := horaf || ':' || min_f;
	RETURN calculo_h;
END;
$$ 
   LANGUAGE 'plpgsql' ;

   SELECT sysasis_calculohoras_ficha_x_luga( '2013-07-15', '14','114')




