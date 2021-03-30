try:
    f = open("live1.txt", "rt", encoding="UTF-8")
    print(f, type(f))
    text = f.read()
    print(text)
except FileNotFoundError:
    print("파일이 없습니다.")
'''finally:
    f.close()   # f가 오픈되지 않았다면 에러 발생
'''
print("*" * 20)
f = None
try:
    f = open("live1.txt", "rt", encoding="utf8")
    text = f.read()
    print(text)
except FileNotFoundError:
    print("파일이 없습니다.")
finally:
    if f:
        f.close()
