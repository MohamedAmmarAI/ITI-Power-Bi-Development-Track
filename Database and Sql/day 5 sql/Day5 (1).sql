--->Confiruation   setup
--->types of instances
--->types of authentication
--->transact-SQL
--top   newid    select into   insert based on select  Ranking
select * from student

select * from student
where St_Address='alex'

select top(1)* from student

select top(5)* from student

select top(3) st_fname 
from student

select top(1)* from student

select top(1)* from student
where st_address='alex'

select Max(salary)
from Instructor

select top(2) Max(salary)
from Instructor

-- from select  order top
select top(2) salary
from Instructor
order by salary desc

--newid  --builtin function  GUID
select newid()

select * , newid() as xid
from Student
order by xid

select top(1)*
from Student

select top(1)*
from Student
order by newid()

select top(10)*
from questions
order by newid()

--fullpath object
--ServerName.DBName.SchemaName.ObjectName

select * from Student

select * from [RAMI].ITI.dbo.student

select * from Company_SD.dbo.Project

select dept_name from Department
union all
select dname from Company_SD.dbo.Departments

use AdventureWorks2012
select * from HumanResources.shift  

use ITI
select * from AdventureWorks2012.HumanResources.Employee

--Global allis
--synonym
--shortcut
create synonym emp
for AdventureWorks2012.HumanResources.Employee

use ITI
select * from emp

-----------------------------------------
select *
from (select * , Row_number() over(order by st_age desc) as RN
      from Student) as newtable
where RN=1

select *
from (select * , Dense_rank() over(order by st_age desc) as DR
      from Student) as newtable
where DR=1

select *
from (select * , Ntile(3) over(order by st_age desc) as G
      from Student) as newtable
where G=1

-----------------------------------------------------
select *
from (select * , Row_number() over(Partition by dept_id order by st_age desc) as RN
      from Student) as newtable
where RN=1

select *
from (select * , Dense_rank() over(Partition by dept_id order by st_age desc) as DR
      from Student) as newtable
where DR=1
---------------------------------------------

select *
from (select * , Ntile(2) over(Partition by dept_id order by st_id desc) as G
      from Student) as newtable

select *
from (select * , Ntile(2) over(Partition by dept_id order by st_id desc) as G
      from Student) as newtable
where g=1 and dept_id=10

select *
from (select * , Ntile(2) over(Partition by dept_id order by st_id desc) as G
      from Student) as newtable
where g=1 
--------------------------------------------------------
top    Ranking  newid   fullpath   synonym 
--select into
--ddl
--create table from existing one
select *
from Student

select * into tab3
from Student

select * into tab4
from Student

select st_id,st_fname into tab5
from Student
where St_Address='alex'

select * into company_sd.dbo.student
from Student

select * into tab7
from Student
where 1=2   --false condition age<0

--insert based on select
insert into tab5
values(1,'ahmed')

insert into tab5
values(3,'ahmed'),(5,'ali'),(55,'eman')

insert into tab5
select st_id,st_fname from Student where St_Address='alex'

--bulk insert
--insert data from file
bulk insert tab5
from 'e:\mydata.txt'
with (fieldterminator=',')












