USE hotel_database;

-- Temporarily disable "Table already exists" warning
SET sql_notes = 0; 

CREATE TABLE IF NOT EXISTS hotel_database.Booking_Audit(

audit_id int NOT NULL PRIMARY KEY auto_increment,
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
action_type varchar(50) NOT NULL,
date_updated datetime NOT NULL
);

DROP TRIGGER IF EXISTS bookings_after_delete;

-- tell the mysql client to treat the statements, functions, stored procedures or triggers as an entire statement
DELIMITER //

CREATE TRIGGER bookings_after_insert
AFTER INSERT ON bookings
FOR EACH ROW

BEGIN
INSERT INTO bookings_Audit VALUES
(NEW, NEW.booking_id, NEW.booking_date, NEW.duration_of_stay, NEW.`check_in_date`, NEW.`check_out_date`,NEW.`booking_payment_type`, NEW.`total_rooms_booked`,NEW.`hotel_hotel_id`,NEW.`guests_guest_id`,NEW.`employees_emp_id`,NEW.`total_amount`,"INSERTED", NOW());
END//

DELIMITER ;

-- And then re-enable the warning again
SET sql_notes = 1;