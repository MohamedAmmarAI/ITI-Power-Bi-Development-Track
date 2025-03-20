class Employee:
    makefaults = True
    emp_count = 0

    def __init__(self, uname=None, id=None, umail=None, salary=None,
                 bdate='1/1/1990'):  # __init__ initialize object in memory
        print(self)
        self.name = uname
        self.id = id
        self.mail = umail
        self.salary = salary
        Employee.emp_count += 1
        self.bdate = bdate
        # no access modifier public, private, protected
        # protected
        self._dept = "AI"
        # private
        self.__commission = 100



class Manager(Employee):
    def myfun(self):
        print(self._dept)
        # print(self.__commission)