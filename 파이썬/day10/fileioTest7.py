import os

path = "C:\\Temp"
files = os.listdir(path)
for f in files:
    if f.find("_") and f.endswith(".jpg"):
        name = f[0:-4]
        ext = f[-4:]
        part = name.split("_")
        newname = part[1].strip() + "-" + part[0].strip()+"-new" + ext
        print(newname)
        os.rename(path + "\\" + f, path + "\\" + newname)
