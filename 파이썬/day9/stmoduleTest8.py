# =============== datecalc  ===============
import sys
import time

if (len(sys.argv) != 2):
    print("시작 날짜를 yyyymmdd로 입력하십시오.")
    sys.exit(0)

birth = sys.argv[1]
if (len(birth) != 8 or birth.isnumeric() == False):
    print("날짜 형식이 잘못되었습니다.")
    sys.exit(0)

tm = (int(birth[:4]), int(birth[4:6]), int(birth[6:8]), 0, 0, 0, 0, 0, 0)
ellapse = int((time.time() - time.mktime(tm)) / (24 * 60 * 60))
print(ellapse, "일")

# =============== ellapsedate2  ===============
import sys
import time

year = int(input("태어난 년도를 입력하세요(4자리) : "))
month = int(input("태어난 월을 입력하세요 : "))
day = int(input("태어난 일을 입력하세요 : "))

tm = (year, month, day, 0, 0, 0, 0, 0, 0)

ellapse = int((time.time() - time.mktime(tm)) / (24 * 60 * 60))
print(ellapse, "일")

