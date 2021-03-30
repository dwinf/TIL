try:
    print("네트워크 접속")
    a = 2 / 0
    print("네트워크 통신 수행")
except ZeroDivisionError as z:
    print(z)
    '''import sys
    sys.exit(-1)'''
finally:
    print("접속 해제")      # 실행을 중지시켜도 finally문은 실행
print("작업 완료")          # 실행을 중지시키면 출력되지 않는다
