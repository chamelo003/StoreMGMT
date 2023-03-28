-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 28, 2023 at 06:33 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbsistena`
--
CREATE DATABASE IF NOT EXISTS `dbsistena` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `dbsistena`;

-- --------------------------------------------------------

--
-- Table structure for table `articulo`
--
-- Creation: Mar 26, 2023 at 03:37 AM
--

CREATE TABLE `articulo` (
  `idarticulo` int(11) NOT NULL,
  `idcategoria` int(11) NOT NULL,
  `codigo` varchar(50) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `stock` int(11) NOT NULL,
  `descripcion` varchar(256) DEFAULT NULL,
  `imagen` varchar(45) DEFAULT NULL,
  `condicion` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `articulo`:
--   `idcategoria`
--       `categoria` -> `idcategoria`
--

--
-- Dumping data for table `articulo`
--

INSERT INTO `articulo` (`idarticulo`, `idcategoria`, `codigo`, `nombre`, `stock`, `descripcion`, `imagen`, `condicion`) VALUES
(4, 4, '656665', 'Tubo PVC de media', 22, 'lances', '', 1),
(5, 5, '123456', 'interruptor aereo', 2, 'switch interruptor', '', 1),
(6, 5, '224', 'cable 22x4', 12, 'cable 22 x 4 alarmas', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `categoria`
--
-- Creation: Mar 26, 2023 at 03:37 AM
--

CREATE TABLE `categoria` (
  `idcategoria` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(256) DEFAULT NULL,
  `condicion` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `categoria`:
--

--
-- Dumping data for table `categoria`
--

INSERT INTO `categoria` (`idcategoria`, `nombre`, `descripcion`, `condicion`) VALUES
(3, 'Construccion', 'materiales de construccion', 1),
(4, 'Fontaneria', 'Materiales de tuberia y relacionados', 1),
(5, 'Electricidad', 'Materiales electricos', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ingreso`
--
-- Creation: Mar 26, 2023 at 03:37 AM
--

CREATE TABLE `ingreso` (
  `idingreso` int(11) NOT NULL,
  `idproveedor` int(11) NOT NULL,
  `idusuario` int(11) DEFAULT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) DEFAULT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(4,2) NOT NULL,
  `total_compra` decimal(11,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `ingreso`:
--   `idproveedor`
--       `persona` -> `idpersona`
--   `idusuario`
--       `usuario` -> `idusuario`
--

--
-- Dumping data for table `ingreso`
--

INSERT INTO `ingreso` (`idingreso`, `idproveedor`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `impuesto`, `total_compra`, `estado`) VALUES
(4, 3, 1, 'Factura', 'asdfasj', '154555', '2023-03-25 00:00:00', '15.00', '4460.00', 'Aceptado'),
(5, 3, 1, 'Factura', 'kasfj', '243879', '2023-03-25 00:00:00', '15.00', '21600.00', 'Aceptado');

-- --------------------------------------------------------

--
-- Table structure for table `ingresodetalle`
--
-- Creation: Mar 26, 2023 at 03:37 AM
--

CREATE TABLE `ingresodetalle` (
  `idingresodetalle` int(11) NOT NULL,
  `idingreso` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_compra` decimal(11,2) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `ingresodetalle`:
--   `idarticulo`
--       `articulo` -> `idarticulo`
--   `idingreso`
--       `ingreso` -> `idingreso`
--

--
-- Dumping data for table `ingresodetalle`
--

INSERT INTO `ingresodetalle` (`idingresodetalle`, `idingreso`, `idarticulo`, `cantidad`, `precio_compra`, `precio_venta`) VALUES
(8, 4, 4, 22, '200.00', '360.00'),
(9, 4, 5, 2, '30.00', '45.00'),
(10, 5, 6, 12, '1800.00', '2300.00');

--
-- Triggers `ingresodetalle`
--
DELIMITER $$
CREATE TRIGGER `tr_updStockIngreso` AFTER INSERT ON `ingresodetalle` FOR EACH ROW BEGIN
    update articulo set stock = stock + NEW.cantidad
    where articulo.idarticulo = NEW.idarticulo ;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `permiso`
--
-- Creation: Mar 26, 2023 at 03:37 AM
--

CREATE TABLE `permiso` (
  `idpermiso` int(11) NOT NULL,
  `nombre` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `permiso`:
--

--
-- Dumping data for table `permiso`
--

INSERT INTO `permiso` (`idpermiso`, `nombre`) VALUES
(1, 'escritorio'),
(2, 'almacen'),
(3, 'compras'),
(4, 'ventas'),
(5, 'acceso'),
(6, 'consulta de ventas'),
(7, 'consulta de ventas');

-- --------------------------------------------------------

--
-- Table structure for table `permisousuario`
--
-- Creation: Mar 26, 2023 at 03:37 AM
--

CREATE TABLE `permisousuario` (
  `idpermisousuario` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `idpermiso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `permisousuario`:
--   `idpermiso`
--       `permiso` -> `idpermiso`
--   `idusuario`
--       `usuario` -> `idusuario`
--

--
-- Dumping data for table `permisousuario`
--

INSERT INTO `permisousuario` (`idpermisousuario`, `idusuario`, `idpermiso`) VALUES
(15, 1, 1),
(16, 1, 2),
(17, 1, 3),
(18, 1, 4),
(19, 1, 5),
(20, 1, 6),
(21, 1, 7),
(22, 3, 1),
(23, 3, 2),
(24, 3, 3),
(25, 3, 4),
(26, 3, 5),
(27, 3, 6),
(28, 3, 7);

-- --------------------------------------------------------

--
-- Table structure for table `persona`
--
-- Creation: Mar 26, 2023 at 04:51 AM
--

CREATE TABLE `persona` (
  `idpersona` int(11) NOT NULL,
  `tipo_persona` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo_documento` varchar(20) DEFAULT NULL,
  `num_documento` varchar(20) DEFAULT NULL,
  `direccion` varchar(70) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `persona`:
--

--
-- Dumping data for table `persona`
--

INSERT INTO `persona` (`idpersona`, `tipo_persona`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`) VALUES
(3, 'Proveedor', 'proveedor prueba 1', 'RTN', '06071996010488', 'los llano', '35655656', 'kaskdfl!sl@d.com'),
(4, 'Cliente', 'Cliente final', 'CEDULA', '000', '----', '0000000', 'cliente@final.hn');

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--
-- Creation: Mar 26, 2023 at 04:44 AM
--

CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo_documento` varchar(20) NOT NULL,
  `num_documento` varchar(20) NOT NULL,
  `direccion` varchar(70) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `cargo` varchar(20) DEFAULT NULL,
  `login` varchar(20) NOT NULL,
  `clave` varchar(64) NOT NULL,
  `condicion` tinyint(4) DEFAULT 1,
  `imagen` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `usuario`:
--

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`idusuario`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`, `cargo`, `login`, `clave`, `condicion`, `imagen`) VALUES
(1, 'Administrador', 'DNI', '75424245', 'Mz D lt 7 San juan macias', '7814340', '', 'Analista programador', 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 1, '1527651109.png'),
(3, 'root02', 'DNI', 'asskdfkk', 'ksdksk', '555', 'askdfmks@llsd.com', 'sldfl', 'root', 'fd5f02c87843f48ee455e9c059de4bf77040856e9cc73ef3d82cc41ff484ba1c', 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `venta`
--
-- Creation: Mar 26, 2023 at 03:37 AM
--

CREATE TABLE `venta` (
  `idventa` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) DEFAULT NULL,
  `num_comprobante` varchar(20) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(4,2) NOT NULL,
  `total_venta` decimal(11,2) NOT NULL,
  `estado` varchar(10) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `venta`:
--   `idcliente`
--       `persona` -> `idpersona`
--   `idusuario`
--       `usuario` -> `idusuario`
--

--
-- Dumping data for table `venta`
--

INSERT INTO `venta` (`idventa`, `idcliente`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `impuesto`, `total_venta`, `estado`) VALUES
(5, 4, 1, 'Factura', '', '12345', '2023-03-25 00:00:00', '15.00', '2000.00', 'ANULADO'),
(6, 4, 3, 'Ticket', '', '36566', '2023-03-26 00:00:00', '15.00', '90.00', 'ANULADO');

-- --------------------------------------------------------

--
-- Table structure for table `ventadetalle`
--
-- Creation: Mar 26, 2023 at 03:37 AM
--

CREATE TABLE `ventadetalle` (
  `idventadetalle` int(11) NOT NULL,
  `idventa` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL,
  `descuento` decimal(11,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `ventadetalle`:
--   `idarticulo`
--       `articulo` -> `idarticulo`
--   `idventa`
--       `venta` -> `idventa`
--

--
-- Dumping data for table `ventadetalle`
--

INSERT INTO `ventadetalle` (`idventadetalle`, `idventa`, `idarticulo`, `cantidad`, `precio_venta`, `descuento`) VALUES
(10, 5, 6, 1, '2300.00', '300.00'),
(11, 6, 5, 2, '45.00', '0.00');

--
-- Triggers `ventadetalle`
--
DELIMITER $$
CREATE TRIGGER `tr_updStockVenta` AFTER INSERT ON `ventadetalle` FOR EACH ROW BEGIN
    	UPDATE articulo SET stock = stock - NEW.cantidad
        WHERE articulo.idarticulo = NEW.idarticulo;
	END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `articulo`
--
ALTER TABLE `articulo`
  ADD PRIMARY KEY (`idarticulo`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  ADD KEY `fk_articulo_categorio_idx` (`idcategoria`);

--
-- Indexes for table `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idcategoria`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`);

--
-- Indexes for table `ingreso`
--
ALTER TABLE `ingreso`
  ADD PRIMARY KEY (`idingreso`),
  ADD KEY `fk_ingreso_persona_idx` (`idproveedor`),
  ADD KEY `fk_ingreso_usuario_idx` (`idusuario`);

--
-- Indexes for table `ingresodetalle`
--
ALTER TABLE `ingresodetalle`
  ADD PRIMARY KEY (`idingresodetalle`),
  ADD KEY `fk_ingresodetalle_ingreso_idx` (`idingreso`),
  ADD KEY `fk_ingresodetalle_articulo_idx` (`idarticulo`);

--
-- Indexes for table `permiso`
--
ALTER TABLE `permiso`
  ADD PRIMARY KEY (`idpermiso`);

--
-- Indexes for table `permisousuario`
--
ALTER TABLE `permisousuario`
  ADD PRIMARY KEY (`idpermisousuario`),
  ADD KEY `fk_permisousuario_usuario_idx` (`idusuario`),
  ADD KEY `fk_permisousuario_permiso_idx` (`idpermiso`);

--
-- Indexes for table `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idpersona`),
  ADD UNIQUE KEY `num_documento` (`num_documento`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`),
  ADD UNIQUE KEY `login` (`login`);

--
-- Indexes for table `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`idventa`),
  ADD KEY `fk_venta_cliente_idx` (`idcliente`),
  ADD KEY `fk_venta_usuario_idx` (`idusuario`);

--
-- Indexes for table `ventadetalle`
--
ALTER TABLE `ventadetalle`
  ADD PRIMARY KEY (`idventadetalle`),
  ADD KEY `fk_ventadetalle_venta_idx` (`idventa`),
  ADD KEY `fk_ventadetalle_idx` (`idarticulo`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `articulo`
--
ALTER TABLE `articulo`
  MODIFY `idarticulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idcategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `ingreso`
--
ALTER TABLE `ingreso`
  MODIFY `idingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `ingresodetalle`
--
ALTER TABLE `ingresodetalle`
  MODIFY `idingresodetalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `permiso`
--
ALTER TABLE `permiso`
  MODIFY `idpermiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `permisousuario`
--
ALTER TABLE `permisousuario`
  MODIFY `idpermisousuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `persona`
--
ALTER TABLE `persona`
  MODIFY `idpersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `venta`
--
ALTER TABLE `venta`
  MODIFY `idventa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `ventadetalle`
--
ALTER TABLE `ventadetalle`
  MODIFY `idventadetalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `articulo`
--
ALTER TABLE `articulo`
  ADD CONSTRAINT `fk_articulo_categoria` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ingreso`
--
ALTER TABLE `ingreso`
  ADD CONSTRAINT `fk_ingreso_persona` FOREIGN KEY (`idproveedor`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ingreso_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ingresodetalle`
--
ALTER TABLE `ingresodetalle`
  ADD CONSTRAINT `fk_ingresodetalle_articulo` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ingresodetalle_ingreso` FOREIGN KEY (`idingreso`) REFERENCES `ingreso` (`idingreso`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `permisousuario`
--
ALTER TABLE `permisousuario`
  ADD CONSTRAINT `fk_permisousuario_permiso` FOREIGN KEY (`idpermiso`) REFERENCES `permiso` (`idpermiso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_permisousuario_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `fk_venta_cliente` FOREIGN KEY (`idcliente`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_venta_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ventadetalle`
--
ALTER TABLE `ventadetalle`
  ADD CONSTRAINT `fk_ventadetalle_articulo` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ventadetalle_venta` FOREIGN KEY (`idventa`) REFERENCES `venta` (`idventa`) ON DELETE NO ACTION ON UPDATE NO ACTION;


--
-- Metadata
--
USE `phpmyadmin`;

--
-- Metadata for table articulo
--

--
-- Metadata for table categoria
--

--
-- Metadata for table ingreso
--

--
-- Metadata for table ingresodetalle
--

--
-- Metadata for table permiso
--

--
-- Metadata for table permisousuario
--

--
-- Metadata for table persona
--

--
-- Metadata for table usuario
--

--
-- Dumping data for table `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('root', 'dbsistena', 'usuario', '{\"sorted_col\":\"`usuario`.`login`  DESC\"}', '2023-03-26 04:44:21');

--
-- Metadata for table venta
--

--
-- Metadata for table ventadetalle
--

--
-- Metadata for database dbsistena
--
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
