import random
score = random.randint(0, 100)
if 90 <= score:
    grade = "A"
elif 80 <= score < 90:
    grade = "B"
elif 70 <= score < 80:
    grade = "C"
elif 60 <= score < 70:
    grade = "D"
else:
    grade = "F"
print(str(score) + "점은 " + grade + "등급입니다.")