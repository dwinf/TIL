test1 <- function() {
  print("test1호출")
}
test1()

r1 <- test1()
r1

test2 <- function() {
  print("test2호출")
  return()
}
test2()

r2 <- test2()
r2


paste0(c("R"), 1:10)
paste0(c("A", "B"), 1:10)

makeVector <- function(type, ...) {
  return(switch(EXPR=type, paste0("A", c(...)), 
                           paste0("B", c(...)), 
                           paste0("C", c(...)), 
                           paste0("D", c(...))))
}

makeVector(prefix=1,1,2,3,4,5)
makeVector(2,100,200,300)
makeVector(3,10,20,30,40,50,60,70,80,90)
makeVector(4,111,222,333,444,555)

v <- c(10,11,20,22,30,33)
evenodd1 <- function(p) if(p %% 2 == 0) return("even") else return("odd")
sapply(v, evenodd1)
lapply(v, evenodd1)

evenodd2 <- function(p) {
        if(p %% 2 == 0) 
          r <- "even" 
        else 
          r <- "odd"
        return("odd")
}
sapply(v, evenodd2)
lapply(v, evenodd2)

# R에도 전역 변수와 지역 변수가 있당

a<-3;b<-7;c<-11 
ft<-function(a){
  b<-a+10     
  c<<-a+10   # 전역대입연산 
  d<-a
  print(a);print(b);print(c);print(d)
  return()  # NULL
}
print(ft(100))
print(a);print(b);print(c);print(d) 

#return() 함수와 invisible() 함수 

ft.1 <- function(x) return()
ft.2 <- function(x) return(x+10)
ft.3 <- function(x) invisible(x+10)

ft.1(100)
ft.2(100)
ft.3(100)

r1 <- ft.1(1000);r1
r2 <- ft.2(1000);r2
r3 <- ft.3(1000);r3

# sleep() 함수

testSleep <- function(second) {
  for(data in LETTERS[1:5]) {
    cat(data)
    Sys.sleep(second)
  }
}

testSleep(1)
testSleep(0)
testSleep(3)

# 매개변수에 전달된 데이터의 타입 채크
testParamType <- function(x){
  if(is.vector(x)) print("벡터를 전달했군요!")
  if(is.data.frame(x)) print("데이터프레임을 전달했군요!")
  if(is.list(x)) print("리스트를 전달했군요!")
  if(is.matrix(x)) print("매트릭스를 전달했군요!")
  if(is.array(x)) print("배열을 전달했군요!")
  if(is.function(x)) print("함수를 전달했군요!")
}

#dataframe이 list에, list는 vector에 포함 됨 
#list는 원소 1개 짜리 1차원 배열과 같다.
testParamType(100)
testParamType(LETTERS)
testParamType(data.frame())
testParamType(matrix())
testParamType(list())
testParamType(array())
testParamType(mean)

#testParamType1
testParamType1 <- function(x){
  result <- NULL
  if(is.vector(x)  && !is.list(x)) result <-"벡터를 전달했군요!"
  else if(is.data.frame(x)) result <- "데이터프레임을 전달했군요!"
  else if(is.list(x)) result <- "리스트를 전달했군요!"
  else if(is.matrix(x)) result <- "매트릭스를 전달했군요!"
  else if(is.array(x)) result <- "배열을 전달했군요!"
  else if(is.function(x)) result <- "함수를 전달했군요!"
  return(result)
}

#dataframe이 list에, list는 vector에 포함 됨 
#list는 원소 1개 짜리 1차원 배열과 같다.....

testParamType1(100)
testParamType1(LETTERS)
testParamType1(data.frame())
testParamType1(matrix())
testParamType1(list())
testParamType1(array())
testParamType1(function(){})


#testParamType2
testParamType2 <- function(x){
  result <- NULL
  if(is.vector(x)  && !is.list(x) && is.numeric(x)) {
    result <- sum(x)
  } else {
    stop("숫자 백터만을 원하오!!")
  }
  return(result)
}

testParamType2(1:3)
testParamType2(list(1,2,3))
testParamType2(LETTERS)

#stop() 함수도 알고 가자
testError1 <- function(x){
  if(x<=0)
    stop("양의 값만 전달 하숑!! 더 이상 수행 안할거임..")
  return(rep("테스트",x))
}

testError1(5)
testError1(0)



#warning() 함수
testWarn <- function(x){
  if(x<=0)
    stop("양의 값만 전달 하숑!! 더 이상 수행 안할거임..")
  if(x>5){
    x<-5
    warning("5보다 크면 안됨!! 하여 5로 처리했삼...!!")
  }
  return(rep("테스트",x))
}


testWarn(3)
testWarn(10)

test1 <-function(p){
  cat("난 수행함\n")
  testError1(-1)
  cat("나 수행할 까요? \n")
}
test1()

#try() 함수를 알아야 데이터 수집을 편하게 할 수 있다.
test2 <- function(p){
  cat("난 수행함\n")
  try(testError(-1))
  cat("나 수행할 까요? \n")
}
test2()

testAll <-function(p){
  tryCatch({
    if(p=="오류테스트"){
      testError1(-1)
    }else if (p =="경고테스트"){
      testWarn(6)
    }else{
      cat("정상 수행..\n")
      print(testError1(2))
      print(testWarn(3))
    }
  },warning = function(w){
    print(w)
    cat("-.-;;\n")
  },error = function(e){
    print(e)
    cat("ㅠㅠ \n")
  },finally ={
    cat("오류, 경고 발생 여부에 관계없이 반드시 수행되는 부분입니다요..\n")
  })
}

testAll("오류테스트")
testAll("경고테스트")
testAll("아무거나")


f.case1 <- function(x) {
  if(is.na(x)) 
    return("NA가 있슈")
  else
    return("NA가 없슈")
}
f.case1(100)
f.case1(NA)
f.case1(1:6)
f.case1(c(10,20,30))
f.case1(c(NA, 20))
f.case1(c(10, NA, 20))

f.case2 <- function(x) {
  if(any(is.na(x))) 
    return("NA가 있슈")
  else
    return("NA가 없슈")
}
f.case2(100)
f.case2(NA)
f.case2(1:6)
f.case2(c(10,20,30))
f.case2(c(NA, 20))
f.case2(c(10, NA, 20))

f.case3 <- function(x) {
  if(all(is.na(x))) 
    return("모두 NA임")
  else
    return("모두 NA인 것은 아님")
}
f.case3(100)
f.case3(LETTERS)
f.case3(NA)
f.case3(c(NA, NA, NA))
f.case3(c(NA, NA, 10))


#Sys.sleep(초시간) 함수
testSleep <- function(x) {
  for(data in 6:10) {       
    cat(data,"\n")
    if(x)
      Sys.sleep(1)
  }
  return()
}
testSleep(FALSE)
testSleep(TRUE)

# 가변형 인자 테스트
funcArgs1 <- function(...) {
  p <- c(...)
  data <- c(10,15,3,5,17,25)
  for(opt in p) {
    switch(EXPR=opt,
           SUM=, Sum=, sum= print(sum(data)),
           MEAN=, Mean=, mean= print(mean(data)),
           DIFF=, Diff=, diff= print(max(data) - min(data)),
           MAX=, Max=, max= print(max(data)),
           MIN=, Min=, min= print(min(data)),
           SORT=, Sort=, sort= print(sort(data))
    )
  }
}

funcArgs1()
funcArgs1("SUM", "mean", "Min")
funcArgs1("SORT", "Sort", "sort")





# 가변형 인자 테스트
funcArgs2 <- function(...) {
  p <- c(...)
  data <- c(10,15,3,5,17,25)
  if(is.null(p))
    print(data)
  else 
    for(opt in p) {
      switch(EXPR=opt,
             SUM=, Sum=, sum= print(sum(data)),
             MEAN=, Mean=, mean= print(mean(data)),
             DIFF=, Diff=, diff= print(max(data) - min(data)),
             MAX=, Max=, max= print(max(data)),
             MIN=, Min=, min= print(min(data)),
             SORT=, Sort=, sort= print(sort(data))
      )
    }
}

funcArgs2()
funcArgs2("SUM", "mean", "Min")
funcArgs2("SORT", "Sort", "sort")
