import time
def gettime():
    now = time.localtime()
    print(now, type(now))
    return now.tm_hour, now.tm_min

result = gettime()
print("지금은 %d시 %d분입니다" % (result[0], result[1]))

# =============== divmod  ===============
d, m = divmod(7, 3)
print("몫", d)
print("나머지", m)