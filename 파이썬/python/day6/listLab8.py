a = [['B', 'C', 'A', 'A'],
     ['C', 'C', 'B', 'B'],
     [ 'D', 'A', 'A', 'D']]
ca, cb, cc, cd = 0, 0, 0, 0
for i in range(len(a)):
    for j in range(len(a[i])):
            if a[i][j] == 'A':
                ca += 1
            elif a[i][j] == 'B':
                cb += 1
            elif a[i][j] == 'C':
                cc += 1
            else:
                cd += 1
print('A는', ca, '개 입니다.')
print('B는', cb, '개 입니다.')
print('C는', cc, '개 입니다.')
print('D는', cd, '개 입니다.')

numlist = [ca, cb, cc, cd]
for i in range(4):
    print(chr(65 + i), "는 ", numlist[i], "개 입니다.", sep='')