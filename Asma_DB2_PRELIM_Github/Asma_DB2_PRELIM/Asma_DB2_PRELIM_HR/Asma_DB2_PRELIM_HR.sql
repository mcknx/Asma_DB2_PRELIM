/**
* You can copy, modify, distribute and perform the work, even for commercial purposes, 
* all without asking permission. 
* 
*/

-- DROP SCHEMA

-- IF EXISTS hr;
-- 	CREATE SCHEMA hr COLLATE = utf8_general_ci;

-- USE hr;

/* *************************************************************** 
***************************CREATING TABLES************************
**************************************************************** */
CREATE TABLE asma_hr.regions (
	region_id INT NOT NULL,
	region_name VARCHAR(25),
	PRIMARY KEY (region_id)
	);

CREATE TABLE asma_hr.countries (
	country_id CHAR(2) NOT NULL,
	country_name VARCHAR(40),
	region_id INT NOT NULL,
	PRIMARY KEY (country_id)
);


CREATE TABLE asma_hr.locations (
	location_id SERIAL NOT NULL,
	street_address VARCHAR(40),
	postal_code VARCHAR(12),
	city VARCHAR(30) NOT NULL,
	state_province VARCHAR(25),
	country_id CHAR(2) NOT NULL,
	PRIMARY KEY (location_id)
	);

CREATE TABLE asma_hr.departments (
	department_id INT NOT NULL,
	department_name VARCHAR(30) NOT NULL,
	manager_id INT ,
	location_id INT ,
	PRIMARY KEY (department_id)
	);

CREATE TABLE asma_hr.jobs (
	job_id VARCHAR(10) NOT NULL,
	job_title VARCHAR(35) NOT NULL,
	min_salary DECIMAL(8, 0),
	max_salary DECIMAL(8, 0),
	PRIMARY KEY (job_id)
	);

CREATE TABLE asma_hr.employees (
	employee_id INT NOT NULL,
	first_name VARCHAR(20),
	last_name VARCHAR(25) NOT NULL,
	email VARCHAR(25) NOT NULL,
	phone_number VARCHAR(20),
	hire_date DATE NOT NULL,
	job_id VARCHAR(10) NOT NULL,
	salary DECIMAL(8, 2) NOT NULL,
	commission_pct DECIMAL(2, 2),
	manager_id INT,
	department_id INT,
	PRIMARY KEY (employee_id)
	);

CREATE TABLE asma_hr.job_history (
	employee_id INT NOT NULL,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	job_id VARCHAR(10) NOT NULL,
	department_id INT NOT NULL
	);

ALTER TABLE asma_hr.job_history ADD UNIQUE (
	employee_id,
	start_date
	);


CREATE VIEW asma_hr.emp_details_view
AS
SELECT e.employee_id,
	e.job_id,
	e.manager_id,
	e.department_id,
	d.location_id,
	l.country_id,
	e.first_name,
	e.last_name,
	e.salary,
	e.commission_pct,
	d.department_name,
	j.job_title,
	l.city,
	l.state_province,
	c.country_name,
	r.region_name
FROM employees e,
	departments d,
	jobs j,
	locations l,
	countries c,
	regions r
WHERE e.department_id = d.department_id
	AND d.location_id = l.location_id
	AND l.country_id = c.country_id
	AND c.region_id = r.region_id
	AND j.job_id = e.job_id;