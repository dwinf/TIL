iotest1 <- scan('data/iotest1.txt')
cat("오름차순 :",sort(iotest1))
cat("내림차순 :", sort(iotest1, decreasing = T))
#rev(sort(iotest1))
cat("합 :", sum(iotest1))
cat("평균 :", mean(iotest1))

