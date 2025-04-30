
use ITI

-- 1.	Create a scalar function that takes date and returns Month name of that date.

CREATE FUNCTION return_month_name (@date DATE)
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @month_name VARCHAR(20)
    SET @month_name = DATENAME(MONTH, @date)
    RETURN @month_name
END

select dbo.return_month_name('1/1/2000')  -- result january


-- Create a multi-statements table-valued function that takes 2 integers and returns the values between them.

CREATE FUNCTION values_between_2integers (@num1 INT, @num2 INT)
RETURNS @t TABLE (value INT)
AS
BEGIN
    DECLARE @current INT;

    IF @num1 < @num2
    BEGIN
        SET @current = @num1 + 1;
        WHILE @current < @num2
        BEGIN
            INSERT INTO @t (value)
            VALUES (@current);
            SET @current = @current + 1;
        END
    END
    ELSE IF @num1 > @num2
    BEGIN
        SET @current = @num2 + 1;
        WHILE @current < @num1
        BEGIN
            INSERT INTO @t (value)
            VALUES (@current);
            SET @current = @current + 1;
        END
    END

    RETURN;
END;

select * from values_between_2integers(2,10)   -- result 3 4 5 6 7 8 9

select * from values_between_2integers(10,18)   -- result 11 12 13 14 15 16 17 




-- Create inline function that takes Student No and returns Department Name with Student full name.

CREATE FUNCTION return_department_name (@id INT)
RETURNS @t TABLE (
    full_name VARCHAR(50),
    dept_name VARCHAR(50)
)
AS
BEGIN
    INSERT INTO @t (full_name, dept_name)
    SELECT s.st_fname + ' ' + s.st_lname AS full_name,
           d.dept_name
    FROM HRR.student s
    INNER JOIN Department d ON s.dept_id = d.Dept_Id
    WHERE s.st_id = @id;

    RETURN;
END;

drop function return_department_name

select * from return_department_name(2)  




--  4.	Create a scalar function that takes Student ID and returns a message to user 
--         a.	If first name and Last name are null then display 'First name & last name are null'
--         b.	If First name is null then display 'first name is null'
--         c.	If Last name is null then display 'last name is null'
--         d.	Else display 'First name & last name are not null'

create function return_message(@id int)
returns varchar(150)
as
    begin 
	   declare @first_name varchar(20),@last_name varchar(20),@message varchar(150)

	   select @first_name=st_fname , @last_name=st_lname from HRR.Student
	   where st_id=@id

	   if(@first_name is null and @last_name is null)
	   begin 
	     set @message='First name & last name are null'
	   end
	   else if(@first_name is null)
	   begin
	      set @message='First name is null'
	   end
	   else if(@last_name is null)
	   begin 
	       set @message='last name is null'
	   end
	   else
	       set @message='First name & last name are not null'
	  return @message
	end

select dbo.return_message(2)  -- result 'First name & last name are not null'




-- 5.	Create inline function that takes integer which represents manager ID and displays department name, Manager Name and hiring date 

create function Get_Info(@ManagerID int)
returns table
as
return
(
    select 
        D.Dept_Name as DepartmentName,
        I.Ins_Name as ManagerName,
        D.Manager_hiredate as HiringDate
    from 
        Department D
    INNER JOIN 
        Instructor I on D.Dept_Manager = I.Ins_Id
    where 
        D.Dept_Manager = @ManagerID
)


select * from Get_Info(10)
	    

--  6.	Create multi-statements table-valued function that takes a string
--        If string='first name' returns student first name
--        If string='last name' returns student last name 
--        If string='full name' returns Full Name from student table 
--        Note: Use “ISNULL” function

create function studentt_name(@str varchar(20))
returns @t table(first_name varchar(20),last_name varchar(20),full_name varchar(50))
as
begin
if @str='first_name'
begin
  insert into @t (first_name)
  select isnull(st_fname,'no name') from HRR.Student
end
else if @str='last_name'
begin
   insert into @t (last_name)
   select isnull(st_lname,'no name') from HRR.Student
end
else if @str='full_name'
begin
   insert into @t (full_name)
   select isnull(st_fname,'no name')+' '+isnull(st_lname,'no name') from HRR.Student
end
return
end

select * from HRR.student
select * from dbo.studentt_name('full_name')




-- 7.	Write a query that returns the Student No and Student first name without the last char

select st_id,left(st_fname,len(st_fname)-1) as name_without_last_char from HRR.Student 




-- 8.	Write query to delete all grades for the students Located in SD Department 

delete from  Stud_Course 
where st_id in (
 select sc.st_id 
 from stud_course sc inner join student s
 on sc.st_id=s.st_id inner join department d
 on d.Dept_Id=s.Dept_Id 
 where d.Dept_Name='SD'
)


