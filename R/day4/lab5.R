# 문제1
exam1 <- function(){return(paste0(LETTERS,letters))}
exam1()


# 문제2
exam2 <- function(num){return(sum(1:num))}
exam2(10);exam2(5)


# 문제3
exam3 <- function(num1, num2){
  if(num1<=num2){
    result <- num2-num1
  }else
    result <- num1-num2
  return(result)
  
}
exam3(2,15);exam3(20,10);exam3(10,10)


# 문제4
exam4 <- function(num1, op, num2){
  if(op != '+' & op != '-'& op != '*' & op != '%/%' & op != '%%'){
    return(print("규격의 연산자만 전달하세요"))
  }else if(op == '+'){
    result <- num1 + num2
  }else if(op == '-'){
    result <- num1 - num2
  }else if(op == '*'){
    result <- num1 * num2
  }else if(op == '%/%'){
    if(num1 == 0){return("오류1")}
    if(num2 == 0){return("오류2")}
    result <- num1%/%num2
  }else if(op == '%%'){
    if(num1 == 0){return("오류1")}
    if(num2 == 0){return("오류2")}
    result <- num1%%num2
  }
  return(result)
}
exam4(20,'+',9);exam4(20,'-',9);exam4(20,'*',9);exam4(20,'%/%',9);exam4(20,'%%',9)
exam4(10,'/',20);exam4(0,'%/%',9);exam4(3,'%%',0)


# 문제5
exam5 <- function(num, word='#'){
  if(num<0){
    return(NULL)
  }
  cat(rep(word, num), sep = '')
}
exam5(10)
exam5(-1)
exam5(5, '$')

# 문제5-1
exam5 <- function(a, b='#'){
  if(a<=0){
    cat('')
  }else{
    for(i in 1:a){
      cat(b)
    }
  }
}



# 문제6
exam6 <- function(...){
  data <- c(...)
  for(i in data){
    if(is.na(i)){
      print("NA는 처리불가")
    }else if(i>=85){
      print(paste0(i,"점은 상등급입니다."))
    }else if(i>=70){
      print(paste0(i,"점은 중등급입니다."))
    }else{
      print(paste0(i,"점은 하등급입니다."))
    }
  }
}
# 문제6-1
exam6 <- function(score){
  for (i in 1:length(score)) {
    if(is.na(score[i])){
      print("NA는 처리불가")
    }else if(score[i]>=85){
      print(paste0(score[i],"점은 상등급입니다."))
    }else if(score[i]>=70){
      print(paste0(score[i],"점은 중등급입니다."))
    }else{
      print(paste0(score[i],"점은 하등급입니다."))
    }
  }
}

exam6(c(80, 50, 70, 66, NA, 35))

