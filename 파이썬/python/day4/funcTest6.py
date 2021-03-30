def print_name(num, deco) :
    for i in range(num) :
        print(deco, "유니코", deco)


print("수행시작")
print_name(1, '#')
print("-" * 10)
print_name(3, '*')
print("-" * 10)
print_name(2, '@')
print("-" * 10)
print_name(int(3.14), '%')
print("수행종료")