from encapsulation import Employee,Manager

e = Employee()
# e.dept = 'AI'  # add attribute in runtime to the object
# print(e.__commission)
print("fff")

m = Manager()
m.myfun()
m._dept="opensource"
print(m._dept)
print("gggg")
print("tesst")