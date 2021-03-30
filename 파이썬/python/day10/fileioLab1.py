import os
import time
import calendar

if not os.path.isdir("c:/iotest"):
    os.mkdir("c:/iotest")
    print("c:/iotest 생성")
else:
    print("c:/iotest 폴더는 이미 존재!!")

f = open("c:/iotest/today.txt", "wt", encoding="UTF-8")
print(f, type(f))
f.write("""오늘은 2021년 01월 18일입니다.
오늘은 월요일입니다.
나는 목요일에 태어났습니다.""")
f.close()
print("저장이 완료되었습니다.")

##########################################

if not os.path.isdir("c:/iotest"):
    os.mkdir("c:/iotest")

now = time.localtime()
week = ['월', '화', '수', '목', '금', '토', '일']

f = open("c:/iotest/today.txt", "wt", encoding="UTF-8")

f.write(f'''오늘은 {now.tm_year}년 {now.tm_mon:02d}월 {now.tm_mday:02d}일입니다.
오늘은 {week[calendar.weekday(now.tm_year, now.tm_mon, now.tm_mday)]}요일입니다.
나는 {week[calendar.weekday(1996,8,8)]}요일에 태어났습니다.''')

f.close()
print("저장이 완료되었습니다.")
