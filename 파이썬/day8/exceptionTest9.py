try:
    print("네트워크 접속")
    a = 2 / 0
    print("네트워크 통신 수행")
except ZeroDivisionError as z :
    print(z)
finally:
    print("접속 해제")
print("작업 완료")