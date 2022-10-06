-- CUESTIONES SQL BD EMPRESA TELEFON�A

-- 1.	Crea la siguiente tabla en la base de datos:
TELEFONOS (IMEI, MARCA, MODELO, FECHA, PRECIO)
CREATE TABLE TELEFONOS (
IMEI NUMERIC(5) PRIMARY KEY,
MARCA VARCHAR(10),
MODELO VARCHAR(20),
FECHA DATE,
PRECIO DECIMAL(4,2)
)
-- 2.	A�ade a la tabla anterior el campo COLOR para indicar el color del aparato.
ALTER TABLE TELEFONOS ADD COLOR VARCHAR(10)
-- 3.	Inserta dos registros en la tabla TELEFONOS.
INSERT INTO TELEFONOS VALUES (11111,'IPHONE','8','2020-01-20',300, 'NEGRO'),
(22222,'IPHONE','10','2021-01-30',500, 'ROJO')
-- 4.	Borra las llamadas que realizaran los n�meros de Prepago el �ltimo trimestre del a�o pasado.
DELETE FROM LLAMADAS WHERE 
INSTANTE >=SUBDATE(NOW(), INTERVAL 15 MONTH)
AND NUMERO IN (SELECT NUMERO FROM NUMEROS WHERE TIPO='PREPAGO')
-- 5.	Incrementa en 10 euros el saldo de los tel�fonos de Prepago de Ana Torrente Ortega.
UPDATE NUMEROS SET SALDO=SALDO+10 WHERE TIPO='PREPAGO' AND CLIENTE =
(SELECT DNICLIENTE FROM CLIENTES WHERE NOMBRE='ANA' AND APELLIDOS='TORRENTE ORTEGA')
-- 6.	Relaci�n de clientes de Vera y Pulp� dados de alta el a�o pasado.
SELECT * FROM CLIENTES WHERE YEAR(FECHAALTA)=�2021� 
AND CIUDAD IN ('VERA','PULPI')
-- 7.	N�mero y fecha de alta de los n�meros de tel�fono del cliente Emilio Blanco P�rez.
SELECT NUMERO,FECHAALTA FROM NUMEROS WHERE CLIENTE IN
(SELECT DNICLIENTE FROM CLIENTES WHERE NOMBRE='EMILIO' AND APELLIDOS='BLANCO PEREZ')
-- 8.	N�mero de tel�fono, nombre de la tarifa y precio por minuto de esta de los tel�fonos del cliente Emilio Blanco P�rez.
SELECT NUMERO,NOMBRE,PRECIOMINUTO FROM NUMEROS N INNER JOIN TARIFAS T 
ON N.`Tarifa`=T.`CodTarifa` WHERE CLIENTE IN
(SELECT DNICLIENTE FROM CLIENTES WHERE NOMBRE='EMILIO' AND APELLIDOS='BLANCO PEREZ')
-- 9.	N�mero total de tel�fonos que tiene cada cliente, indicando el DNI, Nombre y Apellidos del cliente.
SELECT C.`DNICliente`,C.`Nombre`,C.`Apellidos`,COUNT(N.NUMERO) FROM NUMEROS N 
INNER JOIN CLIENTES C ON N.`Cliente`=C.`DNICliente`
GROUP BY C.`DNICliente`,C.`Nombre`,C.`Apellidos`
-- 10.	Relaci�n de clientes que tienen m�s de un n�mero de tel�fono en la modalidad Prepago.
SELECT C.`DNICliente`,C.`Nombre`,C.`Apellidos`,COUNT(N.NUMERO) FROM NUMEROS N 
INNER JOIN CLIENTES C ON N.`Cliente`=C.`DNICliente`
WHERE TIPO='PREPAGO'
GROUP BY C.`DNICliente`,C.`Nombre`,C.`Apellidos`
HAVING COUNT(N.NUMERO)>1
-- 11.	N�meros de tel�fono que nunca han realizado ni recibido una llamada.
SELECT * FROM LLAMADAS WHERE NUMERO NOT IN (SELECT NUMERO FROM LLAMADAS)
-- 12.	N�meros de tel�fono que nunca han realizado una llamada pero que s� han recibido.
SELECT * FROM LLAMADAS WHERE NUMERO NOT IN (SELECT NUMERO FROM LLAMADAS WHERE TIPOLLAMADA='E')
-- 13.	N�mero total de tel�fonos que est�n acogidos a cada tarifa. Se debe indicar el nombre de la tarifa y contemplar que puede haber tarifas sin n�meros acogidos.
SELECT T.`CodTarifa`,T.`Nombre`,COUNT(N.NUMERO) FROM NUMEROS N 
RIGHT JOIN TARIFAS T ON N.`Tarifa`=T.`CodTarifa`
GROUP BY T.`CodTarifa`,T.`Nombre`
-- 14.	Relaci�n de n�meros de tel�fono con m�s de dos llamadas realizadas en lo que va de mes. 
SELECT N.NUMERO,COUNT(L.NUMERO) FROM NUMEROS N 
NATURAL JOIN LLAMADAS L
WHERE TIPOLLAMADA='E' AND INSTANTE>SUBDATE(NOW(), INTERVAL 1 MONTH)
GROUP BY N.NUMERO
HAVING COUNT(L.NUMERO)>2
-- 15.	Duraci�n media en segundos de las llamadas recibidas en el a�o 2013.
SELECT AVG(DURACION) FROM LLAMADAS L
WHERE YEAR(INSTANTE)=2013
-- 16.	Total de minutos que ha sido utilizado cada tel�fono de la cliente Maria Soler Asensio.
SELECT N.NUMERO,SUM(DURACION/60) FROM LLAMADAS L NATURAL JOIN NUMEROS N
WHERE CLIENTE IN
(SELECT DNICLIENTE FROM CLIENTES WHERE NOMBRE='MARIA' AND APELLIDOS='SOLER ASENSIO')
GROUP BY N.NUMERO
-- 17.	Duraci�n media en segundos de las llamadas realizadas por cada tel�fono en el a�o 2013 y cuya duraci�n media fuera superior a 30 segundos.
SELECT N.NUMERO,AVG(DURACION) FROM LLAMADAS L NATURAL JOIN NUMEROS N
WHERE YEAR(INSTANTE)=2013
GROUP BY N.NUMERO
HAVING AVG(DURACION)>30
-- 18.	Muestra los datos de los clientes que han realizado llamadas por un tiempo superior a 20 minutos.
SELECT C.`DNICliente`,C.`Nombre`,C.`Apellidos`,N.NUMERO,DURACION/60 FROM LLAMADAS L
 NATURAL JOIN NUMEROS N 
INNER JOIN CLIENTES C ON N.`Cliente`=C.`DNICliente`
WHERE DURACION/60>20
GROUP BY N.NUMERO
-- 19.	Gasto total en euros del cliente Jose Alvarez Barrendero en el mes de enero de 2014.
SELECT C.`DNICliente`,C.`Nombre`,C.`Apellidos`,SUM(N.`Saldo`) FROM NUMEROS N 
INNER JOIN CLIENTES C ON N.`Cliente`=C.`DNICliente`
WHERE C.`Nombre`='Jose' AND C.`Apellidos`='Alvarez Barrendero' AND YEAR(N.FECHAALTA)='2014' AND
MONTH(N.FECHAALTA)='01'
GROUP BY C.`DNICliente`,C.`Nombre`,C.`Apellidos`
-- 20.	N�mero de tel�fono, duraci�n total llamadas salientes y duraci�n total llamadas entrantes de los tel�fonos para los que la duraci�n total de llamadas salientes super� a la duraci�n total de las entrantes

