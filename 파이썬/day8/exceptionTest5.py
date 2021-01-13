str = "89"
try:
    score = int(str)
    print(score)
    a = str[5]
except ValueError as e:
    print(e)
except IndexError as e:
    print(e)
print("작업완료")