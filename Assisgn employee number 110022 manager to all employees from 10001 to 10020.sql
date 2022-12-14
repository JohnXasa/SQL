drop table if exists emp_manager;
create table  emp_manager(
emp_no int(11) not null,
dept_no char(4) null,
manager_no int(11) not null);

Insert INTO emp_manager SELECT
A.*
FROM (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    dm.emp_no
                FROM
                    dept_manager dm
                WHERE
                    dm.emp_no = '110022') AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A
    UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employees_ID,
            MIN(de.dept_no),
            (SELECT 
                    dm.emp_no
                FROM
                    dept_manager dm
                WHERE
                    dm.emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020 AND e.emp_no < 10041
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS B
    UNION SELECT 
    C.*
FROM
    (SELECT 
        e.emp_no AS employees_ID,
            MIN(de.dept_no),
            (SELECT 
                    dm.emp_no
                FROM
                    dept_manager dm
                WHERE
                    dm.emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS C
    UNION SELECT 
    D.*
FROM
    (SELECT 
        e.emp_no AS employees_ID,
            MIN(de.dept_no),
            (SELECT 
                    dm.emp_no
                FROM
                    dept_manager dm
                WHERE
                    dm.emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS D;
    
    
