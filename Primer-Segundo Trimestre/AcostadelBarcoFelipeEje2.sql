ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER ExamenEj2 IDENTIFIED BY ExamenEj2;
GRANT CONNECT, RESOURCE, DBA TO ExamenEj2;

CREATE TABLE clientes
(
	dni varchar2(10),
	nombre varchar2(10),
	apellidos varchar2(20),
	ciudad varchar2(10),
	
	CONSTRAINT pk_clientes PRIMARY KEY (dni)
);

CREATE TABLE marcas
(
	codMarca number(4),
	nombre varchar2(10),
	pais varchar2(10),
	
	CONSTRAINT pk_marcas PRIMARY KEY (codMarca)
);

CREATE TABLE coches
(
	codCoche number(4),
	codMarca number(4),
	modelo varchar2(10),
	matricula varchar2(10),
	color varchar2(10),
	
	CONSTRAINT pk_coche PRIMARY KEY (codCoche),
	CONSTRAINT fk_coche FOREIGN KEY (codMarca) REFERENCES marcas (codMarca)
);

CREATE TABLE ventas
(
	codCoche number(4),
	cifc varchar2(10),
	fechaVentas DATE,
	dni varchar2(10),
	pvp number(4),
	
	CONSTRAINT pk_ventas PRIMARY KEY (codCoche),
	CONSTRAINT fk_ventas FOREIGN KEY (codCoche) REFERENCES coches (codCoche),
	CONSTRAINT fk2_ventas FOREIGN KEY (dni) REFERENCES clientes (dni)
);

CREATE TABLE concesionarios
(
	cifc varchar2(10),
	nombre varchar2(10),
	ciudad varchar2(10),
	cifcMatriz varchar2(10),
	
	CONSTRAINT pk_concesionarios PRIMARY KEY (cifc),
	CONSTRAINT fk_concesionarios FOREIGN KEY (cifcMatriz) REFERENCES concesionarios (cifc)
);

CREATE TABLE distribucion
(
	cifc varchar2(10),
	codCoche number(4),
	
	CONSTRAINT pk_distribucion PRIMARY KEY (cifc,codCoche),
	CONSTRAINT fk_distribucion FOREIGN KEY (cifc) REFERENCES concesionarios (cifc),
	CONSTRAINT fk2_distribucion FOREIGN KEY (codCoche) REFERENCES coches (codCoche)
);

ALTER TABLE ventas MODIFY fechaVentas DATE DEFAULT sysdate;
ALTER TABLE coches ADD CONSTRAINT ch_color CHECK (lower(color) IN ('rojo','amarillo','verde'));
ALTER TABLE clientes ADD CONSTRAINT ch_ciudadClientes CHECK (ciudad = upper(ciudad));
ALTER TABLE concesionarios ADD CONSTRAINT ch_ciudadConcesionario CHECK (ciudad = upper(ciudad));
ALTER TABLE distribucion ADD area varchar2(10);
ALTER TABLE distribucion ADD CONSTRAINT ch_area CHECK (regexp_like(area,'[T]{any}'));
ALTER TABLE concesionarios DISABLE CONSTRAINT fk_concesionarios;
ALTER TABLE concesionarios DROP CONSTRAINT fk_concesionarios;









