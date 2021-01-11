print("---가변형 인자 함수 정의---")
def sumall(*p) :    #*가 없으면 1개의 매개변수를 받기 때문에 에러
    """ 아규먼트로 전달되는 모든 숫자들의 합을 리턴""" #docstring
    print("p의 타입 :", type(p))
    sum = 0
    for data in p :
        sum += data
    return sum

print(sumall(1,2,3,4,5))    #튜플로 패킹되어 전달
print(sumall(100, 200, 300))
print(sumall(10,20,30,40,50,60,70))

help(sumall)