# =====width  =====
value = 123
print("###%d###" % value)
print("###%5d###" % value)
print("###%10d###" % value)
print("###%1d###" % value)

# =====align  =====
price = [30, 13500, 2000]
for p in price:
    print("가격:%d원" % p)
for p in price:
    print("가격:%7d원" % p)
print("%d - %d - %d" % tuple(price))

# =====numalign  =====
price = [30, 13500, 2000]
for p in price:
    print("가격:%-7d원" % p)
    print("가격:%7d원" % p)

# =====precision  =====
pie = 3.14159265
print("%10f" % pie)
print("%10.8f" % pie)
print("%10.5f" % pie)
print("%10.2f" % pie)

# ===== 1000단위 , 사용 =====
num = 1000000
print('%s' % format(num, ','))
