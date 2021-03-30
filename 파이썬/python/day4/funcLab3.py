def expr(num1, num2, op):
    sum = 0
    if op == '+':
        sum = num1 + num2
    elif op == '-':
        sum =  num1 - num2
    elif op == '*':
        sum =  num1 * num2
    elif op == '/':
        sum =  num1 / num2
    else:
        return
    return sum

num1 = int(input("num1을 입력 : "))
num2 = int(input("num2을 입력 : "))
op = input("연산자를 입력(+, -, *, /) : ")
result = expr(num1, num2, op)
if result == None:
    print("수행 불가")
else:
    print("연산결과 :", result)