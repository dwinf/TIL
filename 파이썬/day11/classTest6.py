class Account:
    def __init__(self, name, balance):
        self.name = name
        self.balance = balance

    def deposit(self, money):
        self.balance += money

    def inquire(self):
        print("%s의 잔액은 %s원입니다." % (self.name, format(self.balance, ',')))


obj1 = Account("둘리", 8000)
obj2 = Account("또치", 8000)
obj3 = Account("도우너", 8000)
obj1.deposit(1000)
obj2.deposit(2000)
obj3.deposit(3000)
obj1.inquire()
obj2.inquire()
obj3.inquire()
