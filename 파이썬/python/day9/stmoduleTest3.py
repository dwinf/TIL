# =============== ellapse  ===============
import time

start = time.time()
for a in range(1000):
    print(a)
end = time.time()
print(end - start)

# =============== sleep  ===============
import time

print("안녕하세요.")
time.sleep(1)
print("밤에 성시경이 두 명 있으면 뭘까요?")
time.sleep(5)
print("야간투시경입니다.")

