# 파이썬 2.6 과 3.0부터 사용 가능
# =====newformat  =====
name = "한결"
age = 16
height = 162.5
print("이름:{}, 나이:{}, 키:{}".format(name, age, height))

# =====newformat2  =====
name = "한결"
age = 16
height = 162.5
print("이름:{0:s}, 나이:{1:d}, 키:{2:f}".format(name, age, height))  # 포맷문자 앞 {0:}는 아규먼트 인덱스

# =====newformat3  =====
name = "한결"
age = 16
height = 162.5
print("이름:{0:10s}, 나이:{1:5d}, 키:{2:8.2f}".format(name, age, height))    # 한글은 1글자당 2칸 차지

# =====newformat4  =====
name = "한결"
age = 16
height = 162.5
print("이름:{0:^10s}, 나이:{1:>5d}, 키:{2:<8.2f}".format(name, age, height))     # ^:가운데정렬, >:오른쪽, <:왼쪽

# =====newformat5  =====
name = "한결"
age = 16
height = 162.5
print("이름:{0:$^10s}, 나이:{1:>05d}, 키:{2:!<8.2f}".format(name, age, height))  # 정렬 문자 앞의 문자는 공백을 채울 문자

#===== 1000단위 , 사용 =====
num = 1000000
print('{:,}'.format(num))