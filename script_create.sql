-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema new_schema
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema new_schema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `new_schema` DEFAULT CHARACTER SET utf8 ;
USE `new_schema` ;

-- -----------------------------------------------------
-- Table `new_schema`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema`.`client` (
  `client_id` INT NOT NULL AUTO_INCREMENT,
  `client_fname` VARCHAR(45) NOT NULL,
  `client_mname` VARCHAR(45) NOT NULL,
  `client_sname` VARCHAR(45) NOT NULL,
  `client_dateofbirth` DATE NOT NULL,
  `client_passport` VARCHAR(45) NOT NULL,
  `client_address` VARCHAR(45) NOT NULL,
  `client_phone` VARCHAR(45) NOT NULL,
  `client_email` VARCHAR(45) NULL,
  PRIMARY KEY (`client_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `new_schema`.`post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema`.`post` (
  `post_id` INT NOT NULL AUTO_INCREMENT,
  `post_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`post_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `new_schema`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema`.`employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `employee_fname` VARCHAR(45) NOT NULL,
  `employee_mname` VARCHAR(45) NOT NULL,
  `employee_sname` VARCHAR(45) NOT NULL,
  `employee_dateofbirth` DATE NOT NULL,
  `employee_passport` VARCHAR(45) NOT NULL,
  `employee_address` VARCHAR(45) NOT NULL,
  `employee_phone` VARCHAR(45) NOT NULL,
  `employee_email` VARCHAR(45) NOT NULL,
  `post_post_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `fk_employee_post_idx` (`post_post_id` ASC),
  CONSTRAINT `fk_employee_post`
    FOREIGN KEY (`post_post_id`)
    REFERENCES `new_schema`.`post` (`post_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `new_schema`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema`.`order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `order_date` DATETIME(6) NOT NULL,
  `exp_date` DATETIME(6) NOT NULL,
  `notes` VARCHAR(200) NOT NULL,
  `client_client_id` INT NOT NULL,
  `employee_employee_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_order_client1_idx` (`client_client_id` ASC),
  INDEX `fk_order_employee1_idx` (`employee_employee_id` ASC),
  CONSTRAINT `fk_order_client1`
    FOREIGN KEY (`client_client_id`)
    REFERENCES `new_schema`.`client` (`client_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_employee1`
    FOREIGN KEY (`employee_employee_id`)
    REFERENCES `new_schema`.`employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `new_schema`.`service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema`.`service` (
  `service_id` INT NOT NULL AUTO_INCREMENT,
  `service_name` VARCHAR(45) NOT NULL,
  `service_cost` DECIMAL(9,2) NOT NULL,
  PRIMARY KEY (`service_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `new_schema`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema`.`payment` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `order_order_id` INT NOT NULL,
  `pay_date` DATETIME(6) NOT NULL,
  `pay_summ` DECIMAL(9,2) NOT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `fk_payment_order1_idx` (`order_order_id` ASC),
  CONSTRAINT `fk_payment_order1`
    FOREIGN KEY (`order_order_id`)
    REFERENCES `new_schema`.`order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `new_schema`.`ordercontent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema`.`ordercontent` (
  `order_order_id` INT NOT NULL,
  `service_service_id` INT NOT NULL,
  `qnt` INT NOT NULL,
  PRIMARY KEY (`service_service_id`, `order_order_id`),
  INDEX `fk_ordercontent_order1_idx` (`order_order_id` ASC),
  INDEX `fk_ordercontent_service1_idx` (`service_service_id` ASC),
  CONSTRAINT `fk_ordercontent_order1`
    FOREIGN KEY (`order_order_id`)
    REFERENCES `new_schema`.`order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ordercontent_service1`
    FOREIGN KEY (`service_service_id`)
    REFERENCES `new_schema`.`service` (`service_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
