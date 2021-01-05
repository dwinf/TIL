num = int(input("1부터 10사이의 숫자를 하나 입력하세요 : "))
if 1 <= num <= 10:
    if num % 2 ==0:
        print(str(num), ": 짝수")
    else:
        print(str(num), ": 홀수")
else:
    print("1부터 10사이의 값이 아닙니다.")