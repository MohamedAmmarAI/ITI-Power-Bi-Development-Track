class Person:
    def __init__(self, name, address):
        self.name = name
        self.address = address

    def speak(self):
        print(f"I am {self.name}")


class Employee(Person):
    def __init__(self, id=None, email=None, name=None, address=None):
        super().__init__(name=name, address=address)  # call parent constructor
        self.id = id
        self.email = email


    # overriding
    def speak(self, msg="text"):
        super().speak()
        print("this is the child function")



# python support multiple inheritance

class Human:
    def __init__(self):
        self.abc= None
        print("I am human")
    # pass

class Engineer(Human, Employee):  # diamond problem
    def __init__(self):
        super().__init__()
        Employee.__init__(self)
        self.name ="test"



class A():
    def __init__(self):
        self.a = "a"

class B(A):
    def __init__(self):
        super(B, self).__init__()
        self.b="B"  #a,b
        self.a= 'ab'

class C(A):

    def __init__(self):
        super(C, self).__init__()
        self.c = "c"  #c,a
        self.a = "ac"


class D(B,C):
    def __init__(self):
        super(D, self).__init__()
        C.__init__(self)
        # c,a, a,b

d= D()
print(d)

