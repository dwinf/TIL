import random    # random 모듈을 가져옴
count = 0
while True:
    count += 1
    num = random.randint(1, 20)
    if num % 5 == 0 :
        print("끝낼께용!!")
        break
    elif num % 2 == 0 :
        print("다시 할께용!!")
        continue
    else :
        for i in range(num) :
            print("#", end="")
        print()
    print("지금까지", count, "회 반복")
print("====== 수행 종료 =====")