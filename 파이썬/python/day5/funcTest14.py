price = 1000

def sale():
    global price        # 이 함수내에서 값을 할당하는 price 는 전역 변수라고 설정하는 결과가 된다.
    price = 500         # 전역변수 price 의 값을 변경하게 된다.
    print("sale", id(price))

sale()
print("global", id(price))

price = 1000

def sale():
    global price
    price = 500

sale()
print(price)
