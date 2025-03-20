# emp1 = {
#     "id": 1,
#     "name": "Noha",
#     "salary": 3000
# }
#
# emp2 = {
#     "id": 2,
#     "name": "Ali",
#     "salary": 3000
# }
# emp3 = {
#     "id": 3,
#     "name": "Ahmed",
#     "salary": 3000
# }
#
# emp3["email"] ="jkdhjkd@gmail.com"


# define class --> blueprint for structure ,,,,
# class Employee:
#     pass
#
#
#
# e = Employee()  # inilizie object from class Employee
# print(e)

#################################
class Employee:
    # class variable ---> can be accessed using className.
    # represent property that shared with all instances
    # class variable ===> is a variable that is shared between all class instances
    # once the variable change  Employee.makefaults ----> the value of it will be changed for all instances
    makefaults = True
    emp_count = 0

    # name, id, mail, salary
    # define class attribute
    # define constructor  --> initialize object
    def __init__(self, uname=None, id=None, umail=None, salary=None, bdate='1/1/1990'):  # __init__ initialize object in memory
        print(self)  # self ---> refer to current instance which is created
        #     print("New object created")
        # by default class attributes --> public
        self.name = uname
        self.id = id
        self.mail = umail
        self.salary = salary
        Employee.emp_count += 1
        self.bdate= bdate


    # can do something , functions
    # member function
    def speak(self, specialmsg="I am fine"):
        print(f"I am {self.name} {specialmsg}")
        return self.id

    def setmyfullname(self, lname):
        # instance variable
        self.fullname = f"{self.name} {lname}"

    # behaviour related to the class
    @classmethod   # python decorator
    def getEmpcount(cls):
        # cls --> refer to the current class
        print(cls)
        return cls.emp_count

    # objects factory
    @classmethod
    def generateobj(cls):
        return cls(),  cls("Ahmed", "300", "ff@gmail.com", 3000)

    @staticmethod
    def calage(abc):
        from datetime import datetime
        years = datetime.now() - datetime.strptime(abc, "%d/%m/%Y")
        return years.days / 365



# class Test:
#     def __init__(self,**kwargs):
#         print(kwargs)
#         for item in kwargs:
#             self.


# t = Test(name="Zakria", id=1000)
