memo_new <- readLines('data/memo.txt', encoding = 'UTF-8')
memo_new[[1]] <- gsub("[[:punct:]]", "", memo_new[[1]])
memo_new[[2]] <- toupper(memo_new[[2]])
memo_new[[3]] <- gsub('[12]', "", memo_new[[3]])
memo_new[[4]] <- gsub("[a-zA-Z]", "", memo_new[[4]])
memo_new[[5]] <- gsub("[[:punct:][:digit:]]", "", memo_new[[5]])
memo_new[[6]] <- gsub("[[:blank:]]", "", memo_new[[6]])
memo_new[[7]] <- tolower(memo_new[[7]])
write.table(memo_new, file="data/memo_new.txt", 
            sep = "", row.names = FALSE, col.names = FALSE, quote = FALSE)
            
            
          