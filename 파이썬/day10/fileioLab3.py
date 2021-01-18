count = 0
try:
    f = open("yesterday.txt", "rt", encoding="UTF-8")
    while True:
        text = f.readline().split()
        if not text:
            break
        for i in text:
            if i.lower() == 'yesterday':
                count += 1
                print(i)
except FileNotFoundError:
    print("파일을 읽을 수 없어요")
finally:
    f.close()

print("yesterday의 개수 :", count)