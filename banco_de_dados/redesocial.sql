-- MySQL Script generated by MySQL Workbench
-- 08/18/17 23:26:27
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema redesocial
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema redesocial
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `redesocial` DEFAULT CHARACTER SET utf8 ;
USE `redesocial` ;

-- -----------------------------------------------------
-- Table `redesocial`.`albuns`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `redesocial`.`albuns` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `data` DATETIME NOT NULL,
  `usuario` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Albuns_Usuarios_idx` (`usuario` ASC),
  CONSTRAINT `fk_Albuns_Usuarios`
    FOREIGN KEY (`usuario`)
    REFERENCES `redesocial`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `redesocial`.`multimidias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `redesocial`.`multimidias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `midia` BLOB NOT NULL,
  `tipo_conteudo` VARCHAR(20) NOT NULL,
  `data` DATETIME NOT NULL,
  `album` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Multimidias_Albuns1_idx` (`album` ASC),
  CONSTRAINT `fk_Multimidias_Albuns1`
    FOREIGN KEY (`album`)
    REFERENCES `redesocial`.`albuns` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `redesocial`.`paises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `redesocial`.`paises` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `redesocial`.`estados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `redesocial`.`estados` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(90) NOT NULL,
  `pais` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Estados_Paises1_idx` (`pais` ASC),
  CONSTRAINT `fk_Estados_Paises1`
    FOREIGN KEY (`pais`)
    REFERENCES `redesocial`.`paises` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `redesocial`.`cidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `redesocial`.`cidades` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(90) NOT NULL,
  `estado` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Cidades_Estados1_idx` (`estado` ASC),
  CONSTRAINT `fk_Cidades_Estados1`
    FOREIGN KEY (`estado`)
    REFERENCES `redesocial`.`estados` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `redesocial`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `redesocial`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(200) NOT NULL,
  `email` VARCHAR(200) NOT NULL,
  `telefone` VARCHAR(18) NULL,
  `senha` CHAR(32) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `data_cadastro` DATETIME NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 1,
  `foto` INT NULL,
  `cidade` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Usuarios_Multimidias1_idx` (`foto` ASC),
  INDEX `fk_Usuarios_Cidades1_idx` (`cidade` ASC),
  CONSTRAINT `fk_Usuarios_Multimidias1`
    FOREIGN KEY (`foto`)
    REFERENCES `redesocial`.`multimidias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_Cidades1`
    FOREIGN KEY (`cidade`)
    REFERENCES `redesocial`.`cidades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `redesocial`.`postagens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `redesocial`.`postagens` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `curtidas` INT NOT NULL,
  `descricao` TEXT NOT NULL,
  `data` DATETIME NOT NULL,
  `usuario` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_postagens_usuarios1_idx` (`usuario` ASC),
  CONSTRAINT `fk_postagens_usuarios1`
    FOREIGN KEY (`usuario`)
    REFERENCES `redesocial`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `redesocial`.`comentarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `redesocial`.`comentarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` TEXT NOT NULL,
  `curtidas` INT NOT NULL,
  `data` DATETIME NOT NULL,
  `postagem` INT NOT NULL,
  `resposta` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Comentarios_Postagens1_idx` (`postagem` ASC),
  INDEX `fk_Comentarios_Comentarios1_idx` (`resposta` ASC),
  CONSTRAINT `fk_Comentarios_Postagens1`
    FOREIGN KEY (`postagem`)
    REFERENCES `redesocial`.`postagens` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comentarios_Comentarios1`
    FOREIGN KEY (`resposta`)
    REFERENCES `redesocial`.`comentarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `redesocial`.`postagens_multimidias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `redesocial`.`postagens_multimidias` (
  `postagem` INT NOT NULL,
  `multimidia` INT NOT NULL,
  PRIMARY KEY (`postagem`, `multimidia`),
  INDEX `fk_Postagens_has_Multimidias_Multimidias1_idx` (`multimidia` ASC),
  INDEX `fk_Postagens_has_Multimidias_Postagens1_idx` (`postagem` ASC),
  CONSTRAINT `fk_Postagens_has_Multimidias_Postagens1`
    FOREIGN KEY (`postagem`)
    REFERENCES `redesocial`.`postagens` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Postagens_has_Multimidias_Multimidias1`
    FOREIGN KEY (`multimidia`)
    REFERENCES `redesocial`.`multimidias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `redesocial`.`postagens_albuns`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `redesocial`.`postagens_albuns` (
  `postagem` INT NOT NULL,
  `album` INT NOT NULL,
  PRIMARY KEY (`postagem`, `album`),
  INDEX `fk_Postagens_has_Albuns_Albuns1_idx` (`album` ASC),
  INDEX `fk_Postagens_has_Albuns_Postagens1_idx` (`postagem` ASC),
  CONSTRAINT `fk_Postagens_has_Albuns_Postagens1`
    FOREIGN KEY (`postagem`)
    REFERENCES `redesocial`.`postagens` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Postagens_has_Albuns_Albuns1`
    FOREIGN KEY (`album`)
    REFERENCES `redesocial`.`albuns` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `redesocial`.`grupos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `redesocial`.`grupos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  `data_criacao` DATETIME NOT NULL,
  `descricao` TEXT(400) NOT NULL,
  `privacidade` INT NOT NULL,
  `tipo` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `redesocial`.`participantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `redesocial`.`participantes` (
  `grupo` INT NOT NULL,
  `usuario` INT NOT NULL,
  `cargo` INT NOT NULL,
  PRIMARY KEY (`grupo`, `usuario`),
  INDEX `fk_grupos_has_usuarios_usuarios1_idx` (`usuario` ASC),
  INDEX `fk_grupos_has_usuarios_grupos1_idx` (`grupo` ASC),
  CONSTRAINT `fk_grupos_has_usuarios_grupos1`
    FOREIGN KEY (`grupo`)
    REFERENCES `redesocial`.`grupos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupos_has_usuarios_usuarios1`
    FOREIGN KEY (`usuario`)
    REFERENCES `redesocial`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
