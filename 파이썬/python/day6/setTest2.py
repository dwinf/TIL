mammal = { '코끼리', '고릴라', '사자', '고래', '사람', '원숭이', '개' }
primate = { '사람', '원숭이', '고릴라' }

if '사자' in mammal:
    print("사자는 포유류이다")
else:
    print("사자는 포유류가 아니다.")

print(primate <= mammal)
print(primate < mammal)
print(primate <= primate)
print(primate < primate)

