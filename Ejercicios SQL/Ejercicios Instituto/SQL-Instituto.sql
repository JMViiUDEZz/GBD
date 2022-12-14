-- PREGUNTAS SQL. BASE DE DATOS ?INSTITUTO?
-- 1.	Introducir datos de 5 profesores.
INSERT INTO PROFESORES VALUES (8,'LUISA','PARRA GARCIA','HUERCAL-OVERA','2019-09-01','INFORMATICA','M',1600)
-- 2.	Introducir datos de 10 alumnos.
INSERT INTO ALUMNOS (NOMBRE,APELLIDOS,CODAL,CIUDAD,FECHANACIMIENTO) VALUES ('PEDRO','ALMANSA BOTELLA',11,'PULPI','2000-04-12')
-- 3.	Introducir datos de 6 asignaturas.
INSERT INTO ASIGNATURAS VALUES ('FOL','FORMACION Y ORIENTACION LABORAL','1','ASIR')
-- 4.	Introducir 10 registros en la tabla imparte.
INSERT INTO IMPARTE VALUES (8,'PAR','21-22')
-- 5.	Introducir 15 registros en la tabla matr?cula.
INSERT INTO MATRICULA VALUES (12,'PAR','21-22')
-- 6.	Introducir 20 registros en la tabla notas.
INSERT INTO NOTAS VALUES (8,'GBD',NOW(),9)
-- 7.	Nombre y apellidos de los profesores de matem?ticas.
SELECT NOMBRE,APELLIDOS FROM PROFESORES WHERE DEPARTAMENTO='MATEMATICAS'
-- 8.	Nombre y apellidos de los profesores de matem?ticas de Huercal-Overa.
SELECT NOMBRE,APELLIDOS FROM PROFESORES WHERE DEPARTAMENTO='MATEMATICAS' AND CIUDAD='HUERCAL-OVERA'
-- 9.	Nombre y apellidos de las profesoras de franc?s de Huercal-Overa y Murcia.
SELECT NOMBRE,APELLIDOS FROM PROFESORES WHERE DEPARTAMENTO='FRANCES' AND CIUDAD IN ('HUERCAL-OVERA','MURCIA') AND SEXO='M'
-- 10.	Profesores que llevan m?s de diez a?os en el centro.
SELECT * FROM PROFESORES WHERE FECHAALTA<=SUBDATE(NOW(), INTERVAL 10 YEAR)
-- 11.	?Cu?ntos alumnos menores de edad hay en el centro?
SELECT COUNT(*) FROM ALUMNOS WHERE FECHANACIMIENTO>SUBDATE(NOW(),INTERVAL 18 YEAR)
-- 12.	Relaci?n de alumnos menores de edad de fuera de Huercal-Overa.
SELECT * FROM ALUMNOS WHERE FECHANACIMIENTO>=SUBDATE(NOW(),INTERVAL 18 YEAR) AND CIUDAD!='HUERCAL-OVERA'
-- 13.	Profesores de inform?tica con un sueldo comprendido entre 1500 y 1800 euros
SELECT * FROM PROFESORES WHERE DEPARTAMENTO='INFORMATICA' AND SUELDO BETWEEN 1500 AND 1800
-- 14.	Relaci?n de alumnos matriculados en Servicios de Red e Internet en el pasado curso acad?mico.
SELECT * FROM ALUMNOS NATURAL JOIN MATRICULA WHERE CURSO='20-21' AND CODAS=(SELECT CODAS FROM ASIGNATURAS WHERE NOMBRE='Servicios de Red e Internet')
-- 15.	Nota media del alumno Emilio Parra Sanz en la asignatura PAR.
SELECT AVG(NOTA) FROM ALUMNOS NATURAL JOIN NOTAS WHERE NOMBRE='Emilio' AND APELLIDOS='Parra Sanz' AND CODAS='PAR'
-- 16.	Nota media del alumno Emilio Parra Sanz en la asignatura Planificaci?n y Admon de Redes.
SELECT AVG(NOTA) FROM NOTAS NATURAL JOIN ALUMNOS WHERE NOMBRE='Emilio' AND APELLIDOS='Parra Sanz' AND CODAS=(SELECT CODAS FROM ASIGNATURAS WHERE NOMBRE='Planificaci?n y Admon de Redes')
-- 17.	Nota media del alumno Emilio Parra Sanz en cada asignatura.
SELECT CODAS,AVG(NOTA) FROM NOTAS NATURAL JOIN ALUMNOS WHERE NOMBRE='Emilio' AND APELLIDOS='Parra Sanz' GROUP BY CODAS
-- 18.	Relaci?n de asignaturas de 2? ASIR.
SELECT * FROM ASIGNATURAS WHERE CURSO='2' AND NIVEL='ASIR'
-- 19.	Relaci?n de asignaturas de 2? ASIR que no hayan tenido ning?n alumno matriculado nunca.
SELECT * FROM ASIGNATURAS WHERE CURSO='2' AND NIVEL='ASIR' AND CODAS NOT IN (SELECT CODAS FROM MATRICULA)
-- 20.	Relaci?n de asignaturas de 2? ASIR que no tengan ning?n alumno matriculado este curso.
SELECT * FROM ASIGNATURAS WHERE CURSO='2' AND NIVEL='ASIR' AND CODAS NOT IN (SELECT CODAS FROM MATRICULA WHERE CURSO='21-22')
-- 21.	Relaci?n de asignaturas en las que no se ha matriculado ning?n alumno este curso.
SELECT * FROM ASIGNATURAS WHERE CODAS NOT IN (SELECT CODAS FROM MATRICULA WHERE CURSO='21-22')
-- 22.	?Cu?les han sido las notas m?s alta y m?s baja en Gesti?n de bases de datos este curso?
SELECT MAX(NOTA),MIN(NOTA) FROM NOTAS WHERE FECHA BETWEEN '2021-09-15' AND '2022-06-22' AND CODAS=(SELECT CODAS FROM ASIGNATURAS WHERE NOMBRE='Gesti?n de bases de datos')
-- 23.	Alumnos a los que han correspondido las notas m?s alta y m?s baja en Gesti?n de bases de datos este curso.
SELECT * FROM ALUMNOS WHERE CODAL IN (SELECT CODAL FROM NOTAS WHERE (FECHA BETWEEN '2021-09-15' AND '2022-06-22'AND CODAS=(SELECT CODAS FROM ASIGNATURAS WHERE NOMBRE='GESTION DE BASES DE DATOS') AND NOTA= (SELECT MAX(nota) FROM NOTAS WHERE FECHA BETWEEN '2021-09-15' AND '2022-06-22'AND CODAS=(SELECT CODAS FROM ASIGNATURAS WHERE NOMBRE='GESTION DE BASES DE DATOS')))) OR CODAL IN (SELECT CODAL FROM NOTAS WHERE (FECHA BETWEEN '2021-09-15' AND '2022-06-22'AND CODAS=(SELECT CODAS FROM ASIGNATURAS WHERE NOMBRE='GESTION DE BASES DE DATOS') AND NOTA=(SELECT MIN(nota) FROM NOTAS WHERE FECHA BETWEEN '2021-09-15' AND '2022-06-22'AND CODAS=(SELECT CODAS FROM ASIGNATURAS WHERE NOMBRE='GESTION DE BASES DE DATOS'))))
-- 24.	Relaci?n de asignaturas en las que est? matriculada este curso la alumna Mar?a S?nchez Vi?dez.
SELECT * FROM ALUMNOS AL NATURAL JOIN MATRICULA M INNER JOIN ASIGNATURAS A ON A.CODAS=M.CODAS WHERE AL.NOMBRE='Mar?a' AND AL.APELLIDOS='S?nchez Vi?dez' AND M.CURSO='21-22'
-- 25.	Relaci?n de asignaturas que imparti? el profesor Juan Antonio Cuello el curso pasado ordenada.
SELECT * FROM PROFESORES P NATURAL JOIN IMPARTE I INNER JOIN ASIGNATURAS A ON A.CODAS=I.CODAS WHERE P.NOMBRE='Juan Antonio' AND P.APELLIDOS='Cuello' AND I.CURSO='20-21'
-- 26.	Calificaci?n media de los alumnos que tienen una nota media mayor de 5.
SELECT AVG(NOTA) NOTA_MEDIA FROM NOTAS GROUP BY CODAL HAVING AVG(NOTA)>5
-- 27.	Igual que la anterior, pero mostrando el nombre, apellidos y ciudad del alumno.
SELECT NOMBRE,APELLIDOS,CIUDAD,AVG(NOTA) NOTA_MEDIA FROM NOTAS NATURAL JOIN ALUMNOS GROUP BY CODAL,NOMBRE,APELLIDOS,CIUDAD HAVING AVG(NOTA)>5
-- 28.	N?mero de alumnos matriculados en las asignaturas de 1? SMyR este curso.
SELECT COUNT(CODAL) FROM MATRICULA WHERE CURSO='21-22' AND CODAS IN (SELECT CODAS FROM ASIGNATURAS WHERE CURSO='1' AND NIVEL='SMyR')
-- 29.	Relaci?n de profesores que hayan impartido alguna vez la asignatura de matem?ticas en 1? de ESO.
SELECT * FROM PROFESORES WHERE CODPR IN (SELECT CODPR FROM IMPARTE WHERE CURSO='21-22' AND CODAS IN (SELECT CODAS FROM ASIGNATURAS WHERE CURSO='1' AND NIVEL='ESO' AND NOMBRE='MATEMATICAS'))
-- 30.	Igual que la anterior, pero mostrando el curso acad?mico en que la han impartido.
SELECT * FROM PROFESORES NATURAL JOIN IMPARTE WHERE CODAS IN (SELECT CODAS FROM ASIGNATURAS WHERE CURSO='1' AND NIVEL='ESO' AND NOMBRE='MATEMATICAS')
-- 31.	?Cu?ntas calificaciones tenemos de cada alumno en la base de datos? Queremos que aparezca el nombre del alumno y el n?mero de calificaciones.
SELECT CODAL,NOMBRE,COUNT(NOTA) "NUMERO CALIFICACIONES" FROM NOTAS NATURAL JOIN ALUMNOS GROUP BY CODAL,NOMBRE
-- 32.	Lo mismo que la anterior, pero mostrando tambi?n los alumnos de los que no tengamos ninguna calificaci?n.
SELECT N.CODAL,A.NOMBRE,COUNT(N.NOTA) "NUMERO CALIFICACIONES"  FROM NOTAS N RIGHT JOIN ALUMNOS A ON N.CODAL=A.CODAL GROUP BY N.CODAL,A.NOMBRE
-- 33.	Relaci?n de profesores que ganan m?s que todos los profesores de inform?tica.
SELECT * FROM PROFESORES WHERE SUELDO > (SELECT MAX(SUELDO) FROM PROFESORES WHERE DEPARTAMENTO='INFORMATICA')
-- 34.	Relaci?n de profesores que ganan m?s que alguno de los profesores de inform?tica.
SELECT * FROM PROFESORES WHERE SUELDO > (SELECT MIN(SUELDO) FROM PROFESORES WHERE DEPARTAMENTO='INFORMATICA')
-- 35.	Incrementa en un 10% el sueldo de los profesores de inform?tica.
UPDATE PROFESORES SET SUELDO=SUELDO*1.1 WHERE DEPARTAMENTO='INFORMATICA'
-- 36.	Relaci?n de alumnos y asignatura a los que da clase este curso el profesor Juan Valera Ortega ordenada por asignatura y alumno.
SELECT AL.APELLIDOS,AL.NOMBRE,A.NOMBRE FROM ALUMNOS AL INNER JOIN MATRICULA M ON AL.CODAL=M.CODAL INNER JOIN ASIGNATURAS A ON M.CODAS=A.CODAS INNER JOIN IMPARTE I ON A.CODAS=I.CODAS INNER JOIN PROFESORES P ON I.CODPR=P.CODPR WHERE P.NOMBRE='JUAN' AND P.APELLIDOS='VALERA ORTEGA' AND M.CURSO='21-22' AND I.CURSO='21-22' ORDER BY AL.APELLIDOS,AL.NOMBRE,A.NOMBRE
-- 37.	Aumenta en 0,1 puntos las calificaciones de Gesti?n de bases de datos del alumno Emilio Parra Sanz.
UPDATE NOTAS SET NOTA=NOTA+0.1 WHERE CODAS=(SELECT CODAS FROM ASIGNATURAS WHERE NOMBRE='Gesti?n de bases de datos') AND CODAL=(SELECT CODAL FROM ALUMNOS WHERE NOMBRE='Emilio' AND APELLIDOS='Parra Sanz')
-- 38.	Elimina los alumnos que no tengan calificaciones.
DELETE FROM ALUMNOS WHERE CODAL NOT IN (SELECT CODAL FROM NOTAS)
-- 39.	Alumnos que aprobaron todos los ex?menes de Gesti?n de bases de datos.
SELECT * FROM ALUMNOS A WHERE NOT EXISTS (SELECT * FROM NOTAS WHERE NOTA<5 AND CODAS = (SELECT CODAS FROM ASIGNATURAS WHERE NOMBRE='Gesti?n de bases de datos') AND CODAL=A.CODAL) AND CODAL IN (SELECT CODAL FROM NOTAS WHERE CODAS = (SELECT CODAS FROM ASIGNATURAS WHERE NOMBRE='Gesti?n de bases de datos'))
-- 40.	Alumnos matriculados en todas las asignaturas de 1? ASIR.
SELECT * FROM ALUMNOS A WHERE NOT EXISTS (SELECT * FROM ASIGNATURAS WHERE CURSO='1' AND NIVEL = 'ASIR' AND CODAS NOT IN (SELECT CODAS FROM MATRICULA WHERE CURSO='21-22' AND CODAL=A.CODAL))
