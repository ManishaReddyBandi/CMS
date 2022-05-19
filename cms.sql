-- MySQL Workbench Forward Engineering

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
-- Table `mydb`.`Consultant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Consultant` (
  `Consultant_ID` INT NOT NULL,
  `Consultant_Name` VARCHAR(45) NULL,
  `Consultant_Contact` VARCHAR(45) NULL,
  `Consultant_Email` VARCHAR(45) NULL,
  `Consultant_Address` VARCHAR(45) NULL,
  `Consultant_City` VARCHAR(45) NULL,
  `Consultant_State` VARCHAR(45) NULL,
  PRIMARY KEY (`Consultant_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Client` (
  `Client_ID` INT NOT NULL,
  `Client_Name` VARCHAR(45) NULL,
  `Client_Contact_Name` VARCHAR(45) NULL,
  `Client_Contact_Mobile` VARCHAR(45) NULL,
  `Client_Contact_Email` VARCHAR(45) NULL,
  PRIMARY KEY (`Client_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Project` (
  `Project_ID` INT NOT NULL,
  `Project_Name` VARCHAR(45) NULL,
  `Project_Manager` VARCHAR(45) NULL,
  `Project_Location` VARCHAR(45) NULL,
  `Client_Client_ID` INT NOT NULL,
  PRIMARY KEY (`Project_ID`, `Client_Client_ID`),
  INDEX `fk_Project_Client1_idx` (`Client_Client_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Project_Client1`
    FOREIGN KEY (`Client_Client_ID`)
    REFERENCES `mydb`.`Client` (`Client_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Skill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Skill` (
  `Skill_ID` INT NOT NULL,
  `Skill_Name` VARCHAR(45) NULL,
  `Skill_Description` VARCHAR(60) NULL,
  PRIMARY KEY (`Skill_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Certification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Certification` (
  `Certification_ID` INT NOT NULL,
  `Certification_Name` VARCHAR(45) NULL,
  `Certification_Date` DATE NULL,
  `Level_Of_Certification` VARCHAR(45) NULL,
  `Skill_ID` INT NOT NULL,
  PRIMARY KEY (`Certification_ID`),
  INDEX `fk_Certification_Skill1_idx` (`Skill_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Certification_Skill1`
    FOREIGN KEY (`Skill_ID`)
    REFERENCES `mydb`.`Skill` (`Skill_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SubProject`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SubProject` (
  `SubProject_ID` INT NOT NULL,
  `SubProject_Name` VARCHAR(45) NULL,
  `Project_Description` VARCHAR(45) NULL,
  `SubProject_Lead` VARCHAR(45) NULL,
  `Project_ID` INT NOT NULL,
  PRIMARY KEY (`SubProject_ID`, `Project_ID`),
  INDEX `fk_SubProject_Project1_idx` (`Project_ID` ASC) VISIBLE,
  CONSTRAINT `fk_SubProject_Project1`
    FOREIGN KEY (`Project_ID`)
    REFERENCES `mydb`.`Project` (`Project_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Project_Consultant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Project_Consultant` (
  `Project_Consultant_ID` INT NULL,
  `Start_Date` DATE NOT NULL,
  `End_Date` DATE NOT NULL,
  `Evaluation_Date` DATE NOT NULL,
  `Person_Evaluted` VARCHAR(45) NOT NULL,
  `Evaluation_Score` VARCHAR(45) NOT NULL,
  `Comments` VARCHAR(45) NOT NULL,
  `Consultant_ID` INT NOT NULL,
  `Project_ID` INT NOT NULL,
  PRIMARY KEY (`Project_Consultant_ID`),
  INDEX `fk_Project_Consultant_Consultant_idx` (`Consultant_ID` ASC) VISIBLE,
  INDEX `fk_Project_Consultant_Project1_idx` (`Project_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Project_Consultant_Consultant`
    FOREIGN KEY (`Consultant_ID`)
    REFERENCES `mydb`.`Consultant` (`Consultant_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Project_Consultant_Project1`
    FOREIGN KEY (`Project_ID`)
    REFERENCES `mydb`.`Project` (`Project_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Consultant_Skill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Consultant_Skill` (
  `Consultant_ID` INT NOT NULL,
  `Skill_Duration` VARCHAR(45) NULL,
  `Consultant_ID` INT NOT NULL,
  `Skill_ID` INT NOT NULL,
  PRIMARY KEY (`Consultant_ID`),
  INDEX `fk_Consultant_Skill_Consultant1_idx` (`Consultant_ID` ASC) VISIBLE,
  INDEX `fk_Consultant_Skill_Skill1_idx` (`Skill_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Consultant_Skill_Consultant1`
    FOREIGN KEY (`Consultant_ID`)
    REFERENCES `mydb`.`Consultant` (`Consultant_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consultant_Skill_Skill1`
    FOREIGN KEY (`Skill_ID`)
    REFERENCES `mydb`.`Skill` (`Skill_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Project_Skill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Project_Skill` (
  `Project_Skill_ID` INT NOT NULL,
  `Skill_Updation` VARCHAR(45) NULL,
  `Project_ID` INT NOT NULL,
  `Skill_ID` INT NOT NULL,
  PRIMARY KEY (`Project_Skill_ID`),
  INDEX `fk_Project_Skill_Skill1_idx` (`Skill_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Project_Skill_Project1`
    FOREIGN KEY (`Project_ID`)
    REFERENCES `mydb`.`Project` (`Project_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Project_Skill_Skill1`
    FOREIGN KEY (`Skill_ID`)
    REFERENCES `mydb`.`Skill` (`Skill_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Review` (
  `Review_ID` INT NOT NULL,
  `Rating` VARCHAR(45) NULL,
  `Feedback` VARCHAR(45) NULL,
  `Appraisal` VARCHAR(45) NULL,
  `Client_ID` INT NOT NULL,
  PRIMARY KEY (`Review_ID`),
  CONSTRAINT `fk_Review_Client1`
    FOREIGN KEY (`Client_ID`)
    REFERENCES `mydb`.`Client` (`Client_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
