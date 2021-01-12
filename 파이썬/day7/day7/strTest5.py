# =============== center  ===============
traveler = """강나루 건너서\n밀밭 길을\n\n구름에 달 가듯이\n가는 나그네\n
길은 외줄기\n남도 삼백리\n\n술 익는 마을마다\n타는 저녁놀\n
구름에 달 가듯이\n가는 나그네"""
poet = traveler.splitlines()
for line in poet:
    print(line.center(30))

text = "Py@12가 나%"

for data in text:
    print(data)

print("-" * 20)

for data in text:
    if data.isalpha():
        print("문자(", data, ")", end="", sep="")
    if data.isdigit():
        print("숫자(", data, ")", end="", sep="")
    if data.isascii():      # 영어 대소문자는 아스키라고도 함
        print("아스키(", data, ")", end="", sep="")
    if data.islower():
        print("소문자(", data, ")", end="", sep="")
    if data.isupper():
        print("대문자(", data, ")", end="", sep="")
    if data.isspace():
        print("공백문자(", data, ")", end="", sep="")
    if data.isalnum():
        print("문자 또는 숫자(", data, ")", end="", sep="")
    print("\n------")
