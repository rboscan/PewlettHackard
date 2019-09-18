DROP TABLE departments;
DROP TABLE dept_emp;
DROP TABLE dept_manager;
DROP TABLE employees;
DROP TABLE salaries;
DROP TABLE titles;

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

SELECT d.dept_no, d.dept_name, e.emp_no, s.from_date, s.to_date, e.birth_date, e.gender, e.hire_date, s.salary, t.title  
FROM departments as d 
JOIN dept_emp AS de 
ON d.dept_no = de.dept_no
JOIN employees AS e
ON e.emp_no = de.emp_no
JOIN salaries AS s
ON s.emp_no = e.emp_no
JOIN titles as t
ON t.emp_no = e.emp_no