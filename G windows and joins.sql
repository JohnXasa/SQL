/* Exercise #1:
Write a query that ranks the salary values in descending order of all contracts 
signed by employees numbered between 10500 and 10600 inclusive. Let equal salary 
values for one and the same employee bear the same rank. Also, allow gaps in the 
ranks obtained for their subsequent rows.
Use a join on the “employees” and “salaries” tables to obtain the desired result

Exercise #2:
Write a query that ranks the salary values in descending order of the following contracts 
from the "employees" database:
- contracts that have been signed by employees numbered between 10500 and 10600 inclusive.
- contracts that have been signed at least 4 full-years after the date when the given employee 
was hired in the company for the first time.
In addition, let equal salary values of a certain employee bear the same rank. Do not allow 
gaps in the ranks obtained for their subsequent rows.
Use a join on the “employees” and “salaries” tables to obtain the desired result. */

--Solution #1:

SELECT
    e.emp_no,
    RANK() OVER w as employee_salary_ranking,
    s.salary
FROM
employees e
JOIN
    salaries s ON s.emp_no = e.emp_no
WHERE e.emp_no BETWEEN 10500 AND 10600
WINDOW w as (PARTITION BY e.emp_no ORDER BY s.salary DESC);


--Solution #2:

SELECT
    e.emp_no,
    DENSE_RANK() OVER w as employee_salary_ranking,
    s.salary,
    e.hire_date,
    s.from_date,
    (YEAR(s.from_date) - YEAR(e.hire_date)) AS years_from_start
FROM
employees e
JOIN
    salaries s ON s.emp_no = e.emp_no
    AND YEAR(s.from_date) - YEAR(e.hire_date) >= 5
WHERE e.emp_no BETWEEN 10500 AND 10600
WINDOW w as (PARTITION BY e.emp_no ORDER BY s.salary DESC);