url <- 'https://comic.naver.com/genre/bestChallenge.nhn?&page='
navercomic <- NULL
for(i in 1:20){
  naver <- read_html(paste0(url, i))
  comicName <- html_text(html_nodes(naver, 'div.weekchallengeBox div.challengeInfo a:nth-child(1)'), trim=T)
  comicName
  
  comicSummeary <- html_text(html_nodes(naver, 'div.weekchallengeBox div.challengeInfo div.summary'))
  comicSummeary
  
  comicGrade <- html_text(html_nodes(naver, 'div.weekchallengeBox div.challengeInfo div.rating_type strong'))
  comicGrade
  
  comic <- data.frame(comicName, comicSummeary, comicGrade)
  navercomic <- rbind(navercomic, comic)
}

write.csv(navercomic, 'output/navercomic.csv')
#content > div:nth-child(5) > table > tbody > tr:nth-child(1) > td:nth-child(1) > div.challengeInfo > div.summary


url <- 'https://comic.naver.com/genre/bestChallenge.nhn?&page=1'
naver <- read_html(url)
html_text(html_nodes(naver, xpath='//*[@id="content"]/div[4]//div[2]/h6/a/text()'), trim=T) # table 관련 경로 삭제하면 가능
html_text(html_nodes(naver, '#content > div.weekchallengeBox div.challengeInfo div.summary')) 
# > 는 태그의 자식을 의미하기 때문에 자식의 자식을 접근할 때는 없어야 된다.


