/* Similar to the exercises done in the lecture, obtain a result set containing the employee 
number, first name, and last name of all employees with a number higher than 109990. 
Create a fourth column in the query, indicating whether this employee is also a manager, 
according to the data provided in the dept_manager table, or a regular employee.*/

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
WHERE
    e.emp_no > 109990; 
    
/* Extract a dataset containing the following information about the managers: employee number, 
first name, and last name. Add two columns at the end – one showing the difference between 
the maximum and minimum salary of that employee, and another one saying whether this salary raise was higher than $30,000 or NOT.
If possible, provide more than one solution.*/

SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN COUNT(s.emp_no) > 1 THEN (MAX(salary) - MIN(salary))
        ELSE 'this employee have only one contract'
    END AS salary_difference,
    CASE
        WHEN (MAX(salary) - MIN(salary)) > 30000 THEN 'this salary raise was higher than $30,000'
        ELSE 'this salary raise was NOT higher than $30,000'
    END AS raise_over_30000
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
        JOIN
		dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY s.emp_no;

-- OR

SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more then $30,000'
        ELSE 'Salary was NOT raised by more then $30,000'
    END AS salary_raise
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;  

-- OR

SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    IF(MAX(s.salary) - MIN(s.salary) > 30000,
        'Salary was raised by more then $30,000',
        'Salary was NOT raised by more then $30,000') AS salary_increase
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;

/* Extract the employee number, first name, and last name of the first 100 employees, 
and add a fourth column, called “current_employee” saying “Is still employed” if the 
employee is still working in the company, or “Not an employee anymore” if they aren’t.
Hint: You’ll need to use data from both the ‘employees’ and the ‘dept_emp’ table to solve this exercise. */

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) < SYSDATE() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
GROUP BY de.emp_no
LIMIT 100;
