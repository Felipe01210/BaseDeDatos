ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER caladero IDENTIFIED BY caladero;
GRANT CONNECT, RESOURCE, DBA TO caladero;

CREATE TABLE barco
(
	matricula varchar2(10),
	nombre varchar2(30),
	clase varchar2(10),
	armador varchar2(10),
	nacionalidad varchar2(10),
	
	CONSTRAINT pk_barco PRIMARY KEY (matricula),
	CONSTRAINT res_barco CHECK (regexp_like(matricula, '[A-Z]{2}[-]{1}[0-9]{4}'))
);

CREATE TABLE especie
(
	codigo varchar2(10),
	nombre varchar2(30),
	tipo varchar2(10),
	cupoPorBarco number(5),
	caladero_principal varchar2(10),
	
	CONSTRAINT pK_especie PRIMARY KEY (codigo)
);

CREATE TABLE caladero
(
	codigo varchar2(10),
	nombre varchar2(30),
	ubicacion varchar2(30),
	especie_principal varchar2(10),
	
	CONSTRAINT pk_caladero PRIMARY KEY (codigo),
	CONSTRAINT fk_caladero FOREIGN KEY (especie_principal) REFERENCES especie (codigo),
	CONSTRAINT res_nombre_ubicacion CHECK (nombre = upper(nombre) AND ubicacion = upper(ubicacion))
);

ALTER TABLE especie ADD CONSTRAINT fk_especie FOREIGN KEY (caladero_principal) REFERENCES caladero (codigo);

CREATE TABLE lote
(
	codigo varchar2(10),
	matricula varchar2(10),
	numKilos number(5),
	precioPorKilosSalidas number(5),
	precioPorKilosAdjud number(5),
	fechaVenta DATE NOT NULL,
	cod_especie varchar2(10),
	
	CONSTRAINT pk_lote PRIMARY KEY (codigo),
	CONSTRAINT fk_lote_barco FOREIGN KEY (matricula) REFERENCES barco (matricula),
	CONSTRAINT fk_lote_especie FOREIGN KEY (cod_especie) REFERENCES especie (codigo),
	CONSTRAINT res_precios CHECK (precioPorKilosAdjud > precioPorKilosSalidas),
	CONSTRAINT res_kilos_precios CHECK (numKilos>0 AND precioPorKilosSalidas>0 AND precioPorKilosAdjud>0)
);

CREATE TABLE fecha_captura_permitida
(
	cod_especie varchar2(10),
	cod_caladero varchar2(10),
	fecha_inicial DATE,
	fecha_final DATE,
	
	CONSTRAINT pk_fecha_captura_permitida PRIMARY KEY (cod_especie,cod_caladero),
	CONSTRAINT fk_fecha_especie FOREIGN KEY (cod_especie) REFERENCES especie (codigo),
	CONSTRAINT fk_fecha_caladero FOREIGN KEY (cod_caladero) REFERENCES caladero (codigo),
	CONSTRAINT res_fechas CHECK (fecha_inicial<=to_date('01/02/2022','DD/MM/YYYY') AND fecha_final>=to_date('29/03/2022','DD/MM/YYYY'))
);



INSERT INTO barco VALUES ('AA-2','bbbb','ccccc','ddddd','eeeee');
INSERT INTO barco VALUES ('BB-2','bbb1','cccc1','dddd1','eeee1');
INSERT INTO barco VALUES ('CC-2','bbb2','cccc2','dddd2','eeee2');
INSERT INTO barco VALUES ('XX-4','bbb3','cccc3','dddd3','eeee3');

