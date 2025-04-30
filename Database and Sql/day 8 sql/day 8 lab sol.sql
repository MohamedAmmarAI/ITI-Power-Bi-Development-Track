use ITI


-- 1.	 Create a view that displays student full name, course name if the student has a grade more than 50. 

create view stud_info
as
   select s.st_fname+' '+s.st_lname as "full name",crs_name
   from sales.Student s inner join stud_course sc
   on s.St_Id=sc.St_Id inner join sales.course c
   on c.crs_id=sc.crs_id
   where sc.grade > 50

select * from stud_info


-- 2.  Create an Encrypted view that displays manager names and the topics they teach. 

create view mang_top 
with encryption
as 
    select d.Dept_manager , t.top_name  
	from Department d join instructor i
	on d.Dept_Manager=i.Ins_Id join Ins_Course ic
	on ic.Ins_Id=i.Ins_Id join sales.Course c
	on c.crs_id=ic.Crs_Id join Topic t
	on t.Top_Id=c.top_id
   
select * from mang_top



-- 3.	Create a view that will display Instructor Name, Department Name for the ‘SD’ or ‘Java’ Department 

create view ins_info
as
   select i.ins_name,d.dept_name 
   from Department d join Instructor i
   on d.Dept_Id=i.Dept_Id
   where d.Dept_Name in ('SD','Java')

select * from ins_info



-- 4.  Create a view “V1” that displays student data for student who lives in Alex or Cairo. 
--         Note: Prevent the users to run the following query 
--         Update V1 set st_address=’tanta’
--         Where st_address=’alex’;


create view v1
as
   select * from sales.student 
   where St_Address in ('cairo','alex')
   with check option

select * from v1 Where st_address='alex'

Update V1 set st_address='tanta'
   Where st_address='alex';



-- 5.   Create a view that will display the project name and the number of employees work on it. “Use SD database”

use SD

drop view sd_view

create view sd_view(Project_Name, Number_of_Employees)
as
select P.Pname, COUNT(*) 
from [Company_SD].dbo.Project P join [Company_SD].dbo.Works_for W on P.Pnumber = W.Pno
group by P.Pname

select * from sd_view




-- 6.	Create index on column (Hiredate) that allow u to cluster the data in table Department. What will happen?

use ITI

create clustered index i1
on department(manager_hiredate)

-- answer
-- Cannot create more than one clustered index on table 'department'. Drop the existing clustered index 'PK_Department' before creating another.



-- 7.	Create index that allow u to enter unique ages in student table. What will happen? 

create unique index i2
on sales.student(st_age)

-- The CREATE UNIQUE INDEX statement terminated because a duplicate key was found for the object name
-- 'Sales.Student' and the index name 'i2'. The duplicate key value is (21).
--   The statement has been terminated.


-- 8.	Using Merge statement between the following two tables [User ID, Transaction Amount]

create table daily(user_id int,transaction_amount int)

insert into daily(user_id,transaction_amount)
            values(1,1000)
			      ,(2,2000)
				  ,(3,1000)

create table last_transaction(user_id int,transaction_amount int)

insert into last_transaction(user_id,transaction_amount)
            values(1,4000)
			      ,(4,2000)
				  ,(2,10000)


merge into last_transaction as t
using daily as d
on d.user_id=t.user_id

when matched then
  update 
     set t.transaction_amount=d.transaction_amount

when not matched then 
     insert
       values(d.user_id ,d.transaction_amount);

select * from daily
select * from last_transaction




-- 9.	Create a cursor for Employee table that increases Employee salary by 10% if Salary <3000 and increases it by 20% if Salary >=3000. Use company DB

use Company_SD

declare c1 cursor
for select salary from Employee
for update 
declare @sal int
open c1
fetch c1 into @sal
while @@FETCH_STATUS=0
	begin
		if @sal>=3000
			update Employee
				set Salary=@sal*1.20
			where current of c1
		else if @sal<3000
			update Employee
				set Salary=@sal*1.10
			where current of c1
		fetch c1 into @sal
	end
close c1
deallocate c1


select salary from Employee


-- 10.	Display Department name with its manager name using cursor. Use ITI DB

use ITI


declare c1 cursor
for
select 
    d.Dept_Name,                  
    i.Ins_Name as ManagerName
from
    Department d
join 
    Instructor i on d.Dept_Manager = i.Ins_Id
for read only

declare @DeptName varchar(50)=''
declare @ManagerName varchar(50)=''
open c1
fetch c1 into @DeptName, @ManagerName

while @@FETCH_STATUS = 0
begin
    select  @DeptName,@ManagerName
    fetch c1 into @DeptName, @ManagerName;
end

close c1
deallocate c1;



-- 11.	Try to display all students first name in one cell separated by comma. Using Cursor 

declare c1 cursor
for select distinct st_fname from sales.Student where St_Fname is not null
for read only

declare @name varchar(20) , @all_names varchar(300)=''
open c1 
fetch c1 into @name
while @@FETCH_STATUS=0
  begin
      set @all_names=CONCAT(@all_names,',',@name)
	  fetch c1 into @name
  end

select @all_names
close c1
deallocate c1







-- 12.	Try to generate script from DB ITI that describes all tables and views in this DB

-- done  ---> error  on desktop


-- 13.	Use import export wizard to display student’s data (ITI DB) in excel sheet

-- done on desktop




--------------------------------------------------------------------- part 2 --------------------------------------------


-- 1)	Create view named   “v_clerk” that will display employee#,project#, the date of hiring of all the jobs of the type 'Clerk'.

use SD

create view v_clerk
as
   select w.EmpNo as employee, w.ProjectNo as project, w.Enter_Date as hiring_date
   from [Human Resource].employee e join works_on w
   on e.emp_no = w.EmpNo join [Company_Schema].project p
   on p.ProjectNo = w.ProjectNo
   where w.Job = 'Clerk'

select * from v_clerk



-- 2)  Create view named  “v_without_budget” that will display all the projects data 
--     without budget

create view v_without_budget
as
    select ProjectNo , ProjectName
	from Company_Schema.project

select * from v_without_budget



-- 3)  Create view named  “v_count “ that will display the project name and the # of jobs in it

create view v_count
as
    select p.projectName , count(w.job) as job_count
	from Company_Schema.project p join works_on w
	on p.ProjectNo=w.ProjectNo
	group by p.ProjectName

select * from v_count




-- 4)   Create view named ” v_project_p2” that will display the emp#  for the project# ‘p2’
--      use the previously created view  “v_clerk”


create view v_project_p2
as
    select employee 
	from v_clerk 
	where Project='p2'

select * from v_project_p2




-- 5)	modifey the view named  “v_without_budget”  to display all DATA in project p1 and p2 

alter view v_without_budget
as
    select ProjectNo , ProjectName , Budget
	from Company_Schema.project
	where ProjectNo in ('p1','p2')

select * from v_without_budget




-- 6)	Delete the views  “v_ clerk” and “v_count”

drop view if exists v_clerk

drop view v_count





-- 7)	Create view that will display the emp# and emp lastname who works on dept# is ‘d2’

create view emp_info
as
    select e.emp_no , e.emp_lname 
	from [Human Resource].employee e join Company_Schema.department d
	on e.dept_no=d.dept_no
	where d.dept_no='d2'

select * from emp_info




-- 8)	Display the employee  lastname that contains letter “J”
--      Use the previous view created in Q#7

select emp_lname
from emp_info
where emp_lname like '%j%'



-- 9)	Create view named “v_dept” that will display the department# and department name.

create view v_dept
as
   select dept_no , dept_name 
   from Company_Schema.department

select * from v_dept



-- 10)	using the previous view try enter new department data where dept# is ’d4’ and dept name is ‘Development’

insert into v_dept(dept_no , dept_name)
            values('d4','development')

select * from v_dept



-- 11)	Create view name “v_2006_check” that will display employee#, the project #where he works
--      and the date of joining the project which must be from the first of January and the last of December 2006.

create view v_2006_check
as
    select e.emp_no , p.ProjectNo , w.Enter_Date
	from [Human Resource].employee e join works_on w
	on e.emp_no=w.EmpNo join Company_Schema.project p
	on p.ProjectNo=w.ProjectNo
	where w.Enter_Date between '2006-01-01' and '2006-12-31'


select * from v_2006_check