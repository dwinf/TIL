def total1(p1, *p2, **p3) :
    print(p1)
    print(p2)
    print(p3)

total1(1,2,3,4,5)
print("="*30)
total1(1,2,3,4,5,a=7,b=8)
print("="*30)
total1(1,a=7,b=8)
print("=*"*15)

def total2(p1, *p2, p4=100, **p3) :
    print(p1)
    print(p2)
    print(p4)
    print(p3)

total2(1,2,3,4,5)
print("="*30)
total2(1,2,3,4,5,a=7,b=8)
print("="*30)
total2(1,2,3,4,5,p4=3000, a=7,b=8)
print("="*30)
total2(1,a=7,b=8)