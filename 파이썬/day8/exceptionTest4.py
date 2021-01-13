str = "89"
try:
    score = int(str)
    print(score)
    a = str[5]
except ValueError:
    print("점수의 형식이 잘못되었습니다.")
except IndexError:
    print("첨자 범위를 벗어났습니다.")
print("작업완료")