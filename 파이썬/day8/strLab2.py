s1 = "pythonjavascript"
print(len(s1))

s2 = "010-7777-9999"
print(s2.replace('-', ''))
a = s2.split('-')
print(''.join(a))

s3 = "PYTHON"
print(s3[::-1])

s4 = "Python"
print(s4.lower())

s5 = "https://www.python.org/"
print(s5[8:-1])

s6 = '891022-2473837'
if s6[7] == '1' or s6[7] == '3':
    sex = '남성'
else:
    sex = '여성'
print(sex)

def gender(a):
    if a[7] == '1' or a[7] == '3':
        sex = '남성'
    else:
        sex = '여성'
    return sex
print(gender(s6))

s7 = '100'
print(int(s7), float(s7))

s8 = ' The Zen of Python'
print(s8.count('n'))
print(s8.index('Z'))
lists8 = [s8.upper().split()]
print(lists8)