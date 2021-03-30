def myprint(*a, **args):
    deco = '**'     # 기본값 설정, 인수가 없을 경우
    s = ','     # 기본값 설정
    """if 'deco' in args.keys():   # 데이터가 없으면 에러
        deco = args['deco']
    if 'sep' in args.keys():
        s = args['sep']"""

    deco = args.get('deco', "**")   # deco가 없을 경우 "**" 삽입
    s = args.get('sep', ',')

    result = ''
    if len(a) == 0:     # if p:
        print("Hello Python")
    else:
        result += deco
        for i in range(len(a)):
            result += str(a[i])
            if i < len(a) - 1:
                result += s
        result += deco
        print(result)

    '''print(deco, end='')
    print(*args, sep=sep, end='')
    print(deco)'''

myprint(10, 20, 30, deco='@', sep='-')
myprint("python", "javascript", "R", deco="$")
myprint("가", "나", "다")
myprint(100)
myprint(True, 111, False, "abc", deco="&", sep="")
myprint()