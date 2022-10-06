-- EJERCICIOS SQL
-- Para realizar las siguientes consultas serán necesarias las tablas creadas por el script SQL proporcionado. Haced primero un listado de tablas y una descripción de las mismas.
-- 1.	A partir de la tabla EMPLE mostrar todos los empleados del departamento 20 ordenados por Apellido. Los campos a mostrar son nº empleado, apellido, oficio y nº departamento.
SELECT EMP_NO,APELLIDO,OFICIO,DEPT_NO FROM EMPLE WHERE DEPT_NO="20" ORDER BY APELLIDO
-- 2.	Obtener los empleados cuyo oficio sea 'ANALISTA' ordenados por el número de empleado.
SELECT * FROM EMPLE WHERE OFICIO='ANALISTA' ORDER BY EMP_NO
-- 3.	Obtener los empleados del departamento 10 cuyo oficio sea 'ANALISTA' ordenados descendentemente por el número de empleado.
SELECT * FROM EMPLE WHERE OFICIO='ANALISTA' AND DEPT_NO=10
ORDER BY EMP_NO
-- 4.	A partir de la tabla ALUM0405 (hacer descripción de la tabla: DESC ALUM0405), obtener:
-- ?	Todos los datos de los alumnos.
SELECT * FROM ALUM0405
-- ?	Todos los datos de los alumnos cuya población sea 'GUADALAJARA'.
SELECT * FROM ALUM0405 WHERE POBLACION='GUADALAJARA'
-- ?	Apellidos y nombre de los alumnos cuya población sea 'GUADALAJARA'.
SELECT APELLIDOS,NOMBRE FROM ALUM0405 WHERE POBLACION='GUADALAJARA'
-- ?	DNI, nombre, apellidos, curso, nivel y clase de todos los alumnos ordenados por apellidos y nombre.
SELECT DNI,NOMBRE,APELLIDOS,CURSO,NIVEL,CLASE  FROM ALUM0405 ORDER BY APELLIDOS,NOMBRE
-- 5.	A partir de la tabla NOTAS_ALUMNOS, obtener la nota media de cada alumno visualizando su nombre.
SELECT NOMBRE_ALUMNO,(NOTA1+NOTA2+NOTA3)/3 FROM NOTAS_ALUMNOS  
-- 6.	Obtener los alumnos que tengan un 7 en Nota1 y cuya media sea mayor que 6.
SELECT NOMBRE_ALUMNO,(NOTA1+NOTA2+NOTA3)/3 FROM NOTAS_ALUMNOS   
WHERE NOTA1=7 AND (NOTA1+NOTA2+NOTA3)/3>6
-- 7.	A partir de la tabla EMPLE, obtener los empleados cuyo apellido empiece por 'J'.
SELECT * FROM EMPLE WHERE APELLIDO LIKE 'J%'
-- 8.	Obtener los empleados cuyo apellido tenga una 'R' en la segunda posición.
SELECT * FROM EMPLE WHERE APELLIDO LIKE '_R%'
-- 9.	Obtener los empleados cuyo apellido empiece por 'A' y tenga una 'O' en su interior.
SELECT * FROM EMPLE WHERE APELLIDO LIKE 'A%O%'
-- 10.	Obtén (de dos maneras diferentes) los empleados cuyo oficio sea 'ANALISTA', 'VENDEDOR' o 'EMPLEADO'.
SELECT * FROM EMPLE WHERE OFICIO='ANALISTA' OR OFICIO='VENDEDOR' OR OFICIO='EMPLEADO'
SELECT * FROM EMPLE WHERE OFICIO IN ('ANALISTA','VENDEDOR','EMPLEADO')
-- 11.	Obtén (de dos maneras diferentes) los empleados cuyo oficio no sea 'ANALISTA', ni 'VENDEROR' ni 'EMPLEADO'.
SELECT * FROM EMPLE WHERE OFICIO<>'ANALISTA' AND OFICIO<>'VENDEDOR' AND OFICIO<>'EMPLEADO'
SELECT * FROM EMPLE WHERE NOT (OFICIO='ANALISTA' OR OFICIO='VENDEDOR' OR OFICIO='EMPLEADO')
SELECT * FROM EMPLE WHERE OFICIO NOT IN ('ANALISTA','VENDEDOR','EMPLEADO')
-- 12.	Obtener (de dos maneras diferentes) los empleados cuyo salario esté comprendido entre 1500 y 2000.
SELECT * FROM EMPLE WHERE SALARIO BETWEEN 1500 AND 2000
SELECT * FROM EMPLE WHERE SALARIO>=1500 AND SALARIO<=2000
-- 13.	Obtener (de dos maneras diferentes) los empleados cuyo salario no esté comprendido entre 1500 y 2000.
SELECT * FROM EMPLE WHERE SALARIO NOT BETWEEN 1500 AND 2000
SELECT * FROM EMPLE WHERE SALARIO<1500 OR SALARIO>2000
-- 14.	Obtener los empleados de los departamentos 10 y 20 cuyo salario sea mayor de 2000.
SELECT * FROM EMPLE WHERE SALARIO>2000 AND (DEPT_NO=20 OR DEPT_NO=10)
SELECT * FROM EMPLE WHERE SALARIO>2000 AND DEPT_NO IN (10,20)
-- 15.	Obtén los empleados con el mismo oficio que 'GIL'.
SELECT * FROM EMPLE WHERE OFICIO=
(SELECT OFICIO FROM EMPLE WHERE APELLIDO='GIL')
-- 16.	Usando las tablas EMPLE y DEPART obtener todos los datos de los empleados que trabajen en 'Madrid' o 'Barcelona'.
SELECT * FROM EMPLE WHERE DEPT_NO IN
(SELECT DEPT_NO FROM DEPART WHERE LOC='Madrid' OR LOC='Barcelona')
SELECT * FROM EMPLE WHERE DEPT_NO IN
(SELECT DEPT_NO FROM DEPART WHERE LOC IN ('Madrid','Barcelona'))
-- 17.	Obtén los apellidos y oficios de los empleados que tienen el mismo oficio que 'JIMENEZ'.
SELECT APELLIDO,OFICIO FROM EMPLE WHERE OFICIO IN
(SELECT OFICIO FROM EMPLE WHERE APELLIDO='JIMENEZ')
-- 18.	Muestra el apellido, oficio y salario de los empleados del departamento de 'Fernandez' que tengan su mismo salario.
SELECT APELLIDO,OFICIO,SALARIO FROM EMPLE WHERE 
SALARIO=(SELECT SALARIO FROM EMPLE WHERE APELLIDO='FERNANDEZ') AND 
DEPT_NO=(SELECT DEPT_NO FROM EMPLE WHERE APELLIDO='FERNANDEZ' AND SALARIO)
-- 19.	Muestra el nº de empleado, apellido, salario, nombre del departamento y localidad del departamento para todos los empleados.
SELECT * FROM EMPLE E,DEPART D WHERE E.DEPT_NO=D.DEPT_NO //COLUMNA FK DUPLICADA YA QUE LA FK DE DEPART Y EMPLE SE LLAMAN IGUAL
SELECT EMP_NO,APELLIDO,SALARIO,DNOMBRE,LOC FROM EMPLE NATURAL JOIN DEPART //SOLUCION
-- 20.	Considerando las tablas ALUMNOS, ASIGNATURAS y NOTAS obtén los alumnos que tengan una nota entre 7 y 8 en 'Fol'.
SELECT APENOM FROM ALUMNOS NATURAL JOIN NOTAS WHERE NOTA BETWEEN 7 AND 8 AND COD=
(SELECT COD FROM ASIGNATURAS WHERE NOMBRE='FOL')

SELECT APENOM FROM ALUMNOS NATURAL JOIN NOTAS NATURAL JOIN ASIGNATURAS
WHERE NOMBRE='FOL' AND NOTA BETWEEN 7 AND 8

SELECT APENOM FROM ALUMNOS A INNER JOIN NOTAS N ON A.DNI=N.DNI
INNER JOIN ASIGNATURAS AI ON N.COD=AI.COD WHERE NOMBRE='FOL'
AND NOTA BETWEEN 7 AND 8
-- 21.	Muestra los nombres de las asignaturas que no tengan suspensos.
SELECT NOMBRE FROM ASIGNATURAS WHERE COD NOT IN
(SELECT COD FROM NOTAS WHERE NOTA<5)
-- 22.	Usando las tablas EMPLE y DEPART, muestra apellido, oficio y localidad del departamento para aquellos empleados cuyo oficio sea 'Analista'.
SELECT APELLIDO,OFICIO,LOC FROM EMPLE NATURAL JOIN DEPART WHERE OFICIO='ANALISTA'

SELECT APELLIDO,OFICIO,LOC FROM EMPLE E INNER JOIN DEPART D ON E.DEPT_NO=D.DEPT_NO WHERE OFICIO='ANALISTA'
-- 23.	Obtén los datos de los empleados cuyo director sea 'Cerezo'.
SELECT * FROM EMPLE WHERE DIR=
(SELECT EMP_NO FROM EMPLE WHERE APELLIDO='CEREZO')
-- 24.	Obtén los datos de los empleados del departamento de 'Ventas'.
SELECT * FROM EMPLE WHERE DEPT_NO=
(SELECT DEPT_NO FROM DEPART WHERE DNOMBRE='VENTAS')

SELECT * FROM EMPLE NATURAL JOIN DEPART WHERE DNOMBRE='VENTAS'
-- 25.	Obtener los datos de los departamentos que no tengan empleados.
SELECT * FROM DEPART WHERE DEPT_NO NOT IN 
(SELECT DEPT_NO FROM EMPLE)
-- 26.	Obtener los datos de los departamentos que tengan empleados.
SELECT * FROM DEPART WHERE DEPT_NO IN 
(SELECT DEPT_NO FROM EMPLE)
-- 27.	Obtén apellido y salario de los empleados que superen todos los salarios de los empleados del departamento 20.
SELECT APELLIDO,SALARIO FROM EMPLE WHERE SALARIO>
(SELECT MAX(SALARIO) FROM EMPLE WHERE DEPT_NO=20)
-- 28.	Utilizando la tabla LIBRERÍA, visualiza el estante, tema y ejemplares de los libros cuyo estante no esté comprendido entre la 'B' y la 'D'.
SELECT * FROM LIBRERIA WHERE ESTANTE NOT BETWEEN 'B' AND 'D'
-- 29.	Muestra los temas cuyo número de ejemplares sea inferior a los que hay en 'Medicina'.
SELECT * FROM LIBRERIA WHERE EJEMPLARES<
(SELECT EJEMPLARES FROM LIBRERIA WHERE TEMA='MEDICINA')
-- 30.	Muestra los temas cuyo número de ejemplares no esté comprendido entre 15 y 20, ambos incluidos.
SELECT TEMA FROM LIBRERIA WHERE EJEMPLARES NOT IN
(SELECT EJEMPLARES FROM LIBRERIA WHERE EJEMPLARES BETWEEN 15 AND 20)
-- 31.	Considerando las tablas ALUMNOS, ASIGNATURAS y NOTAS, muestra las asignaturas que contengan tres letras 'o' en su interior y tengan alumnos matriculados de 'Madrid'.
SELECT * FROM ASIGNATURAS WHERE NOMBRE LIKE "%o%o%o%" AND COD IN
(SELECT COD FROM NOTAS WHERE DNI IN(
SELECT DNI FROM ALUMNOS WHERE POBLA="MADRID"))
-- 32.	Muestra los nombres de los alumnos de 'Madrid' que tengan alguna asignatura suspendida.
SELECT APENOM FROM ALUMNOS WHERE POBLA="MADRID" AND DNI IN
(SELECT DNI FROM NOTAS WHERE NOTA<5)
-- 33.	Muestra los nombres de los alumnos que tengan la misma nota que tiene 'Díaz Fernández, María' en FOL, en alguna asignatura.
SELECT APENOM FROM ALUMNOS WHERE DNI IN
(SELECT DNI FROM NOTAS WHERE NOTA=(SELECT NOTA FROM NOTAS WHERE DNI= (SELECT DNI FROM ALUMNOS WHERE APENOM="Díaz Fernández, María") AND COD=
(SELECT COD FROM ASIGNATURAS WHERE NOMBRE='FOL')))
-- 34.	Obtén los datos de las asignaturas que no tengan alumnos.
SELECT * FROM ASIGNATURAS WHERE COD NOT IN
(SELECT COD FROM NOTAS)
-- 35.	Obtén el nombre y apellido de los alumnos que tengan nota en la asignatura con código 1.
SELECT APENOM FROM ALUMNOS WHERE DNI IN
(SELECT DNI FROM NOTAS WHERE COD=1)
-- 36.	Obtén el nombre y apellido de los alumnos que no tengan nota en la asignatura con código 1.
SELECT APENOM FROM ALUMNOS WHERE DNI NOT IN
(SELECT DNI FROM NOTAS WHERE COD=1)
-- 37.	Muestra los alumnos con todas las asignaturas aprobadas (Consultas Coorrelacionadas / Test de Existencia / AL REVÉS).
-- Todas suspensas
SELECT * FROM ALUMNOS NATURAL JOIN ASIGNATURAS WHERE COD IN
(SELECT COD FROM NOTAS WHERE NOTA>=5)
-- Alguna suspensa
SELECT * FROM ALUMNOS WHERE DNI IN
(SELECT DNI FROM NOTAS WHERE NOTA>5)
-- 38.	Muestra los alumnos que estén matriculados en todas las asignaturas (Consultas Coorrelacionadas / Test de Existencia / AL REVÉS
SELECT * FROM ALUMNOS WHERE NOT EXISTS
(SELECT COD FROM ASIGNATURAS WHERE COD NOT IN (SELECT COD
FROM NOTAS WHERE DNI=ALUMNOS.DNI))
