####################################################################################################
# Clear all Variables and Clear console
rm(list = ls())
cat("\014")
####################################################################################################
# R reshape를 활용한 데이터 마트 개발
library(reshape)
data(airquality)
head(airquality)
head(airquality, 10)
names(airquality)
names(airquality) <- tolower(names(airquality))

# id에 있는 변수를 기준으로 하여 나머지 변수들을 variable/value 형태의 데이터로 만든다.
aqm <- melt(airquality, id=c("month","day"), na.rm=TRUE)
head(aqm, 10)

nrow(airquality)
nrow(aqm)

# cast를 사용하여 자료를 변환
# cast(data, y축 ~ x축 ~ z축)
a <- cast(aqm, day ~ month ~ variable)
a # y축은 month, x축은 variable로 지정하여 월별, 일별 variable의 값을 보여준다.

b <- cast(aqm, month ~ variable, mean)
b # y축은 month, x축은 variable로 지정하여 월별 평균값을 보여준다.

c <- cast(aqm, month ~ .| variable, mean)
c # b와 동일한 결과를 나타내지만 산출물을 분리해 표시해준다.

d <- cast(aqm, month ~variable, mean, margins=c("grand_row", "grand_col"))
d # margin 옵션을 사용하여, 행과 열에 대한 소계를 산출할 수 있다.

e <- cast(aqm, day ~ month, mean, subset=variable=="ozone")
e # 특정 변수만 처리하고자 하는 경우 subset 옵션을 이용하여 특정 변수만 처리를 할 수 있다.

f <- cast(aqm, month ~ variable, range)
f # _X1은 min값, _X2는 max값을 의미한다.
####################################################################################################
# sqldf를 이용한 데이터 분석
library(sqldf)
data(iris)
sqldf("select * from iris")
sqldf("select * from iris limit 10")
sqldf("select count(*) from iris where Species like 'se%'")
####################################################################################################
# plyr
set.seed(1) # 난수 발생시 시드값
runif(9,0,20) # runif(생성할 난수의 개수, 최소값, 최대값)
d <- data.frame(year=rep(2012:2014, each=6),count=round(runif(9,0,20)))
d

library(plyr)
ddply(d, "year", function(x){
  mean.count = mean(x$count)
  sd.count = sd(x$count)
  cv = sd.count/mean.count
  data.frame(cv.count=cv)
})

ddply(d, "year", summarise, mean.count=mean(count))
ddply(d, "year", transform, total.count=sum(count))
####################################################################################################
# 데이터 테이블
library(data.table)
rnorm(100) # rnorm(n)은 정규분포에서 n개의 난수를 생성해 준다.
DT <- data.table(x=c("b","b","b","a","a"),v=rnorm(5))
DT

data(cars)
head(cars)
CARS <- data.table(cars)
head(CARS)

tables()
sapply(CARS,class)
DT
DT[2,] # 2번째행 조회
DT[DT$x=="b",]
setkey(DT,x)
DT
tables()

DT["b",]
DT["b",mult="first"]
DT["b",mult="last"]

# data.frame 성능 테스트
grpsize <- ceiling(1e7/26^2)
tt <- system.time(DF <- data.frame(
  x=rep(LETTERS, each=26*grpsize),
  y=rep(letters, each=grpsize),
  v=runif(grpsize*26^2),
  stringAsFactors=FALSE
))

DF[grpsize+1,]
DF[grpsize*26+1,]

tt

head(DF,3)
tail(DF,3)
dim(DF)
tt <- system.time(ans1 <-DF[DF$x=="R" & DF$y=="h",]) # system.time()을 사용하여 시간 측정
tt

head(ans1,3)
dim(ans1)

DT <- data.table(DF)
setkey(DT,x,y)
ss <- system.time(ans2 <- DT[J("R","h")])
ss
head(ans2, 3)
dim(ans2)
identical(ans1$v, ans2$v)

system.time(ans2 <-DT[DT$x=="R" & DT$y=="h",])
mapply(identical, ans1, ans2)

head(DT, 3)
DT[,sum(v)]
DT[,sum(v), by=x]
ttt <- system.time(tt<-tapply(DT$v, DT$x, sum));ttt
sss <- system.time(ss<-DT[,sum(v),by=x]);sss

head(tt)
head(ss)
identical(as.vector(tt),ss$V1)

sss <- system.time(ss <- DT[,sum(v), by="x,y"]);sss;ss
####################################################################################################