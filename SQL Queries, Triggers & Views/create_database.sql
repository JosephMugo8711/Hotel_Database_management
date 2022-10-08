-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hotel_database
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hotel_database
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hotel_database` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema new_schema1
-- -----------------------------------------------------
USE `hotel_database` ;

-- -----------------------------------------------------
-- Table `hotel_database`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel_database`.`addresses` (
  `address_id` INT NOT NULL,
  `address_line1` VARCHAR(100) NULL,
  `address_line2` VARCHAR(100) NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `zipcode` VARCHAR(6) NULL,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel_database`.`hotel_chain`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel_database`.`hotel_chain` (
  `hotel_chain_id` INT NOT NULL,
  `hotel_chain_name` VARCHAR(45) NULL,
  `hotel_chain_contact_number` VARCHAR(12) NULL,
  `hotel_chain_email_address` VARCHAR(45) NULL,
  `hotel_chain_website` VARCHAR(45) NULL,
  `hotel_chain_head_office_address_id` INT NOT NULL,
  PRIMARY KEY (`hotel_chain_id`, `hotel_chain_head_office_address_id`),
  INDEX `fk_hotel_chains_addresses1_idx` (`hotel_chain_head_office_address_id` ASC) VISIBLE,
  CONSTRAINT `fk_hotel_chains_addresses1`
    FOREIGN KEY (`hotel_chain_head_office_address_id`)
    REFERENCES `hotel_database`.`addresses` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel_database`.`star_ratings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel_database`.`star_ratings` (
  `star_rating` INT NOT NULL,
  `star_rating_image` VARCHAR(100) NULL,
  PRIMARY KEY (`star_rating`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel_database`.`hotel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel_database`.`hotel` (
  `hotel_id` INT NOT NULL,
  `hotel_name` VARCHAR(45) NULL,
  `hotel_contact_number` VARCHAR(12) NULL,
  `hotel_email_address` VARCHAR(45) NULL,
  `hotel_website` VARCHAR(45) NULL,
  `hotel_description` VARCHAR(100) NULL,
  `hotel_floor_count` INT NULL,
  `hotel_room_capacity` INT NULL,
  `hotel_chain_id` INT NULL,
  `addresses_address_id` INT NOT NULL,
  `star_ratings_star_rating` INT NOT NULL,
  `check_in_time` TIME NULL,
  `check_out_time` TIME NULL,
  PRIMARY KEY (`hotel_id`, `addresses_address_id`, `star_ratings_star_rating`),
  INDEX `fk_hotels_addresses1_idx` (`addresses_address_id` ASC) VISIBLE,
  INDEX `fk_hotel_star_ratings1_idx` (`star_ratings_star_rating` ASC) VISIBLE,
  CONSTRAINT `fk_hotels_addresses1`
    FOREIGN KEY (`addresses_address_id`)
    REFERENCES `hotel_database`.`addresses` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hotel_star_ratings1`
    FOREIGN KEY (`star_ratings_star_rating`)
    REFERENCES `hotel_database`.`star_ratings` (`star_rating`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '		';


-- -----------------------------------------------------
-- Table `hotel_database`.`room_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel_database`.`room_type` (
  `room_type_id` INT NOT NULL,
  `room_type_name` VARCHAR(45) NULL,
  `room_cost` DECIMAL(10,2) NULL,
  `room_type_description` VARCHAR(100) NULL,
  `smoke_friendly` TINYINT(1) NULL,
  `pet_friendly` TINYINT(1) NULL,
  PRIMARY KEY (`room_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel_database`.`rooms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel_database`.`rooms` (
  `room_id` INT NOT NULL,
  `room_number` INT(4) NULL,
  `rooms_type_rooms_type_id` INT NOT NULL,
  `hotel_hotel_id` INT NOT NULL,
  PRIMARY KEY (`room_id`, `rooms_type_rooms_type_id`, `hotel_hotel_id`),
  INDEX `fk_rooms_rooms_type1_idx` (`rooms_type_rooms_type_id` ASC) VISIBLE,
  INDEX `fk_rooms_hotel1_idx` (`hotel_hotel_id` ASC) VISIBLE,
  CONSTRAINT `fk_rooms_rooms_type1`
    FOREIGN KEY (`rooms_type_rooms_type_id`)
    REFERENCES `hotel_database`.`room_type` (`room_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rooms_hotel1`
    FOREIGN KEY (`hotel_hotel_id`)
    REFERENCES `hotel_database`.`hotel` (`hotel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel_database`.`guests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel_database`.`guests` (
  `guest_id` INT NOT NULL,
  `guest_first_name` VARCHAR(45) NULL,
  `guest_last_name` VARCHAR(45) NULL,
  `guest_contact_number` VARCHAR(12) NULL,
  `guest_email_address` VARCHAR(45) NULL,
  `guest_credit_card` VARCHAR(45) NULL,
  `guest_id_proof` VARCHAR(45) NULL,
  `addresses_address_id` INT NOT NULL,
  PRIMARY KEY (`guest_id`, `addresses_address_id`),
  INDEX `fk_guests_addresses1_idx` (`addresses_address_id` ASC) VISIBLE,
  CONSTRAINT `fk_guests_addresses1`
    FOREIGN KEY (`addresses_address_id`)
    REFERENCES `hotel_database`.`addresses` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `hotel_database`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel_database`.`department` (
  `department_id` INT NOT NULL,
  `department_name` VARCHAR(45) NULL,
  `department_description` VARCHAR(100) NULL,
  PRIMARY KEY (`department_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel_database`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel_database`.`employees` (
  `emp_id` INT NOT NULL,
  `emp_first_name` VARCHAR(45) NULL,
  `emp_last_name` VARCHAR(45) NULL,
  `emp_designation` VARCHAR(45) NULL,
  `emp_address_id` INT NULL,
  `emp_contact_number` VARCHAR(12) NULL,
  `emp_email_address` VARCHAR(45) NULL,
  `department_department_id` INT NOT NULL,
  `addresses_address_id` INT NOT NULL,
  `hotel_hotel_id` INT NOT NULL,
  PRIMARY KEY (`emp_id`, `department_department_id`, `addresses_address_id`, `hotel_hotel_id`),
  INDEX `fk_employees_services1_idx` (`department_department_id` ASC) VISIBLE,
  INDEX `fk_employees_addresses1_idx` (`addresses_address_id` ASC) VISIBLE,
  INDEX `fk_employees_hotel1_idx` (`hotel_hotel_id` ASC) VISIBLE,
  CONSTRAINT `fk_employees_services1`
    FOREIGN KEY (`department_department_id`)
    REFERENCES `hotel_database`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employees_addresses1`
    FOREIGN KEY (`addresses_address_id`)
    REFERENCES `hotel_database`.`addresses` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employees_hotel1`
    FOREIGN KEY (`hotel_hotel_id`)
    REFERENCES `hotel_database`.`hotel` (`hotel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel_database`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel_database`.`bookings` (
  `booking_id` INT NOT NULL,
  `booking_date` DATETIME NULL,
  `duration_of_stay` VARCHAR(10) NULL,
  `check_in_date` DATETIME NULL,
  `check_out_date` DATETIME NULL,
  `booking_payment_type` VARCHAR(45) NULL,
  `total_rooms_booked` INT NULL,
  `hotel_hotel_id` INT NOT NULL,
  `guests_guest_id` INT NOT NULL,
  `employees_emp_id` INT NOT NULL,
  `total_amount` DECIMAL(10,2) NULL,
  PRIMARY KEY (`booking_id`, `hotel_hotel_id`, `guests_guest_id`, `employees_emp_id`),
  INDEX `fk_bookings_hotel1_idx` (`hotel_hotel_id` ASC) VISIBLE,
  INDEX `fk_bookings_guests1_idx` (`guests_guest_id` ASC) VISIBLE,
  INDEX `fk_bookings_employees1_idx` (`employees_emp_id` ASC) VISIBLE,
  CONSTRAINT `fk_bookings_hotel1`
    FOREIGN KEY (`hotel_hotel_id`)
    REFERENCES `hotel_database`.`hotel` (`hotel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bookings_guests1`
    FOREIGN KEY (`guests_guest_id`)
    REFERENCES `hotel_database`.`guests` (`guest_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bookings_employees1`
    FOREIGN KEY (`employees_emp_id`)
    REFERENCES `hotel_database`.`employees` (`emp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel_database`.`hotel_chain_has_hotel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel_database`.`hotel_chain_has_hotel` (
  `hotel_chains_hotel_chain_id` INT NOT NULL,
  `hotels_hotel_id` INT NOT NULL,
  PRIMARY KEY (`hotel_chains_hotel_chain_id`, `hotels_hotel_id`),
  INDEX `fk_hotel_chains_has_hotels_hotels1_idx` (`hotels_hotel_id` ASC) VISIBLE,
  INDEX `fk_hotel_chains_has_hotels_hotel_chains1_idx` (`hotel_chains_hotel_chain_id` ASC) VISIBLE,
  CONSTRAINT `fk_hotel_chains_has_hotels_hotel_chains1`
    FOREIGN KEY (`hotel_chains_hotel_chain_id`)
    REFERENCES `hotel_database`.`hotel_chain` (`hotel_chain_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hotel_chains_has_hotels_hotels1`
    FOREIGN KEY (`hotels_hotel_id`)
    REFERENCES `hotel_database`.`hotel` (`hotel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel_database`.`room_rate_discount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel_database`.`room_rate_discount` (
  `discount_id` INT NOT NULL,
  `discount_rate` DECIMAL(10,2) NULL,
  `start_month` TINYINT(2) NULL,
  `end_month` TINYINT(2) NULL,
  `room_type_room_type_id` INT NOT NULL,
  PRIMARY KEY (`discount_id`, `room_type_room_type_id`),
  INDEX `fk_room_rate_discount_room_type1_idx` (`room_type_room_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_room_rate_discount_room_type1`
    FOREIGN KEY (`room_type_room_type_id`)
    REFERENCES `hotel_database`.`room_type` (`room_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel_database`.`rooms_booked`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel_database`.`rooms_booked` (
  `rooms_booked_id` INT NOT NULL,
  `bookings_booking_id` INT NOT NULL,
  `rooms_room_id` INT NOT NULL,
  PRIMARY KEY (`rooms_booked_id`, `bookings_booking_id`, `rooms_room_id`),
  INDEX `fk_rooms_booked_bookings1_idx` (`bookings_booking_id` ASC) VISIBLE,
  INDEX `fk_rooms_booked_rooms1_idx` (`rooms_room_id` ASC) VISIBLE,
  CONSTRAINT `fk_rooms_booked_bookings1`
    FOREIGN KEY (`bookings_booking_id`)
    REFERENCES `hotel_database`.`bookings` (`booking_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rooms_booked_rooms1`
    FOREIGN KEY (`rooms_room_id`)
    REFERENCES `hotel_database`.`rooms` (`room_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel_database`.`hotel_services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel_database`.`hotel_services` (
  `service_id` INT NOT NULL,
  `service_name` VARCHAR(45) NULL,
  `service_description` VARCHAR(100) NULL,
  `service_cost` DECIMAL(10,2) NULL,
  `hotel_hotel_id` INT NOT NULL,
  PRIMARY KEY (`service_id`, `hotel_hotel_id`),
  INDEX `fk_hotel_services_hotel1_idx` (`hotel_hotel_id` ASC) VISIBLE,
  CONSTRAINT `fk_hotel_services_hotel1`
    FOREIGN KEY (`hotel_hotel_id`)
    REFERENCES `hotel_database`.`hotel` (`hotel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel_database`.`hotel_services_used_by_guests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel_database`.`hotel_services_used_by_guests` (
  `service_used_id` INT NOT NULL,
  `hotel_services_service_id` INT NOT NULL,
  `bookings_booking_id` INT NOT NULL,
  PRIMARY KEY (`service_used_id`, `hotel_services_service_id`, `bookings_booking_id`),
  INDEX `fk_hotel_services_has_bookings_bookings1_idx` (`bookings_booking_id` ASC) VISIBLE,
  INDEX `fk_hotel_services_has_bookings_hotel_services1_idx` (`hotel_services_service_id` ASC) VISIBLE,
  CONSTRAINT `fk_hotel_services_has_bookings_hotel_services1`
    FOREIGN KEY (`hotel_services_service_id`)
    REFERENCES `hotel_database`.`hotel_services` (`service_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hotel_services_has_bookings_bookings1`
    FOREIGN KEY (`bookings_booking_id`)
    REFERENCES `hotel_database`.`bookings` (`booking_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
