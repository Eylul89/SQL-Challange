CREATE TABLE departments (
	dept_no varchar PRIMARY KEY,
	dept_name varchar
);

CREATE TABLE employees (
 	emp_no integer PRIMARY KEY,
 	birth_date date,
 	first_name varchar,
 	last_name varchar,
 	gender varchar(1),
 	hire_date date
);

CREATE TABLE dept_emp (
	emp_no integer REFERENCES employees(emp_no),
	dept_no varchar REFERENCES departments(dept_no),
	from_date date,
	to_date date
);

CREATE TABLE dept_manager (
	dept_no varchar REFERENCES departments(dept_no),
	emp_no integer REFERENCES employees(emp_no),
	from_date date,
	to_date date
);

CREATE TABLE salaries (
	emp_no integer REFERENCES employees(emp_no),
	salary integer,
	from_date date,
	to_date date
);

CREATE TABLE titles (
	emp_no integer REFERENCES employees(emp_no),
	title varchar,
	from_date date,
	to_date date
);


-- List the following details of each employee: employee number, last name, first name, gender, and salary.

select a.emp_no, a.birth_date, a.first_name, a.last_name, a.gender, b.salary
from employees a, salaries b
where a.emp_no = b.emp_no;

-- List employees who were hired in 1986

select emp_no, first_name, last_name, hire_date from employees
where hire_date > '12/31/1985' and hire_date < '01/01/1987';

--List the manager of each department with the following information: department number,
-- department name, the manager's employee number, last name, first name, and start and end employment dates. 
select a.dept_no, a.dept_name, b.emp_no, b.first_name, b.last_name, c.from_date, c.to_date
from dept_manager c
join departments a ON c.dept_no = a.dept_no
join employees b ON c.emp_no = b.emp_no;

--List the department of each employee with the following information:
-- employee number, last name, first name, and department name.

SELECT a.emp_no, a.first_name, a.last_name, b.dept_name
FROM employees a
JOIN dept_emp c ON a.emp_no = c.emp_no
JOIN departments b ON b.dept_no = c.dept_no;

--List all employees whose first name is "Hercules" and last names begin with "B."

SELECT * FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- List all employees in the Sales department,
-- including their employee number, last name, first name, and department name.

SELECT a.emp_no, a.last_name, a.first_name, b.dept_name
FROM employees a
JOIN dept_emp c ON a.emp_no = c.emp_no
JOIN departments b ON b.dept_no = c.dept_no
WHERE b.dept_name = 'Sales';

-- List all employees in the Sales and Development departments,
-- including their employee number, last name, first name, and department name.

SELECT a.emp_no, a.last_name, a.first_name, b.dept_name
FROM employees a
JOIN dept_emp c ON a.emp_no = c.emp_no
JOIN departments b ON b.dept_no = c.dept_no
WHERE b.dept_name = 'Sales'
OR b.dept_name = 'Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY last_name DESC;

