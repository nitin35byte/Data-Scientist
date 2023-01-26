select * from salaries;

SELECT  Salary FROM salaries ORDER BY Salary Desc LIMIT 3 OFFSET 2;

create table student2
select * from student ;

create table student3
select * from student  WHERE 1=0;

select * from student3;

#fetching alternative rows
select * from employees where emp_no %2=0;
select * from employees where emp_no %2=1;


CREATE TABLE teacher_info (
      teacher_ID int auto_increment,
      LastName varchar(255),
      FirstName varchar(255) NOT NULL,
      Class int(11),
      PRIMARY KEY (teacher_ID)
      );
      
	select max(salary) from salaries where salary not in  (select max(salary) from salaries);
    select max(salary) from salaries; #158220
    
    select salary  from salaries order by salary desc limit 5 offset 0;
    
    select * from employees order by emp_no limit 20 offset 5
      
      
