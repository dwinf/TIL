def myemail_info(email):
    mail = ()
    if email.count('@') == 0:
        return
    id, adr = email.split('@')
    mail = id, adr
    return mail



print(myemail_info('kim@google.com'))
print(myemail_info('jang@naver.com'))
print(myemail_info('unico@hmail.net'))
print(myemail_info("goog.com"))


def myemail_info2(email):
    mail = ()
    if '@' in email:
        adr = email.split('@')
        return adr
    else:
        return None


print(myemail_info2('kim@google.com'))
print(myemail_info2('jang@naver.com'))
print(myemail_info2('unico@hmail.net'))
print(myemail_info2("goog.com"))