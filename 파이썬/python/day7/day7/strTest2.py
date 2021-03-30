# =============== find  ===============
s = "python programming"
print(len(s))
print(s.find('o'))
print(s.rfind('o'))
print(s.index('r'))
print(s.count('n'))

# =============== count  ===============
s = """생각이란 생각할수록 생각나므로 생각하지 말아야 할 생각은 생각하지 
않으려고 하는 생각이 옳은 생각이라고 생각합니다."""
print("생각의 출현 횟수 :", s.count('생각'))

# =============== in  ===============
s = "python programming"
print('a' in s)
print('z' in s)
print('pro' in s)
print('x' not in s)

# =============== startswith  ===============
name = "김한결"
if name.startswith("김"):
    print("김가입니다.")
if name.startswith("한"):
    print("한가입니다.")

file = "girl.jpg"
if file.endswith(".jpg"):
    print("그림 파일입니다.")
