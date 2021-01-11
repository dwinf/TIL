def printdeco(*p, deco="@") :
    for data in p :
        print(deco, data, deco)
    print()

printdeco(1,2,3,4,5)
printdeco("가", "나")
printdeco(True, "A", 10, deco="$")
