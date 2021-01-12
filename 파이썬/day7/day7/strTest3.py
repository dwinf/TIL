# =============== isdecimal  ===============
height = input("키를 입력하세요 :")    # 입력은 str 객체로 받는다
if height.isdecimal():
    print("키 =", height)
else:
    print("숫자만 입력하세요.")

# =============== lower  ===============
s = "Good morning. my love KIM."
print(s.lower())
print(s.upper())
print(s)

print(s.swapcase())
print(s.capitalize())
print(s.title())

# =============== strlower  ===============
python = input("파이썬의 영문 철자를 입력하시오 : ")
if python.lower() == "python":
    print("맞췄습니다.")

# =============== strip  ===============
s = "  angel   "
print(s + "님")
print(s.lstrip() + "님")
print(s.rstrip() + "님")
print(s.strip() + "님")