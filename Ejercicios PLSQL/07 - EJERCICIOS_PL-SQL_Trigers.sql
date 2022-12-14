--EJ 2
CREATE OR REPLACE TRIGGER SALARIO_EMPLE
BEFORE INSERT ON EMPLE
FOR EACH ROW
DECLARE
 SAL_MEDIO NUMBER(8,2);
BEGIN
 SELECT AVG(SALARIO) INTO SAL_MEDIO FROM EMPLE WHERE DEPT_NO=:NEW.DEPT_NO;
 IF :NEW.SALARIO>SAL_MEDIO THEN
  :NEW.SALARIO:=SAL_MEDIO;
 END IF;
END;

SELECT AVG(SALARIO) FROM EMPLE WHERE DEPT_NO=30;
SELECT * FROM EMPLE WHERE DEPT_NO=30;

ROLLBACK;