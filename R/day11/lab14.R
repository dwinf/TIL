library(tm)
library(proxy)

duke <- "사과 포도 망고"
dooly <- "포도 자몽 자두"
ddochi <- "복숭아 사과 포도"
douner <- "오렌지 바나나 복숭아"
gildong <- "포도 바나나 망고"
heedong <- "포도 귤 오렌지"

fruits <- c(duke, dooly, ddochi, douner, gildong, heedong)

cps <- VCorpus(VectorSource(fruits)) # Corpus를 사용하면 한글깨짐 발생
dtm <- DocumentTermMatrix(cps, 
                          control=list(wordLengths = c(1, Inf)))

as.matrix(dtm)
inspect(dtm)
m <- as.matrix(dtm)
com <- m %*% t(m)
com

# (1) 좋아하는 과일이 가장 유사한 친구들을 찾아본다.
dist(com, method = "cosine")
dist(com, method = "Euclidean")
# duke & ddochi / duke & gildong

#(2) 학생들에게 가장 많이 선택된 과일을 찾아본다.
as.matrix(dtm)
sort(colSums(as.matrix(dtm)))
names(which.max(colSums(as.matrix(dtm))))

#(3) 학생들에게 가장 적게 선택된 과일을 찾아본다.
which.min(colSums(as.matrix(dtm)))
names(which(colSums(as.matrix(dtm))==which.min(colSums(as.matrix(dtm)))))
