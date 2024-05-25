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
  `IdTdoc` CHAR(2) NOT NULL,
  `tip_doc` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`IdTdoc`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rrhh`.`personal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rrhh`.`personal` (
  `IdPer` INT NOT NULL AUTO_INCREMENT,
  `tipo_documento_IdTdoc` CHAR(2) NOT NULL,
  `dni` VARCHAR(9) NOT NULL,
  `condicion_laboral_IdClab` INT NOT NULL,
  `nombre` VARCHAR(60) NOT NULL,
  `banco_IdBco` INT NOT NULL,
  `ctacte` VARCHAR(20) NOT NULL,
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
INSERT INTO `rrhh`.`tipo_documento` (`IdTdoc`, `tip_doc`) VALUES ('01', 'D.N.I.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `rrhh`.`personal`
-- -----------------------------------------------------
START TRANSACTION;
USE `rrhh`;
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (1, '01', '485211', 3, 'ALVAREZ RAMOS FERNANDO SALVADOR', 1, '4151179326');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (2, '01', '415893', 2, 'CALDERON ALANOCA JUAN DE DIOS ADOLFO', 1, '4141614342');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (3, '01', '499945', 3, 'DURAN CRUZ MARIA LUZ', 1, '4151179628');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (4, '01', '416833', 3, 'GUTIERREZ FLORES ANABEL ESTHER', 1, '4151364824');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (5, '01', '4437604', 3, 'MARCA AMESQUITA PAMELA PATRICIA', 1, '4151179423');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (6, '01', '4410991', 3, 'MINAYA MALAGA GLADYS', 1, '4141304777');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (7, '01', '416814', 3, 'ORDOÑEZ ARANDA YIZELA TERESA', 1, '4151365294');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (8, '01', '23878956', 3, 'PALZA CARRASCO ELOY ANIBAL', 1, '4151134586');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (9, '01', '489009', 3, 'PARIA BEJARANO GUIDO JAVIER', 1, '4151173883');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (10, '01', '40453319', 2, 'QUEQUE MAMANI JOHN GILBERT', 1, '4151174022');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (11, '01', '425088', 3, 'SOTO MELENDEZ JOSE ALBERTO', 1, '4151147610');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (12, '01', '465625', 3, 'TUESTA RAMIREZ GUSTAVO PATRICIO', 1, '4151173859');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (13, '01', '792289', 3, 'CONDORI GUTIERREZ GLEDY ROXANA', 1, '4151625059');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (14, '01', '520999', 3, 'LOAYZA CHAMBE CARLOS ALFONSO', 1, '4151637251');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (15, '01', '504827', 3, 'MACHACA VARGAS JUANA VERONICA', 1, '4151402106');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (16, '01', '795671', 3, 'OBLITAS RAMOS CARLOS JAVIER', 1, '4151151553');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (17, '01', '506951', 3, 'SAKURAY MONTALVO SILVIA ISABEL', 1, '4151373610');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (18, '01', '41173617', 3, 'ALAVE YAHUARA NICOLAS ALBERTO', 1, '4151179466');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (19, '01', '483918', 3, 'AVENDAÑO CACERES MIRIAM ALICIA', 1, '4151151510');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (20, '01', '511049', 3, 'DELGADO ESPINOZA ROBERTO MARCIAL', 1, '4151179210');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (21, '01', '9938065', 3, 'JAPURA PILCO WALTER', 1, '4151624524');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (22, '01', '495627', 3, 'REYNA CAMPOS ROCIO MARGARITA', 1, '4151179229');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (23, '01', '433509', 3, 'VARGAS SILES CESAR HUGO', 1, '4151126834');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (24, '01', '40008358', 3, 'ALANOCA MULLUNI DE ALVARADO ESPERANZA', 1, '4151859947');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (25, '01', '41408908', 2, 'ALAY ALE ANGEL ELISEO', 1, '4151720574');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (26, '01', '666548', 3, 'ALVARADO ALAY OMAR ALFONSO', 1, '4151179369');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (27, '01', '476619', 3, 'CALLAHUI VILLAFUERTE MARTHA', 1, '4151179547');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (28, '01', '40342564', 3, 'CHURA APAZA LUZ MARINA', 2, '7408302102');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (29, '01', '417957', 3, 'CUNYAR LIENDO ANGEL TITO', 1, '4160076416');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (30, '01', '10350442', 3, 'GARCIA WONG ALFREDO', 1, '4151179342');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (31, '01', '422573', 3, 'HUAYLLA HUACHANI DOMITILA', 1, '4151179520');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (32, '01', '488901', 3, 'LEVANO VEGA EDWIN JOSEZANDRO', 1, '4151179121');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (33, '01', '441652', 3, 'MARCA ANCCO MARIO FERNANDO', 1, '4151365073');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (34, '01', '475146', 3, 'MIRANDA SUCASAIRE LEONOR NIEVES', 1, '4151365170');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (35, '01', '27713620', 3, 'MONTENEGRO ROJAS JUAN ISIDRO', 1, '4151173891');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (36, '01', '488711', 3, 'OCHOA AQUINO JUAN CARLOS', 2, '7408326432');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (37, '01', '403243', 3, 'ORTIZ MENENDEZ LUIS ALBERTO', 1, '4151173794');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (38, '01', '45883178', 3, 'PALZA SOTOMAYOR MARY CARMEN', 1, '4157112754');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (39, '01', '509143', 3, 'PARI MORENO OSCAR MARIO', 1, '4151179601');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (40, '01', '16682733', 3, 'POLO FIGUEROA CESAR LEONEL', 1, '4151179113');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (41, '01', '476945', 3, 'SALCEDO SALINAS JORGE AUGUSTO', 1, '4151173999');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (42, '01', '478802', 3, 'SALINAS CERREÑO JOSE MIGUEL', 1, '4151174073');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (43, '01', '480212', 2, 'TOLEDO HUACAN FELIX MARIO', 1, '4151151618');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (44, '01', '498256', 3, 'TORREBLANCA SANCHEZ ERICK YVAN', 2, '7408319270');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (45, '01', '473362', 3, 'VELARDE CORRO EDUARDO AGUSTO', 2, '7408323769');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (46, '01', '419903', 3, 'ZAPANA VELA HONORATO NESTOR', 1, '4151365804');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (47, '01', '44302661', 1, 'BAUTISTA ARPHI GERARDO CLIDER', 1, '4051719064');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (48, '01', '472065', 3, 'CALIZAYA PEREIRA NELLY CATALINA', 1, '4151364387');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (49, '01', '422286', 3, 'ACERO VILLEGAS ONDINA HERMENEGILDA', 1, '4151364107');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (50, '01', '433107', 3, 'BASADRE NAQUIRA EDGARD RICARDO', 1, '4151364255');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (51, '01', '416903', 3, 'BOHORQUEZ FERNANDEZ MARIO FEDERICO', 1, '4151364271');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (52, '01', '507681', 3, 'CACERES ALVARADO FELIX LEONCIO', 1, '4151364344');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (53, '01', '445381', 3, 'CALLALLA NIETO JOSE LUIS', 1, '4151369702');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (54, '01', '403038', 3, 'CENTURION BAHAMONDES JUAN CARLOS', 1, '4151134594');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (55, '01', '432098', 3, 'COAYLA FLORES NANCY FAUSTINA', 1, '4151364514');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (56, '01', '489569', 3, 'DAVILA PARIA KATHERINE OTILIA', 1, '4151364611');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (57, '01', '404751', 3, 'DOMINGUEZ AGUIRRE IGNACIA', 1, '4141303126');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (58, '01', '415601', 3, 'FERRERO VACCARI RINA LUZ', 1, '4151400650');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (59, '01', '476019', 3, 'GARCIA BEDOYA MARINA MARGOT', 1, '4151364719');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (60, '01', '40057323', 2, 'HERRERA VILLANUEVA IVETTE LUZ', 1, '4151456605');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (61, '01', '418798', 3, 'HUME LANCHIPA GRACIELA CARMEN', 1, '4151364948');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (62, '01', '495924', 3, 'JIMENEZ LUPE YUDITH NELLY', 1, '4151151561');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (63, '01', '491609', 3, 'MAQUERA ALAVE ELEUTERIO ADOLFO', 1, '4151365065');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (64, '01', '411142', 3, 'MEJIA VELA JOHN ERNESTO', 1, '4151365111');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (65, '01', '413181', 3, 'NIETO CUTIPA VIVIANA JUVELIT', 1, '4151365235');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (66, '01', '440735', 3, 'QUISPE QUISPE LOURDES ELIANA', 1, '4151365405');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (67, '01', '7444682', 3, 'SALINAS CORNEJO DE HINOJOSA CARMEN ROSA', 1, '4151365545');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (68, '01', '40413772', 3, 'SANCHEZ ALE GEORGE CHRISTIAN', 1, '4151214725');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (69, '01', '793254', 3, 'TOULLIER FERNANDEZ VIVIAN ESTELA', 1, '4151151537');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (70, '01', '1217242', 3, 'VELASQUEZ QUINTO BETTY GUADALUPE', 1, '4151365758');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (71, '01', '40727898', 2, 'GARCIA RIVERA GUSTAVO EDGAR', 1, '4151778319');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (72, '01', '790046', 3, 'HUANACUNI LANCHIPA JESSENIA JANETH', 1, '4151179350');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (73, '01', '794968', 3, 'HURTADO RAMOS EDITH HAYDEE', 1, '4151505630');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (74, '01', '42865409', 3, 'MONGE FIGUEROA JESSICA GINA', 1, '4151573636');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (75, '01', '43802241', 3, 'PARAVICINO RUELAS CYNTHIA GEORGINA', 1, '4151573695');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (76, '01', '472032', 3, 'PINTO DE BRAVO MARLENY YOLANDA', 1, '4151365367');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (77, '01', '472501', 3, 'TEJADA VASQUEZ EDGAR HERNAN', 1, '4151365677');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (78, '01', '416832', 3, 'FERNANDEZ CHIPOCO LOURDES MARINA', 1, '4151364689');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (79, '01', '416808', 3, 'MENDOZA SALINAS FREDY EDGAR', 1, '4151365146');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (80, '01', '486705', 3, 'VILLANUEVA ROQUE JAVIER CLEMENTE', 1, '4151600897');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (81, '01', '484893', 3, 'APAZA CORONEL VERONICA AMANDA', 1, '4151179334');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (82, '01', '492845', 3, 'CHANGLLIO ROAS JUAN JOSE EVARISTO', 1, '4151179296');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (83, '01', '413513', 3, 'COPAJA FLORES MARITZA CLARA', 1, '4151366622');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (84, '01', '30415359', 3, 'EGUILUZ LLERENA GILVER MARCOS', 1, '4151174154');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (85, '01', '4641243', 3, 'YAMPASI MENDOZA FELIX ROMEO', 1, '4151174146');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (86, '01', '446580', 3, 'MAMANI CHURA HERMILIA', 1, '4151204843');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (87, '01', '4749146', 3, 'PEÑALOZA ALVARADO MARCO ANTONIO', 1, '4151179318');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (88, '01', '419414', 2, 'RIOS FLORES LOURDES MARIELLA', 1, '4151179504');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (89, '01', '477873', 3, 'RIOS VALDEZ JUAN CARLOS', 1, '4151365472');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (90, '01', '486201', 3, 'TICONA PEREZ CARMEN EMILIANA', 1, '4151173972');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (91, '01', '410856', 3, 'CHAMBILLA CUSICANQUI LUZ TERESA', 1, '4151100533');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (92, '01', '40379750', 3, 'GAMBETTA MELENDEZ GABRIELA CECILIA', 2, '7408302110');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (93, '01', '492683', 3, 'HUAMAN MELODIAS GLADYS ELIZABETH', 1, '4151173875');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (94, '01', '440282', 3, 'PACOMPIA PANCA BERNARDINO', 1, '4151365308');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (95, '01', '4437367', 2, 'QUISPE VIZCARRA HENRY CESAR', 1, '4146238578');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (96, '01', '484820', 3, 'RODRIGUEZ VILCA GIOVANNA FRIDA', 1, '4151375567');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (97, '01', '40958186', 2, 'ROQUE RODRIGUEZ EVA MARIA', 1, '4151643367');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (98, '01', '472089', 3, 'SAIRA MANCHEGO DE MOSQUERA MATILDE MARIA', 1, '4151365510');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (99, '01', '432764', 3, 'SALCEDO CONDORI BERTHA', 1, '4151365537');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (100, '01', '796615', 3, 'VARGAS LAZO GLENDA PATRICIA', 1, '4151173840');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (101, '01', '2434783', 2, 'VASQUEZ ALTAMIRANO FELIPE LUIS', 1, '4151171775');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (102, '01', '29258926', 3, 'BRAVO BRAVO ANTONIETA IRENE', 1, '4151366142');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (103, '01', '40527164', 3, 'CALDERON SOSA RAUL MARCELO', 1, '4035587158');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (104, '01', '404460', 3, 'FLORES CHAMBILLA AIDA CARMEN', 1, '4151366851');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (105, '01', '43247382', 3, 'QUISPE GUTIERREZ HAYDEE DINA', 1, '4045336080');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (106, '01', '40949043', 2, 'ACERO MAMANI VIVIANA YANETH', 1, '4151586401');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (107, '01', '494449', 3, 'CARDENAS AMEZQUITA FLOR MARIA', 1, '4151173921');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (108, '01', '432104', 3, 'COHAILA MAMANI TEOFILA ESTHER', 1, '4151364522');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (109, '01', '400128', 3, 'COPAJA BARTRA TERESA ISABEL', 1, '4151300265');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (110, '01', '469807', 3, 'ESQUIVEL ACOSTA LUIS ENRRIQUE', 1, '4151364662');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (111, '01', '22078000', 3, 'GOYZUETA NEYRA ALINE MAYRA LUISA', 1, '4151131404');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (112, '01', '40761980', 3, 'ROSALES FLORES YASSELY VANESSA', 1, '4157052654');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (113, '01', '506629', 3, 'SOSA ARIAS JUANA ROSA', 1, '4151240629');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (114, '01', '497959', 3, 'VELASQUEZ JUCULACA GIOVANNA PAOLA', 1, '4151240637');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (115, '01', '479477', 3, 'ALARICO TAPIA JORGE ALBERTO', 1, '4151136716');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (116, '01', '795598', 3, 'ALAVE CONDORI FRANCISCO', 1, '4151364115');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (117, '01', '489818', 3, 'ANGULO MEDINA JUAN CARLOS', 1, '4151179288');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (118, '01', '517039', 3, 'CANAZA VELASQUEZ VALERIANO', 1, '4151179377');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (119, '01', '401886', 3, 'CARPIO BECERRA JOSE AUGUSTO', 1, '4151240599');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (120, '01', '29315755', 2, 'CHIRE CHOQUE DANIEL RAUL', 1, '4151180308');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (121, '01', '484922', 3, 'CHOQUE CHAMBE ALEJANDRINA ROSAURA', 1, '4151179407');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (122, '01', '488759', 3, 'CUTIPA VARGAS CELIA GREGORIA', 1, '4151187302');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (123, '01', '3678303', 3, 'ESCOBAR HIDALGO PATRICIA', 1, '4151179539');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (124, '01', '422733', 3, 'GIL MENDIETA PAULA LEONOR', 1, '4151179415');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (125, '01', '402910', 3, 'LANCHIPA ROSPIGLIOSI MORELIA MERCEDES', 1, '4151364964');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (126, '01', '42647000', 2, 'MAMANI MAMANI RAUL HUMBERTO', 1, '4151551357');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (127, '01', '450689', 3, 'MAMANI URURE SERAFIN LEONARDO', 1, '4151179458');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (128, '01', '403107', 3, 'MELENDEZ DE GAMBETTA CARMEN FLORA', 1, '4151365138');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (129, '01', '29423898', 3, 'MENDOZA AQUINO MARISOL', 1, '4151240726');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (130, '01', '433779', 3, 'MORALES MALDONADO VICTOR ADRIAN', 1, '4151365197');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (131, '01', '413141', 3, 'NAQUIRA SAAVEDRA MARIANO ARNALDO', 1, '4151365227');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (132, '01', '10393521', 2, 'ORTEGA CUTIPA BERTHA', 1, '4151240696');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (133, '01', '8164825', 2, 'REYNOSO PAREDES TILER HANS', 1, '4151804395');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (134, '01', '790795', 3, 'SANCHEZ GARCIA ERIKA', 1, '4151179563');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (135, '01', '441628', 3, 'SARAVIA BLANCO NESTOR', 1, '4151240610');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (136, '01', '423829', 3, 'SOTELO ACERO JULIO LUCIO', 1, '4151107244');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (137, '01', '479815', 3, 'VELASQUEZ REVILLA JUAN MARIO', 1, '4151901285');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (138, '01', '517824', 3, 'ZAPANA GARCIA ELIZABETH', 1, '4151151545');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (139, '01', '432998', 3, 'CARPIO DE SANCHEZ MARIA LUISA', 1, '4151364441');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (140, '01', '492511', 3, 'CASTAÑON GUTIERREZ MARLENE LOURDES', 1, '4151174286');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (141, '01', '41985499', 3, 'CRUZ PALMA JOSELYN ARACELI', 1, '4706013348');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (142, '01', '40538757', 3, 'GONZALES MAQUERA YEMELY KARINA', 1, '4151564637');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (143, '01', '793248', 3, 'HUANCA CHOQUE MARITZA MILAGROS', 1, '4151221055');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (144, '01', '40919396', 3, 'HUARACHI CHUQUIMIA ROXANA HAYDEE', 1, '4151182653');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (145, '01', '477459', 3, 'LIZARRAGA DE MELLO DORA GINA BEATRIZ', 1, '4151367297');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (146, '01', '404748', 3, 'LUNA PARI MARIA MAGDALENA', 1, '4151367378');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (147, '01', '419415', 3, 'MARTINEZ CHIRI ADELAIDA BELINDA', 2, '8251559632');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (148, '01', '485146', 3, 'MONTALVO CHAVEZ PATRICIA VERONICA', 2, '7408111990');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (149, '01', '25845282', 3, 'PAREDES FLORES DINA', 1, '4151240653');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (150, '01', '431745', 3, 'PEREZ NIETO YOLANDA ELIANA', 1, '4151365340');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (151, '01', '420886', 3, 'PIZARRO VEGA MARIA LUISA DE LOURDES', 1, '4151365375');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (152, '01', '474080', 3, 'ROJAS URRIETA PEDRO ANGEL', 1, '4151509741');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (153, '01', '794923', 3, 'VALDIVIA DIAZ WILLIAM JUAN', 1, '4151501228');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (154, '01', '505138', 3, 'VILCA CENTENO PATRICIA VIRGILIA', 1, '4151187337');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (155, '01', '415206', 3, 'YAVE CORONADO ESMERALDA DEL ROSARIO', 1, '4151368846');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (156, '01', '401715', 3, 'ZARATE ISIDRO FLORA NELLY', 1, '4151368889');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (157, '01', '478047', 3, 'GIRON COPA ROSARIO NIEVES', 1, '4151364743');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (158, '01', '508016', 2, 'NEIRA ZEGARRA RENAN ALEJANDRO', 1, '4151130122');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (159, '01', '473234', 3, 'ALVAREZ GOYCOCHEA ROSARIO ELIZABETH', 1, '4151364166');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (160, '01', '40594595', 3, 'CHOQUE BERNABE CESAR', 1, '4151174081');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (161, '01', '425389', 3, 'CONDORI MAMANI CARMEN ROSA', 1, '4151151529');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (162, '01', '413487', 3, 'KOC CHANG JUANA', 1, '4151364956');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (163, '01', '29411446', 3, 'APAZA QUILCA INES', 1, '4151128454');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (164, '01', '796943', 3, 'CHAMBE VARGAS JANET ROSARIO', 1, '4151174030');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (165, '01', '418875', 3, 'CORRALES CARAZAS YDA LUZ APOLONIA', 1, '4151364565');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (166, '01', '1230796', 3, 'DIAZ SAAVEDRA MARCO ANTONIO', 1, '4701342246');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (167, '01', '794655', 3, 'GARCIA RIVERA FRANCISCO', 1, '4151364727');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (168, '01', '516073', 2, 'VARGAS CANCINO HUGO JUAN', 1, '4160025498');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (169, '01', '435562', 3, 'ALVAREZ ESPEJO JOSE EMILIO', 1, '4151364158');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (170, '01', '45568907', 2, 'GALLO SUAREZ RAQUEL', 1, '4151456133');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (171, '01', '491851', 3, 'PAZ JORDAN RICHARD OSWALDO', 1, '4151179393');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (172, '01', '488724', 3, 'VILDOSO ROMERO JOSE TEODOSIO', 1, '4151204894');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (173, '01', '516837', 3, 'ALCANTARA QUISPE ELISEO', 1, '4151365030');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (174, '01', '512107', 2, 'AMERI VILLEGAS PABLO HUMBERTO', 1, '4151179431');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (175, '01', '413145', 3, 'BRAVO BOHORQUEZ JUAN CARLOS JAIME', 1, '4151364328');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (176, '01', '419591', 3, 'CALIZAYA YUFRA ESTHER LOURDES', 1, '4151364409');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (177, '01', '405465', 3, 'CASTRO ANCCO ALFREDO ELFREN', 1, '4151423138');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (178, '01', '497554', 3, 'COHAILA ALFEREZ OSMAN NACIAN', 1, '4151174065');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (179, '01', '479207', 3, 'GOMEZ GUTIERREZ JOSE LUIS', 1, '4151173948');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (180, '01', '470800', 3, 'GONZALES PORTOCARRERO LILIANA NORMA', 1, '4151364808');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (181, '01', '475081', 3, 'GUZMAN GUISA JORGE RAUL', 1, '4151364840');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (182, '01', '496201', 3, 'LAURA CHIPANA ANA MARIA', 1, '4151179482');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (183, '01', '494845', 3, 'LIENDO FLORES ELEANA ELOISA', 1, '4151174049');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (184, '01', '432097', 3, 'PUMAYAURI SANDOVAL VICTOR ALBERTO', 1, '4151365391');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (185, '01', '418536', 3, 'RAMOS ALVARADO FERNANDO JOSE', 1, '4151365413');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (186, '01', '4643522', 3, 'TALLEDO FLORES FELICIA ALEJANDRINA', 1, '4371343046');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (187, '01', '472377', 3, 'TAPIA LUCERO ELISEO', 1, '4151365650');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (188, '01', '71248919', 3, 'ALVARADO CHACOLLI JHEYSON JEANKARLO', 1, '4151057727');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (189, '01', '449997', 3, 'ARCE RAMOS INGRID LILIANA', 1, '4151689391');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (190, '01', '43098578', 3, 'ARIAS ROJAS VICTOR ALFONSO', 1, '4043918007');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (191, '01', '42390255', 3, 'BRAVO CHECA CESAR AUGUSTO', 2, '8312025631');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (192, '01', '42609159', 3, 'CALIZAYA CONDORI ELVIA YANIRA', 2, '8250330399');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (193, '01', '402890', 3, 'CHAMBILLA DE MARTINEZ LOURDES CRISTINA', 1, '4151423707');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (194, '01', '42940723', 3, 'GUILLERMO MAQUERA GUINA NOEMI', 1, '4034290828');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (195, '01', '41041402', 3, 'PORTUGAL QUISPE MAGDELIA MAYDA', 1, '4151529300');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (196, '01', '504249', 3, 'RAMOS GARCIA JANET MADALI', 1, '4151509725');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (197, '01', '43187395', 3, 'RIVAS CARRILLO PIERINA GUADALUPE', 1, '4706013356');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (198, '01', '42418738', 3, 'RIVERA LLANQUI KARINA RUTH', 1, '4151733374');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (199, '01', '10328104', 3, 'SANCHEZ VELEZ CARLOS ALFONSO', 1, '4151751801');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (200, '01', '45481983', 3, 'VIZA VIZCARRA MARILLY ELIZABETH', 1, '4052918893');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (201, '01', '793689', 3, 'ACHATA ANCCO YANETH', 1, '4151733390');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (202, '01', '29219702', 3, 'MAQUE GUERRA JUAN LUDWING', 1, '4151372193');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (203, '01', '42272984', 3, 'TESILLO CHOQUE JEANETH KARINA', 1, '4151733382');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (204, '01', '80190013', 3, 'CHAGUA JIMENEZ FELIX ANTONIO', 1, '4151179474');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (205, '01', '403037', 3, 'EYZAGUIRRE ZAPATA LORENA MARIA', 1, '4151134608');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (206, '01', '70496878', 4, 'MAMANI VILCA EDGARD MAURICIO', 2, '7408241136');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (207, '01', '74969673', 4, 'HUANCA PERALTA TANIA REYNA', 2, '7408305733');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (208, '01', '47304017', 4, 'COCHACHIN ORTIZ ERIKA JULISSA', 1, '4151947846');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (209, '01', '70297544', 4, 'GUEVARA ARREDONDO FABRIZIO ALEJANDRO', 2, '7408242183');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (210, '01', '73832191', 4, 'LUNA ZARSOZA XIOMARA BELEN', 2, '7408241144');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (211, '01', '47891117', 4, 'ARPI ZAPANA DORIS CARLETH', 1, '4151935643');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (212, '01', '72535308', 4, 'GONZA HUALLA MADAI CELINA', 2, '7008765203');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (213, '01', '70444035', 4, 'LEDESMA PERAZA OSCAR ALEXANDER', 2, '7408241177');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (214, '01', '20039710', 4, 'PEREZ GARAY REBECA ESPERANZA', 2, '7408241185');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (215, '01', '71326203', 4, 'PORTUGAL CABRERA YENI FERNANDA', 1, '4151947870');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (216, '01', '70842408', 4, 'ARCE VENTURA RUTH MARILU', 2, '7408302177');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (217, '01', '46874972', 4, 'LIMACHE CONDORI YESENIA LEIDI', 1, '4021267681');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (218, '01', '72552243', 4, 'ROMERO COAQUIRA ALDO JEFFERSON', 2, '7408241110');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (219, '01', '71234086', 4, 'NINAJA SARMIENTO SANDRA PAOLA', 2, '7408241169');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (220, '01', '74449419', 4, 'PARIAN MARQUEZ ISRAEL', 1, '4151947900');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (221, '01', '72858861', 4, 'VÁSQUEZ RAMOS KATHLEN XIMENA', 2, '8311978020');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (222, '01', '74051706', 4, 'YAULLI CHOQUEHUANCA EYMI JHOAN', 2, '7408241052');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (223, '01', '71224115', 4, 'FELICIANO MAMANI SINDI KATI', 2, '7408240583');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (224, '01', '72384884', 4, 'MACHICADO GOMEZ SALLY KATHERINE', 2, '7408241128');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (225, '01', '48461465', 4, 'CJURO VERA LUSMY', 2, '7408241151');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (226, '01', '71346756', 4, 'PUMA VELASQUEZ GUADALUPE', 2, '7408241060');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (227, '01', '70473294', 4, 'LLANOS PUMA MARY LUZ', 2, '7931056845');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (228, '01', '71213922', 4, 'CHOQUE ALAVE XINA KIMBERLY', 2, '7408240609');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (229, '01', '71908574', 4, 'RAMIREZ GUTIERREZ ROSARIO DEL PILAR', 2, '7408302680');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (230, '01', '77172251', 4, 'VASQUEZ FLORES YENIFER', 2, '7408302557');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (231, '01', '74560868', 4, 'PAREDES MAMANI ALONDRA ESTEFANY', 2, '7408241094');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (232, '01', '70212795', 4, 'APAZA CANCAPA CLEMENTINA', 1, '4151935651');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (233, '01', '75927280', 4, 'JOAQUIN COTRADO YACEL EILEN', 1, '4151935740');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (234, '01', '72630989', 4, 'SANTE FARFAN ANGIE MARILU', 2, '7408241383');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (235, '01', '70579902', 4, 'SONCCO COAQUIRA FIORELA DIANA', 2, '7408241078');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (236, '01', '70559169', 4, 'BARRIENTOS SOTO LUIS RODRIGO', 1, '4151935686');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (237, '01', '72489520', 4, 'CABANA RODRIGUEZ ALEJANDRA DESIREE', 2, '7408241086');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (238, '01', '44981360', 4, 'PARIONA CALDERÓN JANETT SINDY', 1, '4151935635');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (239, '01', '71321462', 4, 'AROCUTIPA CALDERON CYNTHIA ROSA', 2, '7408241102');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (240, '01', '46770320', 4, 'CHOQUE VARGAS JOSE VICTOR ENRIQUE', 2, '7408302706');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (241, '01', '75208410', 4, 'KGORIMAYA CHÁVEZ CLAUDIA JULEISSI', 2, '8311978012');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (242, '01', '518255', 5, 'AGUILAR YUJRA GRACIELA FRANCISCA', 1, '4151501295');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (243, '01', '45388164', 5, 'ALAVE CHOQUE HAYDEE BLANCA', 1, '4093700673');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (244, '01', '46803153', 5, 'ALFEREZ APAZA JESUS ANIBAL', 2, '8218164161');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (245, '01', '43299650', 5, 'ALI PARI YANET', 1, '4160219551');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (246, '01', '47272510', 5, 'APAZA MAQUERA VICTOR LEONARDO', 2, '8310106144');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (247, '01', '44367839', 5, 'ARANA RODRIGUEZ MARIEL DEL CARMEN', 2, '8250697086');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (248, '01', '41248752', 5, 'ARAUJO ANQUISE CARMEN ROSA', 2, '7408325673');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (249, '01', '44613945', 5, 'ARIAS ORDOÑEZ JESUS EDUARDO', 1, '4151864266');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (250, '01', '80285131', 5, 'AROCUTIPA LINARES LISANDRO WILFREDO', 1, '4194080854');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (251, '01', '790865', 5, 'BARRIGA RAMOS MAURO DICKS', 2, '7408240021');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (252, '01', '45350879', 5, 'BARRIOS AVENDAÑO VALERY JEYMY', 1, '4072814296');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (253, '01', '70911575', 5, 'BLAS ALVARO FLOR MARIA ISABEL', 1, '4151067633');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (254, '01', '510884', 5, 'BORDA LLANOS ROLFY', 2, '8310103299');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (255, '01', '45496538', 5, 'CAHUAYA CHUQUICALLATA ELIZABETH GLADYS', 1, '4055105613');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (256, '01', '76610721', 5, 'CALDAS SILES FLOR DE MARIA', 1, '4194099334');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (257, '01', '42884273', 5, 'CALDERON CALISAYA DINA ROCIO', 2, '7408282080');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (258, '01', '44818405', 5, 'CALIZAYA QUIÑONES SADITH EVELIN', 2, '8251049394');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (259, '01', '48116336', 5, 'CALLE MAQUERA RUTH MARIBEL', 1, '4151751933');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (260, '01', '46557198', 5, 'CAMPOS QUISPE JUAN YHONATAN', 1, '4151916894');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (261, '01', '70601043', 5, 'CAPACUTE CHAMBILLA TANIA CAROLINA', 1, '4076855639');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (262, '01', '41800924', 5, 'CARAZAS CONDE SANDRA ANGELICA', 1, '4151505622');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (263, '01', '40542475', 5, 'CARDENAS GUTIERREZ MARIVEL TRINIDAD', 1, '4151618435');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (264, '01', '70492244', 5, 'CARRIL TEJADA MARIA JOSE', 1, '4160025641');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (265, '01', '71821439', 5, 'CASTRO VARGAS MAYRA ALEXANDRA', 2, '8250354001');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (266, '01', '443552', 5, 'CATACHURA QUISPE JAVIER VIRGILIO', 1, '4157283257');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (267, '01', '41887856', 5, 'CESPEDES PINTO MILTON RENE', 1, '4151607042');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (268, '01', '44462018', 5, 'CHACCOLLI GOMEZ SONIA SOLEDAD', 2, '8310106151');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (269, '01', '42115786', 5, 'CHOQUE MAMANI VERONICA BERTHA', 1, '4151922525');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (270, '01', '42817709', 5, 'CHOQUE SANTOS ANAHI', 1, '4093316474');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (271, '01', '47612953', 5, 'CHURA APAZA KATHERINE ISSAMAR', 2, '8251415488');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (272, '01', '45271862', 5, 'COAQUIRA MAQUERA GUSTAVO ADOLFO', 1, '4151060582');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (273, '01', '43232168', 5, 'CONTRERAS AQUISE NILLS ELID RICARDO', 2, '8250432245');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (274, '01', '71345531', 5, 'CORONADO CONDORI LUDWIKA AMPARO', 2, '8253051976');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (275, '01', '80282632', 5, 'COROPUNA CORNEJO RENE LUIS', 1, '4151736802');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (276, '01', '797267', 5, 'CORTEZ AVALOS HERNAN', 1, '4157287759');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (277, '01', '43540915', 5, 'CUENTAS COILA DE DOMINGUEZ ROSSANA YENI', 1, '4047248952');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (278, '01', '44462017', 5, 'CURO CACERES EDDY MABEL', 1, '4151006014');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (279, '01', '504139', 5, 'CUTIMBO ALANOCA ROSA LUZ', 2, '8251049402');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (280, '01', '72174284', 5, 'DELGADO CRUZ SANDRA VERONICA', 1, '4157122873');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (281, '01', '795142', 5, 'DURAND GAMEZ ARTURO YVAN', 1, '4151063158');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (282, '01', '46870682', 5, 'ECHEVARRIA MAMANI NELD ENRIQUE', 2, '8253051984');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (283, '01', '70614554', 5, 'ESPINAL QUIÑONEZ DELSY MIRIAN', 1, '4093700525');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (284, '01', '72271498', 5, 'ESPINOZA ORTIZ MARICELI MILAGROS', 2, '7408304090');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (285, '01', '491383', 5, 'FERNANDEZ DAVILA FORLONG DANIEL AUGUSTO', 1, '4194095029');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (286, '01', '70137686', 5, 'FLORES GALVEZ HANDDY FABRIZZIO', 2, '8247944484');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (287, '01', '44665455', 5, 'FLORES ORMEÑO VERONICA KARINA', 1, '4151031957');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (288, '01', '795271', 5, 'FLORES PLATERO HUGO HENRY', 1, '4194081540');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (289, '01', '796472', 5, 'FONTTIS CALDERóN LUZ CAROLINA', 1, '4061010047');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (290, '01', '43441998', 5, 'GALLARDO TORRES CESAR ALBERTO', 2, '8250313205');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (291, '01', '45993183', 5, 'GARCIA IQUISE FABIOLA NIDIA', 1, '4141856788');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (292, '01', '45091291', 5, 'GARCIA PINTO GREIS DEL CARMEN', 1, '4066242094');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (293, '01', '71239043', 5, 'GOMEZ MENDOZA RUTH NORMA', 1, '4151069288');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (294, '01', '47252832', 5, 'GOMEZ RODRIGUEZ MIGUEL ANGEL', 1, '4194040119');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (295, '01', '2618505', 5, 'GONZALEZ MORA DIANA NOHEMI', 2, '8253716685');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (296, '01', '46795542', 5, 'GUTIERREZ AGUILAR CLAUDIA TATHIANA', 2, '8250321000');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (297, '01', '43982352', 5, 'GUTIERREZ QUISPE ROSA VANESSA', 2, '8251559608');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (298, '01', '45817607', 5, 'HUAMAN APAZA YESENIA EVANS', 2, '8218176256');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (299, '01', '46973618', 5, 'HUANACUNI APAZA WILMA YANETH', 1, '4151029146');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (300, '01', '76470765', 5, 'HUANCA HUANCA MARIA CRISTINA', 2, '8253049962');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (301, '01', '46349017', 5, 'HUATTA NAVIA HERALDINA HELEN', 1, '4093708267');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (302, '01', '41493146', 5, 'HURTADO MANCHEGO LIZBETH YULIANA', 1, '4151276151');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (303, '01', '47685356', 5, 'JIMENEZ ESTAÑA SIMON EDUARDO', 1, '4093799297');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (304, '01', '40604734', 5, 'JIMENEZ LUPE SAUL CAMILO', 1, '4151718456');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (305, '01', '47953958', 5, 'JIMENEZ PERALTA GIANCARLO', 1, '4151468344');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (306, '01', '514643', 5, 'JUANILLO VILCA ERICKA RUTH', 2, '8253052008');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (307, '01', '47489879', 5, 'LLAMPAZO PAXI MAYUMI SANDRA', 1, '4151807637');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (308, '01', '73998112', 5, 'LUJAN CASTILLO DEICY ESTIFFANI', 1, '4074629666');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (309, '01', '70652132', 5, 'LUJAN CHOQUE FLOR DEL PILAR', 1, '4151063182');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (310, '01', '72212420', 5, 'LUYO FONTTIS PAOLA ADELY', 1, '4151067900');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (311, '01', '71217839', 5, 'MACEDO CHOQUECOTA KAREN LIZBETH', 2, '8253676913');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (312, '01', '42206520', 5, 'MAMANI MORERA MALENA ANAI', 1, '4703476886');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (313, '01', '71739085', 5, 'MAMANI PARI JORGE LUIS', 1, '4151850753');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (314, '01', '72463859', 5, 'MAMANI TAPIA ROCIO KATIA', 1, '4151036371');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (315, '01', '42792296', 5, 'MANCHEGO BARRERA ANYELO JEMPHI', 2, '8250320994');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (316, '01', '40616708', 5, 'MARAZA HUAYCANI EDDY KENYI', 1, '4151595028');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (317, '01', '70975526', 5, 'MARCA MACHACA DANITZA MARITEé', 1, '4157306672');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (318, '01', '10582088', 5, 'MELENDEZ SALMON ANTONIO DANTE', 1, '4151848333');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (319, '01', '47656118', 5, 'MENDOZA CHAMBILLA JHON NOE', 2, '8218176264');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (320, '01', '46711245', 5, 'MENDOZA VALDEZ GRETA LIZBETH', 2, '7408210891');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (321, '01', '41550586', 5, 'MENDOZA ZUASNABAR MARJORIE JAYNE', 1, '4157300240');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (322, '01', '44747071', 5, 'MONASTERIO CHURA DIANA RUTH', 1, '4039934448');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (323, '01', '45986848', 5, 'MORALES CUTIPA LADY ALEJANDRA', 1, '4045291680');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (324, '01', '71399287', 5, 'MURILLO VARGAS LUIS RENATO', 1, '4151954362');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (325, '01', '46543590', 5, 'NEYRA CATACORA ERIKA MIREYA', 1, '4157108242');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (326, '01', '425804', 5, 'NINA QUISPE VENANCIO', 1, '4151187760');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (327, '01', '42537860', 5, 'OCAMPO HUAMAN ANDREA ISABEL', 2, '8253051992');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (328, '01', '41351166', 5, 'PACCI YUFRA ROCIO', 1, '4042353790');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (329, '01', '70432921', 5, 'PACO APAZA JOSE LUIS', 1, '4151771284');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (330, '01', '44649918', 5, 'PALOMINO CAHUANA WILLY ALFREDO', 2, '8251827096');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (331, '01', '42101016', 5, 'PAREDES ONOFRE WILBERT', 1, '4151502410');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (332, '01', '45091750', 5, 'PEREZ INFANTAS FABIOLA MELANY', 2, '8311978038');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (333, '01', '514300', 5, 'QUENTA RIOS JOSE LUIS', 2, '7408305519');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (334, '01', '517334', 5, 'QUIJANDRIA ARIAS ROSELYN GERALDINE', 1, '4160098940');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (335, '01', '40941914', 5, 'QUISPE ACERO REYNALDO JAIME', 1, '4151035952');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (336, '01', '46390477', 5, 'QUISPE MAMANI ERICA GINA', 1, '4157212031');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (337, '01', '518353', 5, 'RAMIREZ CHOQUECOTA WALTER BERNARDO', 2, '8310419828');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (338, '01', '44328066', 5, 'RAMOS MENDOZA KARINNA DEL ROCIO', 2, '7408306699');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (339, '01', '511642', 5, 'RAMOS VERGARA GABRIELA MASIEL', 1, '4151604272');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (340, '01', '72647398', 5, 'REJAS MAMANI YULISSA NOELIA', 1, '4151069296');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (341, '01', '512280', 5, 'RIOS MONDOÑEDO FERNANDO ENRIQUE ERASMO', 2, '8250311977');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (342, '01', '44707736', 5, 'SANTOS CHIPANA CARLOS AGUSTO', 1, '4151916916');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (343, '01', '41411089', 5, 'SANTOS CUTIPA MIRIAN DAYSI', 1, '4049135586');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (344, '01', '40188909', 5, 'SOLIS CHIPANA JAVIER ALONSO', 1, '4151181282');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (345, '01', '481298', 5, 'TAPIA CONDE FRANCISCO JUAN', 1, '4151270773');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (346, '01', '47619796', 5, 'TICONA FLORES EDITH GINA PASTORA', 1, '4151757729');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (347, '01', '40180413', 5, 'TICONA SERRANO EDWIN PERCY', 1, '4157150559');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (348, '01', '70023091', 5, 'TORRES HUARACHI CRISTHIAN DAVID POLDAR', 1, '4066332123');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (349, '01', '41383322', 5, 'VARGAS FLORES CINTHIA JAZMIN', 1, '4049114465');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (350, '01', '47689705', 5, 'VARGAS POMA LUIGUI XAVIER', 2, '8250324830');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (351, '01', '44908651', 5, 'VEGA CHAVEZ SELMA YESENIA', 1, '4151065800');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (352, '01', '793327', 5, 'VICENTE GUILLERMO JULIAN REYNALDO', 1, '4151254921');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (353, '01', '43463932', 5, 'VICENTE VEGA KARINA MAGALY', 1, '4201470078');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (354, '01', '482751', 5, 'VILLAR AGURTO JESUS HERNAN', 1, '4194100111');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (355, '01', '46105346', 5, 'VIZCARRA OROS ANNA PATRICIA', 1, '4049135667');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (356, '01', '47207395', 5, 'ZAPANA ALANIA LUIS JONATAN', 1, '4151062305');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (357, '01', '406072', 5, 'ZAPATA SALAMANCA IVOR EDGARD', 1, '4151761874');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (358, '01', '70661278', 5, 'ABURTO QUISPE SUSAN GRETA', 2, '7408335649');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (359, '01', '43767821', 5, 'ALARCON VEGA NILGER', 2, '7408336001');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (360, '01', '40274244', 5, 'ARUA ORDOÑEZ RICARDO MOISES', 2, '7408335599');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (361, '01', '46930829', 5, 'CARPIO VENANCIO JESSICA LIDIA', 1, '4074670208');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (362, '01', '40425189', 5, 'COAQUERA ALAVE YANIRA MIRYAN', 2, '7408335615');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (363, '01', '41946666', 5, 'ELIAS COLQUE KENNY ENRIQUE', 1, '4151681595');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (364, '01', '42027694', 5, 'FLORES GARCIA PAOLA ELIZABETH', 2, '7408335607');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (365, '01', '474362', 5, 'FLORES GUERRERO JOSE ANTONIO', 1, '4151533359');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (366, '01', '72127879', 5, 'GALINDO ZEVALLOS SANDRA LUZ', 1, '4069719290');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (367, '01', '42022161', 5, 'GAMBOA ALVARADO CRISTHIAN WALTER', 1, '4151533375');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (368, '01', '29677372', 5, 'GONZALES ANGULO LUIS LUCAS', 1, '4157473811');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (369, '01', '45624762', 5, 'HONORE CACHICATARI JUDIT VICTORIA', 2, '7408335664');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (370, '01', '47121563', 5, 'IBAÑEZ PANTA DIEGO HERNAN', 1, '4085605815');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (371, '01', '46433178', 5, 'LOAYZA AGUILAR ALBERT JOSEPH', 2, '7408335631');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (372, '01', '41269221', 5, 'MACHACA CHACOLLI EFRAIN NELSON', 1, '4160076726');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (373, '01', '46727854', 5, 'MAMANI CHURA LESLIE ZUKI', 2, '7408335656');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (374, '01', '44438382', 5, 'MAMANI PILCO FREDY LUIS', 1, '4160323618');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (375, '01', '18907390', 5, 'MENDO VASQUEZ VICTOR HUMBERTO', 1, '4160029272');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (376, '01', '796435', 5, 'MOGROVEJO CHIRI GUILLERMO ANDRES', 2, '7408262264');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (377, '01', '41887866', 5, 'NIETO PACCI EVA MARIELA', 1, '4151482681');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (378, '01', '40215185', 5, 'NOVA PALOMINO CHRISTIAN FELIX', 2, '7408216336');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (379, '01', '43246550', 5, 'PAREJA GARCIA ANA CAROLINA', 1, '4151482703');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (380, '01', '42044918', 5, 'RAMIREZ MUÑOZ OSCAR ROBERTO', 1, '4151652986');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (381, '01', '41297443', 5, 'RIVERA CACERES DEMETRIA', 2, '7408335623');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (382, '01', '71316709', 5, 'TAPIA CORDOVA MIRIAM ELIZABETH', 2, '7408338577');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (383, '01', '44392350', 5, 'VALDERRAMA CABRERA CARLOS ANDRES', 2, '7408328784');
INSERT INTO `rrhh`.`personal` (`IdPer`, `tipo_documento_IdTdoc`, `dni`, `condicion_laboral_IdClab`, `nombre`, `banco_IdBco`, `ctacte`) VALUES (384, '01', '40779050', 5, 'VIZCARRA AROCUTIPA YANETH MARIELA', 1, '4151839822');

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

