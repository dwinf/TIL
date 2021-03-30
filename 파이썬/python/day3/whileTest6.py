import random    # random 모듈을 가져옴
dice_num = 0
count = 0;
while dice_num != 3:    # 3이 아닐 때 계속 반복
    dice_num = random.randint(1, 6)    # randint를 사용하여 1과 6 사이의 난수를 생성
    print(dice_num)
    count += 1
print(count, "회 반복", sep="")