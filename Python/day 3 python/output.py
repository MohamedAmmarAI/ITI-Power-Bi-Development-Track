from classes import Employee

# e1=Employee(uname="Ali")
# print(e1.name)
# e2= Employee("Noha",10)
# print(e2.id)
#
# e3= Employee(id=4)
# e5=Employee(id=5, salary=1000)
#
# e = Employee("ahmed", 10, "ahmed@gmail.com", 1000)  # inilizie object from class Employee
# e6= Employee()
# print(e)


########## Access modifiers
# e = Employee("ahmed", 10, "ahmed@gmail.com", 1000)
# # print(e.name)
# # e.name = "Ahmed Ali"
# # print(e.name)
# # e.age = 25  # self.age =25
# # print(e.age)
# e.speak()
# # inilizie object from class Employee
# e5=Employee(id=5, salary=1000)
# s = e5.speak("test")
# print(s)
################################# class variable
print(Employee.makefaults)  # True
e = Employee("ahmed", 10, "ahmed@gmail.com", 1000)
Employee.makefaults = False
e2 = Employee("Huda", 19, "ahmed@gmail.com", 10000)
Employee.makefaults = "Updateeeeeeddddddddd"
e3 = Employee("Abc", 19, "abc@gmail.com", 10000)
e3.makefaults = "ooooooooooooooooooo"
print("fffff")

print(Employee.emp_count)

Employee.getEmpcount()
print(e.getEmpcount())

z = Employee.generateobj()
print(z)
## calculate age
# from datetime import datetime
# # that is not depend on the object
# def getage(age):
#     no_of_days= datetime.now()-datetime.strptime(age,"%d/%m/%Y")
#     return no_of_days.days/365
#
# e_age= getage(e.bdate)
# print(f"age of employeez  ={e_age}")
#
# e_age= getage('17/6/1992')
# print(f"age of employeez  ={e_age}")

# print(e.getage(e.bdate))
# print(Employee.getage(e.bdate))
#
# print(Employee.getage("20/6/1996"))

aya = Employee("Aya", 200, "aya@gmail.com", 1000, '1/8/1999')


def calage(abc):
    from datetime import datetime
    years = datetime.now() - datetime.strptime(abc, "%d/%m/%Y")
    return years.days / 365


x = calage(aya.bdate)
print(f"age = {x}")

print(Employee.calage(aya.bdate))
print(Employee.calage("17/6/1992"))

###
l1 = [3, 4, 5]
l2 = [3, 4, 5]
l3 = l1 + l2  ###new object --->


