# 문제 1
v1 <- c("Happy", "Birthday", "to", "You")
length(v1)
sum(nchar(v1))


# 문제 2
v2 <- paste(v1, collapse = " ")
length(v2)
nchar(v2)


# 문제 3
alnum <- paste(LETTERS[1:10], 1:10)
alnum
alnum2 <- paste0(LETTERS[1:10], 1:10)
alnum2


# 문제 4
text <- "Good Morning"
strsplit(text, " ")


# 문제 5
text <- c("Yesterday is history, tommrrow is a mystery, today is a gift!", 
  "That's why we call it the present – from kung fu Panda")
gsub("[[:punct:]]", "", text)
strsplit(gsub("[[:punct:]]", "", text), " ")


# 문제 6
s1 <- "@^^@Have a nice day!! 좋은 하루!! 오늘도 100점 하루...."
r1 <- gsub("[가-힣]", "", s1); r1
r2 <- gsub("[[:punct:]]", "", s1); r2
r3 <- gsub("[[:punct:]가-힣]", "", s1); r3
r4 <- gsub("100", "백", s1); r4


# 문제 7
hotel <- readLines('output/hotel.txt')
#hotel
wordlist <- sapply(hotel, extractNoun, USE.NAMES = F)

undata <- unlist(wordlist)
undata

undata2 <- Filter(function(x) {nchar(x) >= 2}, undata)
word_table <- table(undata2)
word_table

final <- sort(word_table2, decreasing = T)

words <- head(final, 10)
names(words)
df <- data.frame(words)
names(df) <- c("명칭", "횟수")
df

write.csv(df, "output/hotel_top_word.csv")
