while True:
    word = input("문자열을 입력하세요 : ")
    wordlength = len(word)
    if wordlength == 0:
        break
    elif 0 < wordlength < 5:
        result = '*' + word + '*'
    elif 5 <= wordlength <= 8:
        continue
    else:
        result = '$' + word + '$'
    print("유효한 입력 결과 :", result)