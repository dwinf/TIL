# =============== filter  ===============
def flunk(s):
    return s < 60

score = [ 45, 89, 72, 53, 94 ]
for s in filter(flunk, score):
    print(s)

# =============== map  ===============
def half(s):
    return s / 2

score = [ 45, 89, 72, 53, 94 ]
for s in map(half, score):
    print(s, end = ', ')

# =============== map2  ===============
def total(s, b):
    return s + b

score = [ 45, 89, 72, 53, 94 ]
bonus = [ 2, 3, 0, 0, 5 ]
for s in map(total, score, bonus):
    print(s, end=", ")


