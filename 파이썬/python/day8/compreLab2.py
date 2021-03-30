def mycompredict(**arg):
    dict1 = {'my' + k: v for k, v in arg.items()}
    return dict1


print(mycompredict(b=2, c=3, d=4, e=5, f=6))
print(mycompredict(교육='멀캠', 현재='파이썬'))
print(mycompredict(Korean=50, Math=100, Science=30))
print(mycompredict())