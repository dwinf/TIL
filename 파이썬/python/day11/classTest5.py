def deposit(name, money):
    if name == "둘리":
        global balancedooly
        balancedooly += money
    elif name == "또치":
        global balanceddochi
        balanceddochi += money
    elif name == "도우너":
        global balancedouner
        balancedouner += money


def inquire(name):
    if name == "둘리":
        print("%s의 잔액은 %s원입니다." % (name, format(balancedooly, ',')))
    elif name == "또치":
        print("%s의 잔액은 %s원입니다." % (name, format(balanceddochi, ',')))
    elif name == "도우너":
        print("%s의 잔액은 %s원입니다." % (name, format(balancedouner, ',')))


dooly = "둘리"
ddochi = "또치"
douner = "도우너"

balancedooly = 8000
balanceddochi = 8000
balancedouner = 8000

deposit(dooly, 1000)
inquire(dooly)

deposit(ddochi, 2000)
inquire(ddochi)

deposit(douner, 3000)
inquire(douner)
