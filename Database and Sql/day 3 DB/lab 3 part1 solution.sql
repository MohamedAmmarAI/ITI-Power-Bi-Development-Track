

use Company_SD

-- 1.	Display the Department id, name and id and the name of its manager.

SELECT d.Dnum, d.Dname, d.MGRSSN, e.Fname
FROM departments AS d, employee AS e
WHERE d.MGRSSN=e.ssn


-- 2.	Display the name of the departments and the name of the projects under its control.
SELECT Dname,Pname 
FROM Departments AS D , Project AS P
WHERE D.Dnum=P.Dnum

-- 3.	Display the full data about all the dependence associated with the name of the employee they depend on him/her.

SELECT Fname,d.*
from Employee as e , Dependent as d
where e.SSN=d.ESSN

-- 4.	Display the Id, name and location of the projects in Cairo or Alex city.

select pnumber,pname,plocation 
from Project
where city='cairo' or city='alex'

--where city in ('Alex','cairo')

-- 5.	Display the Projects full data of the projects with a name starts with "a" letter.

select * from Project
where pname like 'a%'

-- 6.	display all the employees in department 30 whose salary from 1000 to 2000 LE monthly

select fname+' '+lname as "full name" 
from employee
where Dno=30 and salary between 1000 and 2000


-- 7.	Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project.

select e.fname+' '+e.lname as "full name"
from Employee e , Project p , Works_for w
where e.SSN=w.ESSn and w.Pno=p.Pnumber and e.Dno=10 and w.Hours>=10 and p.Pname='AL Rabwah'

-- 8.	Find the names of the employees who directly supervised with Kamel Mohamed.

select x.fname+' '+x.lname as "full name"
from Employee x,Employee y
where x.Superssn=y.SSN and x.Fname='Kamel' and x.lname='Mohamed'


-- 9.	Retrieve the names of all employees and the names of the projects they are working on,
--      sorted by the project name.

SELECT e.fname+' '+e.lname AS "full name" , p.Pname
FROM Employee e
JOIN Works_for w ON e.SSN = w.ESSn
JOIN Project p ON w.Pno = p.Pnumber
order by p.Pname

-- 10.	For each project located in Cairo City , find the project number, the controlling department name 
--      ,the department manager last name ,address and birthdate.

select p.pnumber,d.dname,e.Lname,e.Address,e.Bdate
from Employee e,Departments d , Project p
where e.Dno=d.Dnum and d.Dnum=p.Dnum and p.City='cairo'


-- 11.	Display All Data of the managers

select e.*
from employee e join Departments d
on e.SSN=d.MGRSSN


-- 12.	Display All Employees data and the data of their dependents even if they have no dependents

select e.*,D.*
from Employee e left outer join Dependent D
on e.SSN=D.ESSN


-- 13.	Insert your personal data to the employee table as a new employee in department number 30, SSN = 102672, Superssn = 112233, salary=3000.

insert into Employee(Dno,SSN,Superssn,Salary)
            values(30,106272,112233,3000)


-- 14.	Insert another employee with personal data your friend as new employee in department number 30,
--      SSN = 102660, but don’t enter any value for salary or supervisor number to him.

insert into employee (fname, lname, ssn, Bdate, Address, sex, superssn, dno )
values ('Mohamed', 'ali', 102640, '1/1/1980', '55 new - helwan', 'M', NULL, 30);


-- 15.	Upgrade your salary by 20 % of its last value.

update Employee
   set salary=salary * 1.20

