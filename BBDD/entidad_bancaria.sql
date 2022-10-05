/*
SQLyog Ultimate v8.61 
MySQL - 5.5.5-10.4.6-MariaDB : Database - entidad_bancaria
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`entidad_bancaria` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci */;

USE `entidad_bancaria`;

/*Table structure for table `clientes` */

DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `DNICli` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `Nomcli` varchar(15) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Apecli` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Dircli` varchar(35) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Pobcli` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Sexocli` char(1) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Fnaccli` date DEFAULT NULL,
  PRIMARY KEY (`DNICli`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Data for the table `clientes` */

insert  into `clientes`(`DNICli`,`Nomcli`,`Apecli`,`Dircli`,`Pobcli`,`Sexocli`,`Fnaccli`) values ('111111111','Jose Luis','Parra Lopez','La fuente, 33','Huercal-Overa','H','1955-03-22'),('222222222','Ana Maria','Torres Salcedo','Juan XXIII, 4','Pulpi','M','1966-07-04'),('333333333','Pedro','Puentes Benitez','Amanecer, 7','Huercal-Overa','H','1970-12-12'),('444444444','Martina','Salmeron Cox','Cuesta del Rosario, 21','Sevilla','M','1966-11-10'),('555555555','Enrique','Morales Meseguer','Pastor y Landero, 15','Sevilla','H','1950-03-29'),('666666666','Gines','Fuentes Artero','Neptuno, 6','Granada','H','1980-10-14');

/*Table structure for table `cuentas` */

DROP TABLE IF EXISTS `cuentas`;

CREATE TABLE `cuentas` (
  `NumeroCta` varchar(5) COLLATE utf8_spanish_ci NOT NULL,
  `Sucursal` varchar(4) COLLATE utf8_spanish_ci NOT NULL,
  `Tipo` varchar(15) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Fechaapertura` date DEFAULT NULL,
  `Clititular` varchar(9) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Cliautorizado` varchar(9) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`NumeroCta`,`Sucursal`),
  KEY `FK_cuentas_sucursales` (`Sucursal`),
  KEY `FK_cuentas_titular` (`Clititular`),
  KEY `FK_cuentas_autorizado` (`Cliautorizado`),
  CONSTRAINT `FK_cuentas_autorizado` FOREIGN KEY (`Cliautorizado`) REFERENCES `clientes` (`DNICli`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_cuentas_sucursales` FOREIGN KEY (`Sucursal`) REFERENCES `sucursales` (`Codsucursal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_cuentas_titular` FOREIGN KEY (`Clititular`) REFERENCES `clientes` (`DNICli`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Data for the table `cuentas` */

insert  into `cuentas`(`NumeroCta`,`Sucursal`,`Tipo`,`Fechaapertura`,`Clititular`,`Cliautorizado`) values ('00001','0001','Corriente','2012-12-19','111111111','222222222'),('00001','0002','Corriente','2005-09-11','333333333','444444444'),('00002','0001','Coorriente','2002-12-13','222222222','111111111'),('00002','0003','Deposito','2009-10-04','444444444','555555555'),('00003','0001','Deposito','2003-01-15','222222222','111111111'),('00003','0003','Corriente','2013-02-02','555555555','444444444'),('00004','0001','Corriente','2021-03-21','666666666',NULL),('00005','0002','Corriente','2021-03-21','666666666',NULL);

/*Table structure for table `movimientos` */

DROP TABLE IF EXISTS `movimientos`;

CREATE TABLE `movimientos` (
  `NumeroCta` varchar(5) COLLATE utf8_spanish_ci NOT NULL,
  `Sucursal` varchar(4) COLLATE utf8_spanish_ci NOT NULL,
  `NumeroMov` int(11) NOT NULL,
  `FechaMov` date DEFAULT NULL,
  `TipoMov` char(1) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Concepto` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Importe` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`NumeroCta`,`Sucursal`,`NumeroMov`),
  CONSTRAINT `FK_movimientos_cuentas` FOREIGN KEY (`NumeroCta`, `Sucursal`) REFERENCES `cuentas` (`NumeroCta`, `Sucursal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Data for the table `movimientos` */

insert  into `movimientos`(`NumeroCta`,`Sucursal`,`NumeroMov`,`FechaMov`,`TipoMov`,`Concepto`,`Importe`) values ('00001','0001',1,'2012-12-19','I','Apertura','1000.00'),('00001','0001',2,'2012-12-24','I','Nomina','1294.50'),('00001','0001',3,'2013-01-02','R','Reintegro ventanilla','234.00'),('00001','0001',4,'2021-03-21','I','Dev. AEAT','89.41'),('00001','0002',1,'2008-01-23','I','Apertura','554.00'),('00001','0002',2,'2008-08-30','R','Recibo IBI','221.35'),('00001','0002',3,'2009-12-13','I','Nomina','986.00'),('00001','0002',4,'2013-02-14','R','Mercadona','58.34'),('00002','0001',1,'2002-12-01','I','Apertura','2500.00'),('00002','0001',2,'2003-01-24','R','Electrodomesticos Lopez','356.00'),('00002','0001',3,'2021-03-21','I','Dev. AEAT','1450.66'),('00002','0003',1,'2009-10-04','I','Apertura','10500.00'),('00003','0001',1,'2012-06-21','I','Apertura','30000.00'),('00003','0001',2,'2021-03-21','R','Recibo teléfono','40.55'),('00003','0003',1,'2012-09-09','I','Apertura','892.00'),('00003','0003',2,'2012-09-11','R','Repsol Gas','124.66'),('00004','0001',1,'2021-03-21','I','Ingreso efectivo','350.00'),('00004','0001',2,'2021-03-21','R','Recibo teléfono','40.55'),('00004','0001',3,'2021-03-21','I','Dev. AEAT','187.30'),('00004','0001',4,'2021-03-21','R','Gasolinera Sur','33.50');

/*Table structure for table `sucursales` */

DROP TABLE IF EXISTS `sucursales`;

CREATE TABLE `sucursales` (
  `Codsucursal` varchar(4) COLLATE utf8_spanish_ci NOT NULL,
  `Dirsucursal` varchar(25) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Pobsucursal` varchar(15) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Telsucursal` varchar(9) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`Codsucursal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Data for the table `sucursales` */

insert  into `sucursales`(`Codsucursal`,`Dirsucursal`,`Pobsucursal`,`Telsucursal`) values ('0001','San Pablo, 25','Sevilla','954123456'),('0002','Gran Via de Colon, 4','Granada','958123456'),('0003','Pza Contitucion, 1','Huercal-Overa','950123456'),('0004','Mayor, 3','Pulpi','950234567'),('0005','Pza de la Campana, 2','Sevilla','954234567');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
