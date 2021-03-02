# 문제1
countEvenOdd <- function(num){
  if(is.vector(num) && !is.list(num)){
    if(is.numeric(num)){
      evencount <- 0
      oddcount <- 0
      for (i in num) {
        if(i%%2==0)
          evencount <- evencount + 1
        else
          oddcount <- oddcount + 1
      }
      result <- list(even=evencount, odd=oddcount)
    }else result <- NULL
  }
  return(result)
}
countEvenOdd(c(1,2,3,4,5))
countEvenOdd(c('abc', 12, 124))
countEvenOdd(c(1,4,3))


#문제1-1
countEvenOdd <- function(vt){
  if(!is.numeric(vt) || !is.vector(vt)) return()
  else {
    total <- length(vt)
    even <- 0
    for (i in 1:total) {
      if(vt[i]%%2==0){
        even <- even+1
        #odd <- total-even
      }
    }
    odd <- total-even
    result <- list(even = even, odd=odd)
    return(result)
  }
}


# 문제2
vmSum <- function(numv){
  if(is.vector(numv) && !is.list(numv))
    if(!is.numeric(numv)){
      print("숫자 벡터를 전달하세요")
      result <- 0
    }
    else
      result <- sum(numv)
  else
    result <- "벡터만 전달하세요"
  return(result)
}
vmSum(c(1,2,3))
vmSum(c(12, "abc", 21))
vmSum(function(){})
vmSum(c('가', '1'))
vmSum(data.frame(1,2,3))



# 문제2-1
vmSum <- function(vt){
  if(!is.vector(vt) || is.list(vt)){
    result <- "벡터만 전달하세요"
    return(result)
  }
  else if(!is.numeric(vt)){
    print("숫자 벡터를 전달하세요")
    return(0)
  }
  else
    return(sum(vt))
}
vmSum(c(1,2,3))
vmSum(c(12, "abc", 21))
vmSum(function(){})
vmSum(c('가', '1'))
vmSum(data.frame(1,2,3))



# 문제3
vmSum2 <- function(...){
  numv <- c(...)
  if(is.vector(numv) && !is.list(numv))
    if(!is.numeric(numv)){
      warning("숫자 벡터를 전달하세요") 
      result <- 0
    }
  else
    result <- sum(numv)
  else
    stop("벡터만 전달하세요")
  return(result)
}
vmSum2(1,2,3)
vmSum2(12, "abc", 21)
vmSum2(function(){})


# 문제3-1
vmSum2 <- function(numv){
  if(!is.vector(numv) || is.list(numv))
    stop("벡터만 전달하세요")
  else if(!is.numeric(numv)){
      warning("숫자 벡터를 전달하세요") 
      result <- 0
    }
  else
    result <- sum(numv)
  return(result)
}
vmSum2(c(1,2,3))
vmSum2(c(12, "abc", 21))
vmSum2(function(){})
vmSum2(c('가', '1'))
vmSum2(data.frame(1,2,3))



# 문제4
mySum <- function(numv){
  odd <- 0
  even <- 0
  if(any(is.null(numv))){
    return()
  }
  if(!(is.vector(numv) && !is.list(numv)))
    stop("벡터만 처리 가능합니다")
  if(any(is.na(numv))){
    warning("NA값은 최저값으로 변경하여 처리합니다")
    numv[is.na(numv)] <- min(numv[!is.na(numv)])
    #numv[is.na(numv)] <- min(numv, na.rm=T)
  }
  for (i in numv) {
    if(i%%2 == 0)
      even <- even + i
    else
      odd <- odd + i
  }
    result <- list(oddSum = odd,
                   evenSum = even)
  return(result)
}
mySum(list(1,2,3))
mySum(c(12, 11, 21, 100))
mySum(c(22, NA, 11, 1, 4))
mySum(NULL)



# 문제5
myExpr <- function(x){
  if(!is.function(x))
    stop("수행하지 않습니다.")
  else
    #nums <- sample(1:45, 6)
    return(x(sample(1:45, 6)))
}
myExpr(sum)
myExpr(base::sum) # sum이라는 변수를 만들었다면
myExpr(mean)
myExpr(max)
myExpr(min)



# 문제6
createVector1 <- function(...){
  v <- c(...)
  if(is.null(v))
    result <- NULL
  else if(any(is.na(v)))
    result <- NA
  else
    result <- v
  return(result)
}
createVector1(1,2,3,4,'avc')
createVector1()
createVector1('dsds', NA)
createVector1(1,2,3,4,T)
createVector1(1,2,3,4,T, "a")



# 문제7
createVector2 <- function(...){
  v <- list(...)
  nums <- NULL;chars<-NULL; logs<-NULL
  if(is.null(c(...)))
    result <- NULL
  else{
    for(data in v){
      if(is.numeric(data)) nums <- paste(nums, data)
      else if(is.character(data)) chars <- paste(chars, data)
      else if(is.logical(data)) logs <- paste(logs, data)
      result <- list(num=nums, char=chars, log=logs)
    }
  }
  return(result)
}
createVector2()
createVector2(1,2,3,4,5,'abc', T, F, T, '가나다')
createVector2(1,2,3)

