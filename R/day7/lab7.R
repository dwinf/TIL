url <- "http://unico2013.dothome.co.kr/crawling/exercise_bs.html"
text <- read_html(url)

# <h1> 태그의 컨텐츠
nodes <- html_nodes(text, 'h1')
html_text(nodes);


# <a> 태그의 href 속성값
anodes <- html_nodes(text, 'a')
html_attr(anodes, 'href')


# <img> 태그의 src 속성값
imgnodes <- html_nodes(text, 'img')
html_attr(imgnodes, 'src')


# 첫 번째 <h2> 태그의 컨텐츠
firsth2 <- html_nodes(text, "h2:nth-of-type(1)")
html_text(firsth2)


# <ul> 태그의 자식 태그들 중 style 속성 의 값이 green으로 끝나는 태그의 컨텐츠
ulist <- html_nodes(text, 'ul')
html_text(html_nodes(ulist, '[style$=green]'))

ulist <- html_nodes(text, 'ul > [style$=green]')
ulist <- html_nodes(text, 'ul > li[style$=green]')
html_text(ulist)


# 두 번째 <h2> 태그의 컨텐츠
secondh2 <- html_nodes(text, "h2:nth-of-type(2)")
html_text(secondh2)


# <ol> 태그의 모든 자식 태그들의 컨텐츠
olist <- html_nodes(text, 'ol *')
html_text(olist)


# <table> 태그의 모든 자손 태그들의 컨텐츠
tables <- html_nodes(text, 'table *')
html_text(tables)


# name이라는 클래스 속성을 갖는 <tr> 태그의 컨텐츠
tables <- html_nodes(text, 'table .name')
html_text(tables)


# target이라는 아이디 속성을 갖는 <td> 태그의 컨텐츠
td <- html_nodes(text, 'td#target')
html_text(td)



