def calcsum(n):
    """1 ~ n까지의 합계를 구해 리턴한다."""
    sum = 0
    for i in range(n+1):
        sum += i
    return sum

print(calcsum(10))
help(calcsum)

