-- CUESTIONES SQL BD EMPRESA TELEFONÍA

-- 1.	Crea la siguiente tabla en la base de datos:
TELEFONOS (IMEI, MARCA, MODELO, FECHA, PRECIO)
CREATE TABLE TELEFONOS (
IMEI NUMERIC(5) PRIMARY KEY,
MARCA VARCHAR(10),
MODELO VARCHAR(20),
FECHA DATE,
PRECIO DECIMAL(4,2)
)
-- 2.	Añade a la tabla anterior el campo COLOR para indicar el color del aparato.
ALTER TABLE TELEFONOS ADD COLOR VARCHAR(10)
-- 3.	Inserta dos registros en la tabla TELEFONOS.
INSERT INTO TELEFONOS VALUES (11111,'IPHONE','8','2020-01-20',300, 'NEGRO'),
(22222,'IPHONE','10','2021-01-30',500, 'ROJO')
-- 4.	Borra las llamadas que realizaran los números de Prepago el último trimestre del año pasado.
DELETE FROM LLAMADAS WHERE 
INSTANTE >=SUBDATE(NOW(), INTERVAL 15 MONTH)
AND NUMERO IN (SELECT NUMERO FROM NUMEROS WHERE TIPO='PREPAGO')
-- 5.	Incrementa en 10 euros el saldo de los teléfonos de Prepago de Ana Torrente Ortega.
UPDATE NUMEROS SET SALDO=SALDO+10 WHERE TIPO='PREPAGO' AND CLIENTE =
(SELECT DNICLIENTE FROM CLIENTES WHERE NOMBRE='ANA' AND APELLIDOS='TORRENTE ORTEGA')
-- 6.	Relación de clientes de Vera y Pulpí dados de alta el año pasado.
SELECT * FROM CLIENTES WHERE YEAR(FECHAALTA)=’2021’ 
AND CIUDAD IN ('VERA','PULPI')
-- 7.	Número y fecha de alta de los números de teléfono del cliente Emilio Blanco Pérez.
SELECT NUMERO,FECHAALTA FROM NUMEROS WHERE CLIENTE IN
(SELECT DNICLIENTE FROM CLIENTES WHERE NOMBRE='EMILIO' AND APELLIDOS='BLANCO PEREZ')
-- 8.	Número de teléfono, nombre de la tarifa y precio por minuto de esta de los teléfonos del cliente Emilio Blanco Pérez.
SELECT NUMERO,NOMBRE,PRECIOMINUTO FROM NUMEROS N INNER JOIN TARIFAS T 
ON N.`Tarifa`=T.`CodTarifa` WHERE CLIENTE IN
(SELECT DNICLIENTE FROM CLIENTES WHERE NOMBRE='EMILIO' AND APELLIDOS='BLANCO PEREZ')
-- 9.	Número total de teléfonos que tiene cada cliente, indicando el DNI, Nombre y Apellidos del cliente.
SELECT C.`DNICliente`,C.`Nombre`,C.`Apellidos`,COUNT(N.NUMERO) FROM NUMEROS N 
INNER JOIN CLIENTES C ON N.`Cliente`=C.`DNICliente`
GROUP BY C.`DNICliente`,C.`Nombre`,C.`Apellidos`
-- 10.	Relación de clientes que tienen más de un número de teléfono en la modalidad Prepago.
SELECT C.`DNICliente`,C.`Nombre`,C.`Apellidos`,COUNT(N.NUMERO) FROM NUMEROS N 
INNER JOIN CLIENTES C ON N.`Cliente`=C.`DNICliente`
WHERE TIPO='PREPAGO'
GROUP BY C.`DNICliente`,C.`Nombre`,C.`Apellidos`
HAVING COUNT(N.NUMERO)>1
-- 11.	Números de teléfono que nunca han realizado ni recibido una llamada.
SELECT * FROM LLAMADAS WHERE NUMERO NOT IN (SELECT NUMERO FROM LLAMADAS)
-- 12.	Números de teléfono que nunca han realizado una llamada pero que sí han recibido.
SELECT * FROM LLAMADAS WHERE NUMERO NOT IN (SELECT NUMERO FROM LLAMADAS WHERE TIPOLLAMADA='E')
-- 13.	Número total de teléfonos que están acogidos a cada tarifa. Se debe indicar el nombre de la tarifa y contemplar que puede haber tarifas sin números acogidos.
SELECT T.`CodTarifa`,T.`Nombre`,COUNT(N.NUMERO) FROM NUMEROS N 
RIGHT JOIN TARIFAS T ON N.`Tarifa`=T.`CodTarifa`
GROUP BY T.`CodTarifa`,T.`Nombre`
-- 14.	Relación de números de teléfono con más de dos llamadas realizadas en lo que va de mes. 
SELECT N.NUMERO,COUNT(L.NUMERO) FROM NUMEROS N 
NATURAL JOIN LLAMADAS L
WHERE TIPOLLAMADA='E' AND INSTANTE>SUBDATE(NOW(), INTERVAL 1 MONTH)
GROUP BY N.NUMERO
HAVING COUNT(L.NUMERO)>2
-- 15.	Duración media en segundos de las llamadas recibidas en el año 2013.
SELECT AVG(DURACION) FROM LLAMADAS L
WHERE YEAR(INSTANTE)=2013
-- 16.	Total de minutos que ha sido utilizado cada teléfono de la cliente Maria Soler Asensio.
SELECT N.NUMERO,SUM(DURACION/60) FROM LLAMADAS L NATURAL JOIN NUMEROS N
WHERE CLIENTE IN
(SELECT DNICLIENTE FROM CLIENTES WHERE NOMBRE='MARIA' AND APELLIDOS='SOLER ASENSIO')
GROUP BY N.NUMERO
-- 17.	Duración media en segundos de las llamadas realizadas por cada teléfono en el año 2013 y cuya duración media fuera superior a 30 segundos.
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
-- 20.	Número de teléfono, duración total llamadas salientes y duración total llamadas entrantes de los teléfonos para los que la duración total de llamadas salientes superó a la duración total de las entrantes

