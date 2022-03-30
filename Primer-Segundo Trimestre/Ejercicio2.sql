CREATE TABLE equipo
(
	codEquipo varchar2(4),
	nombre varchar2(30) NOT NULL,
	localidad varchar2(15),
	
	CONSTRAINT pk_equipo PRIMARY KEY (codEquipo)
);

CREATE TABLE jugador
(
	codJugador varchar2(4),
	nombre varchar2(30)NOT NULL,
	fechaNacimiento DATE,
	demarcación varchar2(10),
	codEquipo varchar2(4),
	
	CONSTRAINT pk_jugador PRIMARY KEY (codJugador),
	CONSTRAINT fk_jugador FOREIGN KEY (codEquipo) REFERENCES equipo (codEquipo)
	CONSTRAINT res_jugador CHECK (nombre IS initcap)
);

CREATE TABLE partido
(
	codPartido varchar2(4),
	codEquipoLocal varchar2(4),
	codEquipoVisitante varchar2(4),
	fecha DATE,
	competicion varchar2(4),
	jornada varchar2(20),
	
	CONSTRAINT pk_partido PRIMARY KEY (codPartido),
	CONSTRAINT fk_equipoLocal FOREIGN KEY (codEquipoLocal) REFERENCES equipo (codEquipo),
	CONSTRAINT fk_equipoVisitante FOREIGN KEY (codEquipoVisitante) REFERENCES equipo (codEquipo),
	CONSTRAINT res_fecha CHECK (EXTRACT(MONTH FROM fecha) != 7 AND EXTRACT(MONTH FROM fecha) != 8),
	CONSTRAINT res_competicion CHECK (competicion IN ('Copa','Liga'))
);

CREATE TABLE incidencia
(
	numIncidencia varchar2(6),
	codPartido varchar2(4),
	codJugador varchar2(4),
	minuto number(2),
	tipo varchar2(20),
	
	CONSTRAINT pk_incidencia PRIMARY KEY (numIncidencia),
	CONSTRAINT fk_incidenciaPartido FOREIGN KEY (codPartido) REFERENCES partido (codPartido),
	CONSTRAINT fk_incidenciaJugador FOREIGN KEY (codJugador) REFERENCES jugador (codJugador),
	CONSTRAINT res_minuto CHECK (minuto > 0 AND minuto < 101)
);