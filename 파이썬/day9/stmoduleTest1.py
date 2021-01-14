# =============== import  ===============
import math

print(math.sqrt(2))

# =============== fromimport  ===============
from math import sqrt

print(sqrt(2))

# =============== importas  ===============
import math as m

print(m.sqrt(2))

# =============== fromas  ===============
from math import sqrt as sq

print(sq(2))

# =============== sin  ===============
import math

print(math.sin(math.radians(45)))
print(math.sqrt(2))
print(math.factorial(5))

# =============== statistics  ===============
import statistics

score = [30, 40, 60, 70, 80, 90]
print(statistics.mean(score))
print(statistics.harmonic_mean(score))
print(statistics.median(score))
print(statistics.median_low(score))
print(statistics.median_high(score))