CREATE DATABASE company;
USE company;
CREATE TABLE IF NOT EXISTS `company`.`employee` (
  `employee_id` INT NOT NULL DEFAULT '1000',
  `sex` VARCHAR(45) NOT NULL,
  `f_name` VARCHAR(45) NOT NULL,
  `l_name` VARCHAR(20) NOT NULL,
  `birth_date` DATETIME NOT NULL,
  `position` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`employee_id`));
  
CREATE TABLE IF NOT EXISTS `company`.`attendance` (
  `attendance_id` INT NOT NULL,
  `todays_date` DATETIME NOT NULL,
  `attended` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`attendance_id`),
  CONSTRAINT `fk_attendance_employee`
    FOREIGN KEY (`attendance_id`)
    REFERENCES `company`.`employee` (`employee_id`)
    ON DELETE CASCADE 
    -- ON DELETE CASCADE
    ON UPDATE NO ACTION);  
    
 CREATE TABLE IF NOT EXISTS `company`.`project` (
  `project_id` INT NOT NULL,
  `project_name` VARCHAR(45) NOT NULL,
  `project_deadline` DATETIME NOT NULL,
  PRIMARY KEY (`project_id`, `project_name`),
  UNIQUE INDEX `uk_project_name` (`project_name`)
);
       
CREATE TABLE IF NOT EXISTS `company`.`project_member` (
  `project_id` INT NOT NULL,
  `member_id` INT NOT NULL,
  PRIMARY KEY (`member_id`),
  INDEX `fk_project_member_project1_idx` (`project_id` ASC) VISIBLE,
  CONSTRAINT `fk_project_member_project1`
    FOREIGN KEY (`project_id`)
    REFERENCES `company`.`project` (`project_id`)
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_member_employee1`
  FOREIGN KEY (`member_id`)
  REFERENCES `company`.`employee` (`employee_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION);
  
CREATE TABLE IF NOT EXISTS `company`.`works_on` (
  `project_project_id` INT NOT NULL,
  `project_project_name` VARCHAR(45) NOT NULL,
  `project_member_member_id` INT NOT NULL,
  PRIMARY KEY (`project_project_id`, `project_project_name`, `project_member_member_id`),
  INDEX `fk_project_has_project_member_project_member1_idx` (`project_member_member_id` ASC) VISIBLE,
  INDEX `fk_project_has_project_member_project1_idx` (`project_project_id` ASC, `project_project_name` ASC) VISIBLE,
  CONSTRAINT `fk_project_has_project_member_project1`
    FOREIGN KEY (`project_project_id` , `project_project_name`)
    REFERENCES `company`.`project` (`project_id` , `project_name`)
    ON DELETE CASCADE 
    -- ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_has_project_member_project_member1`
    FOREIGN KEY (`project_member_member_id`)
    REFERENCES `company`.`project_member` (`member_id`)
    ON DELETE CASCADE 
    -- ON DELETE CASCADE
    ON UPDATE NO ACTION); 
    
CREATE TABLE IF NOT EXISTS `company`.`department` (
  `department_id` INT NOT NULL,
  `department_name` VARCHAR(45) NOT NULL,
  `department_location` VARCHAR(45) NOT NULL,
  `department_project` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`department_id`, `department_name`),
  INDEX `fk_department_project1_idx` (`department_project` ASC) VISIBLE,
  CONSTRAINT `fk_department_project1`
    FOREIGN KEY (`department_project`)
    REFERENCES `company`.`project` (`project_name`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
  
CREATE TABLE IF NOT EXISTS `company`.`manager` (
  `manager_id` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `manager_department_id` INT NOT NULL,
  PRIMARY KEY (`manager_id`, `manager_department_id`),
  INDEX `fk_manager_department1_idx` (`manager_department_id` ASC) VISIBLE,
  CONSTRAINT `fk_manager_employee1`
    FOREIGN KEY (`manager_id`)
    REFERENCES `company`.`employee` (`employee_id`)
    ON DELETE CASCADE 
    -- ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_manager_department1`
    FOREIGN KEY (`manager_department_id`)
    REFERENCES `company`.`department` (`department_id`)
    ON DELETE CASCADE 
    -- ON DELETE CASCADE
    ON UPDATE NO ACTION);
  
 CREATE TABLE IF NOT EXISTS `company`.`manages` (
  `manager_manager_id` INT NOT NULL,
  `manager_manager_department_id` INT NOT NULL,
  `department_department_id` INT NOT NULL,
  `department_department_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`manager_manager_id`, `manager_manager_department_id`, `department_department_id`, `department_department_name`),
  INDEX `fk_manager_has_department_department1_idx` (`department_department_id` ASC, `department_department_name` ASC) VISIBLE,
  INDEX `fk_manager_has_department_manager1_idx` (`manager_manager_id` ASC, `manager_manager_department_id` ASC) VISIBLE,
  CONSTRAINT `fk_manager_has_department_manager1`
    FOREIGN KEY (`manager_manager_id` , `manager_manager_department_id`)
    REFERENCES `company`.`manager` (`manager_id` , `manager_department_id`)
    ON DELETE CASCADE 
    -- ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_manager_has_department_department1`
    FOREIGN KEY (`department_department_id` , `department_department_name`)
    REFERENCES `company`.`department` (`department_id` , `department_name`)
    ON DELETE CASCADE 
    -- ON DELETE CASCADE
    ON UPDATE NO ACTION);


    
 INSERT INTO employee(employee_id,sex,f_name,l_name,birth_date,position)
VALUES  (1000,"Male","Berat","Özkan","1995-06-21","IT Manager"),
	    (1001,"Male","Abdulkadir Efe","Buğday","1995-03-03", "IT Employee"),
        (1002,"Male","Ali Uğur","Gümüşlü","1993-07-11", "IT Employee"),
        (1003,"Male","Mahmut Alperen","Çavuş","1994-08-15", "IT Employee"),
        (1004,"Male","Muhammed","Savaş","1997-10-26", "IT Employee"),
        (1005,"Male","Polat","Alemdar","1999-05-28", "HR Manager"),
        (1006,"Male","Memati","Baş","1991-01-04", "HR Employee"),
        (1007,"Female","Sansa","Stark","1990-03-09", "HR Employee"),
        (1008,"Male","Jon","Snow","1996-02-01", "HR Employee"),
        (1009,"Male","Shirou","Emiya","1992-09-08", "HR Employee"),
        (1010,"Male","Bilbo","Baggins","1992-11-27", "AMD Employee"),
        (1011,"Male","Frodo","Baggins","1991-12-22", "AMD Employee"),
        (1012,"Female","Jolyne","Kujo","1990-04-18", "AMD Employee"),
	    (1013,"Male","Süleyman","Çakır","2000-09-18", "AMD Employee"),
        (1014,"Female","Cercei","Lannister","2000-09-18", "AMD Manager"),
		(1015,"Male","Joseph","Joestar","1996-10-21","FD Manager"),
	    (1016,"Male","Walter","White","1998-08-03", "FD Employee"),
        (1017,"Female","Artoria","Pendragon","2001-01-11", "FD Employee"),
        (1018,"Female","Robin","Nico","2002-12-15", "FD Employee"),
        (1019,"Male","Zoro","Roronoa","2001-10-26", "FD Employee"),
        (1020,"Male","Gabe","Newell","1993-10-20","CS Manager"),
	    (1021,"Male","Robert","Speedwagon","1994-04-16", "CS Employee"),
        (1022,"Male","Mohammad","Abdul","1994-07-24", "CS Employee"),
        (1023,"Male","Jean Pierre","Polnareff","1995-09-04", "CS Employee"),
        (1024,"Male","Dio","Brando","1995-11-17", "CS Employee"),
        (1025,"Male","Edward","Newgate","1996-06-16", "R&D Manager"),
        (1026,"Male","Ace","Portgas D.","1997-05-12", "R&D Employee"),
        (1027,"Female","Linlin","Charlotte","1997-12-09", "R&D Employee"),
        (1028,"Male","Oden","Kozuki","1998-02-03", "R&D Employee"),
        (1029,"Male","Law","Trafalgar D.","1998-09-01", "R&D Employee"),
        (1030,"Male","Doflamingo","Donquixote","1998-12-26", "Legal Employee"),
        (1031,"Male","Tokiomi","Tohsaka","1999-08-17", "Legal Employee"),
        (1032,"Female","Irisviel","Einzbern","2001-09-25", "Legal Employee"),
	    (1033,"Male","Ercüment","Çözer","2002-01-01", "Legal Employee"),
        (1034,"Male","Saul","Goodman","2003-08-14", "Legal Manager"),
		(1035,"Male","Kuzey","Tekinoğlu","2003-12-26","QA Manager"),
	    (1036,"Male","Güney","Tekinoğlu","2004-12-03", "QA Employee"),
        (1037,"Female","Handan","Tekinoğlu","2005-04-22", "QA Employee"),
        (1038,"Female","Lara","Croft","2005-11-15", "QA Employee"),
        (1039,"Male","Waver","Velvet","1995-01-08", "QA Employee"),
        (1040,"Male","Gustavo","Fring","1995-01-31", "Administration Employee"),
        (1041,"Male","Eren","Jaegar","1997-09-10", "Administration Employee"),
        (1042,"Female","Mikasa","Ackermann","1997-10-30", "Administration Employee"),
	    (1043,"Male","Levi","Ackermann","1997-12-16", "Administration Employee"),
        (1044,"Female","Annie","Leonhart","1998-09-20", "Administration Manager"),
		(1045,"Male","Erwin","Smith","1998-02-20","PM Manager"),
	    (1046,"Male","Reiner","Braun","1994-04-25", "PM Employee"),
        (1047,"Female","Suzuha","Amane","2000-02-18", "PM Employee"),
        (1048,"Female","Mayuri","Shiina","2000-06-24", "PM Employee"),
        (1049,"Male","Aizen","Sosuke","2003-10-27", "PM Employee"),
        (1050,"Male","Martin","Weber","1995-06-30","SBD Manager"),
	    (1051,"Male","Thomas","Bax","1995-03-13", "SBD Employee"),
        (1052,"Male","Halle","Day","1993-07-17", "O&L Manager"),
        (1053,"Female","Alison","Padilla","1994-08-16", "O&L Employee"),
        (1054,"Male","Joey","Nicholls","1997-10-27", "L&C Employee"),
        (1055,"Male","Jerry","Langstaff","1999-05-18", "L&C Manager"),
        (1056,"Male","Haven","Hudson","1991-01-09", "FM Manager"),
        (1057,"Female","Daphne","Hill","1990-03-29", "FM Employee"),
        (1058,"Male","Bernard","Warner","1996-02-02", "AOS Manager"),
        (1059,"Male","Patrick","Dinwiddie","1992-09-18", "AOS Employee"),
        (1060,"Male","Teddy","Hall","1992-11-17", "H&S Manager"),
        (1061,"Male","Ulric","Santiago","1991-12-23", "H&S Employee"),
        (1062,"Female","Vita","Hubbard","1990-04-13", "T&D Manager"),
	    (1063,"Male","Kenneth","Andrus","2000-09-17", "T&D Employee"),
        (1064,"Female","Monica","Sowle","2000-09-18", "BI Manager"),
		(1065,"Male","Randall","Malcom","1996-10-23","BI Employee"),
	    (1066,"Male","Walter","White","1998-08-04", "SCM Manager"),
        (1067,"Female","Kate","Robbins","2001-01-10", "SCM Employee"),
        (1068,"Female","Lovell","Weaver","2002-12-12", "PR Manager"),
        (1069,"Male","Roy","Nunez","2001-10-16", "PR Employee");
        
        
        
INSERT INTO project(project_id, project_name, project_deadline)
VALUES(3153, "Pineapple", "2025-01-03"),
	  (3215, "Project T", "2026-11-21"),
      (2721, "WattMann", "2024-05-01"),
      (2777, "CyberBug", "2028-03-03"),
      (2003, "CS 1.6", "2025-01-03"),
	  (2011, "HG-2011", "2026-11-21"),
      (2004, "Project SBR", "2024-05-01"),
      (2023, "FIFA2023", "2028-03-03"),
      (1015, "HaylouT15", "2025-01-03"),
	  (2334, "SAM M34", "2026-11-21"),
      (3060, "PATH-T", "2024-05-01"),
      (7544, "TSP", "2028-03-03"),
      (1111, "JJS", "2025-01-03"),
	  (2103, "WoW", "2026-11-21"),
      (2009, "MC2024", "2024-05-01"),
      (2210, "NIER", "2028-03-03"),
      (2211, "GESTALT", "2025-01-03"),
	  (1453, "DD-01", "2026-11-21"),
      (2108, "FCFS", "2024-05-01"),
      (2017, "RX550", "2028-03-03");
      
INSERT INTO department (department_id, department_name, department_location, department_project)
VALUES (9000,"IT","3F-A","Cyberbug"),
	   (9001,"HR","3F-A","Pineapple"),
       (9002,"AMD","3F-B","Project T"),
	   (9003,"FD","3F-C","FCFS"),
       (9004,"CS","3F-D","CS 1.6"),
	   (9005,"R&D","3F-E","HG-2011"),
       (9006,"Legal","3F-F","SAM M34"),
	   (9007,"QA","3F-G","HaylouT15"), 
       (9008,"Administration Manager","3F-H","WoW"),
	   (9009,"PM","3F-I","JJS"),
       (9010,"SBD","3F-J","MC2024"),
	   (9011,"Q&L","3F-K","RX550"), 
       (9012,"L&C","3F-L","DD-01"),
	   (9013,"FM","3F-M","GESTALT"),
       (9014,"AOS","3F-N","NIER"),
	   (9015,"H&S","3F-O","WattMann"), 
       (9016,"T&D","3F-P","Project SBR"),
	   (9017,"BI","3F-R","PATH-T"),
       (9018,"SCM","3F-S","FIFA2023"),
	   (9019,"PR","3F-T","TSP");      
      
      
      
INSERT INTO manager(manager_id, title, manager_department_id) 
VALUES (1000,'IT Manager',9000),
	   (1005,'HR Manager',9001),
	   (1014,'AMD Manager',9002),
       (1015,'FD Manager',9003),
       (1020,'CS Manager',9004),
	   (1025,'R&D Manager',9005),
	   (1034,'Legal Manager',9006),
       (1035,'QA Manager',9007),
       (1044,'Administration Manager',9008),
	   (1045,'PM Manager',9009),
       (1050,'SBD Manager',9010),
	   (1052,'Q&L Manager',9011),
	   (1055,'L&C Manager',9012),
       (1056,'FM Manager',9013),
       (1058,'AOS Manager',9014),
	   (1060,'H&S Manager',9015),
	   (1062,'T&D Manager',9016),
       (1064,'BI Manager',9017),
       (1066,'SCM Manager',9018),
	   (1068,'PR Manager',9019);
       

       
INSERT INTO attendance(attendance_id, todays_date, attended)
VALUES  (1000,CURDATE(), "TRUE"),
	    (1001,CURDATE(),"TRUE"),
        (1002,CURDATE(),"TRUE"),
        (1003,CURDATE(),"TRUE"),
        (1004,CURDATE(),"TRUE"),
        (1005,CURDATE(),"FALSE"),
        (1006,CURDATE(),"TRUE"),
        (1007,CURDATE(),"TRUE"),
        (1008,CURDATE(),"TRUE"),
        (1009,CURDATE(),"TRUE"),
        (1010,CURDATE(),"TRUE"),
        (1011,CURDATE(),"TRUE"),
        (1012,CURDATE(),"TRUE"),
	    (1013,CURDATE(),"FALSE"),
        (1014,CURDATE(),"TRUE"),
		(1015,CURDATE(),"TRUE"),
	    (1016,CURDATE(),"TRUE"),
        (1017,CURDATE(),"TRUE"),
        (1018,CURDATE(),"TRUE"),
        (1019,CURDATE(),"FALSE"),
        (1020,CURDATE(),"TRUE"),
	    (1021,CURDATE(),"TRUE"),
        (1022,CURDATE(),"TRUE"),
        (1023,CURDATE(),"TRUE"),
        (1024,CURDATE(),"TRUE"),
        (1025,CURDATE(),"TRUE"),
        (1026,CURDATE(),"TRUE"),
        (1027,CURDATE(),"TRUE"),
        (1028,CURDATE(),"TRUE"),
        (1029,CURDATE(),"TRUE"),
        (1030,CURDATE(),"TRUE"),
        (1031,CURDATE(),"FALSE"),
        (1032,CURDATE(),"TRUE"),
	    (1033,CURDATE(),"TRUE"),
        (1034,CURDATE(),"TRUE"),
		(1035,CURDATE(),"FALSE"),
	    (1036,CURDATE(),"TRUE"),
        (1037,CURDATE(),"TRUE"),
        (1038,CURDATE(),"TRUE"),
        (1039,CURDATE(),"TRUE"),
        (1040,CURDATE(),"TRUE"),
        (1041,CURDATE(),"TRUE"),
        (1042,CURDATE(),"TRUE"),
	    (1043,CURDATE(),"TRUE"),
        (1044,CURDATE(),"TRUE"),
		(1045,CURDATE(),"TRUE"),
	    (1046,CURDATE(),"FALSE"),
        (1047,CURDATE(),"TRUE"),
        (1048,CURDATE(),"TRUE"),
        (1049,CURDATE(),"TRUE"),
        (1050,CURDATE(),"TRUE"),
	    (1051,CURDATE(),"TRUE"),
        (1052,CURDATE(),"TRUE"),
        (1053,CURDATE(),"TRUE"),
        (1054,CURDATE(),"TRUE"),
        (1055,CURDATE(),"FALSE"),
        (1056,CURDATE(),"TRUE"),
        (1057,CURDATE(),"TRUE"),
        (1058,CURDATE(),"TRUE"),
        (1059,CURDATE(),"TRUE"),
        (1060,CURDATE(),"TRUE"),
        (1061,CURDATE(),"TRUE"),
        (1062,CURDATE(),"FALSE"),
	    (1063,CURDATE(),"TRUE"),
        (1064,CURDATE(),"TRUE"),
		(1065,CURDATE(),"TRUE"),
	    (1066,CURDATE(),"TRUE"),
        (1067,CURDATE(),"TRUE"),
        (1068,CURDATE(),"TRUE"),
        (1069,CURDATE(),"TRUE");       
       
INSERT INTO project_member (project_id, member_id)
SELECT 3215, employee_id
FROM employee
WHERE position IN ('AMD Manager', 'AMD Employee');

-- Assign members for the Pineapple project (project_id: 3153)
INSERT INTO project_member (project_id, member_id)
SELECT 2721, employee_id
FROM employee
WHERE position IN ('H&S Manager', 'H&S Employee');

-- Assign members for the Project T project (project_id: 3215)
INSERT INTO project_member (project_id, member_id)
SELECT 2777, employee_id
FROM employee
WHERE position IN ('IT Manager', 'IT Employee');

INSERT INTO project_member (project_id, member_id)
SELECT 2003, employee_id
FROM employee
WHERE position IN ('CS Manager', 'CS Employee');

INSERT INTO project_member (project_id, member_id)
SELECT 2011, employee_id
FROM employee
WHERE position IN ('R&D Manager', 'R&D Employee');

-- Assign members for the Pineapple project (project_id: 3153)
INSERT INTO project_member (project_id, member_id)
SELECT 2004, employee_id
FROM employee
WHERE position IN ('T&D Manager', 'T&D Employee');

-- Assign members for the Project T project (project_id: 3215)
INSERT INTO project_member (project_id, member_id)
SELECT 2023, employee_id
FROM employee
WHERE position IN ('SCM Manager', 'SCM Employee');

INSERT INTO project_member (project_id, member_id)
SELECT 1015, employee_id
FROM employee
WHERE position IN ('QA Manager', 'QA Employee');

INSERT INTO project_member (project_id, member_id)
SELECT 2334, employee_id
FROM employee
WHERE position IN ('Legal Manager', 'Legal Employee');

-- Assign members for the Pineapple project (project_id: 3153)
INSERT INTO project_member (project_id, member_id)
SELECT 3060, employee_id
FROM employee
WHERE position IN ('BI Manager', 'BI Employee');

-- Assign members for the Project T project (project_id: 3215)
INSERT INTO project_member (project_id, member_id)
SELECT 7544, employee_id
FROM employee
WHERE position IN ('PR Manager', 'PR Employee');

INSERT INTO project_member (project_id, member_id)
SELECT 1111, employee_id
FROM employee
WHERE position IN ('PM Manager', 'PM Employee');

INSERT INTO project_member (project_id, member_id)
SELECT 2103, employee_id
FROM employee
WHERE position IN ('Administration Manager', 'Administration Employee');

-- Assign members for the Pineapple project (project_id: 3153)
INSERT INTO project_member (project_id, member_id)
SELECT 2009, employee_id
FROM employee
WHERE position IN ('SBD Manager', 'SBD Employee');

-- Assign members for the Project T project (project_id: 3215)
INSERT INTO project_member (project_id, member_id)
SELECT 2210, employee_id
FROM employee
WHERE position IN ('AOS Manager', 'AOS Employee');

INSERT INTO project_member (project_id, member_id)
SELECT 2211, employee_id
FROM employee
WHERE position IN ('FM Manager', 'FM Employee');

INSERT INTO project_member (project_id, member_id)
SELECT 1453, employee_id
FROM employee
WHERE position IN ('L&C Manager', 'L&C Employee');

-- Assign members for the Pineapple project (project_id: 3153)
INSERT INTO project_member (project_id, member_id)
SELECT 2108, employee_id
FROM employee
WHERE position IN ('FD Manager', 'FD Employee');

-- Assign members for the Project T project (project_id: 3215)
INSERT INTO project_member (project_id, member_id)
SELECT 2017, employee_id
FROM employee
WHERE position IN ('Q&L Manager', 'Q&L Employee');

INSERT INTO project_member (project_id, member_id)
SELECT 3153, employee_id
FROM employee
WHERE position IN ('HR Manager', 'HR Employee');

--  -------------------------------------------------QUERIES------------------------------------------------------------------------

 -- o	INSERT 3 tuples to different tables
 INSERT INTO employee(employee_id,sex,f_name,l_name,birth_date,position)
 VALUES(1070,"Male","Luffy","Monkey D.","1997-12-23","PR Employee");

INSERT INTO attendance(attendance_id, todays_date, attended)
 VALUES(1070,curdate(),"TRUE");
 
 INSERT INTO project_member(project_id, member_id)
 VALUES(7544,1070);
 
 -- o	INSERT 5 tuples to same table
 INSERT INTO employee(employee_id, sex, f_name, l_name, birth_date, position)
 VALUES (1071,"Male","Diarmuid","Ua Duibhne","2000-11-08","IT Employee"),
	    (1072,"Male","Sanji","Vinsmoke","1999-07-30","HR Employee"),
        (1073,"Male","Killua","Zoldyck","2002-06-05","AMD Employee"),
        (1074,"Female","Aoi","Tohsaka","1993-06-07","PR Employee"),
        (1075,"Male","Kento","Nanami","1990-04-18","Q&L Employee"); 
        
-- o	UPDATE 3 tuples in different tables
UPDATE employee
SET birth_date = '1995-06-22'
WHERE employee_id = 1000;

UPDATE attendance
SET attended = 'FALSE'
WHERE todays_date = "2024-01-08";

UPDATE department
SET department_location= "3F-Z"
WHERE department_id= 9000;

-- o	DELETE 3 tuples in different tables
DELETE FROM attendance
WHERE attendance_id = 1070 AND todays_date = '2024-01-08';

DELETE FROM project_member
WHERE member_id = 1070;

DELETE FROM manager
WHERE manager_id = 1025;

-- o Add CHECK constraint
ALTER TABLE `company`.`employee`
ADD CONSTRAINT `check_age` CHECK (DATEDIFF("2024-01-05", `birth_date`) >= 6570);

-- o	Create 3 queries with WHERE clause and comparison operators
SELECT *
FROM employee
WHERE position = 'IT Manager';

SELECT *
FROM employee
WHERE position <> 'HR Employee';

SELECT *
FROM employee
WHERE birth_date > '1990-01-01';

-- o	Create 3 queries with WHERE clause and arithmetic operators
SELECT *
FROM employee
WHERE employee_id + 1 = 1006;

SELECT *
FROM employee
WHERE YEAR(birth_date) - 1900 <> 95;

SELECT *
FROM employee
WHERE YEAR(birth_date) * 10000 + MONTH(birth_date) * 100 + DAY(birth_date) > 19950101;

-- o	Create 3 queries with WHERE clause and logical operators
SELECT *
FROM employee
WHERE position = 'HR Employee' AND YEAR(birth_date) >= 1990;

SELECT *
FROM employee
WHERE position = 'IT Manager' OR position = 'QA Manager';

SELECT *
FROM employee
WHERE NOT position = 'Legal Manager';

-- o	Create 3 queries with special operators (BETWEEN, IS NULL, LIKE, IN, EXISTS),
SELECT *
FROM employee
WHERE YEAR(birth_date) BETWEEN 1990 AND 1995;

SELECT *
FROM employee
WHERE l_name LIKE 'S%';

SELECT *
FROM employee e
WHERE EXISTS (SELECT 1 FROM attendance a WHERE a.attendance_id = e.employee_id);

-- o	Create 3 queries with ORDER BY clause 
SELECT *
FROM employee
ORDER BY f_name ASC;

SELECT *
FROM employee
ORDER BY birth_date DESC;

SELECT *
FROM employee
ORDER BY position ASC, l_name DESC;

-- o	Create 3 queries with DISTINCT clause
SELECT DISTINCT position
FROM employee;

SELECT DISTINCT f_name, l_name 
FROM employee;

SELECT DISTINCT position
FROM employee
WHERE sex = 'Female';

-- o	Create 3 queries with String Functions
SELECT CONCAT(f_name, ' ', l_name, ' - ', position) AS employee_info
FROM employee;

SELECT SUBSTRING(f_name, 1, 3) AS short_name
FROM employee;

SELECT UPPER(l_name) AS uppercase_last_name
FROM employee
WHERE sex = 'Male';


-- o	Create 3 queries with Numeric Functions
SELECT SUM(YEAR(CURDATE()) - YEAR(birth_date)) AS total_age
FROM employee;

SELECT AVG(YEAR(CURDATE()) - YEAR(birth_date)) AS average_age
FROM employee
WHERE sex = 'Female';

SELECT MAX(LENGTH(department_name)) AS max_department_name_length
FROM department;

-- o	Create 3 queries with Date Functions
SELECT employee_id, 12*(DATEDIFF(CURDATE(),birth_date) /365) AS total_month_lived
FROM employee;

SELECT employee_id, f_name, l_name, DATEDIFF(CURDATE(), birth_date) / 365 AS age
FROM employee;

SELECT f_name, l_name, DATE_FORMAT(birth_date, '%Y-%m-%d') AS formatted_birth_date
FROM employee;

-- o	Create 3 queries with aggregate functions(COUNT, MIN, MAX, SUM, AVG)
SELECT position, COUNT(employee_id) AS employee_count
FROM employee
GROUP BY position;

SELECT MIN(birth_date) AS earliest_birth_date, MAX(birth_date) AS latest_birth_date
FROM employee;

SELECT AVG(YEAR(birth_date)) AS average_birth_year
FROM employee;

-- o	Use LIMIT clause
SELECT *
FROM employee
LIMIT 5;

SELECT *
FROM project
WHERE project_deadline > CURDATE()
ORDER BY project_deadline
LIMIT 3;

---------------------------------------------------
-- o	Use ROLLUP
SELECT
  CASE WHEN sex IS NOT NULL THEN sex ELSE 'Total' END AS sex,
  COUNT(*) AS employee_count
FROM
  company.employee e
LEFT JOIN
  company.manager m ON e.employee_id = m.manager_id
GROUP BY
  sex WITH ROLLUP;
---------------------------------------------------
-- o	Create 3 queries with GROUP BY clause 
SELECT
  d.department_name,
  MAX(YEAR(CURDATE()) - YEAR(e.birth_date)) AS Oldest_person_age
FROM
  company.employee e
JOIN
  company.manager m ON e.employee_id = m.manager_id

JOIN
  company.department d ON m.manager_department_id= d.department_id 
GROUP BY
  d.department_name;

SELECT project_name, COUNT(*) as member_count
FROM project_member
JOIN project ON project_member.project_id = project.project_id
GROUP BY project_name;
---------------------------------------------------
SELECT
  e.employee_id,
  COUNT(*) AS attendance_count
FROM
  employee e
JOIN
  attendance a ON e.employee_id = a.attendance_id
GROUP BY
  e.employee_id;
---------------------------------------------------
-- o	Create 3 queries with HAVING clause 

SELECT e.employee_id, e.f_name, e.l_name, COUNT(a.attendance_id) AS attendance_count
FROM company.employee e
LEFT JOIN company.attendance a ON e.employee_id = a.attendance_id
GROUP BY e.employee_id, e.f_name, e.l_name
HAVING attendance_count > 0;

SELECT manager_id, COUNT(DISTINCT manager_department_id) as department_count
FROM manager
GROUP BY manager_id
HAVING department_count > 0;

SELECT project_name, COUNT(*) as member_count
FROM project_member
JOIN project ON project_member.project_id = project.project_id
GROUP BY project_name
HAVING member_count >= 3;

-- o	Create a query by LEFT JOIN
SELECT employee.employee_id, employee.f_name, employee.l_name, manager.title
FROM employee
LEFT JOIN manager ON employee.employee_id = manager.manager_id;

-- o	Create a query by RIGHT JOIN
SELECT employee.employee_id, employee.f_name, employee.l_name, manager.title
FROM employee
RIGHT JOIN manager ON employee.employee_id = manager.manager_id;

-- o	Create 3 queries with Joining 2 tables
SELECT project.project_id, project.project_name, project_member.member_id
FROM project
LEFT JOIN project_member ON project.project_id = project_member.project_id;

SELECT employee.employee_id, employee.f_name, employee.l_name, manager.title
FROM employee
RIGHT JOIN manager ON employee.employee_id = manager.manager_id;

SELECT employee.employee_id, employee.f_name, employee.l_name, project_member.project_id
FROM employee
LEFT JOIN project_member ON employee.employee_id = project_member.member_id;

-- o	Create 3 queries with Joining 3 tables
SELECT employee.employee_id, employee.f_name, employee.l_name, attendance.attendance_id, manager.manager_id
FROM employee
INNER JOIN attendance ON employee.employee_id = attendance.attendance_id
INNER JOIN manager ON employee.employee_id = manager.manager_id;

SELECT employee.employee_id, employee.f_name, employee.l_name, attendance.attendance_id, manager.manager_id
FROM employee
LEFT JOIN attendance ON employee.employee_id = attendance.attendance_id
LEFT JOIN manager ON employee.employee_id = manager.manager_id;

SELECT employee.employee_id, employee.f_name, employee.l_name, attendance.attended, project_member.project_id
FROM employee
LEFT JOIN attendance ON employee.employee_id = attendance.attendance_id
LEFT JOIN project_member ON employee.employee_id = project_member.member_id;

-- o	Create 3 queries with subquery in WHERE clause
-- Retrieve employees who attended today
SELECT *
FROM employee
WHERE EXISTS (
    SELECT 1
    FROM attendance
    WHERE attendance.attendance_id = employee.employee_id
    AND attendance.attended = "TRUE"
);

-- Retrieve employees who are members of the 'Project T'
SELECT *
FROM employee
WHERE employee.employee_id IN (
    SELECT member_id
    FROM project_member
    WHERE project_id = 3215
);

-- Retrieve departments with more than 2 employees
SELECT *
FROM department
WHERE department.department_id IN (
    SELECT manager_department_id
    FROM manager
    GROUP BY manager_department_id
    HAVING COUNT(manager_id) >= 1
);

-- o	Create 3 queries with subquery in SELECT columns 
-- Retrieve employee information along with the number of projects they are working on
SELECT employee_id, f_name, l_name,
       (SELECT COUNT(*) FROM project_member WHERE member_id = employee.employee_id) AS project_count
FROM employee;

-- Retrieve employee information along with a column indicating if they attended today
SELECT employee_id, f_name, l_name,
       (SELECT MAX(attended) FROM attendance WHERE attendance_id = employee.employee_id) AS attended_today
FROM employee;

-- Retrieve department information along with the latest project deadline in that department
SELECT d.department_id, d.department_name, d.department_location,
       (SELECT MAX(p.project_deadline) FROM project p WHERE p.project_id IN
           (SELECT pm.project_id FROM project_member pm WHERE pm.member_id IN
               (SELECT m.manager_id FROM manager m WHERE m.manager_department_id = d.department_id)
           )
       ) AS latest_project_deadline
FROM department d;

-- o	Copy one table structure and data to new table
CREATE TABLE new_employee AS SELECT * FROM employee;

-- o	Create a VIEW
CREATE VIEW employee_view AS
SELECT * FROM employee;

-- o	Create a stored procedure and call it
-- Create a stored procedure
DELIMITER //

CREATE PROCEDURE GetEmployeeById(IN emp_id INT)
BEGIN
    SELECT * FROM employee WHERE employee_id = emp_id;
END //

DELIMITER ;

CALL GetEmployeeById(1001);


-- o	Create 3 triggers and use it, give examples in order to execute trigger
-- Create a trigger to update the birth date before inserting into the employee table
DELIMITER //

CREATE TRIGGER before_insert_employee
BEFORE INSERT ON employee
FOR EACH ROW
SET NEW.birth_date = DATE_SUB(NEW.birth_date, INTERVAL 1 YEAR);

//

DELIMITER ;

-- Create a trigger to log updates to the employee table
DELIMITER //

CREATE TRIGGER after_update_employee
AFTER UPDATE ON employee
FOR EACH ROW
INSERT INTO employee_update_log (employee_id, updated_at)
VALUES (OLD.employee_id, NOW());

//

DELIMITER ;

-- Create a trigger to prevent deletion of certain positions from the employee table
DELIMITER //

CREATE TRIGGER before_delete_employee
BEFORE DELETE ON employee
FOR EACH ROW
BEGIN
    IF OLD.position = 'IT Manager' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot delete IT Manager';
    END IF;
END;

//

DELIMITER ;

INSERT INTO employee(employee_id, sex, f_name, l_name, birth_date, position)
VALUES (1079, 'Male', 'John', 'Doe', '1990-01-01', 'IT Employee');

UPDATE employee SET position = 'Senior Developer' WHERE employee_id = 1100;

DELETE FROM employee WHERE employee_id = 1000;