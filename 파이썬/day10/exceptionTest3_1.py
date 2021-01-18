while True:
    str = input("점수를 입력하세요 : ")
    try:
        score = int(str)
        print("입력한 점수 :", score)
    except:
        print("점수 형식이 잘못되었습니다.")
    else:
        print("점수를 잘 입력했습니다.")
        break
    finally:
        print("난 항상 수행하는 코드야")
print("작업완료")