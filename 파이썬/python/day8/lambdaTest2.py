func1 = lambda n1, n2: n1 + n2

print(func1(10, 20))
result = func1(100, 200)
print(result)

func2 = lambda s: len(s)
print(func2('simple'))

func3 = lambda: print("no argument, no return")  # 리턴결과가 None
print(func3())

func4 = lambda p1, p2, p3: print(p1, p2, p3)
func4(10, 20, 30)   # print를 안해서 None 출력이 안됨

func5 = lambda *p: print(sum(p))
func5(1, 2, 3, 4, 5)
func5(11, 22)
