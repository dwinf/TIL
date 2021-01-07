def print_gugudan(num):
    if type(num) != int:
        return
    elif 1 > num or num > 9:
        return
    else:
        for i in range(1, 10):
            print(num, '*', i, '=', num * i)
print("3단")
print_gugudan(3)
print("\n6단")
print_gugudan(6)
print("\n9단")
print_gugudan(9)