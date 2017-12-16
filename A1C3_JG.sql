CREATE DATABASE Ejercicio_1_MySQLNov2017;
USE Ejercicio_1_MySQLNov2017;

CREATE TABLE IF NOT EXISTS departments(
 name VARCHAR(50) NOT NULL DEFAULT 'PENDIENTE' PRIMARY KEY,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS jobs (
 name VARCHAR(50) NOT NULL PRIMARY KEY,
 department_id VARCHAR(50) NOT NULL,
 salary VARCHAR(10) NOT NULL,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 FOREIGN KEY(department_id) REFERENCES departments(name)
);


CREATE TABLE IF NOT EXISTS employees (
 id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
 first_name VARCHAR(25) NOT NULL,
 last_name VARCHAR(25) NOT NULL,
 job_id VARCHAR(50) NOT NULL,
 hire_date DATE NOT NULL,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 FOREIGN KEY(job_id) REFERENCES jobs(name)
);

INSERT INTO departments (name)
  VALUES ('Contraloria'),('Ventas'),('Sistemas');

INSERT INTO jobs (name, salary, department_id)
  VALUES 
  ('Contador',150000, 'Contraloria'),
  ('Auditor',45000, 'Contraloria'),
  ('Vendedor de alfombras',34000, 'Ventas'),
  ('Recolector', 87500,'Ventas'),
  ('Aguador',65000,'Ventas'),
  ('Programmer', 18000,'Sistemas'),
  ('Administrator', 75000, 'Sistemas'),
  ('Colleague', 66000, 'Sistemas');

INSERT INTO employees (first_name, last_name, hire_date,job_id)
	VALUES 
  ('Jose','Guerrero','2016-11-25', 'Contador'),
  ('Luis','Blake','2011-02-22','Auditor'),
  ('Juan','Scott','2009-08-01','Vendedor de alfombras'),
  ('Miguel','King','2006-09-04','Recolector'),
  ('Carlos','Gutierrez','1997-05-01','Aguador')
  ('Robert','Ford','2013-11-12','Programmer');



#1 Write a query to display the name (FIRST_NAME, LAST_NAME) and SALARY
for all employees whose salary is more than 50000
SELECT first_name, last_name FROM employees
  LEFT JOIN jobs ON employees.job_id = jobs.name
  WHERE salary > 50000;

#2 Write a query to display the name (FIRST_NAME, LAST_NAME) and DEPARTMENT_ID
SELECT first_name, last_name FROM employees
  LEFT JOIN jobs ON employees.job_id = jobs.name
  WHERE department_id = (SELECT name
                         FROM departments
                         ORDER BY job_id LIMIT 1);


#3 Write a query to display the name (FIRST_NAME, LAST_NAME) and SALARY
for all employees whose salary is less than 30000
SELECT first_name, last_name FROM employees
  LEFT JOIN jobs ON employees.job_id = jobs.name
  WHERE salary < 30000;
  

#4 Write a query to display the name (FIRST_NAME, LAST_NAME) and HIRE_DATE
for all employees who were hired before November 13
SELECT first_name, last_name, hire_date FROM employees
  WHERE MONTH(hire_date) <= 11 AND DAYOFMONTH(hire_date) < 13;


#5 Write a query to display the first_name of all employees who
have both "b" and "c" in their first name.
SELECT first_name FROM employees
  WHERE INSTR(first_name, 'b') AND INSTR(first_name,'c');


#6 Write a query to display the last name, job, and salary
for all employees whose job is that of a Programmer
SELECT first_name, last_name, job_id, salary FROM employees
  LEFT JOIN jobs ON employees.job_id = jobs.name
  WHERE job_id = "Programmer";


#7 Write a query to display the last name of employees whose
names have exactly 6 characters.
SELECT last_name FROM employees
WHERE CHAR_LENGTH(first_name) = 6;


#8 Write a query to display the last name of employees
 having 'e' as the third character.
 SELECT last_name FROM employees
   WHERE INSTR(last_name, 'e') = 3;

#9 Write a query to display the JOBS available in the employees table.

#10 Write a query to display the name (FIRST_NAME, LAST_NAME), 
SALARY and PF (15% of salary) of all employees
SELECT first_name, last_name, salary, salary*.15 AS 'PF' FROM employees
  LEFT JOIN jobs ON employees.job_id = jobs.name;


#11 Write a query to select all record from employees where
last name in 'BLAKE', 'SCOTT', 'KING' and 'FORD'
SELECT * FROM employees
  WHERE last_name = 'BLAKE' OR 
        last_name = 'SCOTT' OR 
        last_name = 'KING' OR 
        last_name = 'FORD';
