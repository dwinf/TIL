while True:
    mul = 1
    num = int(input("숫자를 하나 입력하세요 : "))
    if num < -10 or num > 10:
        continue
    elif 0 < num <= 10:
        print("입력값 :", num)
        """for i in range(1, num+1):
            mul *= i
        print(mul)"""
        i = 1
        while i <= num:
            mul *= i
            i += 1
        print(mul)
    elif -10 <= num < 0:
        print("입력값(부호변경) :", abs(num))
        """for i in range(1, abs(num) + 1):
            mul *= i
        print(mul)"""
        i = 1
        while i <= abs(num):
            mul *= i
            i += 1
        print(mul)
    else:
        print("종료")
        break