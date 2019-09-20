-- Drops tables if they already exist, CASCADE command makes sure tables are dropped even if they're dependent on other tables.
-- Don't really know why I got that error.

DROP TABLE departments CASCADE;
DROP TABLE dept_emp CASCADE;
DROP TABLE dept_manager CASCADE;
DROP TABLE employees CASCADE;
DROP TABLE salaries CASCADE;
DROP TABLE titles CASCADE;

-- Creates tables for CSV's in folder, VARCHAR used for all INTs as information didn't need to be modified with arithmetic.

CREATE TABLE departments(
	dept_no VARCHAR,
	dept_name VARCHAR
);

CREATE TABLE dept_emp(
	emp_no VARCHAR,
	dept_no VARCHAR,
	from_date DATE,
	to_date DATE
);

CREATE TABLE dept_manager(
	dept_no VARCHAR,
	emp_no VARCHAR,
	from_date DATE,
	to_date DATE
);

CREATE TABLE employees(
	emp_no VARCHAR,
	birth_date DATE,
	first_name VARCHAR,
	last_name VARCHAR,
	gender VARCHAR,
	hire_date DATE
);

CREATE TABLE salaries(
	emp_no VARCHAR,
	salary VARCHAR,
	from_date DATE,
	to_date DATE
);

CREATE TABLE titles(
	emp_no VARCHAR,
	title VARCHAR,
	from_date DATE,
	to_date DATE
);

-- The next two CREATE OR REPLACE VIEWS iterate over the CSV and only keep the employee number with the most current date
-- so that employee entries are not duplicated in the database. 

CREATE OR REPLACE VIEW dept_emp_nd AS
SELECT a.emp_no, a.to_date, a.dept_no, a.from_date
FROM dept_emp a
LEFT OUTER JOIN dept_emp b
ON a.emp_no = b.emp_no 
AND a.to_date < b.to_date
WHERE b.emp_no IS NULL
ORDER BY a.to_date desc;

CREATE OR REPLACE VIEW title_nd AS
SELECT a.emp_no, a.to_date, a.title, a.from_date
FROM titles a
LEFT OUTER JOIN titles b
ON a.emp_no = b.emp_no 
AND a.to_date < b.to_date
WHERE b.emp_no IS NULL
ORDER BY a.to_date desc;

-- Main JOIN for the entire employee database without duplicates containing the most up to date entry and title
-- for each employee in the company as well as all relevant HR information.

CREATE OR REPLACE VIEW full_database AS
SELECT d.dept_no, d.dept_name, s.emp_no, e.first_name, e.last_name, e.gender, e.hire_date, de.from_date, de.to_date, s.salary, t.title
FROM departments AS d 
JOIN dept_emp_nd AS de 
ON d.dept_no = de.dept_no
JOIN employees AS e
ON e.emp_no = de.emp_no
JOIN salaries AS s
ON s.emp_no = e.emp_no
JOIN title_nd AS t
ON t.emp_no = e.emp_no;