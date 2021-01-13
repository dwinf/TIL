while True:
    str = input("점수를 입력하세요 : ")
    try:
        score = int(str)
        print("입력한 점수 :", score)
        break
    except:
        print("점수 형식이 잘못되었습니다.")
    finally:
        print("난 항상 수행하는 코드야")
print("작업완료")