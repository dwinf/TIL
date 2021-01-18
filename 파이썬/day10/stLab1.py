import calendar
while True:
    try:
        year = int(input("태어난 년도를 입력하세요(4자리) : "))
        month = int(input("태어난 월을 입력하세요 : "))
    except (ValueError, IndexError):
        print("숫자를 다시 입력해주세요")
    else:
        print(calendar.month(year, month))
        break



