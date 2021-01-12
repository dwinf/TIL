# =============== split  ===============
s = "짜장 짬뽕 탕슉"
print(s.split())

s2 = "서울->대전->대구->부산"
city = s2.split("->")
print(city)
for c in city:
    print(c, "찍고", end = ' ')

# =============== splitlines  ===============
traveler = """강나루 건너서\n밀밭 길을\n\n구름에 달 가듯이\n가는 나그네\n
길은 외줄기\n남도 삼백리\n\n술 익는 마을마다\n타는 저녁놀\n
구름에 달 가듯이\n가는 나그네"""
poet = traveler.splitlines()
for line in poet:
    print(line)

# =============== join  ===============
s = "._."
print(s.join("대한민국"))

# =============== splitjoin  ===============
s2 = "서울->대전->대구->부산"
city = s2.split("->")
print(" 찍고 ".join(city))

# =============== replace  ===============
s = "독도는 일본땅이다. 대마도도 일본땅이다. "
print(s)
print(s.replace("일본", "한국"))

# =============== just  ===============
message = "안녕하세요."
print(message.ljust(30))
print(message.rjust(30))
print(message.center(30))