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
SELECT first_name, last_name
INTO retirement_info
FROM employees 
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-1' AND '1988-12-31');

SELECT * FROM retirement_info;