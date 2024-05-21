-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema rrhh
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema rrhh
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `rrhh` DEFAULT CHARACTER SET utf8 ;
USE `rrhh` ;

-- -----------------------------------------------------
-- Table `rrhh`.`ley_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rrhh`.`ley_laboral` (
  `IdLlab` INT NOT NULL AUTO_INCREMENT,
  `ley_laboral` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdLlab`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rrhh`.`condicion_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rrhh`.`condicion_laboral` (
  `IdClab` INT NOT NULL AUTO_INCREMENT,
  `condicion_laboral` VARCHAR(20) NULL,
  `ley_laboral_IdLlab` INT NOT NULL,
  PRIMARY KEY (`IdClab`),
  INDEX `fk_condicion_laboral_ley_laboral1_idx` (`ley_laboral_IdLlab` ASC),
  CONSTRAINT `fk_condicion_laboral_ley_laboral1`
    FOREIGN KEY (`ley_laboral_IdLlab`)
    REFERENCES `rrhh`.`ley_laboral` (`IdLlab`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rrhh`.`banco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rrhh`.`banco` (
  `IdBco` INT NOT NULL AUTO_INCREMENT,
  `banco` VARCHAR(30) NOT NULL,
  `avr` VARCHAR(4) NULL,
  PRIMARY KEY (`IdBco`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rrhh`.`tipo_documento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rrhh`.`tipo_documento` (
  `IdTdoc` INT NOT NULL,
  `tip_doc` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`IdTdoc`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rrhh`.`personal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rrhh`.`personal` (
  `IdPer` INT NOT NULL AUTO_INCREMENT,
  `dni` VARCHAR(9) NOT NULL,
  `condicion_laboral_IdClab` INT NOT NULL,
  `nombre` VARCHAR(60) NOT NULL,
  `banco_IdBco` INT NOT NULL,
  `ctacte` VARCHAR(20) NOT NULL,
  `tipo_documento_IdTdoc` INT NOT NULL,
  PRIMARY KEY (`IdPer`),
  INDEX `fk_personal_condicion_laboral1_idx` (`condicion_laboral_IdClab` ASC),
  UNIQUE INDEX `dni_UNIQUE` (`dni` ASC),
  INDEX `fk_personal_banco1_idx` (`banco_IdBco` ASC),
  INDEX `fk_personal_tipo_documento1_idx` (`tipo_documento_IdTdoc` ASC),
  CONSTRAINT `fk_personal_condicion_laboral1`
    FOREIGN KEY (`condicion_laboral_IdClab`)
    REFERENCES `rrhh`.`condicion_laboral` (`IdClab`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_personal_banco1`
    FOREIGN KEY (`banco_IdBco`)
    REFERENCES `rrhh`.`banco` (`IdBco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_personal_tipo_documento1`
    FOREIGN KEY (`tipo_documento_IdTdoc`)
    REFERENCES `rrhh`.`tipo_documento` (`IdTdoc`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rrhh`.`viatico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rrhh`.`viatico` (
  `IdVtco` INT NOT NULL AUTO_INCREMENT,
  `numero_viatico` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `monto` DECIMAL(9,2) NOT NULL,
  `siaf` INT NOT NULL,
  `personal_IdPer` INT NOT NULL,
  PRIMARY KEY (`IdVtco`),
  UNIQUE INDEX `siaf_UNIQUE` (`siaf` ASC),
  INDEX `fk_viatico_personal1_idx` (`personal_IdPer` ASC),
  CONSTRAINT `fk_viatico_personal1`
    FOREIGN KEY (`personal_IdPer`)
    REFERENCES `rrhh`.`personal` (`IdPer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rrhh`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rrhh`.`usuario` (
  `IdUser` INT NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(45) NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`IdUser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rrhh`.`nivel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rrhh`.`nivel` (
  `IdNivel` INT NOT NULL AUTO_INCREMENT,
  `nivel` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdNivel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rrhh`.`usuario_nivel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rrhh`.`usuario_nivel` (
  `IdUserNivel` INT NOT NULL AUTO_INCREMENT,
  `usuario_IdUser` INT NOT NULL,
  `nivel_IdNivel` INT NOT NULL,
  INDEX `fk_usuario_nivel_usuario1_idx` (`usuario_IdUser` ASC),
  INDEX `fk_usuario_nivel_nivel1_idx` (`nivel_IdNivel` ASC),
  PRIMARY KEY (`IdUserNivel`),
  CONSTRAINT `fk_usuario_nivel_usuario1`
    FOREIGN KEY (`usuario_IdUser`)
    REFERENCES `rrhh`.`usuario` (`IdUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_nivel_nivel1`
    FOREIGN KEY (`nivel_IdNivel`)
    REFERENCES `rrhh`.`nivel` (`IdNivel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `rrhh`.`ley_laboral`
-- -----------------------------------------------------
START TRANSACTION;
USE `rrhh`;
INSERT INTO `rrhh`.`ley_laboral` (`IdLlab`, `ley_laboral`) VALUES (1, '276');

COMMIT;


-- -----------------------------------------------------
-- Data for table `rrhh`.`condicion_laboral`
-- -----------------------------------------------------
START TRANSACTION;
USE `rrhh`;
INSERT INTO `rrhh`.`condicion_laboral` (`IdClab`, `condicion_laboral`, `ley_laboral_IdLlab`) VALUES (1, 'CONTRATADO', 1);
INSERT INTO `rrhh`.`condicion_laboral` (`IdClab`, `condicion_laboral`, `ley_laboral_IdLlab`) VALUES (2, 'DESIGNADO', 1);
INSERT INTO `rrhh`.`condicion_laboral` (`IdClab`, `condicion_laboral`, `ley_laboral_IdLlab`) VALUES (3, 'NOMBRADO', 1);
INSERT INTO `rrhh`.`condicion_laboral` (`IdClab`, `condicion_laboral`, `ley_laboral_IdLlab`) VALUES (4, 'SERUMS', 1);
INSERT INTO `rrhh`.`condicion_laboral` (`IdClab`, `condicion_laboral`, `ley_laboral_IdLlab`) VALUES (5, 'CAS', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `rrhh`.`banco`
-- -----------------------------------------------------
START TRANSACTION;
USE `rrhh`;
INSERT INTO `rrhh`.`banco` (`IdBco`, `banco`, `avr`) VALUES (1, 'BANCO DE LA NACIÓN DEL PERU', 'BNP');
INSERT INTO `rrhh`.`banco` (`IdBco`, `banco`, `avr`) VALUES (2, 'SCOTIABANK', 'SCOT');

COMMIT;


-- -----------------------------------------------------
-- Data for table `rrhh`.`tipo_documento`
-- -----------------------------------------------------
START TRANSACTION;
USE `rrhh`;
INSERT INTO `rrhh`.`tipo_documento` (`IdTdoc`, `tip_doc`) VALUES (1, 'D.N.I.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `rrhh`.`personal`
-- -----------------------------------------------------
START TRANSACTION;
USE `rrhh`;
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (1, '485211', 3, 'ALVAREZ RAMOS FERNANDO SALVADOR', 1, '4151179326', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (2, '415893', 2, 'CALDERON ALANOCA JUAN DE DIOS ADOLFO', 1, '4141614342', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (3, '499945', 3, 'DURAN CRUZ MARIA LUZ', 1, '4151179628', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (4, '416833', 3, 'GUTIERREZ FLORES ANABEL ESTHER', 1, '4151364824', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (5, '4437604', 3, 'MARCA AMESQUITA PAMELA PATRICIA', 1, '4151179423', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (6, '4410991', 3, 'MINAYA MALAGA GLADYS', 1, '4141304777', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (7, '416814', 3, 'ORDOÑEZ ARANDA YIZELA TERESA', 1, '4151365294', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (8, '23878956', 3, 'PALZA CARRASCO ELOY ANIBAL', 1, '4151134586', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (9, '489009', 3, 'PARIA BEJARANO GUIDO JAVIER', 1, '4151173883', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (10, '40453319', 2, 'QUEQUE MAMANI JOHN GILBERT', 1, '4151174022', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (11, '425088', 3, 'SOTO MELENDEZ JOSE ALBERTO', 1, '4151147610', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (12, '465625', 3, 'TUESTA RAMIREZ GUSTAVO PATRICIO', 1, '4151173859', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (13, '792289', 3, 'CONDORI GUTIERREZ GLEDY ROXANA', 1, '4151625059', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (14, '520999', 3, 'LOAYZA CHAMBE CARLOS ALFONSO', 1, '4151637251', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (15, '504827', 3, 'MACHACA VARGAS JUANA VERONICA', 1, '4151402106', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (16, '795671', 3, 'OBLITAS RAMOS CARLOS JAVIER', 1, '4151151553', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (17, '506951', 3, 'SAKURAY MONTALVO SILVIA ISABEL', 1, '4151373610', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (18, '41173617', 3, 'ALAVE YAHUARA NICOLAS ALBERTO', 1, '4151179466', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (19, '483918', 3, 'AVENDAÑO CACERES MIRIAM ALICIA', 1, '4151151510', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (20, '511049', 3, 'DELGADO ESPINOZA ROBERTO MARCIAL', 1, '4151179210', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (21, '9938065', 3, 'JAPURA PILCO WALTER', 1, '4151624524', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (22, '495627', 3, 'REYNA CAMPOS ROCIO MARGARITA', 1, '4151179229', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (23, '433509', 3, 'VARGAS SILES CESAR HUGO', 1, '4151126834', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (24, '40008358', 3, 'ALANOCA MULLUNI DE ALVARADO ESPERANZA', 1, '4151859947', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (25, '41408908', 2, 'ALAY ALE ANGEL ELISEO', 1, '4151720574', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (26, '666548', 3, 'ALVARADO ALAY OMAR ALFONSO', 1, '4151179369', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (27, '476619', 3, 'CALLAHUI VILLAFUERTE MARTHA', 1, '4151179547', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (28, '40342564', 3, 'CHURA APAZA LUZ MARINA', 2, '7408302102', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (29, '417957', 3, 'CUNYAR LIENDO ANGEL TITO', 1, '4160076416', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (30, '10350442', 3, 'GARCIA WONG ALFREDO', 1, '4151179342', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (31, '422573', 3, 'HUAYLLA HUACHANI DOMITILA', 1, '4151179520', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (32, '488901', 3, 'LEVANO VEGA EDWIN JOSEZANDRO', 1, '4151179121', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (33, '441652', 3, 'MARCA ANCCO MARIO FERNANDO', 1, '4151365073', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (34, '475146', 3, 'MIRANDA SUCASAIRE LEONOR NIEVES', 1, '4151365170', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (35, '27713620', 3, 'MONTENEGRO ROJAS JUAN ISIDRO', 1, '4151173891', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (36, '488711', 3, 'OCHOA AQUINO JUAN CARLOS', 2, '7408326432', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (37, '403243', 3, 'ORTIZ MENENDEZ LUIS ALBERTO', 1, '4151173794', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (38, '45883178', 3, 'PALZA SOTOMAYOR MARY CARMEN', 1, '4157112754', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (39, '509143', 3, 'PARI MORENO OSCAR MARIO', 1, '4151179601', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (40, '16682733', 3, 'POLO FIGUEROA CESAR LEONEL', 1, '4151179113', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (41, '476945', 3, 'SALCEDO SALINAS JORGE AUGUSTO', 1, '4151173999', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (42, '478802', 3, 'SALINAS CERREÑO JOSE MIGUEL', 1, '4151174073', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (43, '480212', 2, 'TOLEDO HUACAN FELIX MARIO', 1, '4151151618', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (44, '498256', 3, 'TORREBLANCA SANCHEZ ERICK YVAN', 2, '7408319270', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (45, '473362', 3, 'VELARDE CORRO EDUARDO AGUSTO', 2, '7408323769', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (46, '419903', 3, 'ZAPANA VELA HONORATO NESTOR', 1, '4151365804', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (47, '44302661', 1, 'BAUTISTA ARPHI GERARDO CLIDER', 1, '4051719064', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (48, '472065', 3, 'CALIZAYA PEREIRA NELLY CATALINA', 1, '4151364387', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (49, '422286', 3, 'ACERO VILLEGAS ONDINA HERMENEGILDA', 1, '4151364107', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (50, '433107', 3, 'BASADRE NAQUIRA EDGARD RICARDO', 1, '4151364255', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (51, '416903', 3, 'BOHORQUEZ FERNANDEZ MARIO FEDERICO', 1, '4151364271', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (52, '507681', 3, 'CACERES ALVARADO FELIX LEONCIO', 1, '4151364344', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (53, '445381', 3, 'CALLALLA NIETO JOSE LUIS', 1, '4151369702', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (54, '403038', 3, 'CENTURION BAHAMONDES JUAN CARLOS', 1, '4151134594', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (55, '432098', 3, 'COAYLA FLORES NANCY FAUSTINA', 1, '4151364514', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (56, '489569', 3, 'DAVILA PARIA KATHERINE OTILIA', 1, '4151364611', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (57, '404751', 3, 'DOMINGUEZ AGUIRRE IGNACIA', 1, '4141303126', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (58, '415601', 3, 'FERRERO VACCARI RINA LUZ', 1, '4151400650', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (59, '476019', 3, 'GARCIA BEDOYA MARINA MARGOT', 1, '4151364719', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (60, '40057323', 2, 'HERRERA VILLANUEVA IVETTE LUZ', 1, '4151456605', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (61, '418798', 3, 'HUME LANCHIPA GRACIELA CARMEN', 1, '4151364948', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (62, '495924', 3, 'JIMENEZ LUPE YUDITH NELLY', 1, '4151151561', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (63, '491609', 3, 'MAQUERA ALAVE ELEUTERIO ADOLFO', 1, '4151365065', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (64, '411142', 3, 'MEJIA VELA JOHN ERNESTO', 1, '4151365111', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (65, '413181', 3, 'NIETO CUTIPA VIVIANA JUVELIT', 1, '4151365235', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (66, '440735', 3, 'QUISPE QUISPE LOURDES ELIANA', 1, '4151365405', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (67, '7444682', 3, 'SALINAS CORNEJO DE HINOJOSA CARMEN ROSA', 1, '4151365545', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (68, '40413772', 3, 'SANCHEZ ALE GEORGE CHRISTIAN', 1, '4151214725', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (69, '793254', 3, 'TOULLIER FERNANDEZ VIVIAN ESTELA', 1, '4151151537', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (70, '1217242', 3, 'VELASQUEZ QUINTO BETTY GUADALUPE', 1, '4151365758', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (71, '40727898', 2, 'GARCIA RIVERA GUSTAVO EDGAR', 1, '4151778319', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (72, '790046', 3, 'HUANACUNI LANCHIPA JESSENIA JANETH', 1, '4151179350', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (73, '794968', 3, 'HURTADO RAMOS EDITH HAYDEE', 1, '4151505630', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (74, '42865409', 3, 'MONGE FIGUEROA JESSICA GINA', 1, '4151573636', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (75, '43802241', 3, 'PARAVICINO RUELAS CYNTHIA GEORGINA', 1, '4151573695', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (76, '472032', 3, 'PINTO DE BRAVO MARLENY YOLANDA', 1, '4151365367', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (77, '472501', 3, 'TEJADA VASQUEZ EDGAR HERNAN', 1, '4151365677', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (78, '416832', 3, 'FERNANDEZ CHIPOCO LOURDES MARINA', 1, '4151364689', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (79, '416808', 3, 'MENDOZA SALINAS FREDY EDGAR', 1, '4151365146', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (80, '486705', 3, 'VILLANUEVA ROQUE JAVIER CLEMENTE', 1, '4151600897', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (81, '484893', 3, 'APAZA CORONEL VERONICA AMANDA', 1, '4151179334', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (82, '492845', 3, 'CHANGLLIO ROAS JUAN JOSE EVARISTO', 1, '4151179296', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (83, '413513', 3, 'COPAJA FLORES MARITZA CLARA', 1, '4151366622', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (84, '30415359', 3, 'EGUILUZ LLERENA GILVER MARCOS', 1, '4151174154', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (85, '4641243', 3, 'YAMPASI MENDOZA FELIX ROMEO', 1, '4151174146', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (86, '446580', 3, 'MAMANI CHURA HERMILIA', 1, '4151204843', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (87, '4749146', 3, 'PEÑALOZA ALVARADO MARCO ANTONIO', 1, '4151179318', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (88, '419414', 2, 'RIOS FLORES LOURDES MARIELLA', 1, '4151179504', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (89, '477873', 3, 'RIOS VALDEZ JUAN CARLOS', 1, '4151365472', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (90, '486201', 3, 'TICONA PEREZ CARMEN EMILIANA', 1, '4151173972', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (91, '410856', 3, 'CHAMBILLA CUSICANQUI LUZ TERESA', 1, '4151100533', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (92, '40379750', 3, 'GAMBETTA MELENDEZ GABRIELA CECILIA', 2, '7408302110', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (93, '492683', 3, 'HUAMAN MELODIAS GLADYS ELIZABETH', 1, '4151173875', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (94, '440282', 3, 'PACOMPIA PANCA BERNARDINO', 1, '4151365308', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (95, '4437367', 2, 'QUISPE VIZCARRA HENRY CESAR', 1, '4146238578', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (96, '484820', 3, 'RODRIGUEZ VILCA GIOVANNA FRIDA', 1, '4151375567', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (97, '40958186', 2, 'ROQUE RODRIGUEZ EVA MARIA', 1, '4151643367', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (98, '472089', 3, 'SAIRA MANCHEGO DE MOSQUERA MATILDE MARIA', 1, '4151365510', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (99, '432764', 3, 'SALCEDO CONDORI BERTHA', 1, '4151365537', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (100, '796615', 3, 'VARGAS LAZO GLENDA PATRICIA', 1, '4151173840', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (101, '2434783', 2, 'VASQUEZ ALTAMIRANO FELIPE LUIS', 1, '4151171775', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (102, '29258926', 3, 'BRAVO BRAVO ANTONIETA IRENE', 1, '4151366142', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (103, '40527164', 3, 'CALDERON SOSA RAUL MARCELO', 1, '4035587158', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (104, '404460', 3, 'FLORES CHAMBILLA AIDA CARMEN', 1, '4151366851', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (105, '43247382', 3, 'QUISPE GUTIERREZ HAYDEE DINA', 1, '4045336080', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (106, '40949043', 2, 'ACERO MAMANI VIVIANA YANETH', 1, '4151586401', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (107, '494449', 3, 'CARDENAS AMEZQUITA FLOR MARIA', 1, '4151173921', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (108, '432104', 3, 'COHAILA MAMANI TEOFILA ESTHER', 1, '4151364522', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (109, '400128', 3, 'COPAJA BARTRA TERESA ISABEL', 1, '4151300265', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (110, '469807', 3, 'ESQUIVEL ACOSTA LUIS ENRRIQUE', 1, '4151364662', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (111, '22078000', 3, 'GOYZUETA NEYRA ALINE MAYRA LUISA', 1, '4151131404', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (112, '40761980', 3, 'ROSALES FLORES YASSELY VANESSA', 1, '4157052654', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (113, '506629', 3, 'SOSA ARIAS JUANA ROSA', 1, '4151240629', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (114, '497959', 3, 'VELASQUEZ JUCULACA GIOVANNA PAOLA', 1, '4151240637', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (115, '479477', 3, 'ALARICO TAPIA JORGE ALBERTO', 1, '4151136716', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (116, '795598', 3, 'ALAVE CONDORI FRANCISCO', 1, '4151364115', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (117, '489818', 3, 'ANGULO MEDINA JUAN CARLOS', 1, '4151179288', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (118, '517039', 3, 'CANAZA VELASQUEZ VALERIANO', 1, '4151179377', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (119, '401886', 3, 'CARPIO BECERRA JOSE AUGUSTO', 1, '4151240599', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (120, '29315755', 2, 'CHIRE CHOQUE DANIEL RAUL', 1, '4151180308', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (121, '484922', 3, 'CHOQUE CHAMBE ALEJANDRINA ROSAURA', 1, '4151179407', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (122, '488759', 3, 'CUTIPA VARGAS CELIA GREGORIA', 1, '4151187302', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (123, '3678303', 3, 'ESCOBAR HIDALGO PATRICIA', 1, '4151179539', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (124, '422733', 3, 'GIL MENDIETA PAULA LEONOR', 1, '4151179415', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (125, '402910', 3, 'LANCHIPA ROSPIGLIOSI MORELIA MERCEDES', 1, '4151364964', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (126, '42647000', 2, 'MAMANI MAMANI RAUL HUMBERTO', 1, '4151551357', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (127, '450689', 3, 'MAMANI URURE SERAFIN LEONARDO', 1, '4151179458', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (128, '403107', 3, 'MELENDEZ DE GAMBETTA CARMEN FLORA', 1, '4151365138', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (129, '29423898', 3, 'MENDOZA AQUINO MARISOL', 1, '4151240726', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (130, '433779', 3, 'MORALES MALDONADO VICTOR ADRIAN', 1, '4151365197', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (131, '413141', 3, 'NAQUIRA SAAVEDRA MARIANO ARNALDO', 1, '4151365227', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (132, '10393521', 2, 'ORTEGA CUTIPA BERTHA', 1, '4151240696', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (133, '8164825', 2, 'REYNOSO PAREDES TILER HANS', 1, '4151804395', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (134, '790795', 3, 'SANCHEZ GARCIA ERIKA', 1, '4151179563', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (135, '441628', 3, 'SARAVIA BLANCO NESTOR', 1, '4151240610', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (136, '423829', 3, 'SOTELO ACERO JULIO LUCIO', 1, '4151107244', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (137, '479815', 3, 'VELASQUEZ REVILLA JUAN MARIO', 1, '4151901285', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (138, '517824', 3, 'ZAPANA GARCIA ELIZABETH', 1, '4151151545', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (139, '432998', 3, 'CARPIO DE SANCHEZ MARIA LUISA', 1, '4151364441', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (140, '492511', 3, 'CASTAÑON GUTIERREZ MARLENE LOURDES', 1, '4151174286', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (141, '41985499', 3, 'CRUZ PALMA JOSELYN ARACELI', 1, '4706013348', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (142, '40538757', 3, 'GONZALES MAQUERA YEMELY KARINA', 1, '4151564637', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (143, '793248', 3, 'HUANCA CHOQUE MARITZA MILAGROS', 1, '4151221055', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (144, '40919396', 3, 'HUARACHI CHUQUIMIA ROXANA HAYDEE', 1, '4151182653', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (145, '477459', 3, 'LIZARRAGA DE MELLO DORA GINA BEATRIZ', 1, '4151367297', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (146, '404748', 3, 'LUNA PARI MARIA MAGDALENA', 1, '4151367378', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (147, '419415', 3, 'MARTINEZ CHIRI ADELAIDA BELINDA', 2, '8251559632', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (148, '485146', 3, 'MONTALVO CHAVEZ PATRICIA VERONICA', 2, '7408111990', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (149, '25845282', 3, 'PAREDES FLORES DINA', 1, '4151240653', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (150, '431745', 3, 'PEREZ NIETO YOLANDA ELIANA', 1, '4151365340', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (151, '420886', 3, 'PIZARRO VEGA MARIA LUISA DE LOURDES', 1, '4151365375', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (152, '474080', 3, 'ROJAS URRIETA PEDRO ANGEL', 1, '4151509741', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (153, '794923', 3, 'VALDIVIA DIAZ WILLIAM JUAN', 1, '4151501228', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (154, '505138', 3, 'VILCA CENTENO PATRICIA VIRGILIA', 1, '4151187337', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (155, '415206', 3, 'YAVE CORONADO ESMERALDA DEL ROSARIO', 1, '4151368846', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (156, '401715', 3, 'ZARATE ISIDRO FLORA NELLY', 1, '4151368889', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (157, '478047', 3, 'GIRON COPA ROSARIO NIEVES', 1, '4151364743', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (158, '508016', 2, 'NEIRA ZEGARRA RENAN ALEJANDRO', 1, '4151130122', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (159, '473234', 3, 'ALVAREZ GOYCOCHEA ROSARIO ELIZABETH', 1, '4151364166', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (160, '40594595', 3, 'CHOQUE BERNABE CESAR', 1, '4151174081', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (161, '425389', 3, 'CONDORI MAMANI CARMEN ROSA', 1, '4151151529', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (162, '413487', 3, 'KOC CHANG JUANA', 1, '4151364956', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (163, '29411446', 3, 'APAZA QUILCA INES', 1, '4151128454', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (164, '796943', 3, 'CHAMBE VARGAS JANET ROSARIO', 1, '4151174030', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (165, '418875', 3, 'CORRALES CARAZAS YDA LUZ APOLONIA', 1, '4151364565', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (166, '1230796', 3, 'DIAZ SAAVEDRA MARCO ANTONIO', 1, '4701342246', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (167, '794655', 3, 'GARCIA RIVERA FRANCISCO', 1, '4151364727', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (168, '516073', 2, 'VARGAS CANCINO HUGO JUAN', 1, '4160025498', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (169, '435562', 3, 'ALVAREZ ESPEJO JOSE EMILIO', 1, '4151364158', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (170, '45568907', 2, 'GALLO SUAREZ RAQUEL', 1, '4151456133', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (171, '491851', 3, 'PAZ JORDAN RICHARD OSWALDO', 1, '4151179393', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (172, '488724', 3, 'VILDOSO ROMERO JOSE TEODOSIO', 1, '4151204894', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (173, '516837', 3, 'ALCANTARA QUISPE ELISEO', 1, '4151365030', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (174, '512107', 2, 'AMERI VILLEGAS PABLO HUMBERTO', 1, '4151179431', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (175, '413145', 3, 'BRAVO BOHORQUEZ JUAN CARLOS JAIME', 1, '4151364328', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (176, '419591', 3, 'CALIZAYA YUFRA ESTHER LOURDES', 1, '4151364409', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (177, '405465', 3, 'CASTRO ANCCO ALFREDO ELFREN', 1, '4151423138', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (178, '497554', 3, 'COHAILA ALFEREZ OSMAN NACIAN', 1, '4151174065', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (179, '479207', 3, 'GOMEZ GUTIERREZ JOSE LUIS', 1, '4151173948', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (180, '470800', 3, 'GONZALES PORTOCARRERO LILIANA NORMA', 1, '4151364808', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (181, '475081', 3, 'GUZMAN GUISA JORGE RAUL', 1, '4151364840', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (182, '496201', 3, 'LAURA CHIPANA ANA MARIA', 1, '4151179482', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (183, '494845', 3, 'LIENDO FLORES ELEANA ELOISA', 1, '4151174049', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (184, '432097', 3, 'PUMAYAURI SANDOVAL VICTOR ALBERTO', 1, '4151365391', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (185, '418536', 3, 'RAMOS ALVARADO FERNANDO JOSE', 1, '4151365413', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (186, '4643522', 3, 'TALLEDO FLORES FELICIA ALEJANDRINA', 1, '4371343046', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (187, '472377', 3, 'TAPIA LUCERO ELISEO', 1, '4151365650', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (188, '71248919', 3, 'ALVARADO CHACOLLI JHEYSON JEANKARLO', 1, '4151057727', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (189, '449997', 3, 'ARCE RAMOS INGRID LILIANA', 1, '4151689391', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (190, '43098578', 3, 'ARIAS ROJAS VICTOR ALFONSO', 1, '4043918007', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (191, '42390255', 3, 'BRAVO CHECA CESAR AUGUSTO', 2, '8312025631', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (192, '42609159', 3, 'CALIZAYA CONDORI ELVIA YANIRA', 2, '8250330399', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (193, '402890', 3, 'CHAMBILLA DE MARTINEZ LOURDES CRISTINA', 1, '4151423707', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (194, '42940723', 3, 'GUILLERMO MAQUERA GUINA NOEMI', 1, '4034290828', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (195, '41041402', 3, 'PORTUGAL QUISPE MAGDELIA MAYDA', 1, '4151529300', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (196, '504249', 3, 'RAMOS GARCIA JANET MADALI', 1, '4151509725', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (197, '43187395', 3, 'RIVAS CARRILLO PIERINA GUADALUPE', 1, '4706013356', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (198, '42418738', 3, 'RIVERA LLANQUI KARINA RUTH', 1, '4151733374', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (199, '10328104', 3, 'SANCHEZ VELEZ CARLOS ALFONSO', 1, '4151751801', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (200, '45481983', 3, 'VIZA VIZCARRA MARILLY ELIZABETH', 1, '4052918893', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (201, '793689', 3, 'ACHATA ANCCO YANETH', 1, '4151733390', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (202, '29219702', 3, 'MAQUE GUERRA JUAN LUDWING', 1, '4151372193', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (203, '42272984', 3, 'TESILLO CHOQUE JEANETH KARINA', 1, '4151733382', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (204, '80190013', 3, 'CHAGUA JIMENEZ FELIX ANTONIO', 1, '4151179474', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (205, '403037', 3, 'EYZAGUIRRE ZAPATA LORENA MARIA', 1, '4151134608', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (206, '70496878', 4, 'MAMANI VILCA EDGARD MAURICIO', 2, '7408241136', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (207, '74969673', 4, 'HUANCA PERALTA TANIA REYNA', 2, '7408305733', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (208, '47304017', 4, 'COCHACHIN ORTIZ ERIKA JULISSA', 1, '4151947846', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (209, '70297544', 4, 'GUEVARA ARREDONDO FABRIZIO ALEJANDRO', 2, '7408242183', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (210, '73832191', 4, 'LUNA ZARSOZA XIOMARA BELEN', 2, '7408241144', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (211, '47891117', 4, 'ARPI ZAPANA DORIS CARLETH', 1, '4151935643', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (212, '72535308', 4, 'GONZA HUALLA MADAI CELINA', 2, '7008765203', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (213, '70444035', 4, 'LEDESMA PERAZA OSCAR ALEXANDER', 2, '7408241177', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (214, '20039710', 4, 'PEREZ GARAY REBECA ESPERANZA', 2, '7408241185', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (215, '71326203', 4, 'PORTUGAL CABRERA YENI FERNANDA', 1, '4151947870', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (216, '70842408', 4, 'ARCE VENTURA RUTH MARILU', 2, '7408302177', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (217, '46874972', 4, 'LIMACHE CONDORI YESENIA LEIDI', 1, '4021267681', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (218, '72552243', 4, 'ROMERO COAQUIRA ALDO JEFFERSON', 2, '7408241110', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (219, '71234086', 4, 'NINAJA SARMIENTO SANDRA PAOLA', 2, '7408241169', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (220, '74449419', 4, 'PARIAN MARQUEZ ISRAEL', 1, '4151947900', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (221, '72858861', 4, 'VÁSQUEZ RAMOS KATHLEN XIMENA', 2, '8311978020', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (222, '74051706', 4, 'YAULLI CHOQUEHUANCA EYMI JHOAN', 2, '7408241052', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (223, '71224115', 4, 'FELICIANO MAMANI SINDI KATI', 2, '7408240583', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (224, '72384884', 4, 'MACHICADO GOMEZ SALLY KATHERINE', 2, '7408241128', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (225, '48461465', 4, 'CJURO VERA LUSMY', 2, '7408241151', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (226, '71346756', 4, 'PUMA VELASQUEZ GUADALUPE', 2, '7408241060', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (227, '70473294', 4, 'LLANOS PUMA MARY LUZ', 2, '7931056845', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (228, '71213922', 4, 'CHOQUE ALAVE XINA KIMBERLY', 2, '7408240609', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (229, '71908574', 4, 'RAMIREZ GUTIERREZ ROSARIO DEL PILAR', 2, '7408302680', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (230, '77172251', 4, 'VASQUEZ FLORES YENIFER', 2, '7408302557', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (231, '74560868', 4, 'PAREDES MAMANI ALONDRA ESTEFANY', 2, '7408241094', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (232, '70212795', 4, 'APAZA CANCAPA CLEMENTINA', 1, '4151935651', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (233, '75927280', 4, 'JOAQUIN COTRADO YACEL EILEN', 1, '4151935740', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (234, '72630989', 4, 'SANTE FARFAN ANGIE MARILU', 2, '7408241383', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (235, '70579902', 4, 'SONCCO COAQUIRA FIORELA DIANA', 2, '7408241078', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (236, '70559169', 4, 'BARRIENTOS SOTO LUIS RODRIGO', 1, '4151935686', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (237, '72489520', 4, 'CABANA RODRIGUEZ ALEJANDRA DESIREE', 2, '7408241086', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (238, '44981360', 4, 'PARIONA CALDERÓN JANETT SINDY', 1, '4151935635', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (239, '71321462', 4, 'AROCUTIPA CALDERON CYNTHIA ROSA', 2, '7408241102', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (240, '46770320', 4, 'CHOQUE VARGAS JOSE VICTOR ENRIQUE', 2, '7408302706', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (241, '75208410', 4, 'KGORIMAYA CHÁVEZ CLAUDIA JULEISSI', 2, '8311978012', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (242, '518255', 5, 'AGUILAR YUJRA GRACIELA FRANCISCA', 1, '4151501295', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (243, '45388164', 5, 'ALAVE CHOQUE HAYDEE BLANCA', 1, '4093700673', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (244, '46803153', 5, 'ALFEREZ APAZA JESUS ANIBAL', 2, '8218164161', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (245, '43299650', 5, 'ALI PARI YANET', 1, '4160219551', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (246, '47272510', 5, 'APAZA MAQUERA VICTOR LEONARDO', 2, '8310106144', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (247, '44367839', 5, 'ARANA RODRIGUEZ MARIEL DEL CARMEN', 2, '8250697086', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (248, '41248752', 5, 'ARAUJO ANQUISE CARMEN ROSA', 2, '7408325673', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (249, '44613945', 5, 'ARIAS ORDOÑEZ JESUS EDUARDO', 1, '4151864266', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (250, '80285131', 5, 'AROCUTIPA LINARES LISANDRO WILFREDO', 1, '4194080854', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (251, '790865', 5, 'BARRIGA RAMOS MAURO DICKS', 2, '7408240021', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (252, '45350879', 5, 'BARRIOS AVENDAÑO VALERY JEYMY', 1, '4072814296', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (253, '70911575', 5, 'BLAS ALVARO FLOR MARIA ISABEL', 1, '4151067633', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (254, '510884', 5, 'BORDA LLANOS ROLFY', 2, '8310103299', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (255, '45496538', 5, 'CAHUAYA CHUQUICALLATA ELIZABETH GLADYS', 1, '4055105613', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (256, '76610721', 5, 'CALDAS SILES FLOR DE MARIA', 1, '4194099334', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (257, '42884273', 5, 'CALDERON CALISAYA DINA ROCIO', 2, '7408282080', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (258, '44818405', 5, 'CALIZAYA QUIÑONES SADITH EVELIN', 2, '8251049394', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (259, '48116336', 5, 'CALLE MAQUERA RUTH MARIBEL', 1, '4151751933', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (260, '46557198', 5, 'CAMPOS QUISPE JUAN YHONATAN', 1, '4151916894', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (261, '70601043', 5, 'CAPACUTE CHAMBILLA TANIA CAROLINA', 1, '4076855639', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (262, '41800924', 5, 'CARAZAS CONDE SANDRA ANGELICA', 1, '4151505622', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (263, '40542475', 5, 'CARDENAS GUTIERREZ MARIVEL TRINIDAD', 1, '4151618435', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (264, '70492244', 5, 'CARRIL TEJADA MARIA JOSE', 1, '4160025641', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (265, '71821439', 5, 'CASTRO VARGAS MAYRA ALEXANDRA', 2, '8250354001', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (266, '443552', 5, 'CATACHURA QUISPE JAVIER VIRGILIO', 1, '4157283257', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (267, '41887856', 5, 'CESPEDES PINTO MILTON RENE', 1, '4151607042', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (268, '44462018', 5, 'CHACCOLLI GOMEZ SONIA SOLEDAD', 2, '8310106151', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (269, '42115786', 5, 'CHOQUE MAMANI VERONICA BERTHA', 1, '4151922525', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (270, '42817709', 5, 'CHOQUE SANTOS ANAHI', 1, '4093316474', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (271, '47612953', 5, 'CHURA APAZA KATHERINE ISSAMAR', 2, '8251415488', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (272, '45271862', 5, 'COAQUIRA MAQUERA GUSTAVO ADOLFO', 1, '4151060582', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (273, '43232168', 5, 'CONTRERAS AQUISE NILLS ELID RICARDO', 2, '8250432245', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (274, '71345531', 5, 'CORONADO CONDORI LUDWIKA AMPARO', 2, '8253051976', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (275, '80282632', 5, 'COROPUNA CORNEJO RENE LUIS', 1, '4151736802', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (276, '797267', 5, 'CORTEZ AVALOS HERNAN', 1, '4157287759', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (277, '43540915', 5, 'CUENTAS COILA DE DOMINGUEZ ROSSANA YENI', 1, '4047248952', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (278, '44462017', 5, 'CURO CACERES EDDY MABEL', 1, '4151006014', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (279, '504139', 5, 'CUTIMBO ALANOCA ROSA LUZ', 2, '8251049402', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (280, '72174284', 5, 'DELGADO CRUZ SANDRA VERONICA', 1, '4157122873', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (281, '795142', 5, 'DURAND GAMEZ ARTURO YVAN', 1, '4151063158', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (282, '46870682', 5, 'ECHEVARRIA MAMANI NELD ENRIQUE', 2, '8253051984', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (283, '70614554', 5, 'ESPINAL QUIÑONEZ DELSY MIRIAN', 1, '4093700525', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (284, '72271498', 5, 'ESPINOZA ORTIZ MARICELI MILAGROS', 2, '7408304090', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (285, '491383', 5, 'FERNANDEZ DAVILA FORLONG DANIEL AUGUSTO', 1, '4194095029', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (286, '70137686', 5, 'FLORES GALVEZ HANDDY FABRIZZIO', 2, '8247944484', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (287, '44665455', 5, 'FLORES ORMEÑO VERONICA KARINA', 1, '4151031957', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (288, '795271', 5, 'FLORES PLATERO HUGO HENRY', 1, '4194081540', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (289, '796472', 5, 'FONTTIS CALDERóN LUZ CAROLINA', 1, '4061010047', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (290, '43441998', 5, 'GALLARDO TORRES CESAR ALBERTO', 2, '8250313205', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (291, '45993183', 5, 'GARCIA IQUISE FABIOLA NIDIA', 1, '4141856788', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (292, '45091291', 5, 'GARCIA PINTO GREIS DEL CARMEN', 1, '4066242094', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (293, '71239043', 5, 'GOMEZ MENDOZA RUTH NORMA', 1, '4151069288', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (294, '47252832', 5, 'GOMEZ RODRIGUEZ MIGUEL ANGEL', 1, '4194040119', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (295, '2618505', 5, 'GONZALEZ MORA DIANA NOHEMI', 2, '8253716685', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (296, '46795542', 5, 'GUTIERREZ AGUILAR CLAUDIA TATHIANA', 2, '8250321000', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (297, '43982352', 5, 'GUTIERREZ QUISPE ROSA VANESSA', 2, '8251559608', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (298, '45817607', 5, 'HUAMAN APAZA YESENIA EVANS', 2, '8218176256', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (299, '46973618', 5, 'HUANACUNI APAZA WILMA YANETH', 1, '4151029146', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (300, '76470765', 5, 'HUANCA HUANCA MARIA CRISTINA', 2, '8253049962', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (301, '46349017', 5, 'HUATTA NAVIA HERALDINA HELEN', 1, '4093708267', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (302, '41493146', 5, 'HURTADO MANCHEGO LIZBETH YULIANA', 1, '4151276151', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (303, '47685356', 5, 'JIMENEZ ESTAÑA SIMON EDUARDO', 1, '4093799297', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (304, '40604734', 5, 'JIMENEZ LUPE SAUL CAMILO', 1, '4151718456', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (305, '47953958', 5, 'JIMENEZ PERALTA GIANCARLO', 1, '4151468344', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (306, '514643', 5, 'JUANILLO VILCA ERICKA RUTH', 2, '8253052008', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (307, '47489879', 5, 'LLAMPAZO PAXI MAYUMI SANDRA', 1, '4151807637', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (308, '73998112', 5, 'LUJAN CASTILLO DEICY ESTIFFANI', 1, '4074629666', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (309, '70652132', 5, 'LUJAN CHOQUE FLOR DEL PILAR', 1, '4151063182', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (310, '72212420', 5, 'LUYO FONTTIS PAOLA ADELY', 1, '4151067900', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (311, '71217839', 5, 'MACEDO CHOQUECOTA KAREN LIZBETH', 2, '8253676913', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (312, '42206520', 5, 'MAMANI MORERA MALENA ANAI', 1, '4703476886', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (313, '71739085', 5, 'MAMANI PARI JORGE LUIS', 1, '4151850753', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (314, '72463859', 5, 'MAMANI TAPIA ROCIO KATIA', 1, '4151036371', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (315, '42792296', 5, 'MANCHEGO BARRERA ANYELO JEMPHI', 2, '8250320994', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (316, '40616708', 5, 'MARAZA HUAYCANI EDDY KENYI', 1, '4151595028', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (317, '70975526', 5, 'MARCA MACHACA DANITZA MARITEé', 1, '4157306672', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (318, '10582088', 5, 'MELENDEZ SALMON ANTONIO DANTE', 1, '4151848333', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (319, '47656118', 5, 'MENDOZA CHAMBILLA JHON NOE', 2, '8218176264', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (320, '46711245', 5, 'MENDOZA VALDEZ GRETA LIZBETH', 2, '7408210891', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (321, '41550586', 5, 'MENDOZA ZUASNABAR MARJORIE JAYNE', 1, '4157300240', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (322, '44747071', 5, 'MONASTERIO CHURA DIANA RUTH', 1, '4039934448', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (323, '45986848', 5, 'MORALES CUTIPA LADY ALEJANDRA', 1, '4045291680', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (324, '71399287', 5, 'MURILLO VARGAS LUIS RENATO', 1, '4151954362', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (325, '46543590', 5, 'NEYRA CATACORA ERIKA MIREYA', 1, '4157108242', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (326, '425804', 5, 'NINA QUISPE VENANCIO', 1, '4151187760', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (327, '42537860', 5, 'OCAMPO HUAMAN ANDREA ISABEL', 2, '8253051992', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (328, '41351166', 5, 'PACCI YUFRA ROCIO', 1, '4042353790', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (329, '70432921', 5, 'PACO APAZA JOSE LUIS', 1, '4151771284', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (330, '44649918', 5, 'PALOMINO CAHUANA WILLY ALFREDO', 2, '8251827096', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (331, '42101016', 5, 'PAREDES ONOFRE WILBERT', 1, '4151502410', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (332, '45091750', 5, 'PEREZ INFANTAS FABIOLA MELANY', 2, '8311978038', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (333, '514300', 5, 'QUENTA RIOS JOSE LUIS', 2, '7408305519', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (334, '517334', 5, 'QUIJANDRIA ARIAS ROSELYN GERALDINE', 1, '4160098940', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (335, '40941914', 5, 'QUISPE ACERO REYNALDO JAIME', 1, '4151035952', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (336, '46390477', 5, 'QUISPE MAMANI ERICA GINA', 1, '4157212031', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (337, '518353', 5, 'RAMIREZ CHOQUECOTA WALTER BERNARDO', 2, '8310419828', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (338, '44328066', 5, 'RAMOS MENDOZA KARINNA DEL ROCIO', 2, '7408306699', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (339, '511642', 5, 'RAMOS VERGARA GABRIELA MASIEL', 1, '4151604272', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (340, '72647398', 5, 'REJAS MAMANI YULISSA NOELIA', 1, '4151069296', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (341, '512280', 5, 'RIOS MONDOÑEDO FERNANDO ENRIQUE ERASMO', 2, '8250311977', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (342, '44707736', 5, 'SANTOS CHIPANA CARLOS AGUSTO', 1, '4151916916', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (343, '41411089', 5, 'SANTOS CUTIPA MIRIAN DAYSI', 1, '4049135586', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (344, '40188909', 5, 'SOLIS CHIPANA JAVIER ALONSO', 1, '4151181282', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (345, '481298', 5, 'TAPIA CONDE FRANCISCO JUAN', 1, '4151270773', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (346, '47619796', 5, 'TICONA FLORES EDITH GINA PASTORA', 1, '4151757729', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (347, '40180413', 5, 'TICONA SERRANO EDWIN PERCY', 1, '4157150559', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (348, '70023091', 5, 'TORRES HUARACHI CRISTHIAN DAVID POLDAR', 1, '4066332123', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (349, '41383322', 5, 'VARGAS FLORES CINTHIA JAZMIN', 1, '4049114465', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (350, '47689705', 5, 'VARGAS POMA LUIGUI XAVIER', 2, '8250324830', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (351, '44908651', 5, 'VEGA CHAVEZ SELMA YESENIA', 1, '4151065800', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (352, '793327', 5, 'VICENTE GUILLERMO JULIAN REYNALDO', 1, '4151254921', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (353, '43463932', 5, 'VICENTE VEGA KARINA MAGALY', 1, '4201470078', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (354, '482751', 5, 'VILLAR AGURTO JESUS HERNAN', 1, '4194100111', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (355, '46105346', 5, 'VIZCARRA OROS ANNA PATRICIA', 1, '4049135667', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (356, '47207395', 5, 'ZAPANA ALANIA LUIS JONATAN', 1, '4151062305', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (357, '406072', 5, 'ZAPATA SALAMANCA IVOR EDGARD', 1, '4151761874', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (358, '70661278', 5, 'ABURTO QUISPE SUSAN GRETA', 2, '7408335649', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (359, '43767821', 5, 'ALARCON VEGA NILGER', 2, '7408336001', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (360, '40274244', 5, 'ARUA ORDOÑEZ RICARDO MOISES', 2, '7408335599', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (361, '46930829', 5, 'CARPIO VENANCIO JESSICA LIDIA', 1, '4074670208', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (362, '40425189', 5, 'COAQUERA ALAVE YANIRA MIRYAN', 2, '7408335615', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (363, '41946666', 5, 'ELIAS COLQUE KENNY ENRIQUE', 1, '4151681595', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (364, '42027694', 5, 'FLORES GARCIA PAOLA ELIZABETH', 2, '7408335607', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (365, '474362', 5, 'FLORES GUERRERO JOSE ANTONIO', 1, '4151533359', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (366, '72127879', 5, 'GALINDO ZEVALLOS SANDRA LUZ', 1, '4069719290', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (367, '42022161', 5, 'GAMBOA ALVARADO CRISTHIAN WALTER', 1, '4151533375', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (368, '29677372', 5, 'GONZALES ANGULO LUIS LUCAS', 1, '4157473811', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (369, '45624762', 5, 'HONORE CACHICATARI JUDIT VICTORIA', 2, '7408335664', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (370, '47121563', 5, 'IBAÑEZ PANTA DIEGO HERNAN', 1, '4085605815', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (371, '46433178', 5, 'LOAYZA AGUILAR ALBERT JOSEPH', 2, '7408335631', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (372, '41269221', 5, 'MACHACA CHACOLLI EFRAIN NELSON', 1, '4160076726', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (373, '46727854', 5, 'MAMANI CHURA LESLIE ZUKI', 2, '7408335656', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (374, '44438382', 5, 'MAMANI PILCO FREDY LUIS', 1, '4160323618', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (375, '18907390', 5, 'MENDO VASQUEZ VICTOR HUMBERTO', 1, '4160029272', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (376, '796435', 5, 'MOGROVEJO CHIRI GUILLERMO ANDRES', 2, '7408262264', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (377, '41887866', 5, 'NIETO PACCI EVA MARIELA', 1, '4151482681', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (378, '40215185', 5, 'NOVA PALOMINO CHRISTIAN FELIX', 2, '7408216336', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (379, '43246550', 5, 'PAREJA GARCIA ANA CAROLINA', 1, '4151482703', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (380, '42044918', 5, 'RAMIREZ MUÑOZ OSCAR ROBERTO', 1, '4151652986', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (381, '41297443', 5, 'RIVERA CACERES DEMETRIA', 2, '7408335623', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (382, '71316709', 5, 'TAPIA CORDOVA MIRIAM ELIZABETH', 2, '7408338577', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (383, '44392350', 5, 'VALDERRAMA CABRERA CARLOS ANDRES', 2, '7408328784', 1);
INSERT INTO `rrhh`.`personal` (`IdPer`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`, `tipo_documento_IdTdoc`) VALUES (384, '40779050', 5, 'VIZCARRA AROCUTIPA YANETH MARIELA', 1, '4151839822', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `rrhh`.`usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `rrhh`;
INSERT INTO `rrhh`.`usuario` (`IdUser`, `usuario`, `password`) VALUES (1, 'admin', '$2y$10$6cLFhgiPKlnYvZ79CWq38eCqmtIkhrG2hVYoAN2UCefVVsUX0V3T2');

COMMIT;


-- -----------------------------------------------------
-- Data for table `rrhh`.`nivel`
-- -----------------------------------------------------
START TRANSACTION;
USE `rrhh`;
INSERT INTO `rrhh`.`nivel` (`IdNivel`, `nivel`) VALUES (1, 'Viaticos');
INSERT INTO `rrhh`.`nivel` (`IdNivel`, `nivel`) VALUES (2, 'Personal');
INSERT INTO `rrhh`.`nivel` (`IdNivel`, `nivel`) VALUES (3, 'Bancos');
INSERT INTO `rrhh`.`nivel` (`IdNivel`, `nivel`) VALUES (4, 'Condicion Laboral');
INSERT INTO `rrhh`.`nivel` (`IdNivel`, `nivel`) VALUES (5, 'Ley Laboral');
INSERT INTO `rrhh`.`nivel` (`IdNivel`, `nivel`) VALUES (6, 'Usuarios');
INSERT INTO `rrhh`.`nivel` (`IdNivel`, `nivel`) VALUES (7, 'Permisos');

COMMIT;


-- -----------------------------------------------------
-- Data for table `rrhh`.`usuario_nivel`
-- -----------------------------------------------------
START TRANSACTION;
USE `rrhh`;
INSERT INTO `rrhh`.`usuario_nivel` (`IdUserNivel`, `usuario_IdUser`, `nivel_IdNivel`) VALUES (1, 1, 1);
INSERT INTO `rrhh`.`usuario_nivel` (`IdUserNivel`, `usuario_IdUser`, `nivel_IdNivel`) VALUES (2, 1, 2);
INSERT INTO `rrhh`.`usuario_nivel` (`IdUserNivel`, `usuario_IdUser`, `nivel_IdNivel`) VALUES (3, 1, 3);
INSERT INTO `rrhh`.`usuario_nivel` (`IdUserNivel`, `usuario_IdUser`, `nivel_IdNivel`) VALUES (4, 1, 4);
INSERT INTO `rrhh`.`usuario_nivel` (`IdUserNivel`, `usuario_IdUser`, `nivel_IdNivel`) VALUES (5, 1, 5);
INSERT INTO `rrhh`.`usuario_nivel` (`IdUserNivel`, `usuario_IdUser`, `nivel_IdNivel`) VALUES (6, 1, 6);
INSERT INTO `rrhh`.`usuario_nivel` (`IdUserNivel`, `usuario_IdUser`, `nivel_IdNivel`) VALUES (7, 1, 7);

COMMIT;

