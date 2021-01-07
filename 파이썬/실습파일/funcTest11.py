def isType(p) :
    if type(p) == int :
        result = "정수를 전달했네요"
    elif type(p) == float :
        result = "실수를 전달했네요"
    elif type(p) == str :
        result = "문자열을 전달했네요"
    elif type(p) == bool :
        result = "논리값을 전달했네요"
    else :
        result = "몰라용^^"
    return result

print(isType(100))
print(isType(3.14))
print(isType("100"))
print(isType("aaa"))
print(isType(True))
print(isType([])) #리스트