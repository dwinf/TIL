class Member:
    def __init__(self):
        self.name = None
        self.account = None
        self.passwd = None
        self.birthyear = None


s1 = Member()
s2 = Member()
s3 = Member()

s1.name = "kim"
s1.account = "abc"
s1.passwd = "ABC"
s1.birthyear = 1996

s2.name = "lee"
s2.account = "def"
s2.passwd = "DEF"
s2.birthyear = 1997

s3.name = "park"
s3.account = "ghi"
s3.passwd = "GHI"
s3.birthyear = 1998

print(f"회원1 : {s1.name}({s1.account}, {s1.passwd}, {s1.birthyear})")
print(f"회원2 : {s2.name}({s2.account}, {s2.passwd}, {s2.birthyear})")
print(f"회원3 : {s3.name}({s3.account}, {s3.passwd}, {s3.birthyear})")