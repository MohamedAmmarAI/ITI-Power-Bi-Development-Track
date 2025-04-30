

use SD

create type loc from nchar(2) 
go
create default d1 as 'NY'
go
exec sp_bindefault 'd1','loc'
go 
create rule rul_loc
as @value IN ('NY', 'DS', 'KW')
go
EXEC sp_bindrule 'rul_loc', 'loc'
GO

create table department(
                        dept_no nchar(20) primary key,
						dept_name varchar(20),
						location loc
					   )


insert into department(dept_no,dept_name,location)
values('d1','research','NY'),
	  ('d2','accounting','ds'),
	  ('d3','markiting',default)

------------------------------------------------------------------

create table employee(
                      emp_no int,
                      emp_fname varchar(20) not null,
					  emp_lname varchar(20) not null,
					  dept_no nchar(20),
					  salary int,
					  constraint c1 primary key(emp_no),
					  constraint c2 foreign key(dept_no) references department(dept_no),
					  constraint c3 unique(salary),
					  )
                      
create rule r1 as  @x<6000
sp_bindrule r1,'employee.salary'

insert into employee(emp_no,emp_fname,emp_lname,dept_no,salary)
values
      (25348,'Smith','Smith','d3',2500),
	  (10102,'Ann','Jones','d3',3000),
	  (18316,'John','Barrimore','d1',2400)

select * from employee
select * from department

-------------------------------------------------------------------------

select * from works_on


-- 1-Add new employee with EmpNo =11111 In the works_on table [what will happen]

insert into works_on(EmpNo,ProjectNo,Job,Enter_Date)
values(11111,p1,NULL)



-- 2-Change the employee number 10102  to 11111  in the works on table [what will happen]

-- First Check if Employee 11111 Exists
-- Update the works_on Table

update works_on set EmpNo=11111 where EmpNo=10102



-- 3-Modify the employee number 10102 in the employee table to 22222. [what will happen]
--The UPDATE statement conflicted with the REFERENCE constraint "FK_works_on_employee". The conflict occurred in database "SD", table "dbo.works_on", column 'EmpNo'.

update employee set emp_no=22222 where emp_no=10102


-- -Delete the employee with id 10102
-- i dont delete parent and parent has chiled

delete from employee where emp_no=10102


--------------------------------------------------------------------------------------------------------

----------------------------------------------------------- Table modification--------------------------

-- 1-Add  TelephoneNumber column to the employee table[programmatically]

alter table employee 
add TelephoneNumber varchar(15)



-- 2-drop this column[programmatically]

alter table employee
drop column TelephoneNumber


-- 3-Bulid A diagram to show Relations between tables
-- Done

-----------------------------------------------------------------------------------------

-- 2.	Create the following schema and transfer the following tables to it 
--        a.	Company Schema 
--          i.	Department table (Programmatically)
--          ii.	Project table (using wizard)
--        b.	Human Resource Schema
--          i.	  Employee table (Programmatically)

--  i- 
create schema Company_Schema 

alter schema Company_Schema transfer department

select * from Company_Schema.project

-- b
create schema [Human Resource]

alter schema [Human Resource] transfer employee

select * from [Human Resource].employee

-----------------------------------------------------------------------------------------------

-- 3.	 Write query to display the constraints for the Employee table.

SELECT *
FROM 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE 
    table_name = 'employee'


-- 4.	Create Synonym for table Employee as Emp and then run the following queries and describe the results
--      a.	Select * from Employee
--      b.	Select * from [Human Resource].Employee
--      c.	Select * from Emp
--      d.	Select * from [Human Resource].Emp


create synonym emp 
for [Human Resource].employee

-- a-
  Select * from Employee  -- because table employee in [Human Resource schema

-- b- 
   Select * from [Human Resource].Employee  -- show data
  

-- c-
   Select * from Emp   -- show data 


-- d-
   Select * from [Human Resource].emp  -- emp in default schema (dbo) not Human Resource



-- 5.	Increase the budget of the project where the manager number is 10102 by 10%.

update company_schema.project 
set budget=budget*1.10
where ProjectNo in(
 select p.ProjectNo
 from company_schema.project p inner join works_on w
 on p.ProjectNo=w.ProjectNo inner join [Human Resource].employee e
 on e.emp_no=w.EmpNo
 where e.emp_no = 10102 AND w.job ='Manager'
)


-- 6.	Change the name of the department for which the employee named John works.The new department name is Sales.

update Company_Schema.department

set dept_name='sales'

where dept_no in (
select d.dept_no
from Company_Schema.department d inner join [Human Resource].Employee e 
on d.dept_no=e.dept_no
where e.emp_fname='John'
)




-- 7.	Change the enter date for the projects for those employees who work in project p1 and belong to department ‘Sales’. The new date is 12.12.2007.

update works_on
set Enter_Date='12.12.2007'
where EmpNo in (
 select w.EmpNo 
 from works_on w join [Human Resource].Employee e
 on w.EmpNo=e.emp_no join Company_Schema.department d
 on e.dept_no=d.dept_no
 where d.dept_name='sales' and w.ProjectNo='p1'
)



-- 8.	Delete the information in the works_on table for all employees who work for the department located in KW.

delete from works_on
where EmpNo in (
    select w.EmpNo from works_on w inner join [Human Resource].Employee e 
	on w.EmpNo=e.emp_no inner join Company_Schema.department d 
	on d.dept_no=e.dept_no
	where d.dept_name='KW'
)


-- 9.	Try to Create Login Named(ITIStud) who can access Only student and Course tablesfrom ITI DB then allow him to select and
--      insert data into tables and deny Delete and update .(Use ITI DB)

use ITI

create schema Sales

alter schema sales transfer student

alter schema sales transfer course

