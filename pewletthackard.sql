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

CREATE OR REPLACE VIEW dept_emp_nd AS
SELECT a.emp_no, a.to_date, a.dept_no, a.from_date
FROM dept_emp AS a
LEFT OUTER JOIN dept_emp AS b
ON a.emp_no = b.emp_no 
AND a.to_date < b.to_date
WHERE b.emp_no IS NULL
ORDER BY a.to_date desc;

CREATE OR REPLACE VIEW title_nd AS
SELECT a.emp_no, a.to_date, a.title, a.from_date
FROM titles AS a
LEFT OUTER JOIN titles AS b
ON a.emp_no = b.emp_no 
AND a.to_date < b.to_date
WHERE b.emp_no IS NULL
ORDER BY a.to_date desc

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
ON t.emp_no = e.emp_no

-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT emp_no, last_name, first_name, gender, salary
FROM full_database;
-- 2. List employees who were hired in 1986.
SELECT *
FROM full_database
WHERE hire_date between '01/01/1986' and '12/31/1986'
ORDER BY hire_date DESC;
-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
CREATE OR REPLACE VIEW management AS
SELECT dm.dept_no, fdb.dept_name, dm.emp_no, fdb.last_name, fdb.first_name, dm.from_date, dm.to_date
FROM full_database AS fdb
INNER JOIN dept_manager as dm
ON dm.emp_no = fdb.emp_no
WHERE title = 'Manager'
ORDER BY dept_no ASC;
SELECT * FROM management
-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT  emp_no, last_name, first_name, dept_name
FROM full_database
ORDER BY length(emp_no), emp_no;
-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT *
FROM full_database
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'
-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT emp_no, last_name, first_name, dept_name
FROM full_database
WHERE dept_name = 'Sales'
ORDER BY length(emp_no), emp_no;
-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT emp_no, last_name, first_name, dept_name
FROM full_database
WHERE dept_name = 'Sales' OR dept_name = 'Development'
ORDER BY length(emp_no), emp_no;
-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) as "Frequency Count"
FROM full_database
GROUP BY last_name
ORDER BY "Frequency Count" DESC;
