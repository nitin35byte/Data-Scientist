USE employees;

drop PROCEDURE if exists select_employees;

DELIMITER $$
CREATE procedure select_employees()
begin
select * from employees 
LIMIT 1000;

END$$
DELIMITER ;



CALL employees.select_employees();
##DROP procedure select_employees;

CALL select_employees();




USE employees;

drop PROCEDURE if exists emp_salary;

DELIMITER $$
CREATE procedure emp_salary(p_emp__no INTEGER)
begin
select e.first_name , e.last_name,s.salary ,s.from_date , s.to_date
from employees e
join
salaries s ON e.emp_no=s.emp_no
where emp_no=p_emp__no;

END$$
DELIMITER ;

CALL employees.emp_salary();

SET @v_avg_salary =0;
CALL employeeses.emp_avg_salary_out(11300,@v_avg_salary);
select @v_avg_salary



select * from employees;

select * from titles;

SELECT 
    first_name, last_name, gender
FROM
    employees
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            titles
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995-01-01');
            
            
SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            dm.emp_no = e.emp_no);


SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            dm.emp_no = e.emp_no)
ORDER BY emp_no;

SELECT 
    *
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            titles t
        WHERE
            t.emp_no = e.emp_no
                AND title = 'Assistant Engineer');
                
#================================================================================================

USE employees;

DROP PROCEDURE IF EXISTS Select_employees;

DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN
SELECT * FROM employees
LIMIT 1000;

END$$

DELIMITER ;

call employees.select_employees();
call select_employees();

drop procedure select_employees;


=============================================================================================================
select Round(AVG(salary),1) from salaries where from_date ='1997-01-01';

select * from salaries s inner join titles t on s.emp_no=t.emp_no 
group by s.emp_no
order by salary;

SELECT * FROM dept_emp;

   
 #view  
SELECT 
    emp_no, from_date, to_date ,COUNT(emp_no) as Num
FROM
    dept_emp
GROUP BY emp_no
HAVING Num > 1;




CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
    SELECT 
        emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM
        dept_emp
    GROUP BY emp_no;
    
    select * from v_dept_emp_latest_date;
    
   select max(salary) from salaries;
   
    select *from salaries 
group by salary 
order by  salary desc limit 1,1;
select * from salaries where salary=(select Max(salary) from salaries);

select * from salaries where salary not in (select Max(salary) from salaries);


SELECT MAX(salary) AS salary 
FROM salaries 
WHERE salary <> (SELECT MAX(salary) 
FROM salaries);

select * from employees;
select * from salaries ;

##Join----------------------------------------------
SELECT 
    first_name, last_name, gender, salary, from_date, to_date
FROM
    employees e
        INNER JOIN
    salaries s ON e.emp_no = s.emp_no
LIMIT 100;
 
 SELECT * from employees;
 ----------------------------------------------------------------------
describe employees;

CREATE INDEX i_hire_date ON employees(hire_date);

select * from employees where hire_date >'2000-01-01';

select * from employees where first_name='Georgi' and last_name ='Facello';
CREATE INDEX i_composite on employees(first_name,last_name);

SHOW INDEX FROM employees FROM employees;

----------------------------------------------#CASE STATEMENT
SELECT 
    emp_no,
    first_name,
    last_name,
    CASE
        WHEN gender = 'M' THEN 'MALE'
        ELSE 'FEMALE'
    END AS Gender
FROM
    EMPLOYEES;

#update employees set gendder =''

select  * from employees;

------------------------------------------------------------------------#
select * from employees;

select * from titles;

SELECT 
    first_name, last_name, gender
FROM
    employees
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            titles
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995-01-01');
            
            
SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            dm.emp_no = e.emp_no);


SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            dm.emp_no = e.emp_no)
ORDER BY emp_no;

SELECT 
    *
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            titles t
        WHERE
            t.emp_no = e.emp_no
                AND title = 'Assistant Engineer');

------------------------------------------------------------------#Sub query
SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
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
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B;
    
    USE employees;
    
    
    -------------------------------------------------------------#Store procdur
    USE employees;

DROP PROCEDURE IF EXISTS Select_employees;

DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN
SELECT * FROM employees
LIMIT 1000;

END$$

DELIMITER ;

call employees.select_employees();
call select_employees();

drop procedure select_employees;


----------------------------------------------------------#Functions and variables
select * from employees;
select * from salaries;

select first_name, Last_name, gender, salary, from_date, to_date from employees e inner join salaries s
on e.emp_no=s.emp_no;

-------------------------------------------------
DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_avg_salary(IN p_emp_no INTEGER)
BEGIN
SELECT e.first_name, e.Last_name, s.salary, s.from_date,
 s.to_date
 from employees e
 Join salaries s On e.emp_no = s.emp_no 
 where e.emp_no = p_emp_no;

END$$

DELIMITER ;

call emp_avg_salary(11300);

#Variable
SET @V_avg_salary = 0;
CALL employees.emp_avg_salary_in (11300,@V_avg_salary);
select @V_avg_salary;


--------------------------------------------------#Function
DELIMITER $$

CREATE FUNCTION f_emp_avg_salary(p_emp_no INTEGER) RETURNS DECIMAL(10,2)
deterministic
BEGIN

DECLARE v_avg_salary DECIMAL(10,2);

SELECT 
    AVG(s.salary)
INTO v_avg_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
    
    RETURN v_avg_salary;
    END$$
DELIMITER $$

    
SELECT F_EMP_AVG_SALARY(11301)

-------------------------------------------------------------------------------------
DELIMITER $$



CREATE FUNCTION emp_info(p_first_name varchar(255), p_last_name varchar(255)) RETURNS decimal(10,2)

DETERMINISTIC NO SQL READS SQL DATA

BEGIN



                DECLARE v_max_from_date date;



    DECLARE v_salary decimal(10,2);



SELECT

    MAX(from_date)

INTO v_max_from_date FROM

    employees e

        JOIN

    salaries s ON e.emp_no = s.emp_no

WHERE

    e.first_name = p_first_name

        AND e.last_name = p_last_name;



SELECT

    s.salary

INTO v_salary FROM

    employees e

        JOIN

    salaries s ON e.emp_no = s.emp_no

WHERE

    e.first_name = p_first_name

        AND e.last_name = p_last_name

        AND s.from_date = v_max_from_date;

       

                RETURN v_salary;



END$$



DELIMITER ;

SELECT EMP_INFO('Aruna', 'Journel');


-----------------------------------------#
SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salart_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30,000 THEN 'salary WAS RAISE BY MORE THAN $30,000'
        WHEN MAX(s.salary) - MIN(s.salary) BETWEEN 20,000 AND 30,000 THEN 'salary was raise by more than $20,000 and less than $30,000'
        ELSE 'salar was raise by less than $20,000'
    END AS salary_increase
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;
#########################################################################################
SELECT MAX(SALARY) FROM Employees WHERE SALARY < (SELECT MAX(SALARY) FROM Employees);
select max(salary) from salaries where salary<> (select MAX(salary) from  employees);


Select distinct Salary from salaries e1 where 2#=Select count(distinct Salary) from salaries e2 where e1.salary<=e2.salary;

#===============================================================================================================
select * from employees;
select * from salaries;

select first_name, Last_name, gender, salary, from_date, to_date from employees e inner join salaries s
on e.emp_no=s.emp_no;

#-------------------------------------------------
DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_avg_salary(IN p_emp_no INTEGER)
BEGIN
SELECT e.first_name, e.Last_name, s.salary, s.from_date,
 s.to_date
 from employees e
 Join salaries s On e.emp_no = s.emp_no 
 where e.emp_no = p_emp_no;

END$$

DELIMITER ;

call emp_avg_salary(11300);

#Variable
SET @V_avg_salary = 0;
CALL employees.emp_avg_salary_in (11300,@V_avg_salary);
select @V_avg_salary;


===============================================================================================================
DELIMITER $$

CREATE FUNCTION f_emp_avg_salary(p_emp_no INTEGER) RETURNS DECIMAL(10,2)
deterministic
BEGIN

DECLARE v_avg_salary DECIMAL(10,2);

SELECT 
    AVG(s.salary)
INTO v_avg_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
    
    RETURN v_avg_salary;
    END$$
DELIMITER $$

    
SELECT F_EMP_AVG_SALARY(11301)

-------------------------------------------------------------------------------------
DELIMITER $$



CREATE FUNCTION emp_info(p_first_name varchar(255), p_last_name varchar(255)) RETURNS decimal(10,2)

DETERMINISTIC NO SQL READS SQL DATA

BEGIN



                DECLARE v_max_from_date date;



    DECLARE v_salary decimal(10,2);



SELECT

    MAX(from_date)

INTO v_max_from_date FROM

    employees e

        JOIN

    salaries s ON e.emp_no = s.emp_no

WHERE

    e.first_name = p_first_name

        AND e.last_name = p_last_name;



SELECT

    s.salary

INTO v_salary FROM

    employees e

        JOIN

    salaries s ON e.emp_no = s.emp_no

WHERE

    e.first_name = p_first_name

        AND e.last_name = p_last_name

        AND s.from_date = v_max_from_date;

       

                RETURN v_salary;



END$$



DELIMITER ;

SELECT EMP_INFO('Aruna', 'Journel');

#==================================================================================================
SELECT 

    YEAR(d.from_date) AS calendar_year,
    e.gender,    
    COUNT(e.emp_no) AS num_of_employees

FROM     
     t_employees e         
          JOIN    
     t_dept_emp d ON d.emp_no = e.emp_no

GROUP BY calendar_year , e.gender 

HAVING calendar_year >= 1990;

#===========================================================================================================
select max(salary) from salaries;

select top *1 salary from (select top *3 salary from salaries);

select max(salary) from salaries where salary in  (SELECT max(salary)
FROM salaries
WHERE salary
LIMIT 3);

show databases

#==============================================================================================================
SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
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
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B;
    
    USE employees;

##dens rank---------------------------------------------------------------

select * from student;
SELECT
    firstName,
    LastName,
    class,
    Rank() OVER (PARTITION BY
                     StudentID
                 ORDER BY
                     class DESC
                ) StudentID_rank
FROM
    student;
    
SELECT
    StudentID,
    DENSE_RANK() OVER (
        ORDER BY StudentID
    ) my_rank
FROM
    student;
    
select * from student where studentID in (1,2);
select  Class , Marks, DENSE_RANK() OVER
(partition by subject order by marks desc);#as 'DENSE_RANK'

SELECT StudentID,stream,Class,Marks, dense_rank() 
OVER ( partition by stream order by marks desc ) 
AS 'dense_rank' FROM student;

SELECT StudentID,stream,Class,Marks, rank() 
OVER ( partition by stream order by marks desc ) 
AS 'rank' FROM student;

select * from salaries order by salary desc limit 1 offset 0;

select * from employees;
select * from employees where emp_no %2=0;

select firstname, lastname , marks,stream ,dense_rank() over(partition by stream order by marks asc) as 'rank' from student;

select firstname, lastname , marks,stream ,StudentID,row_number() over (order by studentID) from student where COUNT(*) > 1;
select * from student_dummy3;
create table student_dummy3
select * from student GROUP BY studentid Having COUNT(*) > 1;
ALTER TABLE student_dummy3 RENAME TO student_dummy33;
select * from student_dummy2;

select * from student HAVING COUNT(*) > 1;

select firstname, lastname , marks,stream ,StudentID  from student GROUP BY studentid Having COUNT(*) > 1;

drop table student_dummy;


select dense_rank() over(partition by Stream order by marks) from student;