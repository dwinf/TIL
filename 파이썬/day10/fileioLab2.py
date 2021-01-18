try:
    ap = open("sample.txt", "rt", encoding="UTF-8")
    text = ap.read()
    f = open("sample_yyyy_mm_dd.txt", "at", encoding="UTF-8")
    f.write(text)
except FileNotFoundError:
    print("파일을 찾을 수 없습니다.")
else:
    print("저장이 완료되었습니다.")
finally:
    if f:
        f.close()
    if ap:
        ap.close()