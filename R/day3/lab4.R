# 문제1
L1 <- list(name="scott", sal=3000)
result1 <- L1[[2]] * 2
result1 <- L1[['sal']] * 2
result1 <- L1$sal * 2


# 문제 2
L2 <- list("scott", c(100,200,300))
L2


# 문제 3
L3 <- list(c(3,5,7), c('A', 'B', 'C'))
L3
L3[[2]][1] <- "Alpha"
L3


# 문제 4
L4 <- list(alpha=0:4, beta=sqrt(1:5), gamma=log(1:5))
L4
L4[[1]] <- L4$alpha + 10
L4


# 문제 5
emp <- read.csv('data/emp.csv')
L5 <- list(data1=LETTERS, data2=head(emp, n=3), data3=L4)
L5
L5[[1]][1]
L5[[2]]$ename
L5[3]$data3$gamma


# 문제 6
L6 <- list(math=list(95, 90), writing=list(90, 85), reading=list(85, 80))
L6
mean(unlist(L6))


# 문제 7
grade <- sample(1:6, 1)
if(grade < 4){
  print(paste(grade, "학년은 저학년입니다."))
  
} else{
  print(paste(grade, "학년은 고학년입니다."))
}
#switch
grade <- as.character(grade)
stu <- switch(EXPR = grade, 
              '1'=, '2'=, '3'='저학년',
              '4'=, '5'=, '6'='고학년')
print(paste(grade,'학년은 ',stu,'입니다.', sep=''))


# 문제 8
# 8-1
choice <- sample(1:5, 1)

# 8-2
choice <- ifelse(choice == 1, choice+50,
                 ifelse(choice == 2, choice-50,
                        ifelse(choice == 3, choice*50,
                               ifelse(choice == 4, choice/50, choice%%50))))

#8-3
cat('결과값 :', choice)


# 문제 9
# 9-1
count <- sample(3:10, 1)

# 9-2
deco <- sample(1:3, 1)

# 9-3
for (i in 1:count) {
  if(deco==1)
    cat('*')
  else if(deco==2)
    cat('$')
  else
    cat('#')
}


# 문제 10
# 10-1
score <- sample(0:100, 1)

# 10-2
if(score>=90){
  type=1
}else if (score>=80){
  type=2
}else if (score>=70){
  type=3
}else if (score>=60){
  type=4
}else {
  type=5
  }
level <- switch(type,"A 등급","B 등급","C 등급","D 등급","F 등급")

level <- switch(as.character(score%/%10),
                '10' = ,'9' = 'A 등급', '8' = 'B 등급', 
                '7' = 'C 등급', '6' = 'D 등급', 'F 등급')
# 10-3
print(paste(score, "점은 ", level, "입니다.", sep=""))


# 문제 11
paste(big, small, sep='')

for(i in 1:length(LETTERS)){
  for(j in 1:length(letters)){
    if(i==j){
      print(paste(LETTERS[i],letters[j]))
    }
  }
}














