CREATE TABLE caballos
(
	codCaballo varchar2(4),
	nombre varchar2(20) NOT NULL,
	peso number(3),
	fechaNacimiento DATE,
	propietario varchar2(25),
	nacionalidad varchar2(20),
	
	CONSTRAINT pk_caballos PRIMARY KEY (codCaballo),
	CONSTRAINT ch_peso CHECK (peso BETWEEN 240 AND 300),
	CONSTRAINT ch_fechaNacimiento CHECK (fechaNacimiento > to_date('01/01/2000','dd/mm/yyyy')),
	CONSTRAINT ch_nacionalidad CHECK (nacionalidad = upper(nacionalidad))
);

CREATE TABLE carreras
(
	codCarrera varchar2(4),
	fechaHora DATE,
	importePremio number(6),
	apuestaLimite number(5,2),
	
	CONSTRAINT pk_carrera PRIMARY KEY (codCarrera),
	CONSTRAINT ch_fechaHora CHECK (to_char(fechaHora,'hh24')>9 AND to_char(fechaHora,'hh24')<14
	OR (to_char(fechaHora,'hh24')=24 AND to_char(fechaHora,'mi')<=30)),
	CONSTRAINT ch_apuestaLimite CHECK (apuestaLimite < 20000)
);

CREATE TABLE participaciones 
(
	codCaballo varchar2(4),
	codCarrera varchar2(4),
	dorsal number(2) NOT null,
	jockey varchar2(10) NOT null,
	posicionFinal number(2),
	
	CONSTRAINT pk_participaciones PRIMARY KEY (codCaballo,codCarrera),
	CONSTRAINT fk_participaciones FOREIGN KEY (codCaballo) REFERENCES caballos (codCaballo) ON DELETE SET null,
	CONSTRAINT fk2_participaciones FOREIGN KEY (codCarrera) REFERENCES carreras (codCarrera) ON DELETE SET null,
	CONSTRAINT ch_posicionFinal CHECK (posicionFinal > 0)
);

CREATE TABLE clientes
(
	dni varchar2(10),
	nombre varchar2(20),
	nacionalidad varchar2(20),
	
	CONSTRAINT pk_clientes PRIMARY KEY (dni),
	CONSTRAINT ch_dni CHECK (regexp_like(dni,'^[0-9]{8}[A-Z]{1}')),
	CONSTRAINT ch_nacionalidadCl CHECK (nacionalidad = upper(nacionalidad))
);

CREATE TABLE apuestas
(
	dniCliente varchar2(10),
	codCaballo varchar2(4),
	codCarrera varchar2(4),
	importe NUMBER(6) NOT null,
	tantoPorUno number(4,2),
	
	CONSTRAINT pk_apuestas PRIMARY KEY (dniCliente,codCaballo,codCarrera),
	CONSTRAINT fk_apuestas FOREIGN KEY (dniCliente) REFERENCES clientes (dni),
	CONSTRAINT fk2_apuestas FOREIGN KEY (codCaballo) REFERENCES caballos (codCaballo),
	CONSTRAINT fk3_apuestas FOREIGN KEY (codCarrera) REFERENCES carreras (codCarrera),
	CONSTRAINT ch_tantoPorUno CHECK (tantoPorUno > 1)
);








