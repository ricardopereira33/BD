-- Universidade do Minho
-- Mestrado Integrado em Engenharia Informática
-- Unidade Curricular de Bases de Dados
-- 2016/2017
--
-- Caso de Estudo: "EuroTrain" 
-- Criação da base de dados utilizando a script gerada pelo MySQL Workbench.
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema EuroTrain
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `EuroTrain` ;

-- -----------------------------------------------------
-- Schema EuroTrain
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `EuroTrain` DEFAULT CHARACTER SET utf8 ;
USE `EuroTrain` ;

-- -----------------------------------------------------
-- Table `EuroTrain`.`País`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EuroTrain`.`País` ;

CREATE TABLE IF NOT EXISTS `EuroTrain`.`País` (
  `ID_País` INT NOT NULL,
  `Nome` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`ID_País`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EuroTrain`.`Cidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EuroTrain`.`Cidade` ;

CREATE TABLE IF NOT EXISTS `EuroTrain`.`Cidade` (
  `ID_Cidade` INT NOT NULL,
  `País` INT NOT NULL,
  `Nome` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`ID_Cidade`),
  INDEX `fk_Cidade_País1_idx` (`País` ASC),
  CONSTRAINT `fk_Cidade_País1`
    FOREIGN KEY (`País`)
    REFERENCES `EuroTrain`.`País` (`ID_País`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EuroTrain`.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EuroTrain`.`Cliente` ;

CREATE TABLE IF NOT EXISTS `EuroTrain`.`Cliente` (
  `ID_Cliente` INT NOT NULL,
  `Nome` VARCHAR(64) NOT NULL,
  `Username` VARCHAR(32) NOT NULL,
  `Password` VARCHAR(32) NOT NULL,
  `Cidade` INT NOT NULL,
  `Email` VARCHAR(64) NOT NULL,
  `Telemóvel` INT NOT NULL,
  PRIMARY KEY (`ID_Cliente`),
  INDEX `fk_Cliente_Cidade1_idx` (`Cidade` ASC),
  CONSTRAINT `fk_Cliente_Cidade1`
    FOREIGN KEY (`Cidade`)
    REFERENCES `EuroTrain`.`Cidade` (`ID_Cidade`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EuroTrain`.`Comboio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EuroTrain`.`Comboio` ;

CREATE TABLE IF NOT EXISTS `EuroTrain`.`Comboio` (
  `ID_Comboio` INT NOT NULL,
  `Tipo` VARCHAR(64) NOT NULL,
  `Descrição` TEXT(512) NOT NULL,
  `Capacidade` INT NOT NULL,
  PRIMARY KEY (`ID_Comboio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EuroTrain`.`Viagem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EuroTrain`.`Viagem` ;

CREATE TABLE IF NOT EXISTS `EuroTrain`.`Viagem` (
  `ID_Viagem` INT NOT NULL,
  `Comboio` INT NOT NULL,
  `Cidade_Partida` INT NOT NULL,
  `Cidade_Chegada` INT NOT NULL,
  `Hora_Partida` TIME(0) NOT NULL,
  `Hora_Chegada` TIME(0) NOT NULL,
  `Duração` TIME(0) NOT NULL,
  PRIMARY KEY (`ID_Viagem`),
  INDEX `fk_Viagem_Comboio1_idx` (`Comboio` ASC),
  INDEX `fk_Viagem_Cidade1_idx` (`Cidade_Partida` ASC),
  INDEX `fk_Viagem_Cidade2_idx` (`Cidade_Chegada` ASC),
  CONSTRAINT `fk_Viagem_Comboio1`
    FOREIGN KEY (`Comboio`)
    REFERENCES `EuroTrain`.`Comboio` (`ID_Comboio`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Viagem_Cidade1`
    FOREIGN KEY (`Cidade_Partida`)
    REFERENCES `EuroTrain`.`Cidade` (`ID_Cidade`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Viagem_Cidade2`
    FOREIGN KEY (`Cidade_Chegada`)
    REFERENCES `EuroTrain`.`Cidade` (`ID_Cidade`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EuroTrain`.`Lugar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EuroTrain`.`Lugar` ;

CREATE TABLE IF NOT EXISTS `EuroTrain`.`Lugar` (
  `Comboio` INT NOT NULL,
  `Nr` INT NOT NULL,
  `Classe` VARCHAR(16) NOT NULL,
  `Carruagem` INT NOT NULL,
  PRIMARY KEY (`Comboio`, `Nr`),
  CONSTRAINT `fk_Lugar_Comboio1`
    FOREIGN KEY (`Comboio`)
    REFERENCES `EuroTrain`.`Comboio` (`ID_Comboio`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EuroTrain`.`Reserva`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EuroTrain`.`Reserva` ;

CREATE TABLE IF NOT EXISTS `EuroTrain`.`Reserva` (
  `ID_Reserva` INT NOT NULL,
  `Data` DATE NOT NULL,
  `Comboio` INT NOT NULL,
  `Lugar` INT NOT NULL,
  `Código` VARCHAR(8) NOT NULL,
  `Preço` DECIMAL(5,2) NOT NULL,
  `Cliente` INT NOT NULL,
  `Viagem` INT NOT NULL,
  PRIMARY KEY (`ID_Reserva`),
  INDEX `fk_Reserva_Cliente_idx` (`Cliente` ASC),
  INDEX `fk_Reserva_Viagem1_idx` (`Viagem` ASC),
  INDEX `fk_Reserva_Lugar1_idx` (`Comboio` ASC, `Lugar` ASC),
  CONSTRAINT `fk_Reserva_Cliente`
    FOREIGN KEY (`Cliente`)
    REFERENCES `EuroTrain`.`Cliente` (`ID_Cliente`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Reserva_Viagem1`
    FOREIGN KEY (`Viagem`)
    REFERENCES `EuroTrain`.`Viagem` (`ID_Viagem`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Reserva_Lugar1`
    FOREIGN KEY (`Comboio` , `Lugar`)
    REFERENCES `EuroTrain`.`Lugar` (`Comboio` , `Nr`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
