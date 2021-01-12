students = dict(둘리=90, 또치=85, 도우너=95, 희동이=75, 마이콜=80)
print(students)

pass_students = {k: v for k, v in students.items()}
print(pass_students)

pass_students = {k: v for k, v in students.items() if v > 80}
print(pass_students)

pass_students = {k: v for k, v in students.items() if len(k) > 2}
print(pass_students)

pass_students = {k: v for k, v in students.items() if len(k) > 2 and v > 80}
print(pass_students)

swap_students = {v: k for k, v in students.items()}
print(swap_students)
