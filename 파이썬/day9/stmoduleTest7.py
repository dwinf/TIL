# =============== sys  ===============
import sys

print("버전 :", sys.version)
print("플랫폼 :", sys.platform)
if (sys.platform == "win32"):
    print(sys.getwindowsversion())
print("바이트 순서 :", sys.byteorder)
print("모듈 경로 :", sys.path)
#sys.exit(0)

# =============== sysarg  ===============
import sys

print(sys.argv)

# =============== argcal  ===============
import calendar
import time
import sys

if (len(sys.argv) == 1):
    t = time.time()
    tm = time.localtime(t)
    calendar.prmonth(tm.tm_year, tm.tm_mon)
elif (len(sys.argv) == 2):
    print(calendar.calendar(int(sys.argv[1])))
elif (len(sys.argv) == 3):
    calendar.prmonth(int(sys.argv[1]), int(sys.argv[2]))
else:
    print("인수는 2개 이하여야 합니다.")