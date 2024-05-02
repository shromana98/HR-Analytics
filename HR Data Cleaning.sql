-- Create Database
CREATE DATABASE projects;

USE projects;

-- Tables
SELECT * FROM hr;

-- Modify columns

ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

DESCRIBE hr;
-- Date Formate
SELECT birthdate FROM hr;

SET sql_safe_updates = 0;

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;
SELECT  hire_date from hr;
UPDATE hr
SET termdate = IF(termdate is not null and termdate!='',date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')),'0000-00-00')
WHERE true;
Set sql_mode='ALLOW_INVALID_UPDATES';
ALTER TABLE hr
MODIFY COLUMN termdate DATE;
SELECT  termdate from hr;
-- Age Column
ALTER TABLE hr ADD COLUMN age INT;
SELECT age FROM hr;
SELECT 
	min(age) AS youngest,
    max(age) AS oldest
FROM hr;

SELECT count(*) FROM hr WHERE age < 18;

SELECT COUNT(*) FROM hr WHERE termdate > CURDATE();

SELECT COUNT(*)
FROM hr
WHERE termdate = '0000-00-00';

SELECT location FROM hr;
-- Duplicates
select emp_id,count(*)
from hr
group by emp_id
having count(*)>1;

-- Gender
select distinct(gender)
from hr;
-- Race
select distinct(race)
from hr;
-- missing values
select * 
from hr
where race is null or gender is null; 