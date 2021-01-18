f = open("live.txt", "rt", encoding="UTF-8", errors='ignore')
print("[seek기능 처리가능]" if f.seekable() else "[seek기능 처리불가]" )
f.seek(12,0)
text = f.read()
f.close()
print(text)

# =============== append  ===============
f = open("live.txt", "at", encoding="UTF-8")
f.write("\n\n[추가]푸쉬킨 형님의 말씀이었습니다.")
f.close()

# =============== withas  ===============
with open("live.txt", "rt", encoding="UTF-8") as f:   # with블럭 수행이 끝나면 자동으로 close
   text = f.read()
print(text)
