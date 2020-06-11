SELECT student_name
FROM students
WHERE age BETWEEN 18 AND 20; 

SELECT *
FROM students
WHERE student_name LIKE '%ch%' OR student_name LIKE '%nd';

SELECT student_name
FROM students
WHERE (student_name LIKE '%ae%' OR student_name LIKE '%ph%') AND age != 19;

SELECT student_name
FROM students
ORDER BY age DESC;

SELECT student_name, age
FROM students
ORDER BY age DESC
LIMIT 4;

SELECT *
FROM students
WHERE (age <=20 AND ((student_no BETWEEN 3 AND 5) OR student_no = 7))
OR (age > 20 AND student_no>=4);

SELECT UPPER(first_name), LOWER(department)
FROM employees;

SELECT LENGTH(first_name)
FROM employees;

SELECT LENGTH(TRIM('    HELLO THERE.   '));

SELECT first_name || ' ' || last_name AS full_name, (salary> 100000) AS is_highly_paid 
FROM employees
ORDER BY salary DESC;

SELECT department, ('Clothing' IN (department, first_name))
FROM employees;

SELECT department, (department LIKE '%oth%')
FROM employees;

--Pick up the Words
SELECT SUBSTRING('This is test data' FROM 1 FOR 4) AS test_data_extracted;
SELECT SUBSTRING('This is test data' FROM 9 FOR 4) AS test_data_extracted;
SELECT SUBSTRING('This is test data' FROM 9) AS test_data_extracted;

SELECT * FROM departments;

--Replace Any Value (Except Null)
SELECT department, REPLACE(department, 'Clothing', 'Attire') AS modified_data, department || ' department' AS "Complet Department Name"
FROM departments;

--Collect Info after a Certain Character
SELECT SUBSTRING(email, POSITION('@' IN email) +1) AS domain_name
FROM employees;

--Replace Null Value
SELECT COALESCE(email, 'NONE') AS email
FROM employees;

SELECT MAX(salary) FROM employees;
SELECT ROUND(AVG(salary)) FROM employees;
SELECT COUNT(employee_id) FROM employees;
SELECT COUNT(email) FROM employees;
SELECT SUM(salary) FROM employees;
SELECT SUM(salary) FROM employees WHERE department='Clothing';
SELECT department, SUM(salary) AS total_payments FROM employees GROUP BY department;

SELECT * FROM professors;
SELECT last_name || ' works in the ' || department || ' department'FROM professors LIMIT 1;
SELECT 'It is ' || (salary>95000) || ' that professor ' || last_name || ' is highly paid' FROM professors;
SELECT last_name, SUBSTRING(UPPER(department) FROM 1 FOR 3), salary, hire_date FROM professors;
SELECT MAX(salary), MIN(salary) FROM professors WHERE last_name<>'Wilson';
SELECT MIN(hire_date) FROM professors;

--GROUP BY
CREATE TABLE cars(make varchar(10));
SELECT * FROM cars;
INSERT INTO cars VALUES ('HONDA');
INSERT INTO cars VALUES ('HONDA');
INSERT INTO cars VALUES ('HONDA');
INSERT INTO cars VALUES ('HONDA');
INSERT INTO cars VALUES ('TOYOTA');
INSERT INTO cars VALUES ('TOYOTA');
INSERT INTO cars VALUES ('NISSAN');

SELECT COUNT(*), make FROM cars GROUP BY make;

INSERT INTO cars VALUES ('NULL');
INSERT INTO cars VALUES ('NULL');
INSERT INTO cars VALUES ('NULL');
INSERT INTO cars VALUES ('NULL');

SELECT COUNT(*), make FROM cars GROUP BY make;

SELECT department, SUM(salary) AS budget FROM employees GROUP BY department ORDER BY budget DESC;
SELECT department, SUM(salary) FROM employees WHERE region_id IN (4,5,6,7) GROUP BY department;
SELECT department, COUNT(*) FROM employees GROUP BY department;
SELECT department, COUNT(*) AS total_number_employees, ROUND(AVG(salary)) AS avg_salary, MIN(salary) AS min_salary, MAX(salary) AS max_salary FROM employees GROUP BY department ORDER BY total_number_employees DESC;
SELECT department, gender, COUNT(*) FROM employees GROUP BY department, gender ORDER BY department;

SELECT department, COUNT(*) FROM employees GROUP BY department HAVING COUNT(*)>35 ORDER BY department;

SELECT * FROM employees;
SELECT first_name, COUNT(*) FROM employees GROUP BY first_name HAVING COUNT(*) >= 2;
SELECT department FROM employees GROUP BY department;
SELECT DISTINCT department FROM employees;
SELECT SUBSTRING(email,POSITION('@' IN email)+1) AS domain_name, COUNT (*) FROM employees WHERE email IS NOT NULL GROUP BY domain_name ORDER BY COUNT(*) DESC;
SELECT gender, region_id, MIN(salary) AS min_salary, MAX(salary) AS max_salary, AVG(salary) AS avg_salary FROM employees GROUP BY gender, region_id ORDER BY gender, region_id ASC;

-- Assignment 3
CREATE TABLE fruit_imports
(
	id integer,
	name varchar(20),
	season varchar(10),
	state varchar(20),
	supply integer,
	cost_per_unit decimal
);

insert into fruit_imports values(1, 'Apple', 'All Year', 'Kansas', 32900, 0.22);
insert into fruit_imports values(2, 'Avocado', 'All Year', 'Nebraska', 27000, 0.15);
insert into fruit_imports values(3, 'Coconut', 'All Year', 'California', 15200, 0.75);
insert into fruit_imports values(4, 'Orange', 'Winter', 'California', 17000, 0.22);
insert into fruit_imports values(5, 'Pear', 'Winter', 'Iowa', 37250, 0.17);
insert into fruit_imports values(6, 'Lime', 'Spring', 'Indiana', 40400, 0.15);
insert into fruit_imports values(7, 'Mango', 'Spring', 'Texas', 13650, 0.60);
insert into fruit_imports values(8, 'Orange', 'Spring', 'Iowa', 18000, 0.26);
insert into fruit_imports values(9, 'Apricot', 'Spring', 'Indiana', 55000, 0.20);
insert into fruit_imports values(10, 'Cherry', 'Summer', 'Texas', 62150, 0.02);
insert into fruit_imports values(11, 'Cantaloupe', 'Summer', 'Texas', 8000, 0.49);
insert into fruit_imports values(12, 'Apricot', 'Summer', 'Kansas', 14500, 0.20);
insert into fruit_imports values(13, 'Mango', 'Summer', 'Texas', 17000, 0.68);
insert into fruit_imports values(14, 'Pear', 'Fall', 'Nebraska', 30500, 0.12);
insert into fruit_imports values(15, 'Grape', 'Fall', 'Illinois', 72500, 0.35);

SELECT * FROM fruit_imports;
SELECT state, SUM(supply) AS total_supply FROM fruit_imports GROUP BY state ORDER BY total_supply DESC LIMIT 1;
SELECT season, MAX(cost_per_unit) FROM fruit_imports GROUP BY season;
SELECT state, COUNT(name) FROM fruit_imports GROUP BY state HAVING COUNT(name)>1 ;
SELECT season, COUNT(name) FROM fruit_imports GROUP BY season HAVING COUNT(name) IN (3,4);
SELECT state, SUM(supply*cost_per_unit) AS total_cost FROM fruit_imports GROUP BY state ORDER BY total_cost DESC LIMIT 1;

CREATE table fruits (fruit_name varchar(10));
INSERT INTO fruits VALUES ('Orange');
INSERT INTO fruits VALUES ('Apple');
INSERT INTO fruits VALUES (NULL);
INSERT INTO fruits VALUES (NULL);

SELECT * FROM fruits;
SELECT COUNT(fruit_name IS NULL) FROM fruits;
--or
SELECT COUNT(COALESCE(fruit_name, 'SOMEVALUE')) FROM fruits;

SELECT employees.department
FROM employees, departments;

SELECT e.department
FROM employees AS e, departments AS d;

SELECT department
FROM (SELECT * FROM departments) AS d;

SELECT * FROM employees
WHERE department NOT IN (SELECT department FROM departments);

SELECT *
FROM (SELECT * FROM employees WHERE salary>150000) AS a;

SELECT a.employee_name, a.yearly_salary
FROM (SELECT first_name AS employee_name, salary AS yearly_salary
	 FROM employees WHERE salary>150000) AS a;
	 
SELECT * FROM (SELECT department FROM departments) AS a;

SELECT first_name, salary, (SELECT first_name FROM employees LIMIT 1)
FROM employees;

SELECT * FROM departments;

SELECT * FROM (SELECT department FROM departments WHERE division = 'Electronics') AS a;
SELECT * FROM employees WHERE department 
	IN (SELECT department FROM departments WHERE division = 'Electronics');

SELECT * FROM employees;
SELECT * FROM regions;

SELECT * FROM employees WHERE 
	region_id IN (SELECT region_id FROM regions WHERE country ='Asia' OR country ='Canada') 
	AND salary>130000;
	
SELECT first_name, department, salary, (SELECT MAX(salary) FROM employees), (SELECT MAX(salary) FROM employees)-salary 
FROM employees WHERE region_id IN (SELECT region_id FROM regions WHERE country ='Asia' OR country ='Canada');

SELECT * FROM employees
WHERE department = ANY (SELECT department FROM departments WHERE division = 'Kids') AND hire_date > ALL (SELECT hire_date FROM employees WHERE department = 'Maintenance');

SELECT salary FROM (SELECT salary, COUNT(*) FROM employees GROUP BY salary ORDER BY COUNT(*) DESC LIMIT 1) AS a;
SELECT salary FROM employees GROUP BY salary HAVING COUNT(*)>= ALL(SELECT COUNT(*) FROM employees GROUP BY salary) ORDER BY salary DESC LIMIT 1;

CREATE TABLE dupes (id integer, name varchar(10));

INSERT INTO dupes VALUES (1, 'FRANK');
INSERT INTO dupes VALUES (2, 'FRANK');
INSERT INTO dupes VALUES (3, 'ROBERT');
INSERT INTO dupes VALUES (4, 'ROBERT');
INSERT INTO dupes VALUES (5, 'SAM');
INSERT INTO dupes VALUES (6, 'FRANK');
INSERT INTO dupes VALUES (7, 'PETER');

SELECT * FROM dupes;

SELECT MIN(id), name FROM dupes GROUP BY name;
--or
SELECT * FROM dupes WHERE id IN (
	SELECT MIN(id) FROM dupes GROUP BY name);
	
DELETE FROM dupes WHERE id NOT IN (
	SELECT MIN(id) FROM dupes GROUP BY name);

SELECT * FROM dupes;

DROP TABLE dupes;

SELECT ROUND(AVG(salary)) FROM employees WHERE
	salary <> (SELECT MAX(salary) FROM employees)
	AND salary <> (SELECT MIN(salary) FROM employees);
	
--OR

SELECT ROUND(AVG(salary)) FROM employees WHERE
	salary NOT IN ((SELECT MAX(salary) FROM employees),(SELECT MIN(salary) FROM employees));

SELECT * FROM students;
SELECT * FROM student_enrollment;
SELECT * FROM courses;

--Using subqueries only, write a SQL statement that returns the names of those students that are taking the courses  Physics and US History.

SELECT student_name FROM students WHERE student_no = ANY (SELECT student_no FROM student_enrollment WHERE course_no = (SELECT course_no FROM courses WHERE course_title ='Physics'));
SELECT student_name FROM students WHERE student_no = ANY (SELECT student_no FROM student_enrollment WHERE course_no = (SELECT course_no FROM courses WHERE course_title ='US History'));
SELECT student_no FROM student_enrollment WHERE course_no = (SELECT course_no FROM courses WHERE course_title ='Physics');
SELECT student_no FROM student_enrollment WHERE course_no = (SELECT course_no FROM courses WHERE course_title ='US History');

SELECT student_name FROM students WHERE	
	student_no = ANY (SELECT student_no FROM student_enrollment WHERE course_no = (SELECT course_no FROM courses WHERE course_title ='Physics')) AND
					student_no = ANY (SELECT student_no FROM student_enrollment WHERE course_no = (SELECT course_no FROM courses WHERE course_title ='US History'));

--Using subqueries only, write a query that returns the name of the student that is taking the highest number of courses. 

SELECT student_no FROM student_enrollment GROUP BY student_no ORDER BY COUNT(*) DESC LIMIT 1;

SELECT student_name FROM students WHERE student_no = (SELECT student_no FROM student_enrollment GROUP BY student_no ORDER BY COUNT(*) DESC LIMIT 1);

--Write a query to find the student that is the oldest. You are not allowed to use LIMIT or the ORDER BY clause to solve this problem.

SELECT student_name FROM students WHERE age = (SELECT MAX(age) FROM students);

--CASE

SELECT * FROM employees;

SELECT first_name, salary,
CASE
	WHEN salary < 100000 THEN 'UNDERPAID'
	WHEN salary > 100000 THEN 'PAID WELL'
END
FROM employees
ORDER BY salary DESC;

SELECT first_name, salary,
CASE
	WHEN salary < 100000 THEN 'UNDERPAID'
	WHEN salary > 100000 AND salary < 160000 THEN 'PAID WELL'
	ELSE 'EXECUTIVE'
END AS category
FROM employees
ORDER BY salary DESC;

SELECT category, COUNT(*) FROM 
	(SELECT
	CASE
		WHEN salary < 100000 THEN 'UNDERPAID'
		WHEN salary > 100000 AND salary < 160000 THEN 'PAID WELL'
		ELSE 'EXECUTIVE'
	END
	FROM employees) AS category
	GROUP BY category;
--OR
SELECT a.category, COUNT(*) FROM 
	(SELECT
	CASE
		WHEN salary < 100000 THEN 'UNDERPAID'
		WHEN salary > 100000 AND salary < 160000 THEN 'PAID WELL'
		ELSE 'EXECUTIVE'
	END AS category
	FROM employees) AS a
	GROUP BY category;

SELECT SUM (CASE WHEN salary < 100000 THEN 1 ELSE 0 END) AS under_paid,
	SUM (CASE WHEN salary > 100000 AND salary < 160000 THEN 1 ELSE 0 END) AS paid_well,
	SUM (CASE WHEN salary > 160000 THEN 1 ELSE 0 END) AS executive
	FROM employees;
	
SELECT department, COUNT(*)
FROM employees
WHERE department IN ('Sports','Tools','Clothing','Computers')
GROUP BY department;
--Transpose
SELECT SUM(CASE WHEN department = 'Sports' THEN 1 ELSE 0 END) AS sports_employees,
	SUM(CASE WHEN department = 'Tools' THEN 1 ELSE 0 END) AS tools_employees,
	SUM(CASE WHEN department = 'Clothing' THEN 1 ELSE 0 END) AS clothing_employees,
	SUM(CASE WHEN department = 'Computer' THEN 1 ELSE 0 END) AS computers_employees
	FROM employees;
	
SELECT * FROM employees;
SELECT * FROM regions;

SELECT first_name, (CASE WHEN employees.region_id = 1 THEN regions.country END) AS region_1,
	(CASE WHEN employees.region_id = 2 THEN regions.country END) AS region_2,
	(CASE WHEN employees.region_id = 3 THEN regions.country END) AS region_3,
	(CASE WHEN employees.region_id = 4 THEN regions.country END) AS region_4,
	(CASE WHEN employees.region_id = 5 THEN regions.country END) AS region_5,
	(CASE WHEN employees.region_id = 6 THEN regions.country END) AS region_6,
	(CASE WHEN employees.region_id = 7 THEN regions.country END) AS region_7
FROM employees, regions
WHERE (CASE WHEN employees.region_id = regions.region_id THEN regions.country END) IS NOT NULL;
--OR BELOW IS NICER
SELECT first_name, CASE WHEN employees.region_id = 1 THEN (SELECT country FROM regions WHERE region_id = 1) END AS region_1,
CASE WHEN employees.region_id = 2 THEN (SELECT country FROM regions WHERE region_id = 2) END AS region_2,
CASE WHEN employees.region_id = 3 THEN (SELECT country FROM regions WHERE region_id = 3) END AS region_3,
CASE WHEN employees.region_id = 4 THEN (SELECT country FROM regions WHERE region_id = 4) END AS region_4,
CASE WHEN employees.region_id = 5 THEN (SELECT country FROM regions WHERE region_id = 5) END AS region_5,
CASE WHEN employees.region_id = 6 THEN (SELECT country FROM regions WHERE region_id = 6) END AS region_6,
CASE WHEN employees.region_id = 7 THEN (SELECT country FROM regions WHERE region_id = 7) END AS region_7
FROM employees;


SELECT SUM(CASE WHEN a.country = 'United States' THEN 1 ELSE 0 END) AS United_States,
SUM(CASE WHEN a.country = 'Asia' THEN 1 ELSE 0 END) AS Asia,
SUM(CASE WHEN a.country = 'Canada' THEN 1 ELSE 0 END) AS Canada
FROM (
SELECT first_name, country
FROM employees, regions
WHERE (CASE WHEN employees.region_id = regions.region_id THEN regions.country END) IS NOT NULL
) AS a;
--OR
SELECT COUNT(a.region_1) + COUNT(a.region_2) + COUNT(a.region_3) AS United_States,
COUNT(a.region_4) + COUNT(a.region_5) AS Asia,
COUNT(a.region_6) + COUNT(a.region_7) AS Canada
FROM (
SELECT first_name, CASE WHEN employees.region_id = 1 THEN (SELECT country FROM regions WHERE region_id = 1) END AS region_1,
CASE WHEN employees.region_id = 2 THEN (SELECT country FROM regions WHERE region_id = 2) END AS region_2,
CASE WHEN employees.region_id = 3 THEN (SELECT country FROM regions WHERE region_id = 3) END AS region_3,
CASE WHEN employees.region_id = 4 THEN (SELECT country FROM regions WHERE region_id = 4) END AS region_4,
CASE WHEN employees.region_id = 5 THEN (SELECT country FROM regions WHERE region_id = 5) END AS region_5,
CASE WHEN employees.region_id = 6 THEN (SELECT country FROM regions WHERE region_id = 6) END AS region_6,
CASE WHEN employees.region_id = 7 THEN (SELECT country FROM regions WHERE region_id = 7) END AS region_7
FROM employees
) AS a;


--Write a query that displays 3 columns. The query should display the fruit and it's total supply along with a category of either LOW, ENOUGH or FULL. 
--Low category means that the total supply of the fruit is less than 20,000.  The enough category means that the total supply is between 20,000 and 50,000. 
--If the total supply is greater than 50,000 then that fruit falls in the full category.
SELECT * FROM fruit_imports;

SELECT name, total_supply,
CASE WHEN total_supply < 20000 THEN 'LOW'
     WHEN total_supply >= 20000 AND total_supply <= 50000 THEN 'ENOUGH'
     WHEN total_supply > 50000 THEN 'FULL'
END as category
FROM (
SELECT name, sum(supply) AS total_supply
FROM fruit_imports
GROUP BY name
    ) a;

--Taking into consideration the supply column and the cost_per_unit column, you should be able to tabulate the total cost to import fruits by each season. 
--The result will look something like this:
--"Winter" "10072.50"
--"Summer" "19623.00"
--"All Year" "22688.00"
--"Spring" "29930.00"
--"Fall" "29035.00"
--Write a query that would transpose this data so that the seasons become columns and the total cost for each season fills the first row?

SELECT season, SUM(supply*cost_per_unit)
FROM fruit_imports
GROUP BY season;

SELECT SUM(CASE WHEN a.season='Winter' THEN a.total END) AS Winter,
	SUM(CASE WHEN a.season='Summer' THEN a.total END) AS Summer,
	SUM(CASE WHEN a.season='All Year' THEN a.total END) AS All_Year,
	SUM(CASE WHEN a.season='Spring' THEN a.total END) AS Spring,
	SUM(CASE WHEN a.season='Fall' THEN a.total END) AS Fall
FROM (
	SELECT season, SUM(supply*cost_per_unit) AS total
	FROM fruit_imports
	GROUP BY season
)AS a;

SELECT first_name, salary
FROM employees
WHERE salary > (SELECT ROUND(AVG(salary)) FROM employees);
		
--CORRELATED QUERY
SELECT first_name, salary
FROM employees AS e1
WHERE salary > (SELECT ROUND(AVG(salary)) 
				FROM employees AS e2
			   	WHERE e1.department = e2.department);
		
SELECT first_name, salary
FROM employees AS e1
WHERE salary > (SELECT ROUND(AVG(salary)) 
				FROM employees AS e2
			   	WHERE e1.region_id = e2.region_id);			

SELECT first_name, department, salary, 
(SELECT ROUND(AVG(salary)) 
 FROM employees AS e2 
 WHERE e1.department = e2.department) AS avg_department_salary
FROM employees AS e1;

SELECT department, a.total_department
FROM (SELECT department, COUNT(*) AS total_department 
	  FROM employees
	  GROUP BY department) AS a
WHERE a.total_department>38;

SELECT department, COUNT(*) AS total_department 
	  FROM employees
	  GROUP BY department;
	  
SELECT DISTINCT department
FROM employees AS e1
WHERE (SELECT COUNT(*) 
	  FROM employees AS e2
	  WHERE e1.department=e2.department) > 38;
	  
SELECT department
FROM employees AS e1
WHERE (SELECT COUNT(*) 
	  FROM employees AS e2
	  WHERE e1.department=e2.department) > 38
GROUP BY e1.department
;

SELECT d.department, 
	(SELECT MAX(salary) FROM employees WHERE department=d.department) AS max_salary
FROM departments AS d
WHERE (SELECT COUNT(*) 
	  FROM employees AS e2
	  WHERE d.department=e2.department) > 38;
	 
SELECT department, MAX(salary)
FROM employees
GROUP BY department;

SELECT * FROM employees;

SELECT department, first_name, MAX(salary), MIN(salary)
FROM employees 
GROUP BY department, first_name;

SELECT department, first_name, salary,
	(SELECT MAX(salary) FROM employees AS e1 WHERE e1.department = e2.department)
FROM employees AS e2 ORDER BY department;

SELECT department, first_name, salary,
	(SELECT MAX(salary) FROM employees AS e1 WHERE e1.department = e2.department) AS max_salary, 
	(SELECT MIN(salary) FROM employees AS e1 WHERE e1.department = e2.department) AS min_salary
FROM employees AS e2 ORDER BY department;


SELECT a.department, a.first_name, a.salary,
	CASE 
		WHEN a.salary=a.max_salary THEN 'HIGH SALARY' 
		WHEN a.salary=a.min_salary THEN 'LOW SALARY'
	END
FROM
	(SELECT department, first_name, salary,
		(SELECT MAX(salary) FROM employees AS e1 WHERE e1.department = e2.department) AS max_salary, 
		(SELECT MIN(salary) FROM employees AS e1 WHERE e1.department = e2.department) AS min_salary
	FROM employees AS e2 ORDER BY department) AS a
WHERE a.salary IN (a.max_salary,a.min_salary)
ORDER BY 1;


--JOIN SESSION
SELECT first_name, country
FROM employees AS e, regions AS r
WHERE e.region_id = r.region_id;

SELECT first_name, email, e.department, division, country
FROM employees AS e, departments AS d, regions AS r
WHERE e.department = d.department 
AND e.region_id = r.region_id
AND email IS NOT NULL;


SELECT country, COUNT(first_name) AS total_employee
FROM employees AS e, regions AS r
WHERE e.region_id = r.region_id
GROUP BY country;

SELECT first_name, country
FROM employees INNER JOIN regions
ON employees.region_id = regions.region_id;

SELECT first_name, email, division
FROM employees INNER JOIN departments
ON employees.department = departments.department
WHERE email IS NOT NULL;

SELECT first_name, email, division, country
FROM employees INNER JOIN departments
ON employees.department = departments.department
INNER JOIN regions
ON employees.region_id = regions.region_id
WHERE email IS NOT NULL;

-- 27 departments
SELECT DISTINCT department FROM employees;

-- 24 departments
SELECT DISTINCT department FROM departments;

-- INNER JOIN
SELECT DISTINCT employees.department, departments.department
FROM employees INNER JOIN departments
ON employees.department = departments.department;

-- FULL OUTER JOIN
SELECT DISTINCT employees.department, departments.department
FROM employees FULL OUTER JOIN departments
ON employees.department = departments.department;

-- LEFT (OUTER) JOIN
SELECT DISTINCT employees.department, departments.department
FROM employees LEFT JOIN departments
ON employees.department = departments.department;

-- RIGHT (OUTER) JOIN
SELECT DISTINCT employees.department, departments.department
FROM employees RIGHT JOIN departments
ON employees.department = departments.department;

SELECT ref_1.e
FROM (
	SELECT DISTINCT employees.department AS e, departments.department AS d
	FROM employees LEFT JOIN departments
	ON employees.department = departments.department
) AS ref_1
WHERE ref_1.d IS NULL;
--OR
SELECT DISTINCT employees.department AS employees_department
FROM employees LEFT JOIN departments ON employees.department = departments.department
WHERE departments.department IS NULL;

SELECT department FROM employees
UNION
SELECT department FROM departments;

SELECT DISTINCT department FROM employees
UNION ALL
SELECT department FROM departments;


SELECT DISTINCT department FROM employees
UNION ALL
SELECT department FROM departments
ORDER BY department;

SELECT DISTINCT department FROM employees
EXCEPT
SELECT department FROM departments;

SELECT department FROM departments
EXCEPT
SELECT department FROM employees;

SELECT department, COUNT(employee_id)
FROM employees GROUP BY department
UNION ALL
SELECT 'TOTAL', COUNT(*)
FROM employees;

SELECT * FROM employees, departments;
SELECT COUNT(*) FROM (SELECT * FROM employees, departments) AS a;
--SAME AS
SELECT * FROM employees CROSS JOIN departments;
SELECT COUNT(*) FROM (SELECT * FROM employees CROSS JOIN departments) AS a;


-- List the employees who got hired earlist and latest
SELECT MAX(hire_date), MIN(hire_date)
FROM employees;

SELECT first_name, department, hire_date, country
FROM employees LEFT JOIN regions ON employees.region_id = regions.region_id;

SELECT first_name, department, hire_date
FROM employees AS e1, (SELECT MAX(hire_date) AS oldest, MIN(hire_date) AS youngest FROM employees) AS a
WHERE hire_date IN (a.oldest, a.youngest);

SELECT first_name, department, hire_date, country
FROM(
	SELECT first_name, department, hire_date, region_id
	FROM employees, (SELECT MAX(hire_date) AS oldest, MIN(hire_date) AS youngest FROM employees) AS a
	WHERE hire_date IN (a.oldest, a.youngest)
) AS e1 LEFT JOIN regions ON e1.region_id = regions.region_id;
--OR BUT LIMIT 1
(SELECT first_name, department, hire_date, country
FROM employees e INNER JOIN regions r
ON e.region_id = r.region_id
WHERE hire_date= (SELECT MIN(hire_date) FROM employees e2)
LIMIT 1)
UNION
SELECT first_name, department, hire_date, country
FROM employees e INNER JOIN regions r
ON e.region_id = r.region_id
WHERE hire_date= (SELECT MIN(hire_date) FROM employees e2)
ORDER BY hire_date;

--CREATE VIEW
CREATE VIEW v_employee_info AS
SELECT first_name, email, e.department, salary, division, region, country
FROM employees e, departments d, regions r
WHERE e.department = d.department
AND e.region_id = r.region_id;

SELECT * FROM v_employee_info;

--INLINE
SELECT * FROM (SELECT * FROM employees);

--OVER(PARTITION BY...) 
SELECT first_name, department, 
(SELECT COUNT(*) FROM employees e1 WHERE e1.department=e2.department)
FROM employees e2
ORDER BY department;

SELECT first_name, department, 
COUNT(*) OVER()
FROM employees e2;

SELECT first_name, department, 
COUNT(*) OVER(PARTITION BY department)
FROM employees e2;

--INSPECT DATA
(SELECT first_name, department, 
(SELECT COUNT(*) FROM employees e1 WHERE e1.department=e2.department)
FROM employees e2
ORDER BY department)
EXCEPT
SELECT first_name, department, 
COUNT(*) OVER(PARTITION BY department)
FROM employees e2;

SELECT first_name, department, 
SUM(salary) OVER(PARTITION BY department)
FROM employees e2;

SELECT first_name, department, 
SUM(salary) OVER()
FROM employees e2;

SELECT first_name, department, 
COUNT(*) OVER(PARTITION BY department) dep_count,
region_id,
COUNT(*) OVER(PARTITION BY region_id) region_count
FROM employees e2;

SELECT first_name, department, COUNT(*) OVER()
FROM employees;

SELECT first_name, department, COUNT(*) OVER()
FROM employees
WHERE region_id=1;

SELECT first_name, department, COUNT(*) OVER(PARTITION BY department)
FROM employees
WHERE region_id=1;


--ORDERING DATA IN WINDOW FRAMES
SELECT first_name, hire_date, salary,
SUM(salary) OVER(ORDER BY hire_date RANGE BETWEEN UNBOUNDED PRECEDING
				AND CURRENT ROW) AS running_total_of_salaries
FROM employees;
--AS SAME AS (DEFAULT)
SELECT first_name, hire_date, salary,
SUM(salary) OVER(ORDER BY hire_date) AS running_total_of_salaries
FROM employees;

--RUNNING BY DEPPARTMENT
SELECT first_name, hire_date, department, salary,
SUM(salary) OVER(PARTITION BY department ORDER BY hire_date) AS running_total_of_salaries
FROM employees;

--ADDING PREVIOUS ROW WITH CURRENT ROW
SELECT first_name, hire_date, department, salary,
SUM(salary) OVER(ORDER BY hire_date ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS running_total_of_salaries
FROM employees;

--ADDING 3 PREVIOUS ROWS WITH CURRENT ROW
SELECT first_name, hire_date, department, salary,
SUM(salary) OVER(ORDER BY hire_date ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) AS running_total_of_salaries
FROM employees;

--ADDING 1000 PREVIOUS ROWS WITH CURRENT ROW = TOTAL SALARY
SELECT first_name, hire_date, department, salary,
SUM(salary) OVER(ORDER BY hire_date ROWS BETWEEN 1000 PRECEDING AND CURRENT ROW) AS running_total_of_salaries
FROM employees;

SELECT SUM(salary) FROM employees;

--RANK()
SELECT first_name, email, department, salary,
RANK() OVER(PARTITION BY department ORDER BY salary DESC)
FROM employees;

SELECT * FROM (
	SELECT first_name, email, department, salary,
	RANK() OVER(PARTITION BY department ORDER BY salary DESC)
	FROM employees
) AS a WHERE rank = '8';

--RANK THE SALARY AND SEPERATE THEM INTO 5 GROUPS
SELECT first_name, email, department, salary,
NTILE(5) OVER(PARTITION BY department ORDER BY salary DESC)
FROM employees;

--SHOW THE FIRST HIGHEST SALARY VALUE BY DEPARTMENT
SELECT first_name, email, department, salary,
FIRST_VALUE(salary) OVER(PARTITION BY department ORDER BY salary DESC)
FROM employees;
--SAME AS...
SELECT first_name, email, department, salary,
MAX(salary) OVER(PARTITION BY department ORDER BY salary DESC)
FROM employees;

--START FROM NTH VALUE
SELECT first_name, email, department, salary,
NTH_VALUE(salary,5) OVER(PARTITION BY department ORDER BY salary DESC)
FROM employees;

--FOLLOW THE NEXT VALUE: LEAD()
SELECT first_name, last_name, salary,
LEAD(salary) OVER() AS next_salary
FROM employees;

--FOLLOW THE PREVIOUS VALUE: LAG()
SELECT first_name, last_name, salary,
LAG(salary) OVER() AS previous_salary
FROM employees;

SELECT first_name, last_name, salary,
LAG(salary) OVER(ORDER BY salary DESC) AS closest_higher_salary
FROM employees;







