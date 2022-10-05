/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 10.6.5-MariaDB : Database - sistema_pedidos
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sistema_pedidos` /*!40100 DEFAULT CHARACTER SET utf8mb3 */;

USE `sistema_pedidos`;

/*Table structure for table `articulos` */

DROP TABLE IF EXISTS `articulos`;

CREATE TABLE `articulos` (
  `REF` decimal(4,0) NOT NULL,
  `NOMBRE` varchar(40) NOT NULL,
  `FAMILIA` decimal(2,0) NOT NULL,
  `STOCK` decimal(4,0) NOT NULL,
  `PRECIO` decimal(6,2) NOT NULL,
  `OBSERVACIONES` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`REF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `articulos` */

/*Table structure for table `detalles_pedidos` */

DROP TABLE IF EXISTS `detalles_pedidos`;

CREATE TABLE `detalles_pedidos` (
  `REF_PEDIDO` decimal(10,0) NOT NULL,
  `LINEA` decimal(2,0) NOT NULL,
  `REF_ARTICULO` decimal(4,0) NOT NULL,
  `UNIDADES` decimal(5,0) NOT NULL,
  PRIMARY KEY (`REF_PEDIDO`,`LINEA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `detalles_pedidos` */

/*Table structure for table `familias` */

DROP TABLE IF EXISTS `familias`;

CREATE TABLE `familias` (
  `REF` decimal(2,0) NOT NULL,
  `DESCRIPCION` varchar(50) NOT NULL,
  PRIMARY KEY (`REF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `familias` */

/*Table structure for table `pedidos` */

DROP TABLE IF EXISTS `pedidos`;

CREATE TABLE `pedidos` (
  `REF` decimal(10,0) NOT NULL,
  `FECHA` date NOT NULL,
  `CIF_PROVEEDOR` varchar(10) NOT NULL,
  `ESTADO` varchar(30) NOT NULL,
  PRIMARY KEY (`REF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `pedidos` */

/*Table structure for table `proveedores` */

DROP TABLE IF EXISTS `proveedores`;

CREATE TABLE `proveedores` (
  `CIF` varchar(10) NOT NULL,
  `NOMBRE` varchar(25) NOT NULL,
  `DIRECCION` varchar(50) NOT NULL,
  `TELEFONO` varchar(12) DEFAULT NULL,
  `PERSONA_CONTACTO` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`CIF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `proveedores` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
