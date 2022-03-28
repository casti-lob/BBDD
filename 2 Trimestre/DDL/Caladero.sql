alter session set "_oracle_script"=true;  
create user caladero identified by caladero;
GRANT CONNECT, RESOURCE, DBA TO caladero;

CREATE TABLE BARCOS
	(matricula		VARCHAR2(20),
	nombre		VARCHAR2(100),
	clase		VARCHAR2(10),
	armador		VARCHAR2(200),
	capacidad		NUMBER(17,2),
	nacionalidad		VARCHAR2(50),
	CONSTRAINT pk_barcos PRIMARY KEY(matricula)
	);
	
CREATE TABLE LOTES
	(codigo			VARCHAR2(12),
	matricula		VARCHAR2(20),
	numkilos		NUMBER(17,2),
	precioporkilosalida		NUMBER(10,2),
	precioporkiloadjudicado		NUMBER(10,2),
	fechaventa		DATE,
	cod_especie		VARCHAR2(12),
	CONSTRAINT pk_lotes	PRIMARY KEY (codigo),
	CONSTRAINT fk_lotes_matricula FOREIGN KEY (matricula) REFERENCES BARCOS (matricula) ON DELETE CASCADE
	);
	
CREATE TABLE ESPECIE
	(codigo			VARCHAR2(12),
	nombre			VARCHAR2(80),
	tipo			VARCHAR2(50),
	cupoporbarco	NUMBER(17,2),
	caladero_principal		VARCHAR2(12),
	CONSTRAINT pk_especie PRIMARY KEY (codigo)
	);

ALTER TABLE LOTES ADD CONSTRAINT fk_lotes_cod_especie FOREIGN KEY (cod_especie) REFERENCES ESPECIE (codigo) ON DELETE CASCADE;

CREATE TABLE CALADERO
	(codigo 		VARCHAR2(12),
	nombre			VARCHAR2(80),
	ubicacion		VARCHAR2(100),
	especie_principal		VARCHAR2(12),
	CONSTRAINT pk_caladero PRIMARY KEY (codigo),
	CONSTRAINT fk_caladero_especie_principal FOREIGN KEY (especie_principal) REFERENCES ESPECIE(codigo)
	);

CREATE TABLE FECHAS_CAPTURAS_PERMITIDAS 
	(cod_especie		VARCHAR2(12),
	cod_caladero		VARCHAR2(12),
	fecha_inicial		DATE,
	fecha_final			DATE,
	CONSTRAINT pk_fechas_capturas_permitidas PRIMARY KEY(cod_especie,cod_caladero),
	CONSTRAINT fk_FECHAS_CAPTURAS_PERMITIDAS_ESPECIE FOREIGN KEY (cod_especie) REFERENCES ESPECIE(codigo),
	CONSTRAINT fk_FECHAS_CAPTURAS_PERMITIDAS_caladero FOREIGN KEY (cod_caladero) REFERENCES CALADERO(codigo)
	);

ALTER TABLE LOTES MODIFY fechaventa NOT NULL ;

ALTER TABLE LOTES ADD CONSTRAINT ch_lotes_precioporkiloadjudicado CHECK (precioporkiloadjudicado>precioporkilosalida);

ALTER TABLE LOTES ADD CONSTRAINT ch_lotes_numkilos CHECK(numkilos >0);
ALTER TABLE LOTES ADD CONSTRAINT ch_lotes_prc_k CHECK(precioporkilosalida >0);
ALTER TABLE LOTES ADD CONSTRAINT ch_lotes_prc_s CHECK(precioporkiloadjudicado >0);
ALTER TABLE CALADERO ADD CONSTRAINT ch_caladero_nombre CHECK (nombre=UPPER(nombre));
ALTER TABLE CALADERO ADD CONSTRAINT ch_caladero_ubicacion CHECK (ubicacion = UPPER(ubicacion));
ALTER TABLE FECHAS_CAPTURAS_PERMITIDAS ADD CONSTRAINT ch_fcp_fecha_inicial CHECK(EXTRACT(MONTH FROM fecha_inicial)!=2 AND EXTRACT(DAY FROM fecha_inicial)<2);
ALTER TABLE FECHAS_CAPTURAS_PERMITIDAS ADD CONSTRAINT ch_fcp_fecha_final CHECK(EXTRACT(MONTH FROM fecha_final)!=3 AND EXTRACT(DAY FROM fecha_final)>28);

ALTER TABLE CALADERO ADD nombre_cientifico VARCHAR2(100);

INSERT INTO BARCOS
VALUES('UNO','CHANQUETE','CLASE-A','V',120,'ES');

INSERT INTO BARCOS
VALUES('DOS','SARDINILLA','CLASE-A','V',120,'ES');

INSERT INTO ESPECIE
VALUES('PA','atun','azul',50,'h1');

INSERT INTO ESPECIE
VALUES('PU','atun','azul',50,'h2');

INSERT INTO LOTES
VALUES('aa','UNO',555,500,1000,TO_DATE('12-04-2015','DD/MM/YYYY'),'PA');

INSERT INTO LOTES
VALUES('ae','DOS',555,500,1000,TO_DATE('12-04-2015','DD/MM/YYYY'),'PU');

INSERT INTO CALADERO
VALUES('PU','NIEBLA','CADIZ','PU','Ende');

INSERT INTO CALADERO
VALUES('PU','NIEBLA','CADIZ','PU','anda');

INSERT INTO FECHAS_CAPTURAS_PERMITIDAS






