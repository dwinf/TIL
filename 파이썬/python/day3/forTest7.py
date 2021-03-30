for dan in range(1, 10):
    for num in range(2, 10):
        result = dan * num
        if result > 30 :
            break
        print(dan, "*", num, "=", result, end="\t")
    print()
