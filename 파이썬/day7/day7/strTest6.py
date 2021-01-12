str1 = "prettyflower"
str2 = "this is string example....wow!!! this is really string"
print("Capitalize: ", str1.capitalize())
print("endswith?: ", str1.endswith("r"))
print("join str: ", str1.join(["I'm ", "!"]))
print("replace1: ", str1.replace('pretty', 'Good'))
print("replace2: ", str2.replace("is", "was", 3))
print("split: ", str2.split(' '))  # Type 확인
print("sorted: ", sorted(str1))  # reverse=True
print("reversed1: ", reversed(str1)) #list 형 변환
print("reversed2: ", list(reversed(str1)))