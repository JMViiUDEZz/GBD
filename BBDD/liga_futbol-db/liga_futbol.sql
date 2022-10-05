CREATE DATABASE LIGA_FUTBOL;
USE LIGA_FUTBOL;
CREATE TABLE PERSONAS (
DNI CHAR(9) PRIMARY KEY,
NOMBRE VARCHAR(30) NOT NULL,
DIRECCION VARCHAR(50) NOT NULL,
TELEFONO CHAR(9) NULL,
SEXO CHAR(1) NOT NULL
);
CREATE TABLE EQUIPOS (
CODIGO NUMERIC(2) PRIMARY KEY,
NOMBRE VARCHAR(25) NOT NULL,
CIUDAD VARCHAR(20) NOT NULL,
ESTADIO VARCHAR(25) NOT NULL,
AFORO NUMERIC(6,0) NULL,
FECHA_FUNDACION DATE NOT NULL,
DNI_PRESIDENTE CHAR(9),
FOREIGN KEY (DNI_PRESIDENTE) REFERENCES PERSONAS(DNI)
);
CREATE TABLE JUGADORES(
CODIGO NUMERIC(3,0),
NOMBRE VARCHAR(35) NOT NULL,
PUESTO VARCHAR(15) NOT NULL,
DORSAL CHAR(21) NOT NULL,
APODO VARCHAR(25),
EQUIPO NUMERIC(2,0) NOT NULL,
PRIMARY KEY(CODIGO),
FOREIGN KEY(EQUIPO) REFERENCES EQUIPOS(CODIGO) ON DELETE CASCADE
ON UPDATE CASCADE
);
CREATE TABLE PARTIDOS(
ID NUMERIC(3) PRIMARY KEY,
EQUIPO_LOCAL NUMERIC(2),
GOLES_LOCAL NUMERIC(2) NOT NULL,
EQUIPO_VISITANTE NUMERIC(2),
GOLES_VISITANTE NUMERIC (2) NOT NULL,
FECHA_HORA TIMESTAMP NOT NULL,
FOREIGN KEY (EQUIPO_LOCAL) REFERENCES EQUIPOS(CODIGO) ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (EQUIPO_VISITANTE) REFERENCES EQUIPOS(CODIGO) ON DELETE CASCADE
ON UPDATE CASCADE
);
CREATE TABLE PARTIDO_JUGADOR_GOL(
JUGADOR DECIMAL(3,0),
PARTIDO DECIMAL(3),
MINUTO DECIMAL(3),
PRIMARY KEY(JUGADOR,PARTIDO,MINUTO),
FOREIGN KEY(JUGADOR) REFERENCES JUGADORES (CODIGO) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(PARTIDO,MINUTO) REFERENCES GOLES (ID_PARTIDO,MINUTO) ON DELETE CASCADE ON UPDATE CASCADE
);
