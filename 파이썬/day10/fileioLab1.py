import os

if not os.path.isdir("c:/iotest"):
    os.mkdir("c:/iotest")
    print("c:/iotest 생성")
else:
    print("c:/iotest 폴더는 이미 존재!!")

f = open("c:/iotest/today.txt", "wt", encoding="UTF-8")
print(f, type(f))
f.write("""오늘은 2021년 01월 18일입니다.
오늘은 월요일입니다.
나는 목요일에 태어났습니다.""")
f.close()
print("저장이 완료되었습니다.")
