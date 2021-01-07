price = 1000

def sale():
    global price
    price = 500
    print("sale", id(price))

sale()
print("global", id(price))

price = 1000

def sale():
    global price
    price = 500

sale()
print(price)
