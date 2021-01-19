balance = 8000


def deposit(money):
    global balance
    balance += money


def inquire():
    print("잔액은 %s원입니다." % format(balance, ","))


deposit(1000)
inquire()
