salerate = 0.9

def kim():
    print("오늘의 할인율 :", salerate) # r-value(값) --> 지역변수가 없으면 전역변수를 찾아서 사용

def lee():
    price = 1000
    print("가격 :", price * salerate)

kim()
salerate = 1.1
lee()
################
price = 1000

def sale():
    price = 500     # l-value(값) --> 지역변수를 새로 만들게 된다.
    print(price)    # r-value(값) --> 지역변수가 있으므로면 지역변수 사용

sale()
print(price)