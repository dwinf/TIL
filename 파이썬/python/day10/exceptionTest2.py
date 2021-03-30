str = "89점"
try:
    score = int(str)
    print(score)
except:     #모든 종류의 예외를 포함
    print("예외가 발생했습니다.")
    '''import sys
    sys.exit(-1)''' # 프로그램을 종료
print("작업완료")