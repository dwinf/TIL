class Book:
    def __init__(self, title, author, price):
        self.title = title
        self.author = author
        self.price = price

    '''def getBookInfo(self):
        bookinfo = [self.title, self.author, self.price]
        return bookinfo'''

    def getBookInfo(self):
        return f"{self.title},{self.author},{self.price}"

b1 = Book("파이썬 정복", "김상형", "22000")
b2 = Book("생활코딩! HTML  +CSS + 자바스크립트", "이고잉", "27000")
b3 = Book("이것이 MariaDB다", "우재남", "30000")
b4 = Book("파이썬 웹 프로그래밍", "김석훈", "22000")
b5 = Book("맛있는 MongoDB", "정승호", "28000")

booklist = [b1, b2, b3, b4, b5]
num = 0

'''for i in booklist:
    print(f"책이름 : {i.title}")
    print(f"저자 : {i.author}")
    print(f"가격 : {i.price}")
    num += 1
    if num < len(booklist):
        print('-' * 10)'''

for i in booklist:
    print(i.getBookInfo().replace(',', '\n'))
    num += 1
    if num < len(booklist):
        print('-' * 10)