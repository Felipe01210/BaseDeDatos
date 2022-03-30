ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER ex1702 IDENTIFIED BY ex1702;
GRANT CONNECT, RESOURCE, DBA TO ex1702;


CREATE TABLE DIRECTOR
(
NOMBRE VARCHAR2(40),
NACIONALIDAD VARCHAR2(40) ,
CONSTRAINT PK_DIRECTOR PRIMARY KEY(NOMBRE)
);
CREATE TABLE PELICULA
(
ID NUMBER,
TITULO VARCHAR2(40),
PRODUCTORA VARCHAR2(40),
NACIONALIDAD VARCHAR2(40),
FECHA DATE,
DIRECTOR VARCHAR2(40),
CONSTRAINT FK_DIRECTOR FOREIGN KEY (DIRECTOR) REFERENCES DIRECTOR(NOMBRE) ,
CONSTRAINT PK_PELICULA PRIMARY KEY (ID)
);
CREATE TABLE EJEMPLAR
(
IDPELICULA NUMBER,
NUMERO NUMBER(2),
ESTADO VARCHAR2(40),
CONSTRAINT PK_EJEMPLAR PRIMARY KEY(IDPELICULA, NUMERO),
CONSTRAINT FK_EJEMPLAR FOREIGN KEY(IDPELICULA) REFERENCES PELICULA(ID)
);
CREATE TABLE ACTORES
(
NOMBRE VARCHAR2(40),
NACIONALIDAD VARCHAR2(40),
SEXO VARCHAR(1),
CONSTRAINT PK_ACTORES PRIMARY KEY(NOMBRE),
CONSTRAINT CK_SEXO CHECK (SEXO IN ('H', 'M'))
);
CREATE TABLE SOCIO
(
DNI VARCHAR2(9),
NOMBRE VARCHAR2(40) CONSTRAINT NN_NOMBRE NOT NULL,
DIRECCION VARCHAR2(40),
TELEFONO VARCHAR(9),
AVALADOR VARCHAR(9),
CONSTRAINT PK_SOCIO PRIMARY KEY(DNI),
CONSTRAINT FK_SOCIO FOREIGN KEY(AVALADOR) REFERENCES SOCIO(DNI)
);
CREATE TABLE ACTUA
(
ACTOR VARCHAR2(40) ,
IDPELICULA NUMBER,
PROTAGONISTA VARCHAR2(1) DEFAULT 'N',
CONSTRAINT PK_ACTUA PRIMARY KEY(ACTOR, IDPELICULA),
CONSTRAINT FK1_ACTUA FOREIGN KEY(ACTOR )REFERENCES ACTORES(NOMBRE) ON DELETE
CASCADE,
CONSTRAINT FK2_ACTUA FOREIGN KEY (IDPELICULA) REFERENCES PELICULA(ID) ON DELETE
CASCADE,
CONSTRAINT CK_PROTAGONISTA CHECK (PROTAGONISTA IN ('S', 'N')) );
CREATE TABLE ALQUILA
(
DNI VARCHAR2(9),
IDPELICULA NUMBER(10),
NUMERO NUMBER(2),
FECHA_ALQUILER DATE,
FECHA_DEVOLUCION DATE,
CONSTRAINT PK_ALQUILA PRIMARY KEY(DNI, IDPELICULA, NUMERO,FECHA_ALQUILER),
CONSTRAINT FK1_DNI FOREIGN KEY(DNI) REFERENCES SOCIO(DNI), CONSTRAINT
FK2_PELI FOREIGN KEY(IDPELICULA, NUMERO)
REFERENCES EJEMPLAR(IDPELICULA, NUMERO),
CONSTRAINT CK_FECHAS CHECK (FECHA_DEVOLUCION > FECHA_ALQUILER) );

--EJERCICIO 1--

--inserta 2 directores--

INSERT INTO director VALUES ('Paco','España');
INSERT INTO director VALUES ('Antonio','Alemania');

--inserta 4 peliculas dirigidas por estos directores--

INSERT INTO pelicula VALUES ('001','La Jungla de Cristal','Kowabunga','Andorra',to_date('02/03/2000','dd/mm/yyyy'),'Paco');
INSERT INTO pelicula VALUES ('002','La Jungla de Cristal 2.0','Bazinga','Rusia',to_date('03/04/2002','dd/mm/yyyy'),'Antonio');
INSERT INTO pelicula VALUES ('003','La Jungla de Cristal 3.0','Chimichanga','Noruega',to_date('04/05/2004','dd/mm/yyyy'),'Paco');
INSERT INTO pelicula VALUES ('004','La Jungla de Cristal 4.0','Calvos','Estonia',to_date('05/06/2006','dd/mm/yyyy'),'Antonio');

--inserta dos ejemplares de cada pelicula--

INSERT INTO ejemplar VALUES ('001','10','Bueno');
INSERT INTO ejemplar VALUES ('001','11','Perfecto');
INSERT INTO ejemplar VALUES ('002','20','Malo');
INSERT INTO ejemplar VALUES ('002','21','Regumalo');
INSERT INTO ejemplar VALUES ('003','30','Penoso');
INSERT INTO ejemplar VALUES ('003','31','Aceptable');
INSERT INTO ejemplar VALUES ('004','40','Bueno');
INSERT INTO ejemplar VALUES ('004','41','Regumalo');

--inserta 4 socios--

INSERT INTO socio VALUES ('00000001A','Paco','Alli N4','75437598','');
INSERT INTO socio VALUES ('00000002B','Antonio','Aqui N5','4367432','00000001A');
INSERT INTO socio VALUES ('00000003C','Pepe','Ahi N6','74374932','00000002B');
INSERT INTO socio VALUES ('00000004D','Mari','Ese Lugar N7','43798327','00000003C');

--inserta 6 actores--

INSERT INTO actores VALUES ('Mari','Rusia','M');
INSERT INTO actores VALUES ('Pepe','España','H');
INSERT INTO actores VALUES ('Jorge','Andorra','H');
INSERT INTO actores VALUES ('Tommy','Francia','H');
INSERT INTO actores VALUES ('Penelope','Alemania','M');
INSERT INTO actores VALUES ('Paqui','Portugal','M');

--asociar a cada pelicula un actor--

INSERT INTO actua VALUES ('Mari','001','N');
INSERT INTO actua VALUES ('Jorge','002','N');
INSERT INTO actua VALUES ('Penelope','003','S');
INSERT INTO actua VALUES ('Pepe','004','S');

--ejemplares alquilados al menos una vez--

INSERT INTO alquila VALUES ('00000001A','001','10',to_date('01/02/2001','dd/mm/yyyy'),to_date('02/01/2002','dd/mm/yyyy'));
INSERT INTO alquila VALUES ('00000002B','002','20',to_date('02/03/2003','dd/mm/yyyy'),to_date('03/02/2004','dd/mm/yyyy'));
INSERT INTO alquila VALUES ('00000003C','003','30',to_date('03/04/2005','dd/mm/yyyy'),to_date('04/03/2006','dd/mm/yyyy'));
INSERT INTO alquila VALUES ('00000004D','004','40',to_date('04/05/2007','dd/mm/yyyy'),to_date('05/04/2008','dd/mm/yyyy'));
INSERT INTO alquila VALUES ('00000001A','001','11',to_date('05/06/2009','dd/mm/yyyy'),to_date('06/05/2010','dd/mm/yyyy'));
INSERT INTO alquila VALUES ('00000002B','002','21',to_date('06/07/2011','dd/mm/yyyy'),to_date('07/06/2012','dd/mm/yyyy'));
INSERT INTO alquila VALUES ('00000003C','003','31',to_date('07/08/2013','dd/mm/yyyy'),to_date('08/07/2014','dd/mm/yyyy'));
INSERT INTO alquila VALUES ('00000004D','004','41',to_date('08/09/2015','dd/mm/yyyy'),to_date('09/08/2016','dd/mm/yyyy'));

--EJERCICIO 2--

--cambiar nacionalidad // en este caso yo puse el pais asi--
--que lo cambio por el gentilicio--

UPDATE DIRECTOR SET NACIONALIDAD = 'Español' WHERE NACIONALIDAD = 'España';
UPDATE DIRECTOR SET NACIONALIDAD = 'Aleman' WHERE NACIONALIDAD = 'Alemania';


--EJERCICIO 3--

--cambio todos los socios menos el 1A para que este sea su avalador--

UPDATE SOCIO SET AVALADOR = '00000001A' WHERE AVALADOR IS NOT NULL;


--EJERCICIO 4--

--hago un update de uno de mis socios ya que ninguno tenia un--
--numero de telefono que empezara por 5--

UPDATE socio SET telefono = '54432747' WHERE dni = '00000002B';

SELECT * FROM SOCIO WHERE TELEFONO = '5%';

DELETE FROM SOCIO WHERE telefono = '5%';

--Nos debe dar un error ya que este socio tiene registrado un alquiler--

--EJERCICIO 5--

--el error del ejercicio anterior se soluciona borrando las constraint--
--de foreign key entre alquila y socio para hacerla de nuevo y que--
--tenga el ON DELETE CASCADE--

ALTER TABLE alquila DROP CONSTRAINT FK1_DNI;
ALTER TABLE alquila ADD CONSTRAINT FK1_DNI FOREIGN KEY (dni) REFERENCES socio(dni) ON DELETE CASCADE;

--de esta forma, al borrar el socio, tambien se borrara su alquiler--
--y no nos dara error--


--EJERCICIO 6--

--eliminar dos peliculas--

SELECT * FROM PELICULA WHERE ID = '001' AND ID = '002';

DELETE * FROM PELICULA WHERE ID = '001' AND ID = '002';

--debe dar un error porque hay ejemplares hijos de esa pelicula--
--esto se soluciona cambiando la foreign key para que sea ON DELETE CASCADE--

--EJERCICIO 7--

--crear directores backup y almacenar los datos de los directores--

CREATE TABLE DIRECTORES_BACKUP
(
	NOMBRE VARCHAR2(40),
	NACIONALIDAD VARCHAR2(40) ,
	CONSTRAINT PK_DIRECTOR_BACKUP PRIMARY KEY(NOMBRE)
);

INSERT INTO directores_backup VALUES ('Paco','España');
INSERT INTO directores_backup VALUES ('Antonio','Alemania');

--EJERCICIO 8--

--añadir el campo valoracion a directores_backup y añadir--
--la valoracion Muy buena trayectoria profesional a los españoles--

ALTER TABLE directores_backup ADD valoracion varchar2(50);

UPDATE directores_backup SET valoracion = 'Muy buena trayectoria profesional'
WHERE nacionalidad = 'España';

--EJERCICIO 9--

--adapta la creacion de tablas para que funcione en mysql--

CREATE TABLE DIRECTOR
(
NOMBRE VARCHAR(40),
NACIONALIDAD VARCHAR(40) ,
CONSTRAINT PK_DIRECTOR PRIMARY KEY(NOMBRE)
);
CREATE TABLE PELICULA
(
ID int,
TITULO VARCHAR(40),
PRODUCTORA VARCHAR(40),
NACIONALIDAD VARCHAR(40),
FECHA DATE,
DIRECTOR VARCHAR(40),
CONSTRAINT FK_DIRECTOR FOREIGN KEY (DIRECTOR) REFERENCES DIRECTOR(NOMBRE) ,
CONSTRAINT PK_PELICULA PRIMARY KEY (ID)
);
CREATE TABLE EJEMPLAR
(
IDPELICULA int,
NUMERO int(2),
ESTADO VARCHAR(40),
CONSTRAINT PK_EJEMPLAR PRIMARY KEY(IDPELICULA, NUMERO),
CONSTRAINT FK_EJEMPLAR FOREIGN KEY(IDPELICULA) REFERENCES PELICULA(ID)
);
CREATE TABLE ACTORES
(
NOMBRE VARCHAR(40),
NACIONALIDAD VARCHAR(40),
SEXO VARCHAR(1),
CONSTRAINT PK_ACTORES PRIMARY KEY(NOMBRE),
CONSTRAINT CK_SEXO CHECK (SEXO IN ('H', 'M'))
);
CREATE TABLE SOCIO
(
DNI VARCHAR(9),
NOMBRE VARCHAR(40) not null,
DIRECCION VARCHAR(40),
TELEFONO VARCHAR(9),
AVALADOR VARCHAR(9),
CONSTRAINT PK_SOCIO PRIMARY KEY(DNI),
CONSTRAINT FK_SOCIO FOREIGN KEY(AVALADOR) REFERENCES SOCIO(DNI)
);
CREATE TABLE ACTUA
(
ACTOR VARCHAR(40) ,
IDPELICULA int,
PROTAGONISTA VARCHAR(1) DEFAULT 'N',
CONSTRAINT PK_ACTUA PRIMARY KEY(ACTOR, IDPELICULA),
CONSTRAINT FK1_ACTUA FOREIGN KEY(ACTOR )REFERENCES ACTORES(NOMBRE) ON DELETE
CASCADE,
CONSTRAINT FK2_ACTUA FOREIGN KEY (IDPELICULA) REFERENCES PELICULA(ID) ON DELETE
CASCADE,
CONSTRAINT CK_PROTAGONISTA CHECK (PROTAGONISTA IN ('S', 'N')) );
CREATE TABLE ALQUILA
(
DNI VARCHAR(9),
IDPELICULA int(10),
NUMERO int(2),
FECHA_ALQUILER DATE,
FECHA_DEVOLUCION DATE,
CONSTRAINT PK_ALQUILA PRIMARY KEY(DNI, IDPELICULA, NUMERO,FECHA_ALQUILER),
CONSTRAINT FK1_DNI FOREIGN KEY(DNI) REFERENCES SOCIO(DNI), CONSTRAINT
FK2_PELI FOREIGN KEY(IDPELICULA, NUMERO)
REFERENCES EJEMPLAR(IDPELICULA, NUMERO),
CONSTRAINT CK_FECHAS CHECK (FECHA_DEVOLUCION > FECHA_ALQUILER) );

--aqui vemos los cambios necesarios respecto a la creacion de tablas original--

--EJERCICIO 10--

--en oracle hacer que id de pelicula se auto incremente, e insertar dos datos--

--en este caso tendriamos que poner un trozo de codigo
--que especifica que valor incrementamos, cuanto cada vez y el valor max--

--EJERCICIO 11--

--en sql hacer que id de pelifucla se auto incremente, e insertar datos--

--se haria añadiendo autoincrement tras el atributo--

--EJERCICIO 12--

--apartado1: No, debido a que al tener autocommit desactivado, la creacion
--de la tabla queda fijada pero no el insertar datos hasta que hagamos un commit

--apartado2: No, al crear FANS se hace un commit de forma automatica, haciendo
--imposible volver a la situacion anterior a la creacion de FANS

--apartado3: Realizaria un commit tras insertar los datos, que hace que todo
--lo anterior a dicho commit quede fijado en mi base de datos de forma
--persistente

--apartado4: Si no se ha realizado ningun commit tras el borrado de los
--datos podemos realizar un rollback, que nos llevara al ultimo commit,
--en este caso, el que pusimos despues de insertar datos y antes de borrarlos

--apartado5: El savepoint sirve de punto de control en nuestro codigo,
--permitiendonos guardarlo sin que quede fijado de forma persistente en
--nuestra base de datos (a diferencia del commit), permitiendonos movernos
--entre estos "puntos de guardado" segun lo necesitemos (el commit solo
--nos permite volver al ultimo)

CREATE TABLE ejemplo
(
	atributo NUMBER;
	CONSTRAINT pk_ejemplo PRIMARY KEY (atributo);
);

INSERT INTO ejemplo VALUES ('5');

commit; --Aqui guardamos el INSERT de forma persistente, ya NO podemos
			--volver atras--
INSERT INTO ejemplo VALUES ('3');

ROLLBACK; --volvemos al ultimo COMMIT, deshaciendo el ultimo INSERT--

INSERT INTO ejemplo VALUES ('4');

SAVEPOINT punto4;

INSERT INTO ejemplo VALUES ('6');

SAVEPOINT punto6;

DELETE * FROM ejemplo;

ROLLBACK TO SAVEPOINT punto4; --creamos varios SAVEPOINT para guardar
--las operaciones de forma no consistente, tras borrarlas, volvemos
--al savepoint punto4 deshaciendo el borrado y la creacion del punto6--











