
                    
					                                    -- Adv SQLServer Lab

--  Part-1: Use ITI DB

use ITI

-- 1.	Retrieve number of students who have a value in their age. 

select * from Student

select count(st_id) from student
where St_Age is not null


-- 2.	Get all instructors Names without repetition

select distinct ins_name from Instructor


-- 3.	Display student with the following Format (use isNull function)
        --  Student ID	Student Full Name	Department name

select s.st_id as "Student ID" , isnull(s.st_fname,'no first name ')+' '+isnull(s.st_lname,'no name') as "Full Name" , d.dept_name as "Department name"
from student s , department d
where s.Dept_Id=d.Dept_Id


--  4.	Display instructor Name and Department Name 
        -- Note: display all the instructors if they are attached to a department or not

select s.Ins_Name,d.Dept_Name
from Instructor s left outer join Department d
on s.Dept_Id=d.Dept_Id


-- 5.	Display student full name and the name of the course he is taking
--      For only courses which have a grade  

select s.St_Fname+' '+s.St_Lname as [full name] , c.Crs_Name
from student s , Stud_Course sc , Course c
where s.St_Id=sc.St_Id and sc.Crs_Id=c.Crs_Id and sc.Grade is not null 


-- 6.	Display number of courses for each topic name

select  t.Top_Name as top_name , count(c.Crs_Id) as total_number
from Course c inner join  Topic t
on c.Top_Id=t.Top_Id
group by t.Top_Name


-- 7.	Display max and min salary for instructors

select max(Salary) as max_salary, min(Salary) as min_salary
from instructor


-- 8.	Display instructors who have salaries less than the average salary of all instructors.

select Ins_Name
from Instructor
where salary < (select avg(salary) from Instructor)


-- 9.	Display the Department name that contains the instructor who receives the minimum salary.

select d.Dept_Name , min(i.salary) as min_salary
from instructor i , Department d
where i.Dept_Id=d.Dept_Id
group by d.Dept_Name
having min(i.Salary) = (select min(salary) from Instructor)


-- 10.	 Select max two salaries in instructor table. 

select top(2) salary as max_salary
from Instructor
order by salary desc 


-- 11.   Select instructor name and his salary but if there is no salary display instructor bonus keyword. “use coalesce Function”

select ins_name, COALESCE(cast(salary as varchar),'bonus') as salary_bonus
from instructor


-- 12.	Select Average Salary for instructors 

select avg(salary) as avg_salary
from Instructor

-- 13.	Select Student first name and the data of his supervisor 

select x.st_fname , y.*
from Student x join student y
on x.St_super=y.St_Id


-- 14.	Write a query to select the highest two salaries in Each Department for instructors who have salaries. “using one of Ranking Functions”

select ins_name,dept_id,salary as max_two_salary
from (select * , Dense_rank() over(Partition by dept_id order by salary desc) as DR
      from Instructor
	  WHERE Salary IS NOT NULL
	  ) as newtable
where DR<=2


--15   Write a query to select a random student from each department.  “using one of Ranking Functions”

SELECT *
FROM (
    SELECT *, 
           ROW_NUMBER() OVER (PARTITION BY Dept_Id ORDER BY NEWID()) AS rn
    FROM Student
) AS RandomRanked
WHERE rn = 1

--------------------------------------------------------------------------------------------------------------------------------

                                                    -- Part-2: Use AdventureWorks DB


-- 1.	Display the SalesOrderID, ShipDate of the SalesOrderHeader table (Sales schema) 
--      to show SalesOrders that occurred within the period ‘7/28/2002’ and ‘7/29/2014’

use AdventureWorks2012

select SalesOrderID,ShipDate 
from sales.SalesOrderHeader
where OrderDate between '7/28/2002' and '7/29/2014'


-- 2.	Display only Products(Production schema) with a StandardCost below $110.00 (show ProductID, Name only)

select ProductID, Name 
from Production.Product
where StandardCost<110.00


-- 3.	Display ProductID, Name if its weight is unknown

select ProductID, Name
from Production.Product
where weight is null


--4.   Display all Products with a Silver, Black, or Red Color

select * from Production.Product
where Color in ('Silver','Black','Red')


--5.	 Display any Product with a Name starting with the letter B

select *
from Production.Product
where name like 'B%'


--6.	Run the following Query

UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3

-- Then write a query that displays any Product description with underscore value in its description.

select * 
from Production.ProductDescription
where Description like '%\_%' escape'\'


-- 7.	Calculate sum of TotalDue for each OrderDate in Sales.SalesOrderHeader table for the period between  '7/1/2001' and '7/31/2014'

select sum(TotalDue) as total , OrderDate
from Sales.SalesOrderHeader
where OrderDate between '7/1/2001' and '7/31/2014'
group by OrderDate


--8.    Display the Employees HireDate (note no repeated values are allowed)

select distinct HireDate
from HumanResources.Employee


--9.    Calculate the average of the unique ListPrices in the Product table

select avg(distinct ListPrice) as avg_listprice
from Production.Product


-- 10.	Display the Product Name and its ListPrice within the values of 100 and 120 
--      the list should has the following format "The [product name] is only! [List price]" 
--      (the list will be sorted according to its ListPrice value)

SELECT 'The ' + Name + ' is only!   ' + CAST(ListPrice AS VARCHAR) as [product details]
from Production.Product
where ListPrice between 100 and 120
order by ListPrice



-- 11.	

--       a)	 Transfer the rowguid ,Name, SalesPersonID, Demographics from Sales.Store table  in a newly created table named [store_Archive]
--            Note: Check your database to see the new table and how many rows in it?
--       b)Try the previous query but without transferring the data? 


select rowguid,Name,SalesPersonID,Demographics into store_Archive
from Sales.Store

select count(rowguid) as count from Sales.Store

select count(rowguid) as count_rows from store_Archive



select rowguid,Name,SalesPersonID,Demographics
from  dbo.store_Archive


-- 12.	Using union statement, retrieve the today’s date in different styles using convert or format funtion.

SELECT CONVERT(VARCHAR, GETDATE(), 101) AS DateStyle    -- MM/DD/YYYY
UNION
SELECT CONVERT(VARCHAR, GETDATE(), 103)                 -- DD/MM/YYYY
UNION
SELECT CONVERT(VARCHAR, GETDATE(), 120)                 -- YYYY-MM-DD HH:MI:SS

