# 기본값(디폴트) 매개변수
def defaultfn1(p1=10, p2="abc", p3=True) :
    print(p1)
    print(p2)
    print(p3)
    print("=" * 10)

defaultfn1(10,20,30)
defaultfn1("abc", "xyz")
defaultfn1(p2="가", p1="xyz", p3="P")
defaultfn1()

