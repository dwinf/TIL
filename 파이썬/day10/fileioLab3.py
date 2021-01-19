'''count = 0
try:
    f = open("yesterday.txt", "rt", encoding="UTF-8")
    while True:
        text = f.readline()
        if not text:
            break
        for i in text.split():
            if i.lower() == 'yesterday':
                count += 1
    print(text)

except FileNotFoundError:
    print("파일을 읽을 수 없어요")
else:
    print("Number of a Word 'Yesterday'", count)
finally:
    print("수행완료!!")
    if f:
        f.close()'''

###############
'''f = None    # 파일을 여는 중 오류가 나면 f 객체가 생성되지 않기 때문에 if f에서 오류발생
try:
    f = open("yesterday.txt", "rt", encoding="UTF-8")
    text = f.read()
    max = text.lower()
    c = max.count("yesterday")
except FileNotFoundError:
    print("파일을 읽을 수 없어요")
else:
    print("Number of a Word 'Yesterday'", c)
finally:
    print("수행완료!!")
    if f:
        f.close()'''

################
'''count = 0
try:
    f = open("yesterday.txt", "rt", encoding="UTF-8")
except FileNotFoundError:
    print("파일을 읽을 수 없어요")
else:
    for tmp in f:
        tmp = tmp.lower()
        count += tmp.count('yesterday')
    print(f"Number of a Word 'Yesterday' {count}")
finally:
    print("수행완료!!")
    if f:
        f.close()'''

################
'''try:
    f = open("yesterday.txt", "rt", encoding="UTF-8")   #파일명이 잘못될 경우 에러발생
    text = f.read()
    count = text.count('yesterday') + text.count('Yesterday')
except FileNotFoundError:
    print("파일을 읽을 수 없어요")
else:
    print(f"Number of a Word 'Yesterday' {count}")
finally:
    print("수행완료!!")
    if f:
        f.close()'''

#################
try:
    with open("yesterday.txt", "rt") as f:
        text = f.read()
        text = text.lower()
        number = text.count('yesterday')
except FileNotFoundError:
    print("파일을 읽을 수 없어요")
else:
    print(f"Number of a Word 'Yesterday' {number}")
finally:
    print("수행완료!!")
