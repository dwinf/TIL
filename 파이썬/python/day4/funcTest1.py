# 함수의 필요성을 점검하는 예제
sum = 0
for num in range(5):
    sum += num
print("~ 4 =", sum)

sum = 0
for num in range(11):
    sum += num
print("~ 10 =", sum)

print("--- 함수 사용 ---")

def calcsum(n):
    sum = 0
    for num in range(n + 1):
        sum += num
    return sum

print("~ 4 =", calcsum(4))
print("~ 10 =", calcsum(10))