# 1
v <- sample(1:26, 10)
alp <- function(v){
  words <- LETTERS[v]
  return(words)
}
sapply(v, alp)


# 2
vran <- function(v){return(LETTERS[v])}
sapply(v, vran)


# 3
sapply(v, function(d) LETTERS[d])
