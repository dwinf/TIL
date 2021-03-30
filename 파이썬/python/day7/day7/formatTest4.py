# 파이썬 3.6부터 사용 가능
# ===== newnewformat  =====
name = "한결"
age = 16
height = 162.5
print(f"이름:{name}, 나이:{age}, 키:{height}")   # f를 통해 f-string으로 인식

# ===== newnewformat2  =====
name = "한결"
age = 16
height = 162.5
print(f"이름:{name:s}, 나이:{age:d}, 키:{height:f}")

# ===== newnewformat3  =====
name = "한결"
age = 16
height = 162.5
print(f"이름:{name:10s}, 나이:{age:5d}, 키:{height:8.2f}")

# ===== newnewformat4  =====
name = "한결"
age = 16
height = 162.5
print(f"이름:{name:^10s}, 나이:{age:>5d}, 키:{height:<8.2f}")

# ===== newnewformat5  =====
name = "한결"
age = 16
height = 162.5
print(f"이름:{name:$^10s}, 나이:{age:>05d}, 키:{height:!<8.2f}")

#===== 1000단위 , 사용 =====
num = 1000000
print(f'{num:,}')