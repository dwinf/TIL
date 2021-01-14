# =============== time  ===============
import time

print(time.time())

# =============== ctime  ===============
import time

t = time.time()
print(time.ctime(t))

# =============== structtime  ===============
import time

t = time.time()
print(time.localtime(t))

# =============== localtime  ===============
import time

now = time.localtime()
print("%d년 %d월 %d일" % (now.tm_year, now.tm_mon, now.tm_mday))
print("%d:%d:%d" % (now.tm_hour, now.tm_min, now.tm_sec))

# =============== datetime  ===============
import datetime

now = datetime.datetime.now()
print("%d년 %d월 %d일" % (now.year, now.month, now.day))
print("%d:%d:%d" % (now.hour, now.minute, now.second))
print(now.isoformat())  # ISO 8601 -  날짜와 시간과 관련된 데이터 교환을 다루는 국제 표준

print(datetime.datetime.fromtimestamp(0).isoformat())

s = f"smaple_{now.year}_{now.month}_{now.day}"
print(s)
s1 = f"smaple_{now.year}_{now.month:02d}_{now.day:02d}"
print(s1)