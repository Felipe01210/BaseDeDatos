CREATE TABLE tema
(
	cod_tema NUMBER(3) NOT NULL,
	denominacion VARCHAR2(10),
	cod_tema_padre NUMBER(3),
	
	CONSTRAINT pk_tema PRIMARY KEY (cod_tema),
	CONSTRAINT fk_tema_r FOREIGN KEY (cod_tema_padre) REFERENCES tema (cod_tema),
	CONSTRAINT res_cod_tema CHECK (cod_tema <= cod_tema_padre)
);

CREATE TABLE autor
(
	cod_autor NUMBER(3) NOT NULL,
	nombre VARCHAR(20) NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	libro_principal NUMBER(3) NOT NULL,
	
	CONSTRAINT pk_autor PRIMARY KEY (cod_autor)
);


CREATE TABLE libro
(
	cod_libro NUMBER(3) NOT NULL,
	titulo VARCHAR2(10) NOT NULL,
	fecha_creacion DATE,
	cod_tema_h NUMBER(3) NOT NULL,
	autor_principal NUMBER(3) NOT NULL,
	
	CONSTRAINT pk_libro PRIMARY KEY (cod_libro),
	CONSTRAINT fk_tema FOREIGN KEY (cod_tema_h) REFERENCES tema (cod_tema),
	CONSTRAINT fk_autor FOREIGN KEY (autor_principal) REFERENCES autor (cod_autor)
);

ALTER TABLE autor ADD CONSTRAINT fk_libro_autor FOREIGN KEY (libro_principal) REFERENCES libro(cod_libro)


CREATE TABLE libro_autor
(
	cod_libro NUMBER(3) NOT NULL,
	cod_autor NUMBER(3) NOT NULL,
	orden NUMBER(1),
	
	CONSTRAINT pk_libro_autor PRIMARY KEY (cod_libro,cod_autor),
	CONSTRAINT fk_libro FOREIGN KEY (cod_libro) REFERENCES libro (cod_libro),
	CONSTRAINT fk_autor_libroAutor FOREIGN KEY (cod_autor) REFERENCES autor (cod_autor),
	CONSTRAINT res_orden CHECK (1<=orden),
	CONSTRAINT res_orden_2 CHECK (orden<=5)
);

CREATE TABLE editorial
(
	cod_editorial NUMBER(3) NOT NULL,
	denominacion VARCHAR2(10),
	
	CONSTRAINT pk_editorial PRIMARY KEY (cod_editorial)
);

CREATE TABLE publicacion
(
	cod_editorial NUMBER(3) NOT NULL,
	cod_libro NUMBER(3) NOT NULL,
	precio NUMBER(3),
	fecha_publicacion DATE DEFAULT sysdate,
	
	CONSTRAINT pk_publicaciones PRIMARY KEY (cod_editorial,cod_libro),
	CONSTRAINT fk_libro_editorial FOREIGN KEY (cod_libro) REFERENCES libro (cod_libro),
	CONSTRAINT fk_editorial FOREIGN KEY (cod_editorial) REFERENCES editorial (cod_editorial) ON DELETE CASCADE,
	CONSTRAINT precio_min CHECK (precio > 0)
);
