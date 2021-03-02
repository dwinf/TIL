iotest2 <- scan('data/iotest2.txt', what='')
maxword <- which.max(summary(as.factor(iotest2)))
cat("가장 많이 등장한 단어는",names(maxword),"입니다.")


word2 <- c(summary(factor(iotest2)))
cat("가장 많이 등장한 단어는",names(which.max(word2)), "횟수는 ", max(word2),"입니다.")
