dic = {
    '월':{'high':-4, 'low':-12},
    '화': {'high': 2, 'low': -4},
    '수': {'high': 9, 'low': -8},
    '목': {'high': 6, 'low': -3},
    '금': {'high': 8, 'low': -7},
    '토': {'high': -3, 'low': -13},
    '일': {'high': -2, 'low': -6}
}
dic2 = {
    '월':(-4, -12),
    '화':(2, -4),
    '수':(9, -8),
    '목':(6, -3),
    '금':(8, -7),
    '토':(-3, -13),
    '일':(-2, -6)
}
day_of_week = input("요일명을 한글로 입력하세요 : ")
"""if day in dic:
    print(day, "요일의 최저기온는 ", dic[day]['low'], "이고 최고기온는", dic[day]['high'], "입니다.")
else:
    print(day, "요일의 정보를 찾을 수 없습니다.")"""

if day_of_week in dic2:
    print(day_of_week, "요일의 최저기온는 ", dic2[day_of_week][1], "이고 최고기온는", dic2[day_of_week][0], "입니다.")
else:
    print(day_of_week, "요일의 정보를 찾을 수 없습니다.")