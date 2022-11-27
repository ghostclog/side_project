-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema SIDE_PROJECT
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema SIDE_PROJECT
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SIDE_PROJECT` DEFAULT CHARACTER SET utf8 ;
USE `SIDE_PROJECT` ;

-- -----------------------------------------------------
-- Table `SIDE_PROJECT`.`USER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIDE_PROJECT`.`USER` (
  `USER_ID` VARCHAR(50) NOT NULL,
  `PASSWORD` VARCHAR(50) NOT NULL,
  `USER_NAME` VARCHAR(50) NOT NULL,
  `EMAIL` VARCHAR(50) NOT NULL,
  `USER_CODE` INT(6) NOT NULL COMMENT 'ALTER TABLE 사용해서 AUTO INCREMENT 추가해야함',
  `REGIST_DATE` DATE NOT NULL,
  PRIMARY KEY (`USER_ID`),
  UNIQUE INDEX `USER_ID_UNIQUE` (`USER_ID` ASC) VISIBLE,
  UNIQUE INDEX `USER_CODE_UNIQUE` (`USER_CODE` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SIDE_PROJECT`.`CODE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIDE_PROJECT`.`CODE` (
  `CODE_ID` VARCHAR(50) NOT NULL COMMENT '학교 DB시간에 나오는것처럼 약어 혹은 축약어로 제작',
  `CODE_NAME` VARCHAR(50) NOT NULL,
  `CODE_TYPE` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`CODE_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SIDE_PROJECT`.`GAME`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIDE_PROJECT`.`GAME` (
  `ENG_NAME` VARCHAR(50) NOT NULL,
  `KOR_NAME` VARCHAR(50) NOT NULL,
  `GMAE_INFO` TEXT(10000) NOT NULL,
  `CODE_TYPE` TEXT(256) NULL,
  `PUBLSH_DATE` DATE NOT NULL,
  `MIN_SPEC` TEXT(128) NOT NULL,
  `SEPC` TEXT(128) NOT NULL,
  `DEFAULT_PRICE` INT(32) NOT NULL,
  `DEVELOPER` VARCHAR(50) NOT NULL,
  `PUBLISHER` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ENG_NAME`),
  UNIQUE INDEX `ENG_NAME_UNIQUE` (`ENG_NAME` ASC) VISIBLE,
  INDEX `fk_GAME_table12_idx` (`DEVELOPER` ASC) VISIBLE,
  INDEX `fk_GAME_table13_idx` (`PUBLISHER` ASC) VISIBLE,
  CONSTRAINT `fk_GAME_table12`
    FOREIGN KEY (`DEVELOPER`)
    REFERENCES `SIDE_PROJECT`.`CODE` (`CODE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GAME_table13`
    FOREIGN KEY (`PUBLISHER`)
    REFERENCES `SIDE_PROJECT`.`CODE` (`CODE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SIDE_PROJECT`.`BARKET`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIDE_PROJECT`.`BARKET` (
  `USER_USER_ID` VARCHAR(50) NOT NULL,
  `GAME_ENG_NAME` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`USER_USER_ID`, `GAME_ENG_NAME`),
  INDEX `fk_BARKET_GAME1_idx` (`GAME_ENG_NAME` ASC) VISIBLE,
  CONSTRAINT `fk_BARKET_USER`
    FOREIGN KEY (`USER_USER_ID`)
    REFERENCES `SIDE_PROJECT`.`USER` (`USER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BARKET_GAME1`
    FOREIGN KEY (`GAME_ENG_NAME`)
    REFERENCES `SIDE_PROJECT`.`GAME` (`ENG_NAME`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SIDE_PROJECT`.`URL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIDE_PROJECT`.`URL` (
  `GAME_ENG_NAME` VARCHAR(50) NOT NULL,
  `CODE_CODE_ID` VARCHAR(50) NOT NULL,
  `URL` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`GAME_ENG_NAME`, `CODE_CODE_ID`),
  INDEX `fk_URL_table11_idx` (`CODE_CODE_ID` ASC) VISIBLE,
  INDEX `fk_URL_GAME1_idx` (`GAME_ENG_NAME` ASC) VISIBLE,
  CONSTRAINT `fk_URL_table11`
    FOREIGN KEY (`CODE_CODE_ID`)
    REFERENCES `SIDE_PROJECT`.`CODE` (`CODE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_URL_GAME1`
    FOREIGN KEY (`GAME_ENG_NAME`)
    REFERENCES `SIDE_PROJECT`.`GAME` (`ENG_NAME`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SIDE_PROJECT`.`PRICE_INFO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIDE_PROJECT`.`PRICE_INFO` (
  `CODE_CODE_ID` VARCHAR(50) NOT NULL,
  `URL` TEXT(512) NOT NULL,
  `STORE_PRICE` INT(32) NOT NULL,
  `GAME_ENG_NAME` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`CODE_CODE_ID`, `GAME_ENG_NAME`),
  INDEX `fk_PRICE_INFO_GAME1_idx` (`GAME_ENG_NAME` ASC) VISIBLE,
  CONSTRAINT `fk_table2_CODE1`
    FOREIGN KEY (`CODE_CODE_ID`)
    REFERENCES `SIDE_PROJECT`.`CODE` (`CODE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRICE_INFO_GAME1`
    FOREIGN KEY (`GAME_ENG_NAME`)
    REFERENCES `SIDE_PROJECT`.`GAME` (`ENG_NAME`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SIDE_PROJECT`.`REVIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIDE_PROJECT`.`REVIEW` (
  `USER_USER_ID` VARCHAR(50) NOT NULL,
  `REVIEW_CODE` VARCHAR(50) NOT NULL,
  `REVIEW_CONTENTS` TEXT(10000) NULL,
  `IMAGE` TEXT(512) NULL,
  `WRITE_TIME` DATE NOT NULL,
  `USER_RATE` INT(16) NOT NULL,
  `ON_OFF` TINYINT(1) NOT NULL,
  `NF_REASON` TEXT(128) NULL,
  `GAME_ENG_NAME` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`USER_USER_ID`, `REVIEW_CODE`, `GAME_ENG_NAME`),
  INDEX `fk_REVIEW_GAME1_idx` (`GAME_ENG_NAME` ASC) VISIBLE,
  CONSTRAINT `fk_REVIEW_USER1`
    FOREIGN KEY (`USER_USER_ID`)
    REFERENCES `SIDE_PROJECT`.`USER` (`USER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_REVIEW_GAME1`
    FOREIGN KEY (`GAME_ENG_NAME`)
    REFERENCES `SIDE_PROJECT`.`GAME` (`ENG_NAME`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SIDE_PROJECT`.`NEWS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIDE_PROJECT`.`NEWS` (
  `NEWS_ID` VARCHAR(50) NOT NULL,
  `NEWS_NAME` VARCHAR(50) NOT NULL,
  `NEWS_CONTENTS` TEXT(5000) NOT NULL,
  `NEWS_DATE` DATE NOT NULL,
  `GAME_ENG_NAME` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`NEWS_ID`, `GAME_ENG_NAME`),
  INDEX `fk_NEWS_GAME1_idx` (`GAME_ENG_NAME` ASC) VISIBLE,
  CONSTRAINT `fk_NEWS_GAME1`
    FOREIGN KEY (`GAME_ENG_NAME`)
    REFERENCES `SIDE_PROJECT`.`GAME` (`ENG_NAME`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SIDE_PROJECT`.`GAME_RATE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIDE_PROJECT`.`GAME_RATE` (
  `ROTTEN` INT(8) NOT NULL,
  `METACRIT` INT(8) NOT NULL,
  `GAME_ENG_NAME` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`GAME_ENG_NAME`),
  INDEX `fk_GAME_RATE_GAME1_idx` (`GAME_ENG_NAME` ASC) VISIBLE,
  CONSTRAINT `fk_GAME_RATE_GAME1`
    FOREIGN KEY (`GAME_ENG_NAME`)
    REFERENCES `SIDE_PROJECT`.`GAME` (`ENG_NAME`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SIDE_PROJECT`.`RANK`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIDE_PROJECT`.`RANK` (
  `GAME_ENG_NAME` VARCHAR(50) NOT NULL,
  `GAME_RANK` INT(8) NOT NULL,
  `GAME_IMAGE` TEXT(512) NOT NULL,
  PRIMARY KEY (`GAME_ENG_NAME`),
  CONSTRAINT `fk_RANK_GAME1`
    FOREIGN KEY (`GAME_ENG_NAME`)
    REFERENCES `SIDE_PROJECT`.`GAME` (`ENG_NAME`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SIDE_PROJECT`.`SALE_INFO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIDE_PROJECT`.`SALE_INFO` (
  `SAEL_CODE` VARCHAR(50) NOT NULL,
  `CODE_CODE_ID` VARCHAR(50) NOT NULL,
  `SALE_PRICE` INT(32) NOT NULL,
  `START_DATE` DATE NOT NULL,
  `END_DATE` DATE NOT NULL,
  `SALE_NAME` VARCHAR(50) NOT NULL,
  `GAME_ENG_NAME` VARCHAR(50) NULL,
  PRIMARY KEY (`SAEL_CODE`),
  INDEX `fk_SALE_INFO_CODE1_idx` (`CODE_CODE_ID` ASC) VISIBLE,
  INDEX `fk_SALE_INFO_GAME1_idx` (`GAME_ENG_NAME` ASC) VISIBLE,
  CONSTRAINT `fk_SALE_INFO_CODE1`
    FOREIGN KEY (`CODE_CODE_ID`)
    REFERENCES `SIDE_PROJECT`.`CODE` (`CODE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SALE_INFO_GAME1`
    FOREIGN KEY (`GAME_ENG_NAME`)
    REFERENCES `SIDE_PROJECT`.`GAME` (`ENG_NAME`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SIDE_PROJECT`.`RECENT_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIDE_PROJECT`.`RECENT_VIEW` (
  `USER_USER_ID` VARCHAR(50) NOT NULL,
  `VIEW_TIME` DATE NOT NULL,
  `RECENT_VIEWcol` VARCHAR(45) NULL,
  `GAME_ENG_NAME` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`USER_USER_ID`, `GAME_ENG_NAME`),
  INDEX `fk_RECENT_VIEW_GAME1_idx` (`GAME_ENG_NAME` ASC) VISIBLE,
  CONSTRAINT `fk_RECENT_VIEW_USER1`
    FOREIGN KEY (`USER_USER_ID`)
    REFERENCES `SIDE_PROJECT`.`USER` (`USER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RECENT_VIEW_GAME1`
    FOREIGN KEY (`GAME_ENG_NAME`)
    REFERENCES `SIDE_PROJECT`.`GAME` (`ENG_NAME`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SIDE_PROJECT`.`STAFF`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIDE_PROJECT`.`STAFF` (
  `STAFF_ID` VARCHAR(50) NOT NULL,
  `PASSWORD` VARCHAR(50) NOT NULL,
  `STAFF_NAME` VARCHAR(50) NOT NULL,
  `START_DATE` DATE NOT NULL,
  `STAFF_CODE` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`STAFF_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SIDE_PROJECT`.`AS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIDE_PROJECT`.`AS` (
  `USER_USER_ID` VARCHAR(50) NOT NULL,
  `ASCODE` INT(32) NOT NULL,
  `AS_CONTENTS` TEXT(10000) NOT NULL,
  `AS_CATEGORY` VARCHAR(50) NOT NULL,
  `REQUIRE_DATE` DATE NOT NULL,
  `ANSWER` TEXT(10000) NULL,
  `ANSWER_TIME` DATE NULL,
  `STAFF_STAFF_ID` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`USER_USER_ID`, `ASCODE`),
  INDEX `fk_AS_STAFF1_idx` (`STAFF_STAFF_ID` ASC) VISIBLE,
  CONSTRAINT `fk_MESSAGE_USER1`
    FOREIGN KEY (`USER_USER_ID`)
    REFERENCES `SIDE_PROJECT`.`USER` (`USER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AS_STAFF1`
    FOREIGN KEY (`STAFF_STAFF_ID`)
    REFERENCES `SIDE_PROJECT`.`STAFF` (`STAFF_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SIDE_PROJECT`.`MESSAGE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIDE_PROJECT`.`MESSAGE` (
  `USER_USER_ID` VARCHAR(50) NOT NULL,
  `MESSAGE_ID` VARCHAR(50) NOT NULL,
  `MESSAGE_CON` TEXT(5000) NOT NULL,
  `MESSAGE_CATE` VARCHAR(50) NOT NULL,
  `MESSAGE_DATE` DATE NOT NULL,
  PRIMARY KEY (`USER_USER_ID`),
  CONSTRAINT `fk_MESSAGE_USER2`
    FOREIGN KEY (`USER_USER_ID`)
    REFERENCES `SIDE_PROJECT`.`USER` (`USER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

alter table user modify USER_CODE int not null auto_increment;