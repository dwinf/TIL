import os
if not os.path.isdir("c:/Temp/log"):
    os.mkdir("c:/Temp/log")
    print("c:/Temp/log 폴더 생성")
else :
    print("c:/Temp/log 폴더는 이미 존재!!")