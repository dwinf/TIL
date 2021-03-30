oddeven = {d: '홀수' if d % 2 else '짝수' for d in range(1, 16)}
print(oddeven)

scores = {'길동': 90, '순희': 60, '영희': 80, '철수': 50}
grades = {name: 'PASS' if value > 70 else 'No-PASS' for name, value in scores.items()}
print(grades)

member = {'name' + str(i): i * 10 if i > 5 else i + 100 for i in range(1, 11)}
print(member)

fruits = ['apple', 'mango', 'banana', 'cherry']
dic_fruits = {f: len(f) for f in fruits}

print(dic_fruits)

print({v: k for k, v in member.items()})

print({v: k for k, v in dic_fruits.items()})
