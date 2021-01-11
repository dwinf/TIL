def printsum(n):
    sum = 0
    for num in range(n + 1):
        sum += num
    print("~", n, "=", sum)

printsum(4)
printsum(10)