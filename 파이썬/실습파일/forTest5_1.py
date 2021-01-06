startNum = int(input("시작 숫자 : "))
endNum = int(input("종료 숫자 : "))
incNum = int(input("증가치 숫자 : "))

if startNum > endNum and incNum < 0 :
    endNum -= 1
else :
    endNum += 1
for num in range(startNum, endNum, incNum) :
    print(num, end=" ")

