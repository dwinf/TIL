class NoNegativeNumberError(Exception) :
    def __init__(self, msg):
        super().__init__("내가 만든 에러당  : " +msg) 