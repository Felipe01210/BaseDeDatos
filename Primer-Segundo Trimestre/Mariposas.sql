ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER EJ1_RA2 IDENTIFIED BY EJ1_RA2;
GRANT CONNECT, RESOURCE, DBA TO EJ1_RA2;

CREATE TABLE familia
(
	nombre varchar2(10),
	caracteristicas varchar2(100),
	
	CONSTRAINT pk_familia PRIMARY KEY (nombre)
);

CREATE TABLE genero
(
	nombre varchar2(10),
	nombreFamilia varchar2(10),
	caracteristicas varchar2(100),
	
	CONSTRAINT pk_genero PRIMARY KEY (nombre),
	CONSTRAINT fk_genero FOREIGN KEY (nombreFamilia) REFERENCES familia (nombre)
);

CREATE TABLE especie
(
	nombre varchar2(10),
	nombreGenero varchar2(10),
	caracteristicas varchar2(100),
	
	CONSTRAINT pk_especie PRIMARY KEY (nombre),
	CONSTRAINT fk_especie FOREIGN KEY (nombreGenero) REFERENCES genero (nombre)
);

CREATE TABLE zona
(
	nombre varchar2(10),
	localidad varchar2(10),
	extension number(5),
	protegida varchar2(10),
	
	CONSTRAINT pk_zona PRIMARY KEY (nombre),
	CONSTRAINT ch_zona CHECK (protegida IN ('Si','No'))
);

CREATE TABLE persona
(
	dni varchar2(10),
	nombre varchar2(10),
	direccion varchar2(20),
	telefono number(10),
	usuario varchar2(10) UNIQUE,
	
	CONSTRAINT pk_persona PRIMARY KEY (dni)
);

CREATE TABLE coleccion
(
	dniPersona varchar2(10),
	precio number(5),
	fechaInicio DATE,
	nEjemplares number(5),
	
	CONSTRAINT pk_coleccion PRIMARY KEY (dniPersona),
	CONSTRAINT fk_coleccion FOREIGN KEY (dniPersona) REFERENCES persona (dni),
	CONSTRAINT ch_nEjemplares CHECK (nEjemplares >= 1 AND nEjemplares <= 150)
);

CREATE TABLE ejemplarMariposa
(
	fechaCaptura DATE,
	horaCaptura DATE,
	nombreEspecie varchar2(10),
	nombreZona varchar2(10),
	dniPersona varchar2(10),
	dniPersonaColeccion varchar2(10),
	nombreComun varchar2(10),
	precioEjemplar number(5),
	fechaColeccion DATE,
	
	CONSTRAINT pk_ejemplar PRIMARY KEY (fechaCaptura,horaCaptura,nombreEspecie,nombreZona,dniPersona,dniPersonaColeccion),
	CONSTRAINT fk_ejemplar FOREIGN KEY (nombreEspecie) REFERENCES especie (nombre),
	CONSTRAINT fk2_ejemplar FOREIGN KEY (nombreZona) REFERENCES zona (nombre),
	CONSTRAINT fk3_ejemplar FOREIGN KEY (dniPersona) REFERENCES persona (dni),
	CONSTRAINT fk4_ejemplar FOREIGN KEY (dniPersonaColeccion) REFERENCES coleccion (dniPersona),
	CONSTRAINT ch_ejemplar CHECK (precioEjemplar > 0)
);

ALTER TABLE persona ADD apellido varchar2(20);
ALTER TABLE zona ADD CONSTRAINT ch_extension CHECK (extension BETWEEN 100 AND 1500);
ALTER TABLE ejemplarMariposa DISABLE CONSTRAINT ch_ejemplar;

CREATE INDEX indicePersona ON persona(nombre,apellido);

ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER usuario IDENTIFIED BY usuario;
CREATE ROLE rol_usuario;
GRANT SELECT ON,INSERT,UPDATE ON persona TO ;
GRANT SELECT ON,INSERT,UPDATE ON ejemplarMariposa TO rol_usuario;
GRANT SELECT ON,INSERT,UPDATE ON coleccion TO rol_usuario;
GRANT SELECT ON,INSERT,UPDATE ON zona TO rol_usuario;
GRANT rol_ususario TO usuario;







