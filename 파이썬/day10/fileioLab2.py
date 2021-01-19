import time

now = time.localtime()

try:
    fr = open("sample.txt", "rt", encoding="UTF-8")
    filename = f"sample_{now.tm_year}_{now.tm_mon:02d}_{now.tm_mday:02d}.txt"
    # text = fr.read()
    fw = open(filename, "at", encoding="UTF-8")
    # fw.write(text)
    for line in fr:
        fw.write(line)

    fw.close()
    fr.close()
except FileNotFoundError as e:
    # print("파일을 찾을 수 없습니다.")
    print(e)
else:
    print("저장이 완료되었습니다.")
'''finally:
    if fw:
        fw.close()
    if fr:
        fr.close()'''