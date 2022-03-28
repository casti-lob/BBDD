alter session set "_oracle_script"=true;  
create user empleadoDML identified by empleadoDML;
GRANT CONNECT, RESOURCE, DBA TO empleadoDML;

CREATE TABLE DEPARTAMENTO 
	(codigo			NUMBER(10),
	nombre			VARCHAR2(100),
	presupuesto		NUMBER(10,2),
	futuro_presu	NUMBER(10,2),
	CONSTRAINT pk_departamento PRIMARY KEY (codigo)
	);
	
CREATE TABLE EMPLEADO
	(codigo			NUMBER(10),
	nif				VARCHAR2(9),
	nombre			VARCHAR2(100),
	apellido1		VARCHAR2(100),
	apellido2		VARCHAR2(100),
	codigo_departamento NUMBER(10),
	CONSTRAINT pk_empleado PRIMARY KEY(codigo),
	CONSTRAINT fk_empleado FOREIGN KEY(codigo_departamento) REFERENCES DEPARTAMENTO(codigo)
	);

	
INSERT INTO DEPARTAMENTO
VALUES (1, 'Desarrollo', 120000, 6000);

INSERT INTO DEPARTAMENTO
VALUES(2, 'Sistemas', 150000, 21000);

INSERT INTO DEPARTAMENTO
VALUES(3, 'Recursos Humanos', 280000, 25000);

INSERT INTO DEPARTAMENTO
VALUES(4, 'Contabilidad', 110000, 3000);

INSERT INTO DEPARTAMENTO
VALUES(5, 'I+D', 375000, 380000);

INSERT INTO DEPARTAMENTO
VALUES(6, 'Proyectos', 0, 0);

INSERT INTO DEPARTAMENTO
VALUES(7, 'Publicidad', 0, 1000);

INSERT INTO EMPLEADO
VALUES(1, '32481596F', 'Aarón', 'Rivero', 'Gómez', 1);

INSERT INTO EMPLEADO
VALUES(2, 'Y5575632D', 'Adela', 'Salas', 'Díaz', 2);

INSERT INTO EMPLEADO
VALUES(3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3);

INSERT INTO EMPLEADO
VALUES(4, '77705545E', 'Adrián', 'Suárez', NULL, 4);

INSERT INTO EMPLEADO
VALUES(5, '17087203C', 'Marcos', 'Loyola', 'Méndez', 5);

INSERT INTO EMPLEADO
VALUES(6, '38382980M', 'María', 'Santana', 'Moreno', 1);

INSERT INTO EMPLEADO
VALUES(7, '80576669X', 'Pilar', 'Ruiz', NULL, 2);

INSERT INTO EMPLEADO
VALUES(8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3);

INSERT INTO EMPLEADO
VALUES(9, '56399183D', 'Juan', 'Gómez', 'López', 2);

INSERT INTO EMPLEADO
VALUES(10, '46384486H', 'Diego','Flores', 'Salas', 5);

INSERT INTO EMPLEADO
VALUES(11, '67389283A', 'Marta','Herrera', 'Gil', 1);

INSERT INTO EMPLEADO
VALUES(12, '41234836R', 'Irene','Salas', 'Flores', NULL);

INSERT INTO EMPLEADO
VALUES(13, '82635162B', 'Juan Antonio','Sáez', 'Guerrero', NULL);

--1
INSERT INTO DEPARTAMENTO(codigo,nombre,presupuesto)
VALUES(8,'Vividores', 50000);

--2 No se puede ya que le falta la pk y no tiene autoincremento
INSERT INTO DEPARTAMENTO(nombre,presupuesto)
VALUES('Currantes', 200);

--3
INSERT INTO DEPARTAMENTO
VALUES(9,'Repetidores',3000,500);

--4
INSERT INTO EMPLEADO
VALUES(14,'28821641l','Jose','Casti','Lob',9);

--5 No se puede ya que le falta la pk y no tiene autoincremento
INSERT INTO EMPLEADO(nif,nombre,apellido1,apellido2,codigo_departamento)
VALUES('2885555l','Je','ti','ob',8);

--6
CREATE TABLE DEPARTAMENTO_BACKUP
	(codigo			NUMBER(10),
	nombre			VARCHAR2(100),
	presupuesto		NUMBER(10,2),
	gastos	NUMBER(10,2),
	CONSTRAINT pk_departamento_backup PRIMARY KEY (codigo)
	);

INSERT INTO DEPARTAMENTO_BACKUP
VALUES (1, 'Desarrollo', 120000, 6000);

INSERT INTO DEPARTAMENTO_BACKUP
VALUES(2, 'Sistemas', 150000, 21000);

INSERT INTO DEPARTAMENTO_BACKUP
VALUES(3, 'Recursos Humanos', 280000, 25000);

INSERT INTO DEPARTAMENTO_BACKUP
VALUES(4, 'Contabilidad', 110000, 3000);

INSERT INTO DEPARTAMENTO_BACKUP
VALUES(5, 'I+D', 375000, 380000);

INSERT INTO DEPARTAMENTO_BACKUP
VALUES(6, 'Proyectos', 0, 0);

INSERT INTO DEPARTAMENTO_BACKUP
VALUES(7, 'Publicidad', 0, 1000);

--7 Si se puede ya que su pk no tiene relacion con la tabla empleado
DELETE DEPARTAMENTO
WHERE CODIGO=6;

--8 No es posible ya que su pk esta relacionada por lo que deberiamos hacer lo siguiente
DELETE EMPLEADO
WHERE CODIGO_DEPARTAMENTO=1;

DELETE DEPARTAMENTO
WHERE CODIGO=1;

--9 No es posible ya que su pk esta relacionada por lo que deberiamos hacer lo siguiente
ALTER TABLE EMPLEADO DROP CONSTRAINT fk_empleado;
ALTER TABLE EMPLEADO ADD CONSTRAINT fk_empleado FOREIGN KEY(codigo_departamento) REFERENCES DEPARTAMENTO(codigo) ON DELETE CASCADE;

UPDATE EMPLEADO
SET codigo_departamento=30
WHERE codigo_departamento=3;

UPDATE DEPARTAMENTO
SET codigo=30
WHERE codigo=3;

--10
UPDATE DEPARTAMENTO 
SET codigo=40
WHERE codigo=7;

--11
UPDATE DEPARTAMENTO
SET presupuesto = presupuesto+50000
WHERE presupuesto < 20000;

--12
DELETE empleado
WHERE codigo_departamento is NULL;




