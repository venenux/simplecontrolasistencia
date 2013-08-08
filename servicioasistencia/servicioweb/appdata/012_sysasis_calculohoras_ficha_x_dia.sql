-- Database: sysasistencia
-- Schema: public

SET search_path TO public;

-- /**
--  * @nombre  sysasis_calculohoras_ficha_x_dia
--  * @author  lucero_fenix Tyrone Lucero <tyrone.lucero@gmail.com>
--  * @description FUNCION CALCULA HORAS TRABAJADAS POR UN TRABAJADOR POR UN DIA
--  * @param ficha : la identificacion del trabjador, ci en Venezuela
--  * @param fecha : fca de interes de aistencia qu se le calcularan las horas
--  */
CREATE OR REPLACE FUNCTION sysasis_calculohoras_ficha_x_dia (
  fecha DATE,	  -- se introduce fecha
	ficha	VARCHAR  -- se mete fiche, cedula en Venezuela
)
RETURNS VARCHAR AS $$
DECLARE
	 horas_e	INTEGER ARRAY;  -- guarda cada  hora entrada
	 horas_s	INTEGER ARRAY;  -- guarda cada  hora salida
	 horas_d	INTEGER ARRAY;  -- guarda hora de descanso
	 horas_i	INTEGER ARRAY;  -- guarda hora ingreso
	 minut_e	INTEGER ARRAY;  -- guarda minutos hora ingreso
	 minut_d	INTEGER ARRAY;  -- guarda minutos hora descanso
	 minut_r	INTEGER ARRAY;  -- guarda minutos hora reicorporacion
	 minut_s	INTEGER ARRAY;  -- guarda minutos hora salida
	 cont_r		INTEGER :=0;	-- para contar registros
	 summanana	INTEGER :=0;	-- acumula todas las horas
	 sumtarde	INTEGER :=0;	-- hora usada para el descanso -SE RESTA-
	 summinuto	INTEGER :=0;	-- acumula los minutos
	 sumhoras	INTEGER :=0;	-- horas  contadas
	 minumanan	INTEGER :=0;	-- minutos entre la entrada y el descanso
	 minutarde	INTEGER :=0;	-- minutos entre reicorporacion y salida
	 i			INTEGER :=0;	-- para controlar loop
	 f_h_manana INTEGER :=0;	-- se enciende si alguna hora es cero en horario matutino (h_ent - h_salid)
	 f_h_tarde  INTEGER :=0;	-- se enciende si alguna hora es cero en horario de tarde (h_comi - h_salida)
	 temporal	INTEGER :=0;
	 horaf		VARCHAR ;	-- guardará el cast de las horas
	 min_f		VARCHAR ;	-- guardará el cast minutos
	 calculo_h	VARCHAR ;	-- RESULTADO DE SALIDA
	 residuo	INTEGER ;	-- RESIDUO
	 cociente	INTEGER ;
BEGIN
 -- buscar en la bd el empleado especifico en la fecha dada y contar sus registros
	cont_r := (SELECT count(*) FROM sysasis_registro WHERE cod_ficha = ficha AND fecha = fec_registro);

	FOR i IN 1..cont_r LOOP --cargo los arreglos
		f_h_manana:=0; -- es necesario resetear cada flag
		f_h_tarde:= 0;
		-- bloque para guardar cada uno de los querys (proxima optimizacion un solo select parallenar una matriz una matriz)
		horas_d[i]:= (SELECT horadescanso FROM sysasis_registro WHERE cod_ficha = ficha AND fecha = fec_registro OFFSET i-1 LIMIT 1);
		horas_e[i]:= (SELECT horaentrada FROM sysasis_registro WHERE cod_ficha = ficha AND fecha = fec_registro OFFSET i-1 LIMIT 1);
		horas_s[i]:= (SELECT horasalida FROM sysasis_registro WHERE cod_ficha = ficha AND fecha = fec_registro OFFSET i-1 LIMIT 1);
		horas_i[i]:= (SELECT horareincor FROM sysasis_registro WHERE cod_ficha = ficha AND fecha = fec_registro OFFSET i-1 LIMIT 1);
		minut_e[i]:= (SELECT minuentrada FROM sysasis_registro WHERE cod_ficha = ficha AND fecha = fec_registro OFFSET i-1 LIMIT 1);
		minut_d[i]:= (SELECT minudescanso FROM sysasis_registro WHERE cod_ficha = ficha AND fecha = fec_registro OFFSET i-1 LIMIT 1);
		minut_r[i]:= (SELECT minureincor FROM sysasis_registro WHERE cod_ficha = ficha AND fecha = fec_registro OFFSET i-1 LIMIT 1);
		minut_s[i]:= (SELECT minusalida FROM sysasis_registro WHERE cod_ficha = ficha AND fecha = fec_registro OFFSET i-1 LIMIT 1);

		-- tengo que verificar cuantas horas hay entre la entrada y la salida descanso
		IF ((horas_d[i]* horas_e[i])= 0) THEN
			f_h_manana:=1; -- si da cero, para el ciclo "i" actual no hay calculo valido matutino
		END IF;
		 -- tengo que verificar si hay horas entre la reincoporación y la salida
		IF ((horas_s[i]* horas_i[i])= 0) THEN
			f_h_tarde:=1; -- si da cero, para el ciclo "i" actual no hay calculo valido vespertino
		END IF;

		IF (f_h_manana = 0) THEN
			temporal := horas_d[i]-horas_e[i]; -- hago la suma, temporalmente, el tempo es un vector
			IF (temporal < 0) THEN temporal := temporal * -1; END IF; -- si da negativa, se pone positiva, igal l cantida sera la misma
			summanana := summanana + temporal;
			temporal := minut_d[i]-minut_e[i];
			IF (temporal < 0) THEN temporal := temporal * -1; END IF;
			minumanan := minumanan + temporal;
		END IF;
		IF (f_h_tarde = 0) THEN
			temporal := horas_s[i]-horas_i[i];
			IF (temporal < 0) THEN temporal := temporal * -1; END IF;
			sumtarde := sumtarde + temporal;
			temporal := minut_s[i]-minut_r[i];
			IF (temporal < 0) THEN temporal := temporal * -1; END IF;
			minutarde := minutarde + temporal;
		END IF;
	END LOOP;

	sumhoras := summanana  + sumtarde;
	summinuto := minumanan  + minutarde;

	WHILE summinuto > 59 LOOP
		cociente:= summinuto/60;
		residuo := summinuto % 60;
		sumhoras := sumhoras + cociente;
		summinuto :=  residuo;
	END LOOP;

	-- hacer cast para transformar a cadena, fomato X:YY
	horaf := (SELECT CAST( sumhoras AS INTEGER) :: VARCHAR );
	min_f := (SELECT CAST( summinuto AS INTEGER) :: VARCHAR );
	-- verifico que  horaf tenga al menos dos caracteres si no relleno con 0
	i := (SELECT CHAR_LENGTH(horaf));
	IF i<2 THEN horaf := (SELECT LPAD(horaf,2,'0')); END IF;
	-- verifico que  min_f tenga  al menos dos caracteres si no relleno con 0
	i := (SELECT CHAR_LENGTH(min_f));
	IF i<2 THEN min_f:=(SELECT LPAD(min_f,2,'0')); END IF;
	calculo_h := (SELECT RPAD(horaf,3,':'));
	calculo_h := (SELECT RPAD(calculo_h,5,min_f));
	RETURN calculo_h;
END;
$$
   LANGUAGE 'plpgsql' ;


--SELECT sysasis_calculohoras_ficha_x_dia( '2013-07-27', '14912432')
SELECT sysasis_calculohoras_ficha_x_dia( '2013-07-15', '13')
--SELECT cod_ficha,fec_registro,horaentrada,minuentrada,horadescanso,minudescanso,horareincor,minureincor,horasalida,minusalida  FROM sysasis_registro WHERE cod_ficha = '14'



