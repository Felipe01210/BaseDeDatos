CREATE TABLE vehiculo
(
	matricula VARCHAR2(7),
	marca VARCHAR2(10) NOT NULL,
	modelo VARCHAR2(10) NOT NULL,
	fecha_compra DATE,
	precio_dia NUMBER(5,2),
	
	CONSTRAINT pk_vehiculo PRIMARY KEY (matricula),
	CONSTRAINT min_fecha_compra CHECK (fecha_compra>=to_date('01/01/2001','DD/MM/YYYY') AND ),
	CONSTRAINT precio_positivo CHECK (precio_dia>=1)
);

CREATE TABLE cliente
(
	dni VARCHAR2(9),
	nombre VARCHAR2(30) NOT NULL,
	nacionalidad VARCHAR2(30),
	fecha_nacimiento DATE,
	direccion VARCHAR2(50),
	
	CONSTRAINT pk_cliente PRIMARY KEY (dni)
);

CREATE TABLE alquiler
(
	matricula_coche VARCHAR2(9) NOT NULL,
	dni_cliente VARCHAR2(9) NOT NULL,
	fecha_hora DATE,
	num_dias NUMBER(2) NOT NULL,
	kms NUMBER(4) DEFAULT 0,
	
	CONSTRAINT pk_alquiler PRIMARY KEY (matricula_coche,dni_cliente,fecha_hora),
	CONSTRAINT fk_vehiculo FOREIGN KEY (matricula_coche) REFERENCES vehiculo (matricula),
	CONSTRAINT fk_cliente FOREIGN KEY (dni_cliente) REFERENCES cliente (dni)
);
