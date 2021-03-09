# yes24.txt 파일을 읽고 명사만을 추출한다.
yes24 <- readLines('output/yes24.txt')
wordlist <- sapply(yes24, extractNoun)
undata <- unlist(wordlist)

# 텍스트 전처리 - 한글이 아닌 것은 모두 제거한다.
undata <- gsub("[^가-힣]", "", undata)

# 단어의 길이가 2자이상이고 4자 이하인 단어만을 필터링한다.
undata2 <- Filter(function(x) {nchar(x) >= 2 && nchar(x) <= 4}, undata)

# 각 단어의 개수를 센다.
word_table <- table(undata2)
word_table

# 많은 순으로 정렬한다.
final <- sort(word_table, decreasing = T)

# 데이터프레임으로 만든다.
words <- data.frame(final)

# 다음과 같이 워드크라우드2로 시각화한다.
result <- wordcloud2(data=words)

# 시각화 한 것을 htmltools::save_html () 함수를 사용하여 yes24.html 로 저장한다.
htmltools::save_html(result,"output/yes24.html")


###########################3

# yes24.txt 파일을 읽고 명사만을 추출한다.
yes1 <- readLines('output/yes24.txt')
yes2 <- unlist(extractNoun(yes1))

# 텍스트 전처리 - 한글이 아닌 것은 모두 제거한다.
yes3 <- gsub("[^가-힣]", "", yes2)
yes3 <- gsub("[[^가-힣][:space:]", "", yes2) # \\s를 통한 공백 제외는 안먹힘

# 단어의 길이가 2자이상이고 4자 이하인 단어만을 필터링한다.
yes4 <- Filter(function(x) {nchar(x) >= 2 && nchar(x) <= 4}, yes3)

# 각 단어의 개수를 센다.
yes5 <- table(yes4)
yes5

# 많은 순으로 정렬한다.
yes6 <- sort(word_table, decreasing = T)

# 데이터프레임으로 만든다.
data <- data.frame(yes6)

# 다음과 같이 워드크라우드2로 시각화한다.
result <- wordcloud2(data=data, fontFamily = "휴먼옛체")

# 시각화 한 것을 htmltools::save_html () 함수를 사용하여 yes24.html 로 저장한다.
htmltools::save_html(result,"output/yes24.html")
