-- Preguntas SQL Galer�a de Arte
-- 1.	Relaci�n de clientes de Huercal-Overa, Albox y Pulpi
SELECT * FROM CLIENTES WHERE DIRECCION LIKE '%HUERCAL-OVERA%' OR DIRECCION LIKE '%ALBOX%' OR DIRECCION LIKE '%PULPI%'
-- 2.	Datos del pintor que pinto el cuadro "Naturaleza muerta" del a�o 1993
SELECT * FROM PINTORES NATURAL JOIN CUADROS WHERE TITULO='Naturaleza muerta' AND ANNO='1993'
-- 3.	Pintoras que han pintado cuadros en el a�o 2000
SELECT * FROM PINTORES NATURAL JOIN CUADROS WHERE SEXO='M' AND ANNO='2000'
-- 4.	Relaci�n de cuadros con precios comprendidos entre 2000 y 2500 �
SELECT * FROM CUADROS WHERE PRECIO BETWEEN 2000 AND 2500
-- 5.	Relaci�n de acuarelas pintadas por pintores de Murcia
SELECT * FROM PINTORES NATURAL JOIN CUADROS WHERE ESTILO='ACUARELA' AND CIUDAD='MURCIA'
-- 6.	Nombre del pintor que ha pintado el cuadro m�s caro
SELECT P.NOMBRE FROM CUADROS C NATURAL JOIN PINTORES P WHERE C.PRECIO IN (SELECT MAX(PRECIO) FROM CUADROS)
-- 7.	N�mero de obras realizadas por cada pintor (se incluir� el nombre del artista)
SELECT P.ID_PINTOR,P.NOMBRE,COUNT(C.ID_CUADRO) FROM CUADROS C NATURAL JOIN PINTORES P GROUP BY P.ID_PINTOR
-- 8.	A�o y artista del cuadro m�s barato de la galer�a.
SELECT P.NOMBRE,C.ANNO FROM CUADROS C NATURAL JOIN PINTORES P WHERE C.PRECIO IN (SELECT MIN(PRECIO) FROM CUADROS)
-- 9.	N�mero total de cuadros seg�n el estado en que se encuentran.
SELECT C.ESTADO,COUNT(C.ID_CUADRO) FROM CUADROS C NATURAL JOIN PINTORES P GROUP BY C.ESTADO
-- 10.	Relaci�n de cuadros comprados por el cliente Juan Peregrin Mateo
SELECT * FROM CUADROS C NATURAL JOIN VENTAS V WHERE NIF_CLIENTE=(SELECT NIF FROM CLIENTES WHERE NOMBRE='Juan Peregrin Mateo')
-- 11.	Indica la diferencia entre el precio y el precio de venta del cuadro m�s grande de los que se han vendido.
SELECT MAX(C.DIMENSIONES),C.PRECIO-V.PRECIOVENTA FROM CUADROS C NATURAL JOIN VENTAS V
-- 12.	�Cu�ntos cuadros ha vendido el pintor Pepe Bernal?
SELECT P.ID_PINTOR,P.NOMBRE,COUNT(C.ID_CUADRO) FROM CUADROS C NATURAL JOIN PINTORES P WHERE P.NOMBRE='PEPE BERNAL' GROUP BY P.ID_PINTOR
-- 13.	�Cu�nto dinero ha ingresado la galer�a por las ventas realizadas en el ano 2012?
SELECT SUM(V.PRECIOVENTA-V.COMISION) FROM CUADROS C NATURAL JOIN VENTAS V WHERE C.ANNO='2021'
-- 14.	Importe total de los estilos que superan los 1000 �
SELECT ESTILO, SUM(PRECIO) FROM CUADROS GROUP BY ESTILO HAVING SUM(PRECIO)>1000
-- 15.	Relaci�n de cuadros que el pintor Diego Bonillo tiene disponibles en la galer�a.
SELECT * FROM CUADROS C NATURAL JOIN PINTORES P WHERE P.NOMBRE='DIEGO BONILLO' AND C.ESTADO='DISPONIBLE'
-- 16.	Ganancias totales de la galer�a en toda su historia (la ganancia se calcula por el precio de venta y la comisi�n que obtiene la galer�a por la venta).
SELECT SUM(V.PRECIOVENTA-V.COMISION) FROM CUADROS C NATURAL JOIN VENTAS V
-- 17.	Relaci�n de clientes que han comprado alg�n cuadro a un pintor de su misma localidad.
SELECT * FROM CLIENTES CL INNER JOIN VENTAS V ON CL.NIF=V.NIF_CLIENTE NATURAL JOIN CUADROS C INNER JOIN PINTORES P ON C.ID_PINTOR=P.ID_PINTOR WHERE CL.DIRECCION LIKE CONCAT('%',P.CIUDAD,'%')
-- 18.	Caracter�sticas y datos del pintor del �ltimo cuadro vendido por la galer�a.
SELECT *,MIN(FECHAVENTA) FROM PINTORES P NATURAL JOIN CUADROS C NATURAL JOIN VENTAS
-- 19.	Relaci�n de clientes que no han comprado ning�n cuadro en el �ltimo a�o.
SELECT * FROM CLIENTES CL WHERE NIF NOT IN (SELECT NIF_CLIENTE FROM VENTAS WHERE FECHAVENTA=SUBDATE(NOW(), INTERVAL 1 YEAR))
-- 20.	Parejas de pintores de la misma localidad.
SELECT DISTINCT * FROM PINTORES P1 CROSS JOIN PINTORES P2 WHERE P1.CIUDAD=P2.CIUDAD AND P1.ID_PINTOR!=P2.ID_PINTOR
