class Human:
    def __init__(self, age, name):
        self.age = age
        self.name = name
    def __eq__(self, other):
        return self.age == other.age and self.name == other.name

kim = Human(29, "김상형")
kim1 = kim
sang = Human(29, "김상형")
moon = Human(44, "김상형")
print(kim == kim1)
print(kim == sang)
print(kim == moon)
print("-"*5+"추가"+"-"*5)
dooly = Human(44, "둘리")
print(moon == dooly)
dooly2 = Human(44, "둘리")
print(dooly == dooly2)
print(dooly is dooly2)
print(kim is kim1)