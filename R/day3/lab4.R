# 문제1
L1 <- list(name="scott", sal=3000)
result1 <- L1[[2]] * 2
result1 <- L1[['sal']] * 2
L1$sal * 2 -> result1


# 문제 2
L2 <- list("scott", c(100,200,300)) # seq(100, 300, by=100)
L2


# 문제 3
L3 <- list(c(3,5,7), c('A', 'B', 'C'))
L3
L3[[2]][1] <- "Alpha"
L3


# 문제 4
L4 <- list(alpha=0:4, beta=sqrt(1:5), gamma=log(1:5))
L4[['alpha']] + 10
L4[[1]] + 10
L4$alpha + 10


# 문제 5
emp <- read.csv('data/emp.csv')
L5 <- list(data1=LETTERS, data2=head(emp, n=3), data3=L4)
#L5 <- list(data1=LETTERS, data2=emp[1:3,], data3=:4)
L5
L5[[1]][1]
L5[[2]]$ename
L5[3]$data3$gamma
#L5[[3]][3] # 벡터가 아닌 리스트로 꺼내짐
L5[3]$data3[[3]]


# 문제 6
L6 <- list(math=list(95, 90), writing=list(90, 85), reading=list(85, 80))
L6
mean(unlist(L6)) # 모든 리스트를 벡터로

avg<-0
for(i in 1:3){
  for(j in 1:2){
    print(unlist(L6[[i]])[j])
    avg <- avg + unlist(L6[[i]])[j]
  }
  print(avg)
}


# 문제 7
grade <- sample(1:6, 1)
if(grade < 4){
  print(paste(grade, "학년은 저학년입니다."))
} else{
  print(paste(grade, "학년은 고학년입니다."))
}
if(grade == 1 | grade == 2 | grade == 3){
  cat(grade, "학년은 저학년입니다.", '\n')
} else{
  cat(grade, "학년은 고학년입니다.", '\n')
}

#switch
grade <- as.character(sample(1:6, 1))
stu <- switch(EXPR = grade, 
              '1'=, '2'=, '3'=cat(grade, "학년은 저학년입니다."),
              '4'=, '5'=, '6'=cat(grade, '학년은 고학년입니다.'))


# 문제 8
# 8-1
choice <- sample(1:5, 1)

# 8-2
choice <- ifelse(choice == 1, choice+50,
                 ifelse(choice == 2, choice-50,
                        ifelse(choice == 3, choice*50,
                               ifelse(choice == 4, choice/50, choice%%50))))

msg <- switch (choice, choice+50, choice-50,choice*50,choice/50, choice%%50)
cat('결과값 :', msg)

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

if(deco==1){
  cat(rep('*',count), sep='', "\n")
}else if(deco==2){
  cat(rep('$',count), sep='', "\n")
}else{
  cat(rep('#', count), sep='', "\n")
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
paste(LETTERS, letters, sep='')
paste0(LETTERS, letters)

for(i in 1:length(LETTERS)){
  for(j in 1:length(letters)){
    if(i==j){
      print(paste(LETTERS[i],letters[j]))
    }
  }
}














