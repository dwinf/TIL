# =============== sleep2  ===============
import time

for dan in range(2, 10):
    print(dan, "단")
    for hang in range(2, 10):
        print(dan, "*", hang, "=", dan*hang)
        time.sleep(0.2)
    print()
    time.sleep(1)

# =============== calendar  ===============
import calendar

print(calendar.calendar(2018))
print(calendar.month(2019, 1))
#calendar.prcal(2018)
#calendar.prmonth(2019, 1)

# =============== weekday  ===============
import calendar

yoil = ['월', '화', '수', '목', '금', '토', '일']
day = calendar.weekday(2020,8,15)
print("광복절은", yoil[day] + "요일이다." )