picher <- read.csv("data/picher_stats_2017.csv", encoding = "UTF-8")
str(picher)

picher %>% rename("삼진"="삼진.9", "볼넷"="볼넷.9", "홈런"="홈런.9") %>% 
  select("선수명", "삼진", "홈런", "볼넷") -> 
  pichers_stats

max.score <- rep(25,3)
min.score <- rep(0,3)   

picher1 <- pichers_stats[20,]
ps <- rbind(max.score, min.score, picher1[,2:4])

radarchart(ps,                           # 데이터프레임
           pcol='red',                   # 다각형 선의 색 
           pfcol=rgb(0.2,0.5,0.5,0.5),   # 다각형 내부 색
           plwd=3,                       # 다각형 선의 두께
           cglcol='grey',                # 거미줄의 색
           cglty=1,                      # 거미줄의 타입
           cglwd=0.8,                    # 거미줄의 두께
           axistype=1,                   # 축의 레이블 타입
           seg=4,                        # 축의 눈금 분할                         
           axislabcol='grey',            # 축의 레이블 색
           caxislabels=seq(0,25,6),
           title = paste(picher1$선수명, "선수의 성적")
)
dev.copy(png, "output/lab19.png")
dev.off()
