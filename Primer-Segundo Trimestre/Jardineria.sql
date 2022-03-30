ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER jardineria IDENTIFIED BY jardineria;
GRANT CONNECT, RESOURCE, DBA TO jardineria;

CREATE TABLE gama_producto
(
	gama varchar2(50),
	descripcion_texto varchar2(200),
	descripcion_html varchar2(200),
	imagen varchar2(256),
	
	CONSTRAINT pk_gama PRIMARY KEY (gama)
);

CREATE TABLE producto
(
	codigo_producto varchar2(15),
	nombre varchar2(70),
	gama varchar2(50),
	dimensiones varchar2(25),
	proveedor varchar2(50),
	descripcion varchar2(200),
	cantidad_stock number(6),
	precio_venta decimal(15,2),
	precio_proveedor decimal(15,2),
	
	CONSTRAINT pk_producto PRIMARY KEY (codigo_producto),
	CONSTRAINT fk_producto FOREIGN KEY (gama) REFERENCES gama_producto (gama)
);

CREATE TABLE detalle_pedido
(
	codigo_pedido NUMBER(11),
	codigo_producto varchar2(15),
	cantidad number(11),
	precio_unidad decimal(15,2),
	numero_linea number(6),
	
	CONSTRAINT pk__detalle PRIMARY KEY (codigo_pedido),
	CONSTRAINT fk_detalle FOREIGN KEY (codigo_producto) REFERENCES producto (codigo_producto)
);

CREATE TABLE oficina
(
	codigo_oficina varchar2(10),
	ciudad varchar2(30),
	pais varchar2(50),
	region varchar2(50),
	codigo_postal varchar2(10),
	telefono varchar2(20),
	linea_direccion1 varchar2(50),
	linea_direccion2 varchar2(50),
	
	CONSTRAINT pk_oficina PRIMARY KEY (codigo_oficina)
);

CREATE TABLE empleado
(
	codigo_empleado number(11),
	nombre varchar2(50),
	apellido1 varchar2(50),
	apellido2 varchar2(50),
	extension varchar2(10),
	email varchar2(100),
	codigo_oficina varchar2(10),
	codigo_jefe number(11),
	puesto varchar(50),
	
	CONSTRAINT pk_empleado PRIMARY KEY (codigo_empleado),
	CONSTRAINT fk_rflx_empleado FOREIGN KEY (codigo_jefe) REFERENCES empleado (codigo_empleado),
	CONSTRAINT fk_empleado FOREIGN KEY (codigo_oficina) REFERENCES oficina (codigo_oficina)
);

CREATE TABLE cliente
(
	codigo_cliente number(11),
	nombre_cliente varchar2(50),
	nombre_contacto varchar2(30),
	apellido_contacto varchar2(30),
	telefono varchar2(15),
	fax varchar2(15),
	linea_direccion1 varchar2(50),
	linea_direccion2 varchar2(50),
	ciudad varchar2(50),
	region varchar2(50),
	pais varchar2(50),
	codigo_postal varchar2(10),
	codigo_empleado_rep_ventas number(11),
	limite_credito decimal(15,2),
	
	CONSTRAINT pk_cliente PRIMARY KEY (codigo_cliente),
	CONSTRAINT fk_cliente FOREIGN KEY (codigo_empleado_rep_ventas) REFERENCES empleado (codigo_empleado)
);

CREATE TABLE pago
(
	id_transaccion varchar2(50),
	codigo_cliente number(11),
	forma_pago varchar2(40),
	fecha_pago DATE,
	total decimal(15,2),
	
	CONSTRAINT pk_pago PRIMARY KEY (id_transaccion),
	CONSTRAINT fk_pago FOREIGN KEY (codigo_cliente) REFERENCES cliente (codigo_cliente)
);

CREATE TABLE pedido
(
	codigo_pedido number(11),
	fecha_pedido DATE,
	fecha_esperada DATE,
	fecha_entrega DATE,
	estado varchar2(15),
	comentarios varchar2(200),
	codigo_cliente number(11),
	
	CONSTRAINT pk_pedido PRIMARY KEY (codigo_pedido),
	CONSTRAINT fk_pedido FOREIGN KEY (codigo_cliente) REFERENCES cliente (codigo_cliente)
);








