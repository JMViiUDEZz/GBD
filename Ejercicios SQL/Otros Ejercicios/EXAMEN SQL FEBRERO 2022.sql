-- 1.
CREATE TABLE EMPLEADOS(
EMP_NO DECIMAL(4,0) NOT NULL,
APELLIDO VARCHAR(10) NULL,
OFICIO VARCHAR(10) NULL,
DIR DECIMAL(4,0) NULL,
FECHA_ALT DATE NULL,
SALARIO DECIMAL(7,0) NULL,
COMISION DECIMAL(7,0) NULL,
DEPT_NO DECIMAL(2,0) NOT NULL
);

-- 2.
ALTER TABLE EMPLEADOS ADD NOMBRE VARCHAR(15) NULL; 
ALTER TABLE EMPLEADOS ADD FECHANAC DATE NULL; 
ALTER TABLE EMPLEADOS ADD CIUDAD VARCHAR(15) NULL; 

-- 3.
ALTER TABLE DEPART ADD PRIMARY KEY(DEPT_NO);
ALTER TABLE EMPLE
ADD PRIMARY KEY(EMP_NO),
ADD FOREIGN KEY(DEPT_NO) REFERENCES DEPART(DEPT_NO) ON DELETE CASCADE ON UPDATE CASCADE;

-- 4.
SELECT * FROM EMPLE WHERE DEPT_NO IN (10,20);

-- 5.
SELECT APELLIDO,SALARIO,OFICIO FROM EMPLE WHERE COMISION IS NULL AND SALARIO BETWEEN 2000 AND 2500;

-- 6.
SELECT DNOMBRE FROM DEPART WHERE DEPT_NO NOT IN (SELECT DEPT_NO FROM EMPLE);

-- 7.
SELECT D.DNOMBRE,D.LOC,COUNT(EMP_NO) "NUMERO EMPLEADOS" FROM DEPART D NATURAL JOIN EMPLE E GROUP BY DEPT_NO;

-- 8.
SELECT E.APELLIDO,OFICIO,SALARIO,D.APELLIDO FROM EMPLE E NATURAL JOIN EMPLE D WHERE YEAR(FECHA_ALT)='1990' AND E.DIR=D.DIR;

-- 9.
SELECT * FROM EMPLE NATURAL JOIN DEPART WHERE DNOMBRE='VENTAS' AND APELLIDO LIKE 'A%';

-- 10.
SELECT D.DNOMBRE,D.LOC,AVG(SALARIO) "SALARIO MEDIO" FROM DEPART D NATURAL JOIN EMPLE E GROUP BY DEPT_NO;

-- 11.
SELECT NOMBRECLIENTE,CIUDAD,COUNT(CODIGOPEDIDO) "NUMERO PEDIDOS" FROM PEDIDOS NATURAL JOIN CLIENTES GROUP BY CODIGOCLIENTE HAVING COUNT(CODIGOPEDIDO)>5;

-- 12.
SELECT CODIGOPEDIDO,FECHAPEDIDO,SUM(CANTIDAD*PRECIOUNIDAD) "IMPORTE TOTAL" FROM PEDIDOS NATURAL JOIN DETALLEPEDIDOS GROUP BY CODIGOPEDIDO;

-- 13.
SELECT CODIGOPRODUCTO,NOMBRE FROM PRODUCTOS WHERE CANTIDADENSTOCK IN ((SELECT MAX(CANTIDADENSTOCK) FROM PRODUCTOS),(SELECT MIN(CANTIDADENSTOCK) FROM PRODUCTOS));
SELECT CODIGOPRODUCTO,NOMBRE FROM PRODUCTOS WHERE CantidadEnStock=(SELECT MAX(CANTIDADENSTOCK) FROM PRODUCTOS) OR CantidadEnStock=(SELECT MIN(CANTIDADENSTOCK) FROM PRODUCTOS);

-- 14.
SELECT CODIGOOFICINA,COUNT(CODIGOEMPLEADO) FROM OFICINAS NATURAL JOIN EMPLEADOS GROUP BY CODIGOOFICINA HAVING COUNT(CODIGOEMPLEADO)<10;

-- 15.
SELECT DISTINCT NOMBRECLIENTE FROM CLIENTES NATURAL JOIN PEDIDOS WHERE FechaEsperada<FechaEntrega;

-- 16.
SELECT MAX(IMPORTE) FROM (SELECT SUM(CANTIDAD*PRECIOUNIDAD) AS IMPORTE FROM PEDIDOS NATURAL JOIN DETALLEPEDIDOS GROUP BY CODIGOPEDIDO) AS TABLA;

-- 17.
SELECT N.NOMBRECLIENTE,N.LIMITECREDITO,L.NOMBRECLIENTE,L.LIMITECREDITO FROM CLIENTES N CROSS JOIN CLIENTES L WHERE N.LIMITECREDITO=L.LIMITECREDITO;

-- 18.
SELECT * FROM CLIENTES NATURAL JOIN PAGOS WHERE CANTIDAD>1000 AND FECHAPAGO BETWEEN '2000-01-01' AND '2001-12-31';

-- 19.
SELECT SUM(CANTIDAD*PRECIOUNIDAD) "TOTAL FACTURADO" FROM DETALLEPEDIDOS NATURAL JOIN PEDIDOS WHERE YEAR(FECHAPEDIDO)=2000;

-- 20.
SELECT C.CODIGOEMPLEADOREPVENTAS,E.NOMBRE,COUNT(C.CODIGOCLIENTE) "NUMERO CLIENTES" FROM CLIENTES C NATURAL JOIN EMPLEADOS E WHERE E.CODIGOEMPLEADO=C.CODIGOEMPLEADOREPVENTAS GROUP BY C.CODIGOEMPLEADOREPVENTAS HAVING COUNT(C.CODIGOCLIENTE)>2;