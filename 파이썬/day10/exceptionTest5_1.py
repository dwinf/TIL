str = "89"
try:
    score = int(str)
    print(score)
    a = str[5]
except (ValueError, IndexError) as e:   # 예외를 괄호를 이용해 한번에 처리
    print(e)
print("작업완료")