dic = { 'boy':'소년', 'school':'학교', 'book':'책' }
try:
    print(dic['girl'])
except:
    print("찾는 단어가 없습니다.")

han = dic.get('girl')
if (han == None):
    print("찾는 단어가 없습니다.")
else:
    print(han)
