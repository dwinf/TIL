def print_triangle_withdeco(num, deco = '%'):
    if num < 1 or num > 10:
        pass
    else:
        for i in range(1, num + 1):
            print(' ' * (num - i), sep='', end='')
            print(deco * i)

print("숫자 2 전달시")
print_triangle_withdeco(3)
print("숫자 5와 데코문자 '*' 전달시")
print_triangle_withdeco(5, '*')
print("숫자 11 전달시")
print_triangle_withdeco(11)