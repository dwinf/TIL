def myprint(*a, **args):
    '''deco = '**'
    s = ','
    if 'deco' in args.keys():
        deco = args['deco']
    if 'sep' in args.keys():
        s = args['sep']'''

    deco = args.get('deco', '**')
    s = args.get('sep', ',')

    result = ''
    if len(a) == 0:
        print("Hello Python")
    else:
        result += deco
        for i in range(len(a)):
            result += str(a[i])
            if i < (len(a)-1):
                result += s
        result += deco
        print(result)

print("[case1]")
myprint(10, 20, 30, deco="@", sep="-")
myprint("python", "javascript", "R", deco="$")
myprint("가", "나", "다")
myprint(100)
myprint(True, 111, False, "abc", deco="&", sep="")
myprint()

def myprint(*p, **q):
    sep, deco = ',', '**'
    if len(p) != 0:
        if 'sep' in q:
            sep = q['sep']
        if 'deco' in q:
            deco = q['deco']
        p = [str(i) for i in p]
        print(deco, sep.join(p), deco, sep='')
    else:
        print('Hello Python')
print("\n[case2]")
myprint(10, 20, 30, deco="@", sep="-")
myprint("python", "javascript", "R", deco="$")
myprint("가", "나", "다")
myprint(100)
myprint(True, 111, False, "abc", deco="&", sep="")
myprint()


def myprint(*args,**kwargs):
    if(len(args)==0):
        print("Hello Python!!!")
        return
    deco="**"
    sep=","

    if "deco" in kwargs:
        deco=kwargs["deco"]

    if "sep" in kwargs:
        sep=kwargs["sep"]

    print(deco,end='')
    print(*args,sep=sep,end='')
    print(deco)

print("\n[case3]")
myprint(10,20,30,deco="@",sep='-')
myprint("python","javascript","R",deco="$")
myprint("가","나","다")
myprint(100)
myprint(True,111,False,"abc",deco="&",sep='')
myprint()