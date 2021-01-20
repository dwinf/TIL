class Human:
    def __init__(self, age, name):
        self.age = age
        self.name = name
    def __str__(self):
        return "이름 %s, 나이 %d" % (self.name, self.age)
    def __len__(self):
        return self.age

kim = Human(29, "김상형")
print(kim)
print(len(kim))