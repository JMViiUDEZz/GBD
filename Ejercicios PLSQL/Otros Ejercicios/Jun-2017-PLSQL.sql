--1
CREATE OR REPLACE PROCEDURE EX_2017_1(CD DEPART.DEPT_NO%TYPE)
AS
 CURSOR C IS SELECT * FROM EMPLEADOS NATURAL JOIN DEPART WHERE DEPT_NO=CD
 ORDER BY APELLIDOS,NOMBRE;
BEGIN
 FOR F IN C LOOP
  DBMS_OUTPUT.PUT_LINE(F.CODIGO||'-'||F.APELLIDOS||', '||F.NOMBRE||'-'||F.SALARIO||'-'||F.DNOMBRE
  ||'-'||F.LOC);
 END LOOP;
END;

EXECUTE EX_2017_1;

--2
CREATE OR REPLACE PROCEDURE EX_2017_2
AS
    CURSOR C IS SELECT ROWID,SALARIO FROM EMPLEADOS;
BEGIN
 FOR F IN C LOOP
  COMMIT;
  IF F.SALARIO*0.95>=1200 THEN
   UPDATE EMPLEADOS SET SALARIO=SALARIO*0.95 WHERE ROWID=F.ROWID;
  ELSE
   UPDATE EMPLEADOS SET SALARIO=1200 WHERE ROWID=F.ROWID;
  END IF;
  COMMIT;
 END LOOP;
END;

EXECUTE EX_2017_2;

--3
CREATE OR REPLACE PROCEDURE EX_2017_3
AS
 CURSOR C IS SELECT ROWID,SALARIO FROM EMPLEADOS ORDER BY SALARIO;
 F C%ROWTYPE;
BEGIN
OPEN C;
LOOP
 FETCH C INTO F;
 EXIT WHEN C%NOTFOUND OR C%ROWCOUNT>5;
 COMMIT;
 IF F.SALARIO<1200 THEN
  UPDATE EMPLEADOS SET SALARIO=1200 WHERE ROWID=F.ROWID;
 END IF;
  COMMIT;
END LOOP;
CLOSE C;
END;

EXECUTE EX_2017_3;

--4
CREATE OR REPLACE PROCEDURE EX_2017_4
AS
 CURSOR C IS SELECT ROWID,OFICIO,NOMBRE,APELLIDOS FROM EMPLEADOS;
 ID_USU EMPLEADOS.ID_USUARIO%TYPE;
BEGIN
 FOR F IN C LOOP
  ID_USU:=SUBSTR(F.OFICIO,0,1)||SUBSTR(F.NOMBRE,0,1)||SUBSTR(F.APELLIDOS,0,3)||LENGTH(F.APELLIDOS);
  UPDATE EMPLEADOS SET ID_USUARIO=ID_USU WHERE ROWID=F.ROWID;
  COMMIT;
 END LOOP;
END;

EXECUTE EX_2017_4;

--5
CREATE TABLE INCIDENCIAS_SALARIALES(
Cod_Emp NUMBER(4,0) REFERENCES EMPLEADOS(CODIGO),
Fecha TIMESTAMP,
Sal_Viejo NUMBER(10,2),
Sal_Nuevo NUMBER(10,2),
Texto VARCHAR2(255),
PRIMARY KEY (Cod_Emp,Fecha)
)

CREATE OR REPLACE TRIGGER EX_2017_5
AFTER UPDATE OF SALARIO ON EMPLEADOS
FOR EACH ROW
BEGIN
 INSERT INTO INCIDENCIAS_SALARIALES VALUES(:OLD.CODIGO,SYSDATE,:OLD.SALARIO,:NEW.SALARIO,
 'CAMBIO EN EL SALARIO DEL EMPLEADO');
END;