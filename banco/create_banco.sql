-- MySQL Script generated by MySQL Workbench
-- Qua 06 Jul 2016 01:05:42 BRT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema bd_deliverall
-- -----------------------------------------------------

DROP DATABASE IF EXISTS `bd_deliverall`;
CREATE SCHEMA IF NOT EXISTS `bd_deliverall` DEFAULT CHARACTER SET utf8 ;
USE `bd_deliverall` ;

DROP USER IF EXISTS 'bd_deliverall'@'localhost';
CREATE USER 'bd_deliverall'@'localhost' identified by '@senha_bd_deliverall';
GRANT ALL PRIVILEGES ON bd_deliverall.* TO 'bd_deliverall'@'localhost';

-- -----------------------------------------------------
-- Table `bd_deliverall`.`admins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_deliverall`.`admins` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd_deliverall`.`estados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_deliverall`.`estados` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd_deliverall`.`cidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_deliverall`.`cidades` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(120) NOT NULL,
  `estado_id` INT NOT NULL,
  PRIMARY KEY (`id`, `estado_id`),
  INDEX `fk_cidades_estados1_idx` (`estado_id` ASC),
  CONSTRAINT `fk_cidades_estados1`
    FOREIGN KEY (`estado_id`)
    REFERENCES `bd_deliverall`.`estados` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd_deliverall`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_deliverall`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(80) NOT NULL,
  `email` VARCHAR(80) NOT NULL,
  `senha` VARCHAR(200) NOT NULL,
  `telefone1` VARCHAR(45) NULL,
  `telefone2` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd_deliverall`.`gerentes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_deliverall`.`gerentes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(80) NOT NULL,
  `email` VARCHAR(80) NOT NULL,
  `senha` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd_deliverall`.`restaurantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_deliverall`.`restaurantes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `cnpj` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NULL,
  `descricao` TEXT NULL,
  `foto` VARCHAR(255) NULL,
  `horario_abre` VARCHAR(5) NULL,
  `horario_fecha` VARCHAR(5) NULL,
  `tempo_mercado` VARCHAR(45) NULL,
  `valor_min` VARCHAR(45) NOT NULL,
  `telefone1` VARCHAR(45) NULL,
  `telefone2` VARCHAR(45) NULL,
  `gerente_id` INT NOT NULL,
  PRIMARY KEY (`id`, `gerente_id`),
  INDEX `fk_restaurante_gerente1_idx` (`gerente_id` ASC),
  CONSTRAINT `fk_restaurante_gerente1`
    FOREIGN KEY (`gerente_id`)
    REFERENCES `bd_deliverall`.`gerentes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd_deliverall`.`atendentes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_deliverall`.`atendentes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(80) NOT NULL,
  `email` VARCHAR(80) NOT NULL,
  `senha` VARCHAR(200) NOT NULL,
  `restaurante_id` INT NOT NULL,
  PRIMARY KEY (`id`, `restaurante_id`),
  INDEX `fk_atendente_restaurante1_idx` (`restaurante_id` ASC),
  CONSTRAINT `fk_atendente_restaurante1`
    FOREIGN KEY (`restaurante_id`)
    REFERENCES `bd_deliverall`.`restaurantes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd_deliverall`.`produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_deliverall`.`produtos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(200) NOT NULL,
  `tipo` INT NULL,
  `descricao` VARCHAR(150) NULL,
  `preco` DOUBLE NOT NULL,
  `foto` VARCHAR(45) NULL,
  `qtd_max_complemento` INT NULL,
  `restaurante_id` INT NOT NULL,
  PRIMARY KEY (`id`, `restaurante_id`),
  INDEX `fk_produto_restaurante_idx` (`restaurante_id` ASC),
  CONSTRAINT `fk_produto_restaurante`
    FOREIGN KEY (`restaurante_id`)
    REFERENCES `bd_deliverall`.`restaurantes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd_deliverall`.`sugestaos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_deliverall`.`sugestaos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_restaurante` VARCHAR(45) NOT NULL,
  `mensagem` VARCHAR(255) NULL,
  `tel_restaurante` VARCHAR(45) NULL,
  `cliente_id` INT NOT NULL,
  PRIMARY KEY (`id`, `cliente_id`),
  INDEX `fk_sugestao_cliente1_idx` (`cliente_id` ASC),
  CONSTRAINT `fk_sugestao_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `bd_deliverall`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd_deliverall`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_deliverall`.`pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `total` DOUBLE NOT NULL,
  `status` INT NOT NULL,
  `data` DATE NOT NULL,
  `cliente_id` INT NOT NULL,
  PRIMARY KEY (`id`, `cliente_id`),
  INDEX `fk_pedido_cliente1_idx` (`cliente_id` ASC),
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `bd_deliverall`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd_deliverall`.`enderecos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_deliverall`.`enderecos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rua` VARCHAR(100) NOT NULL,
  `numero` INT NOT NULL,
  `bairro` VARCHAR(60) NOT NULL,
  `complemento` VARCHAR(60) NULL,
  `cep` VARCHAR(15) NOT NULL,
  `tipo` INT NOT NULL,
  `cidade_id` INT NOT NULL,
  PRIMARY KEY (`id`, `cidade_id`),
  INDEX `fk_endereços_cidades1_idx` (`cidade_id` ASC),
  CONSTRAINT `fk_endereços_cidades1`
    FOREIGN KEY (`cidade_id`)
    REFERENCES `bd_deliverall`.`cidades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd_deliverall`.`classificacaos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_deliverall`.`classificacaos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nota` DOUBLE NOT NULL,
  `comentario` VARCHAR(120) NULL,
  `restaurante_id` INT NOT NULL,
  `cliente_id` INT NOT NULL,
  PRIMARY KEY (`id`, `restaurante_id`, `cliente_id`),
  INDEX `fk_classificacao_restaurante1_idx` (`restaurante_id` ASC),
  INDEX `fk_classificacao_cliente1_idx` (`cliente_id` ASC),
  CONSTRAINT `fk_classificacao_restaurante1`
    FOREIGN KEY (`restaurante_id`)
    REFERENCES `bd_deliverall`.`restaurantes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_classificacao_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `bd_deliverall`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd_deliverall`.`complementos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_deliverall`.`complementos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `tipo` INT NOT NULL,
  `descricao` VARCHAR(80) NOT NULL,
  `preco` DOUBLE NOT NULL,
  `produto_id` INT NOT NULL,
  PRIMARY KEY (`id`, `produto_id`),
  INDEX `fk_complemento_produto1_idx` (`produto_id` ASC),
  CONSTRAINT `fk_complemento_produto1`
    FOREIGN KEY (`produto_id`)
    REFERENCES `bd_deliverall`.`produtos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd_deliverall`.`tipo_culinarias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_deliverall`.`culinarias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo` INT NOT NULL,
  `restaurante_id` INT NOT NULL,
  PRIMARY KEY (`id`, `restaurante_id`),
  INDEX `fk_tipoCulinarias_restaurantes1_idx` (`restaurante_id` ASC),
  CONSTRAINT `fk_tipoCulinarias_restaurantes1`
    FOREIGN KEY (`restaurante_id`)
    REFERENCES `bd_deliverall`.`restaurantes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd_deliverall`.`forma_pagamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_deliverall`.`pagamentos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(80) NOT NULL,
  `restaurante_id` INT NOT NULL,
  PRIMARY KEY (`id`, `restaurante_id`),
  INDEX `fk_formasPagamentos_restaurantes1_idx` (`restaurante_id` ASC),
  CONSTRAINT `fk_formasPagamentos_restaurantes1`
    FOREIGN KEY (`restaurante_id`)
    REFERENCES `bd_deliverall`.`restaurantes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd_deliverall`.`pedidos_produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_deliverall`.`pedido_produtos` (
  `pedido_id` INT NOT NULL,
  `produto_id` INT NOT NULL,
  `qtd` INT NOT NULL,
  PRIMARY KEY (`pedido_id`, `produto_id`),
  INDEX `fk_pedidos_has_produtos_produtos1_idx` (`produto_id` ASC),
  INDEX `fk_pedidos_has_produtos_pedidos1_idx` (`pedido_id` ASC),
  CONSTRAINT `fk_pedidos_has_produtos_pedidos1`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `bd_deliverall`.`pedidos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_has_produtos_produtos1`
    FOREIGN KEY (`produto_id`)
    REFERENCES `bd_deliverall`.`produtos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd_deliverall`.`clientes_enderecos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_deliverall`.`cliente_enderecos` (
  `cliente_id` INT NOT NULL,
  `endereco_id` INT NOT NULL,
  PRIMARY KEY (`cliente_id`, `endereco_id`),
  INDEX `fk_clientes_has_enderecos_enderecos1_idx` (`endereco_id` ASC),
  INDEX `fk_clientes_has_enderecos_clientes1_idx` (`cliente_id` ASC),
  CONSTRAINT `fk_clientes_has_enderecos_clientes1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `bd_deliverall`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clientes_has_enderecos_enderecos1`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `bd_deliverall`.`enderecos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd_deliverall`.`enderecos_restaurantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_deliverall`.`restaurante_enderecos` (
  `endereco_id` INT NOT NULL,
  `restaurante_id` INT NOT NULL,
  PRIMARY KEY (`endereco_id`, `restaurante_id`),
  INDEX `fk_enderecos_has_restaurantes_restaurantes1_idx` (`restaurante_id` ASC),
  INDEX `fk_enderecos_has_restaurantes_enderecos1_idx` (`endereco_id` ASC),
  CONSTRAINT `fk_enderecos_has_restaurantes_enderecos1`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `bd_deliverall`.`enderecos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_enderecos_has_restaurantes_restaurantes1`
    FOREIGN KEY (`restaurante_id`)
    REFERENCES `bd_deliverall`.`restaurantes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd_deliverall`.`promocaos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_deliverall`.`promocaos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `restaurante_id` INT NOT NULL,
  `produto_id` INT NOT NULL,
  `data_ini` DATE NOT NULL,
  `data_fim` DATE NOT NULL,
  `desconto` INT NOT NULL,
  `tipo` INT NOT NULL,
  PRIMARY KEY (`id`, `restaurante_id`, `produto_id`),
  INDEX `fk_promocaos_produtos1_idx` (`produto_id` ASC),
  INDEX `fk_promocaos_restaurantes1_idx` (`restaurante_id` ASC),
  CONSTRAINT `fk_promocaos_restaurantes1`
    FOREIGN KEY (`restaurante_id`)
    REFERENCES `bd_deliverall`.`pedidos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_promocaos_produtos1`
    FOREIGN KEY (`produto_id`)
    REFERENCES `bd_deliverall`.`produtos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

ALTER TABLE `bd_deliverall`.`promocaos` 
DROP FOREIGN KEY `fk_promocaos_restaurantes1`;

ALTER TABLE `bd_deliverall`.`classificacaos` 
CHANGE COLUMN `comentario` `comentario` VARCHAR(250) NULL DEFAULT NULL COMMENT '' ;

ALTER TABLE `bd_deliverall`.`enderecos` 
CHANGE COLUMN `rua` `rua` VARCHAR(100) NULL DEFAULT NULL COMMENT '' ,
CHANGE COLUMN `numero` `numero` INT(11) NULL DEFAULT NULL COMMENT '' ,
CHANGE COLUMN `bairro` `bairro` VARCHAR(60) NULL DEFAULT NULL COMMENT '' ,
CHANGE COLUMN `cep` `cep` VARCHAR(15) NULL DEFAULT NULL COMMENT '' ,
CHANGE COLUMN `tipo` `tipo` INT(11) NULL DEFAULT NULL COMMENT '' ;

ALTER TABLE `bd_deliverall`.`promocaos` 
DROP COLUMN `tipo`,
DROP COLUMN `restaurante_id`,
CHANGE COLUMN `data_ini` `data_ini` DATE NULL DEFAULT NULL COMMENT '' ,
CHANGE COLUMN `data_fim` `data_fim` DATE NULL DEFAULT NULL COMMENT '' ,
CHANGE COLUMN `desconto` `desconto` INT(11) NULL DEFAULT NULL COMMENT '' ,
ADD COLUMN `restaurante_id` INT(11) NOT NULL COMMENT '' AFTER `desconto`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id`, `produto_id`, `restaurante_id`)  COMMENT '',
ADD INDEX `fk_promocaos_restaurantes1_idx` (`restaurante_id` ASC)  COMMENT '',
DROP INDEX `fk_promocaos_restaurantes1_idx` ;

ALTER TABLE `bd_deliverall`.`restaurantes` 
ADD COLUMN `franqueado_id` INT(11) NOT NULL COMMENT '' AFTER `gerente_id`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id`, `gerente_id`, `franqueado_id`)  COMMENT '',
ADD INDEX `fk_restaurantes_franqueados1_idx` (`franqueado_id` ASC)  COMMENT '';

ALTER TABLE `bd_deliverall`.`sugestaos` 
CHANGE COLUMN `nome_restaurante` `nome_restaurante` VARCHAR(120) NOT NULL COMMENT '' ,
CHANGE COLUMN `mensagem` `mensagem` TEXT NULL DEFAULT NULL COMMENT '' ;

CREATE TABLE IF NOT EXISTS `bd_deliverall`.`franqueados` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(200) NULL DEFAULT NULL COMMENT '',
  `email` VARCHAR(80) NULL DEFAULT NULL COMMENT '',
  `senha` VARCHAR(128) NULL DEFAULT NULL COMMENT '',
  `telefone1` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `telefone2` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

ALTER TABLE `bd_deliverall`.`promocaos` 
ADD CONSTRAINT `fk_promocaos_restaurantes1`
  FOREIGN KEY (`restaurante_id`)
  REFERENCES `bd_deliverall`.`restaurantes` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `bd_deliverall`.`restaurantes` 
ADD CONSTRAINT `fk_restaurantes_franqueados1`
  FOREIGN KEY (`franqueado_id`)
  REFERENCES `bd_deliverall`.`franqueados` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

CREATE TABLE IF NOT EXISTS `bd_deliverall`.`franqueado_enderecos` (
  `endereco_id` INT(11) NOT NULL COMMENT '',
  `franqueado_id` INT(11) NOT NULL COMMENT '',
  PRIMARY KEY (`endereco_id`, `franqueado_id`)  COMMENT '',
  INDEX `fk_clientes_has_enderecos_enderecos1_idx` (`endereco_id` ASC)  COMMENT '',
  INDEX `fk_franqueado_enderecos_franqueados1_idx` (`franqueado_id` ASC)  COMMENT '',
  CONSTRAINT `fk_clientes_has_enderecos_enderecos10`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `bd_deliverall`.`enderecos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_franqueado_enderecos_franqueados1`
    FOREIGN KEY (`franqueado_id`)
    REFERENCES `bd_deliverall`.`franqueados` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `bd_deliverall`.`produto_complementos` (
  `qtd` INT(11) NOT NULL COMMENT '',
  `pedido_id` INT(11) NOT NULL COMMENT '',
  `produto_id` INT(11) NOT NULL COMMENT '',
  `complemento_id` INT(11) NOT NULL COMMENT '',
  PRIMARY KEY (`pedido_id`, `produto_id`, `complemento_id`)  COMMENT '',
  INDEX `fk_produto_complementos_produtos1_idx` (`produto_id` ASC)  COMMENT '',
  INDEX `fk_produto_complementos_complementos1_idx` (`complemento_id` ASC)  COMMENT '',
  CONSTRAINT `fk_produto_complementos_pedidos1`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `bd_deliverall`.`pedidos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_complementos_produtos1`
    FOREIGN KEY (`produto_id`)
    REFERENCES `bd_deliverall`.`produtos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_complementos_complementos1`
    FOREIGN KEY (`complemento_id`)
    REFERENCES `bd_deliverall`.`complementos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

ALTER TABLE `bd_deliverall`.`promocaos` 
CHANGE COLUMN `produto_id` `produto_id` INT(11) NOT NULL COMMENT '' AFTER `desconto`;
ALTER TABLE `bd_deliverall`.`pedidos` 
ADD COLUMN `endereco_id` INT(11) NOT NULL COMMENT '' AFTER `cliente_id`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id`, `cliente_id`, `endereco_id`)  COMMENT '',
ADD INDEX `fk_pedidos_enderecos1_idx` (`endereco_id` ASC)  COMMENT '';
ALTER TABLE `bd_deliverall`.`pedidos` 
ADD CONSTRAINT `fk_pedidos_enderecos1`
  FOREIGN KEY (`endereco_id`)
  REFERENCES `bd_deliverall`.`enderecos` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `bd_deliverall`.`pedidos` 
ADD COLUMN `restaurante_id` INT(11) NOT NULL COMMENT '' AFTER `endereco_id`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id`, `cliente_id`, `endereco_id`, `restaurante_id`)  COMMENT '',
ADD INDEX `fk_pedidos_restaurantes1_idx` (`restaurante_id` ASC)  COMMENT '';
ALTER TABLE `bd_deliverall`.`pedidos` 
ADD CONSTRAINT `fk_pedidos_restaurantes1`
  FOREIGN KEY (`restaurante_id`)
  REFERENCES `bd_deliverall`.`restaurantes` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `bd_deliverall`.`complementos` 
DROP COLUMN `tipo`;

ALTER TABLE `bd_deliverall`.`enderecos` 
DROP COLUMN `tipo`;

ALTER TABLE `bd_deliverall`.`culinarias` 
CHANGE COLUMN `tipo` `tipo` VARCHAR(45) NOT NULL;

ALTER TABLE `bd_deliverall`.`produtos` 
CHANGE COLUMN `tipo` `tipo` VARCHAR(45) NULL DEFAULT NULL;

/* --------------------------------------------------------------------- */
/* adição do troco e relação com forma de pagamento na tabela de pedidos */

ALTER TABLE `bd_deliverall`.`pedidos` 
ADD COLUMN `troco` DOUBLE NULL DEFAULT NULL COMMENT '' AFTER `data`,
ADD COLUMN `pagamento_id` INT(11) NOT NULL COMMENT '' AFTER `restaurante_id`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id`, `cliente_id`, `endereco_id`, `restaurante_id`, `pagamento_id`)  COMMENT '',
ADD INDEX `fk_pedidos_pagamentos1_idx` (`pagamento_id` ASC)  COMMENT '';

ALTER TABLE `bd_deliverall`.`pedidos` 
ADD CONSTRAINT `fk_pedidos_pagamentos1`
  FOREIGN KEY (`pagamento_id`)
  REFERENCES `bd_deliverall`.`pagamentos` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

/* --------------------------------------------------------------------- */

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
