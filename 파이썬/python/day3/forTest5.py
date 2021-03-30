startNum = int(input("시작 숫자 : "))
endNum = int(input("종료 숫자 : "))
incNum = int(input("증가치 숫자 : "))

for num in range(startNum, endNum+1, incNum) :
    print(num, end=" ")


