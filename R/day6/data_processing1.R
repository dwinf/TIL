v <- sample(1:26, 10)
alp <- function(v){
  words <- LETTERS[v]
  return(words)
}
result <- sapply(v, alp)
result
