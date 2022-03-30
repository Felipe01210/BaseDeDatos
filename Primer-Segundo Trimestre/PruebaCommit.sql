ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER backupT IDENTIFIED BY backupT;
GRANT CONNECT, RESOURCE, DBA TO backupT;

CREATE TABLE tema
(
	cod_tema NUMBER(3) NOT NULL,
	denominacion VARCHAR2(10),
	cod_tema_padre NUMBER(3),
	
	CONSTRAINT pk_tema PRIMARY KEY (cod_tema)
);

INSERT INTO tema VALUES (3,'aaaa',2);
INSERT INTO tema VALUES (4,'aabb',3);
INSERT INTO tema VALUES (5,'accc',4);

CREATE TABLE tema_backup
(
	cod_tema NUMBER(3) NOT NULL,
	denominacion VARCHAR2(10),
	cod_tema_padre NUMBER(3),
	
	CONSTRAINT pk_tema_backup PRIMARY KEY (cod_tema)
);

INSERT INTO tema_backup SELECT * FROM tema;



