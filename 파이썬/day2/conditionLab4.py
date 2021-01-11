import random
grade = random.randint(1, 6)
if grade == 1 or grade == 2 or grade == 3:
    print(str(grade) + "학년은 저학년입니다.")
elif grade == 4 or grade == 5 or grade == 6:
    print(str(grade) + "학년은 고학년입니다.")