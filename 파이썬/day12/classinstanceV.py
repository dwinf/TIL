class Card:
    width = 100
    height = 200
    def __init__(self, kind, number):
        self.kind = kind
        self.number = number

    def __str__(self):
        return '카드종류 : "%s", 카드 숫자 : %d, 카드 너비 : %d, 카드 높이 : %d' %(self.kind, self.number, Card.width, Card.height)


card_1 = Card("Heart", 5)
card_2 = Card("Spade", 9)
card_3 = Card("Clover", 2)
card_4 = Card("Diamond", 10)

print(card_1)
print(card_2)
print(card_3)
print(card_4)
