-- MySQL Workbench Forward Engineering
-- drop schema mydb;


SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`game_Data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`game_Data` (
  `game_id` INT NOT NULL,
  `game_title` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`game_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user_Data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user_Data` (
  `user_id` VARCHAR(50) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `user_name` VARCHAR(50) NOT NULL,
  `user_email` VARCHAR(128) NOT NULL,
  `res_data` DATE NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`barket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`barket` (
  `user_Data_user_id` VARCHAR(50) NOT NULL,
  `game_Data_game_id` INT NOT NULL,
  PRIMARY KEY (`user_Data_user_id`, `game_Data_game_id`),
  INDEX `fk_barket_game_Data1_idx` (`game_Data_game_id` ASC) VISIBLE,
  CONSTRAINT `fk_barket_user_Data`
    FOREIGN KEY (`user_Data_user_id`)
    REFERENCES `mydb`.`user_Data` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_barket_game_Data1`
    FOREIGN KEY (`game_Data_game_id`)
    REFERENCES `mydb`.`game_Data` (`game_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`recnet_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`recnet_view` (
  `user_Data_user_id` VARCHAR(50) NOT NULL,
  `game_Data_game_id` INT NOT NULL,
  `view_time` DATE NOT NULL,
  INDEX `fk_recnet_view_user_Data1_idx` (`user_Data_user_id` ASC) VISIBLE,
  INDEX `fk_recnet_view_game_Data1_idx` (`game_Data_game_id` ASC) VISIBLE,
  PRIMARY KEY (`user_Data_user_id`, `game_Data_game_id`),
  CONSTRAINT `fk_recnet_view_user_Data1`
    FOREIGN KEY (`user_Data_user_id`)
    REFERENCES `mydb`.`user_Data` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recnet_view_game_Data1`
    FOREIGN KEY (`game_Data_game_id`)
    REFERENCES `mydb`.`game_Data` (`game_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`game_review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`game_review` (
  `review_id` INT NOT NULL AUTO_INCREMENT,
  `game_Data_game_id` INT NOT NULL,
  `user_Data_user_id` VARCHAR(50) NOT NULL,
  `review_text` MEDIUMTEXT NOT NULL,
  `review_Date` DATE NOT NULL,
  `review_open` TINYINT NOT NULL,
  `review_reject_reason` VARCHAR(512) NULL,
  INDEX `fk_game_review_user_Data1_idx` (`user_Data_user_id` ASC) VISIBLE,
  PRIMARY KEY (`review_id`),
  CONSTRAINT `fk_game_review_game_Data1`
    FOREIGN KEY (`game_Data_game_id`)
    REFERENCES `mydb`.`game_Data` (`game_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_game_review_user_Data1`
    FOREIGN KEY (`user_Data_user_id`)
    REFERENCES `mydb`.`user_Data` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`game_rank`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`game_rank` (
  `game_Data_game_id` INT NOT NULL,
  `rank` INT NOT NULL,
  PRIMARY KEY (`game_Data_game_id`),
  CONSTRAINT `fk_game_rank_game_Data1`
    FOREIGN KEY (`game_Data_game_id`)
    REFERENCES `mydb`.`game_Data` (`game_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

create table news(
	news_id int not null auto_increment,
	headline varchar(50) not null,
    	news_url varchar(256) not null,
	news_time DATETIME not null,
    	primary key(news_id)
)ENGINE = InnoDB;

create table sale_info(
	sale_id int not null auto_increment,
    sale_title varchar(50) not null,
    sale_start date,
    sale_end date,
    primary key(sale_id)
)ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
