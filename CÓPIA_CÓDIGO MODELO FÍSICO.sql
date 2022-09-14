-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema rede_cinema_bd
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema rede_cinema_bd
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `rede_cinema_bd` DEFAULT CHARACTER SET utf8 ;
USE `rede_cinema_bd` ;

-- -----------------------------------------------------
-- Table `rede_cinema_bd`.`Shopping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede_cinema_bd`.`Shopping` (
  `CodShopping` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`CodShopping`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede_cinema_bd`.`Rede_Cinema`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede_cinema_bd`.`Rede_Cinema` (
  `NomeRede` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`NomeRede`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede_cinema_bd`.`Sala_Cinema`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede_cinema_bd`.`Sala_Cinema` (
  `CodSala` INT NOT NULL,
  `FK_NomeRede` VARCHAR(45) NOT NULL,
  `FK_CodShopping` INT NOT NULL,
  `capacidade` INT NULL,
  `2D` TINYINT NULL,
  `3D` TINYINT NULL,
  PRIMARY KEY (`CodSala`),
  INDEX `fk_SalaCinema_Shopping1_idx` (`FK_CodShopping` ASC) VISIBLE,
  INDEX `fk_Sala_Cinema_Rede_Cinema1_idx` (`FK_NomeRede` ASC) VISIBLE,
  CONSTRAINT `fk_SalaCinema_Shopping1`
    FOREIGN KEY (`FK_CodShopping`)
    REFERENCES `rede_cinema_bd`.`Shopping` (`CodShopping`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Sala_Cinema_Rede_Cinema1`
    FOREIGN KEY (`FK_NomeRede`)
    REFERENCES `rede_cinema_bd`.`Rede_Cinema` (`NomeRede`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede_cinema_bd`.`Cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede_cinema_bd`.`Cargo` (
  `CodCargo` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`CodCargo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede_cinema_bd`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede_cinema_bd`.`Funcionario` (
  `N_CarteiraTrabalho` INT NOT NULL,
  `FK_NomeRede` VARCHAR(45) NOT NULL,
  `FK_CodCargo` INT NULL,
  `nome` VARCHAR(45) NULL,
  `dataAdmisaao` DATETIME NULL,
  `salario` INT NULL,
  PRIMARY KEY (`N_CarteiraTrabalho`),
  INDEX `fk_Funcionario_Cargo1_idx` (`FK_CodCargo` ASC) VISIBLE,
  INDEX `fk_Funcionario_Rede_Cinema1_idx` (`FK_NomeRede` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionario_Cargo1`
    FOREIGN KEY (`FK_CodCargo`)
    REFERENCES `rede_cinema_bd`.`Cargo` (`CodCargo`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Funcionario_Rede_Cinema1`
    FOREIGN KEY (`FK_NomeRede`)
    REFERENCES `rede_cinema_bd`.`Rede_Cinema` (`NomeRede`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede_cinema_bd`.`Filme`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede_cinema_bd`.`Filme` (
  `CodFilme` INT NOT NULL,
  `nomeBr` VARCHAR(45) NULL,
  `nomeOriginal` VARCHAR(45) NULL,
  `sinopse` VARCHAR(45) NULL,
  `genero` VARCHAR(45) NULL,
  `diretor` VARCHAR(45) NULL,
  `atores` VARCHAR(45) NULL,
  `anoLancamento` YEAR NULL,
  `legendado` TINYINT NULL,
  `2D` TINYINT NULL,
  `3D` TINYINT NULL,
  PRIMARY KEY (`CodFilme`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede_cinema_bd`.`Sessao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede_cinema_bd`.`Sessao` (
  `FK_CodSala` INT NOT NULL,
  `FK_CodFilme` INT NOT NULL,
  `dataHora` DATETIME NULL,
  INDEX `fk_Sessao_SalaCinema1_idx` (`FK_CodSala` ASC) VISIBLE,
  INDEX `fk_Sessao_Filme1_idx` (`FK_CodFilme` ASC) VISIBLE,
  PRIMARY KEY (`FK_CodFilme`, `FK_CodSala`),
  CONSTRAINT `fk_Sessao_SalaCinema1`
    FOREIGN KEY (`FK_CodSala`)
    REFERENCES `rede_cinema_bd`.`Sala_Cinema` (`CodSala`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Sessao_Filme1`
    FOREIGN KEY (`FK_CodFilme`)
    REFERENCES `rede_cinema_bd`.`Filme` (`CodFilme`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede_cinema_bd`.`Ingresso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede_cinema_bd`.`Ingresso` (
  `CodIngresso` INT NOT NULL,
  `FK_CodShopping` INT NULL,
  `FK_CodFilme` INT NULL,
  `FK_CodSala` INT NULL,
  `dataHora_Venda` DATETIME NULL,
  `dataHora_Exibicao` DATETIME NULL,
  `tipo` VARCHAR(45) NULL,
  `valor` INT NULL,
  `formaPagamento` VARCHAR(45) NULL,
  PRIMARY KEY (`CodIngresso`),
  INDEX `fk_Ingresso_Shopping1_idx` (`FK_CodShopping` ASC) VISIBLE,
  INDEX `fk_Ingresso_Sessao1_idx` (`FK_CodFilme` ASC, `FK_CodSala` ASC) VISIBLE,
  CONSTRAINT `fk_Ingresso_Shopping1`
    FOREIGN KEY (`FK_CodShopping`)
    REFERENCES `rede_cinema_bd`.`Shopping` (`CodShopping`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Ingresso_Sessao1`
    FOREIGN KEY (`FK_CodFilme` , `FK_CodSala`)
    REFERENCES `rede_cinema_bd`.`Sessao` (`FK_CodFilme` , `FK_CodSala`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede_cinema_bd`.`Propaganda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede_cinema_bd`.`Propaganda` (
  `CodPropaganda` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `agencia` INT NULL,
  `faixaEtaria` VARCHAR(45) NULL,
  PRIMARY KEY (`CodPropaganda`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede_cinema_bd`.`Propaganda_has_Sessao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede_cinema_bd`.`Propaganda_has_Sessao` (
  `FK_CodPropaganda` INT NOT NULL,
  `FK_CodSala` INT NOT NULL,
  `FK_CodFilme` INT NOT NULL,
  PRIMARY KEY (`FK_CodPropaganda`, `FK_CodSala`, `FK_CodFilme`),
  INDEX `fk_Propaganda_has_Sessao_Sessao1_idx` (`FK_CodFilme` ASC, `FK_CodSala` ASC) VISIBLE,
  INDEX `fk_Propaganda_has_Sessao_Propaganda1_idx` (`FK_CodPropaganda` ASC) VISIBLE,
  CONSTRAINT `fk_Propaganda_has_Sessao_Propaganda1`
    FOREIGN KEY (`FK_CodPropaganda`)
    REFERENCES `rede_cinema_bd`.`Propaganda` (`CodPropaganda`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Propaganda_has_Sessao_Sessao1`
    FOREIGN KEY (`FK_CodFilme` , `FK_CodSala`)
    REFERENCES `rede_cinema_bd`.`Sessao` (`FK_CodFilme` , `FK_CodSala`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede_cinema_bd`.`Indicacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede_cinema_bd`.`Indicacao` (
  `CodIndicacao` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`CodIndicacao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede_cinema_bd`.`Premiacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede_cinema_bd`.`Premiacao` (
  `CodPremiacao` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`CodPremiacao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede_cinema_bd`.`Filme_has_Indicacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede_cinema_bd`.`Filme_has_Indicacao` (
  `FK_CodFilme` INT NOT NULL,
  `FK_CodIndicacao` INT NOT NULL,
  PRIMARY KEY (`FK_CodFilme`, `FK_CodIndicacao`),
  INDEX `fk_Filme_has_Indicacao_Indicacao1_idx` (`FK_CodIndicacao` ASC) VISIBLE,
  INDEX `fk_Filme_has_Indicacao_Filme1_idx` (`FK_CodFilme` ASC) VISIBLE,
  CONSTRAINT `fk_Filme_has_Indicacao_Filme1`
    FOREIGN KEY (`FK_CodFilme`)
    REFERENCES `rede_cinema_bd`.`Filme` (`CodFilme`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Filme_has_Indicacao_Indicacao1`
    FOREIGN KEY (`FK_CodIndicacao`)
    REFERENCES `rede_cinema_bd`.`Indicacao` (`CodIndicacao`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede_cinema_bd`.`Filme_has_Premiacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede_cinema_bd`.`Filme_has_Premiacao` (
  `FK_CodFilme` INT NOT NULL,
  `FK_CodPremiacao` INT NOT NULL,
  PRIMARY KEY (`FK_CodFilme`, `FK_CodPremiacao`),
  INDEX `fk_Filme_has_Premiacao_Premiacao1_idx` (`FK_CodPremiacao` ASC) VISIBLE,
  INDEX `fk_Filme_has_Premiacao_Filme1_idx` (`FK_CodFilme` ASC) VISIBLE,
  CONSTRAINT `fk_Filme_has_Premiacao_Filme1`
    FOREIGN KEY (`FK_CodFilme`)
    REFERENCES `rede_cinema_bd`.`Filme` (`CodFilme`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Filme_has_Premiacao_Premiacao1`
    FOREIGN KEY (`FK_CodPremiacao`)
    REFERENCES `rede_cinema_bd`.`Premiacao` (`CodPremiacao`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede_cinema_bd`.`Gerente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede_cinema_bd`.`Gerente` (
  `CodGerente` INT NOT NULL,
  `FK_N_CarteiraTrabalho` INT NOT NULL,
  PRIMARY KEY (`CodGerente`, `FK_N_CarteiraTrabalho`),
  INDEX `fk_Gerente_Funcionario1_idx` (`FK_N_CarteiraTrabalho` ASC) VISIBLE,
  CONSTRAINT `fk_Gerente_Funcionario1`
    FOREIGN KEY (`FK_N_CarteiraTrabalho`)
    REFERENCES `rede_cinema_bd`.`Funcionario` (`N_CarteiraTrabalho`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rede_cinema_bd`.`Turno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rede_cinema_bd`.`Turno` (
  `CodTurno` INT NOT NULL,
  `FK_N_CarteiraTrabalho` INT NULL,
  `horaFinal` TIME NULL,
  `horaInicio` TIME NULL,
  PRIMARY KEY (`CodTurno`),
  INDEX `fk_Turno_Funcionario1_idx` (`FK_N_CarteiraTrabalho` ASC) VISIBLE,
  CONSTRAINT `fk_Turno_Funcionario1`
    FOREIGN KEY (`FK_N_CarteiraTrabalho`)
    REFERENCES `rede_cinema_bd`.`Funcionario` (`N_CarteiraTrabalho`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
