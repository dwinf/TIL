def print_triangle(num):
    if 1 <= num <= 10:
        for i in range(1, num + 1):
            for j in range(1, i + 1):
                print('*', end='')
            print()
        """for i in range (1, num+ 1 ):
            print('*' * i)"""
    else:
        return
print("2 전달")
print_triangle(2)
print("5 전달")
print_triangle(5)
print("10 전달")
print_triangle(10)
