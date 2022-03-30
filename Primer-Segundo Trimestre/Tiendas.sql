CREATE TABLE fabricante
(
	cod_fabricante number(3),
	nombre varchar2(15),
	pais varchar2(15),
	
	CONSTRAINT pk_fabricante PRIMARY KEY (cod_fabricante),
	CONSTRAINT res_mayus_fabricante CHECK (nombre=upper(nombre) AND pais=upper(pais))
);

CREATE TABLE articulo
(
	articulo varchar2(20),
	cod_fabricante number(3),
	peso number(3) NOT NULL,
	categoria varchar2(10) NOT NULL,
	precio_venta number(4,2),
	precio_costo number(4,2),
	existencias number(5),
	
	CONSTRAINT pk_articulo PRIMARY KEY (articulo,cod_fabricante,peso,categoria),
	CONSTRAINT fk_articulo FOREIGN KEY (cod_fabricante) REFERENCES fabricante (cod_fabricante),
	CONSTRAINT res_mayor0_articulo CHECK (precio_venta > 0 AND precio_costo > 0 AND peso > 0),
	CONSTRAINT res_categoria CHECK (categoria IN ('PRIMERA','SEGUNDA','TERCERA'))
);

CREATE TABLE tienda
(
	nif varchar2(10),
	nombre varchar2(20),
	direccion varchar2(20),
	poblacion varchar2(20),
	provincia varchar2(20),
	codPostal number(5),
	
	CONSTRAINT pk_tienda PRIMARY KEY (nif),
	CONSTRAINT res_provincia CHECK (provincia=upper(provincia))
);

CREATE TABLE pedido
(
	nif varchar2(10),
	articulo varchar2(20),
	cod_fabricante number(3),
	peso number(3),
	categoria varchar2(10),
	fecha_pedido DATE,
	unidades_pedido number(4),
	
	CONSTRAINT pk_pedido PRIMARY KEY (nif,articulo,cod_fabricante,peso,categoria,fecha_pedido),
	CONSTRAINT fk_pedido FOREIGN KEY (cod_fabricante) REFERENCES fabricante (cod_fabricante),
	CONSTRAINT res_unidades_pedidas CHECK (unidades_pedido>0),
	CONSTRAINT fk_pedido_2 FOREIGN KEY (peso,categoria,articulo,cod_fabricante) REFERENCES articulo (peso,categoria,articulo,cod_fabricante) ON DELETE CASCADE,
	CONSTRAINT fk_pedido_3 FOREIGN KEY (nif) REFERENCES tienda (nif)
);

CREATE TABLE venta
(
	nif varchar2(10),
	articulo varchar2(20),
	cod_fabricante number(3),
	peso number(3),
	categoria varchar2(10),
	fecha_venta DATE DEFAULT sysdate,
	unidades_vendidas number(4),
	
	CONSTRAINT pk_venta PRIMARY KEY (nif,articulo,cod_fabricante,peso,categoria,fecha_venta),
	CONSTRAINT fk_venta FOREIGN KEY (cod_fabricante) REFERENCES fabricante (cod_fabricante) ON DELETE CASCADE,
	CONSTRAINT res_unidades CHECK (unidades_vendidas>0),
	CONSTRAINT fk_venta_2 FOREIGN KEY (articulo,peso,categoria,cod_fabricante) REFERENCES articulo (articulo,peso,categoria,cod_fabricante) ON DELETE CASCADE,
	CONSTRAINT fk_venta_3 FOREIGN KEY (nif) REFERENCES tienda (nif)
);

ALTER TABLE pedido MODIFY (uniddes_pedidas number(6));
ALTER TABLE venta MODIFY (unidades_vendidas number(6));
ALTER TABLE pedido ADD (PVP number(10));
ALTER TABLE venta ADD (PVP number(10));
ALTER TABLE fabricante DROP (pais);
ALTER TABLE venta ADD CONSTRAINT ck_u CHECK (unidades_vendidas >= 100);
ALTER TABLE venta DROP CONSTRAINT ck_u;

DROP TABLE articulo CASCADE CONSTRAINT;
DROP TABLE fabricante CASCADE CONSTRAINT;
DROP TABLE pedido CASCADE CONSTRAINT;
DROP TABLE venta CASCADE CONSTRAINT;
DROP TABLE tienda CASCADE CONSTRAINT;








