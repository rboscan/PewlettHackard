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
