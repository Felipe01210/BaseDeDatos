ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER jardineria IDENTIFIED BY jardineria;
GRANT CONNECT, RESOURCE, DBA TO jardineria; para crear una nueva carpeta de tablas

DROP TABLE nombre CASCADE CONSTRAINT; para borrar una tabla

regexp_like(nombre,'')


SELECT * FROM DICTIONARY para consultar todas las tablas existentes
SELECT * FROM user_tables para consultar las tablas del usuario
WHERE TABLE_NAME LIKE '%CONSTR%' para ver todas las tablas que tengan este nombre

ON DELETE CASCADE al borrar el padre se borra el hijo
ON DELETE SET NULL al borrar el padre se pone a nulo el hijo
la opcion por defecto es que NO se pueda modificar o borrar el padre si tiene un hijo

DEFAULT para poner un valor por defecto, se coloca tras definir la variable

upper() para hacerlo mayus
lower() para hacerlo minusculas
trim() para quitar los espacios, ltrim para quitar solo los de la izquierda
UNIQUE para valores unicos, sin repetecion. Crea un indice para esa columna

CREATE INDEX nombre_indice
ON nombre_tabla (campo1,campo2,...) para crear un indice de nombre "nombre_indice" sobre la
tabla "nombre_tabla" con los campos "campo1,campo2,...".

DROP COLUMN borrar columna
disable CONSTRAINT nombre para deshabilitar un CONSTRAINT

UNIQUE (nombre) disable; para deshabilitar un elemento unico