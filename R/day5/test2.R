iotest2 <- scan('data/iotest2.txt', what='')
maxword <- which.max(summary(as.factor(iotest2)))
cat("가장 많이 등장한 단어는",names(maxword),"입니다.")

