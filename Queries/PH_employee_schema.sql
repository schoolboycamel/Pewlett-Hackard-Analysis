-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no)
);
-- Create employee table
CREATE TABLE employees (
	 emp_no INT NOT NULL,
	 birth_date DATE NOT NULL,
	 first_name VARCHAR NOT NULL,
	 last_name VARCHAR NOT NULL,
	 gender VARCHAR NOT NULL,
	 hire_date DATE NOT NULL,
	 PRIMARY KEY (emp_no)
);
--Create dept_manager table includin foreign keys
CREATE TABLE dept_managers (
	 dept_no VARCHAR NOT NULL,
	 emp_no INT NOT NULL,
     from_date DATE NOT NULL,
	 to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)	 
);
--Create salaries table
CREATE TABLE salaries (
	 emp_no INT NOT NULL,
	 salary INT NOT NULL,
	 from_date DATE NOT NULL, 
	 to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	 PRIMARY KEY (emp_no, from_date)
);
-- Create Dept_emp table 
CREATE TABLE dept_emp (
 	 emp_no INT NOT NULL,
	 dept_no VARCHAR NOT NULL,
	 from_date DATE NOT NULL,
	 to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees,
FOREIGN KEY (dept_no) REFERENCES departments,
	 PRIMARY KEY (emp_no, dept_no)
);
-- Create titles table
CREATE TABLE titles (
	 emp_no INT NOT NULL,
	 title VARCHAR NOT NULL,
	 from_date DATE NOT NULL,
	 to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees, 
	 PRIMARY KEY (emp_no, from_date, title)
);
--RUN CELL
SELECT * FROM departments; 	 
SELECT * FROM dept_emp;
SELECT * FROM dept_managers;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;

-- Retirement eligibility 
SELECT first_name, last_name
FROM employees 
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-1' AND '1988-12-31');

--find employees born in 1953 
SELECT first_name, last_name
FROM employees 
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

--find employees born in 1954 
SELECT first_name, last_name
FROM employees 
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

--find employees born in 1955 
SELECT first_name, last_name
FROM employees 
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement eligibility 
SELECT COUNT (first_name)
FROM employees 
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-1' AND '1988-12-31');

-- ADDING RETIREMENT INFO INTO A TABLE
SELECT e.emp_no,
    e.first_name,
e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-1' AND '1988-12-31')
     AND (de.to_date = '9999-01-01');

SELECT * FROM emp_info;
DROP TABLE retirement_info;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- NICKNAMES TO TABLES retirenment and employees 
SELECT ri.emp_no,
    ri.first_name,
ri.last_name,
    de.to_date
INTO current_emp
FROM retirement_info as ri 
LEFT JOIN dept_emp as de 
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

--NICKNAMES to tables departments and dept managers
SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
FROM departments as d 
LEFT JOIN dept_managers as dm 
ON d.dept_no = dm.dept_no;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO employee_count_by_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM salaries
ORDER BY to_date DESC;


-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_managers AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);

SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

SELECT ce.emp_no,
ce.first_name,
ce.last_name, 
d.dept_name
INTO sales_development_team
FROM current_emp as ce 
INNER JOIN dept_emp as de 
ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d 
ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Sales', 'Development');

SELECT * FROM sales_development_team;