# =============== sort  ===============
score = [88, 95, 70, 100, 99]
score.sort()
print(score)
score.reverse()
print(score)

# =============== sort2  ===============
country = ["Korea", "japan", "CHINA", "america"]
country.sort()
print(country)
country.sort(key=str.lower)
print(country)

# =============== sort3 ===============
country = ["Korea", "japan", "CHINA", "america"]
country.sort()
print(country)
country.sort(key=len)   # 길이를 이용한 정렬
print(country)

# =============== sorted  ===============
score = [88, 95, 70, 100, 99]
score2 = sorted(score)
print(score)
print(score2)
