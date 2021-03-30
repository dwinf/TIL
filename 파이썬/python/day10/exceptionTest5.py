str = "89점"
try:
    score = int(str)
    print(score)
    a = str[5]
except ValueError as e:     # 에러를 변수에 담아 사용
    print(e)
except IndexError as e:
    print(e)
print("작업완료")