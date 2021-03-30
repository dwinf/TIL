# 일부 기본값(디폴트) 매개변수
def defaultfn2(p1, p2="abc", p3=True) :
    print(p1)
    print(p2)
    print(p3)
    print("=" * 10)

defaultfn2(10,20,30)
defaultfn2("abc", "xyz")
defaultfn2(p2="가", p1="xyz")
defaultfn2("aa")
defaultfn2(p1="올라프")
#defaultfn2()
