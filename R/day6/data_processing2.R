# 1 [[]]를 사용했지만 []를 사용해도 된다.
memo_new <- readLines('data/memo.txt', encoding = 'UTF-8')
memo_new[1] <- gsub("[[:punct:]]", "", memo_new[1])
memo_new[2] <- toupper(memo_new[2])
memo_new[3] <- gsub('[12]', "", memo_new[3])
memo_new[4] <- gsub("[a-zA-Z]", "", memo_new[4])
memo_new[5] <- gsub("[[:punct:][:digit:]]", "", memo_new[5])
memo_new[6] <- gsub("[[:blank:]]", "", memo_new[6])
memo_new[7] <- tolower(memo_new[7])
memo_new[7] <- gsub()
memo_new
write.table(memo_new, file="data/memo_new.txt", 
            sep = "", row.names = FALSE, col.names = FALSE, quote = FALSE)
            
            
# 2
memo <- readLines('data/memo.txt', encoding = 'UTF-8')
gsub("[&$!@%#]", "", memo[1]) -> L1

gsub('e', 'E', memo[2])

gsub("[[:digit:]]", "", memo[3])

gsub("[A-z]", "", memo[4])

gsub("[0-9|<>]", "", memo[5])

gsub("[[:space:]]", "", memo[6])

gsub(".   ", ". ", memo[7])


# 3
gsub("[[:punct:]]", "", memo[1])

gsub('e', 'E', memo[2])

gsub("[[:digit:]]", "", memo[3])

gsub("[a-z]", "", memo[4])
gsub("[A-Z]", "", memo[4])

gsub("[[:punct:][:digit:]]", "", memo[5])

gsub("[[:space:]]", "", memo[6])

# gsub("[A-Z]", "[a-z]", memo[7])
# gsub([정규표현식], [일반문자열], 문자열)



