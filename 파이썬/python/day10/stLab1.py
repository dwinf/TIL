'''import calendar
while True:
    try:
        year = int(input("년도를 입력하세요 : "))
        month = int(input("월을 입력하세요 : "))
    except ValueError:
        print("숫자를 다시 입력해주세요")
    else:
        print(calendar.month(year, month))
        break
'''

################3333

import calendar
while True:
    try:
        year = int(input("년도를 입력하세요 : "))
        month = int(input("월을 입력하세요 : "))
        if month not in range(1,13):
            raise ValueError("월은 1~12 사이로 입력하세요")
        if year < 0:
            raise ValueError("년도는 양수로 입력하세요")
        break
    except ValueError as v:
        print("숫자를 다시 입력해주세요", v)
print(calendar.month(year, month))
