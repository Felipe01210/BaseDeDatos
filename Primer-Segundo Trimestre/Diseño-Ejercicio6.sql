ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER EJ6 IDENTIFIED BY EJ6;
GRANT CONNECT, RESOURCE, DBA TO EJ6;

CREATE TABLE profesor
(
	dni varchar2(10),
	nombre varchar2(20),
	direccion varchar2(20),
	titulacion varchar2(10),
	sueldo number(5,2) NOT null,
	
	CONSTRAINT pk_profesor PRIMARY KEY (dni)
);

CREATE TABLE curso
(
	cod_curso varchar2(10),
	nombre varchar2(20) UNIQUE,
	n_max_alumnos number(3),
	fecha_inicio DATE,
	fecha_fin DATE,
	horas number(3) NOT null,
	dni_profesor varchar2(10),
	
	CONSTRAINT pk_curso PRIMARY KEY (cod_curso),
	CONSTRAINT fk_curso FOREIGN KEY (dni_profesor) REFERENCES profesor (dni),
	CONSTRAINT res_fecha CHECK (fecha_fin>fecha_inicio)
);

CREATE TABLE alumno
(
	dni varchar2(10),
	nombre varchar2(20) UNIQUE,
	apellido varchar2(20),
	sexo varchar2(2),
	direccion varchar2(20),
	fecha_nacimiento DATE,
	cod_curso varchar2(10),
	
	CONSTRAINT pk_alumno PRIMARY KEY (dni),
	CONSTRAINT fk_alumno FOREIGN KEY (cod_curso) REFERENCES curso (cod_curso),
	CONSTRAINT res_sexo CHECK (sexo IN ('M','H'))
);



