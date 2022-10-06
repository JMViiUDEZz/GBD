-- Preguntas SQL Galería de Arte
-- 1.	Relación de clientes de Huercal-Overa, Albox y Pulpi
SELECT * FROM CLIENTES WHERE DIRECCION LIKE '%HUERCAL-OVERA%' OR DIRECCION LIKE '%ALBOX%' OR DIRECCION LIKE '%PULPI%'
-- 2.	Datos del pintor que pinto el cuadro "Naturaleza muerta" del año 1993
SELECT * FROM PINTORES NATURAL JOIN CUADROS WHERE TITULO='Naturaleza muerta' AND ANNO='1993'
-- 3.	Pintoras que han pintado cuadros en el año 2000
SELECT * FROM PINTORES NATURAL JOIN CUADROS WHERE SEXO='M' AND ANNO='2000'
-- 4.	Relación de cuadros con precios comprendidos entre 2000 y 2500 €
SELECT * FROM CUADROS WHERE PRECIO BETWEEN 2000 AND 2500
-- 5.	Relación de acuarelas pintadas por pintores de Murcia
SELECT * FROM PINTORES NATURAL JOIN CUADROS WHERE ESTILO='ACUARELA' AND CIUDAD='MURCIA'
-- 6.	Nombre del pintor que ha pintado el cuadro más caro
SELECT P.NOMBRE FROM CUADROS C NATURAL JOIN PINTORES P WHERE C.PRECIO IN (SELECT MAX(PRECIO) FROM CUADROS)
-- 7.	Número de obras realizadas por cada pintor (se incluirá el nombre del artista)
SELECT P.ID_PINTOR,P.NOMBRE,COUNT(C.ID_CUADRO) FROM CUADROS C NATURAL JOIN PINTORES P GROUP BY P.ID_PINTOR
-- 8.	Año y artista del cuadro más barato de la galería.
SELECT P.NOMBRE,C.ANNO FROM CUADROS C NATURAL JOIN PINTORES P WHERE C.PRECIO IN (SELECT MIN(PRECIO) FROM CUADROS)
-- 9.	Número total de cuadros según el estado en que se encuentran.
SELECT C.ESTADO,COUNT(C.ID_CUADRO) FROM CUADROS C NATURAL JOIN PINTORES P GROUP BY C.ESTADO
-- 10.	Relación de cuadros comprados por el cliente Juan Peregrin Mateo
SELECT * FROM CUADROS C NATURAL JOIN VENTAS V WHERE NIF_CLIENTE=(SELECT NIF FROM CLIENTES WHERE NOMBRE='Juan Peregrin Mateo')
-- 11.	Indica la diferencia entre el precio y el precio de venta del cuadro más grande de los que se han vendido.
SELECT MAX(C.DIMENSIONES),C.PRECIO-V.PRECIOVENTA FROM CUADROS C NATURAL JOIN VENTAS V
-- 12.	¿Cuántos cuadros ha vendido el pintor Pepe Bernal?
SELECT P.ID_PINTOR,P.NOMBRE,COUNT(C.ID_CUADRO) FROM CUADROS C NATURAL JOIN PINTORES P WHERE P.NOMBRE='PEPE BERNAL' GROUP BY P.ID_PINTOR
-- 13.	¿Cuánto dinero ha ingresado la galería por las ventas realizadas en el ano 2012?
SELECT SUM(V.PRECIOVENTA-V.COMISION) FROM CUADROS C NATURAL JOIN VENTAS V WHERE C.ANNO='2021'
-- 14.	Importe total de los estilos que superan los 1000 €
SELECT ESTILO, SUM(PRECIO) FROM CUADROS GROUP BY ESTILO HAVING SUM(PRECIO)>1000
-- 15.	Relación de cuadros que el pintor Diego Bonillo tiene disponibles en la galería.
SELECT * FROM CUADROS C NATURAL JOIN PINTORES P WHERE P.NOMBRE='DIEGO BONILLO' AND C.ESTADO='DISPONIBLE'
-- 16.	Ganancias totales de la galería en toda su historia (la ganancia se calcula por el precio de venta y la comisión que obtiene la galería por la venta).
SELECT SUM(V.PRECIOVENTA-V.COMISION) FROM CUADROS C NATURAL JOIN VENTAS V
-- 17.	Relación de clientes que han comprado algún cuadro a un pintor de su misma localidad.
SELECT * FROM CLIENTES CL INNER JOIN VENTAS V ON CL.NIF=V.NIF_CLIENTE NATURAL JOIN CUADROS C INNER JOIN PINTORES P ON C.ID_PINTOR=P.ID_PINTOR WHERE CL.DIRECCION LIKE CONCAT('%',P.CIUDAD,'%')
-- 18.	Características y datos del pintor del último cuadro vendido por la galería.
SELECT *,MIN(FECHAVENTA) FROM PINTORES P NATURAL JOIN CUADROS C NATURAL JOIN VENTAS
-- 19.	Relación de clientes que no han comprado ningún cuadro en el último año.
SELECT * FROM CLIENTES CL WHERE NIF NOT IN (SELECT NIF_CLIENTE FROM VENTAS WHERE FECHAVENTA=SUBDATE(NOW(), INTERVAL 1 YEAR))
-- 20.	Parejas de pintores de la misma localidad.
SELECT DISTINCT * FROM PINTORES P1 CROSS JOIN PINTORES P2 WHERE P1.CIUDAD=P2.CIUDAD AND P1.ID_PINTOR!=P2.ID_PINTOR
