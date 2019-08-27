####################################################################################################
# Clear all Variables and Clear console
rm(list = ls())
cat("\014")
####################################################################################################
# 벡터(Vector)
x <- c(1, 10, 24, 40)
y <- c("사과", "바나나", "오렌지")
z <- c(TRUE, FALSE, TRUE)

xy <- c(x, y)

# 행렬(Matrix)
mx <- matrix(c(1,2,3,4,5,6), ncol=2)
mx

r1 <- c(10, 10)
c1 <- c(20, 20, 20)

rbind(mx, r1)
cbind(mx, c1)

# 데이터 프레임(Data Frame)
income <- c(100, 200, 150, 300, 900)
car <- c("kia", "hyundai", "kia", "toyota", "lexus")
marriage <- c(FALSE, FALSE, FALSE, TRUE, TRUE)

mydat <- data.frame(income, car, marriage)
mydat
####################################################################################################
# 외부 데이터 불러오기
setwd(paste(getwd(),"/R-studio-workspace/ADSP",sep=""))
getwd()

# .csv 파일 불러오기
data1 <- read.table(paste(getwd(), "/Data/Iris_Data.csv", sep=""), header=TRUE, sep=",")
data1 <- read.csv(paste(getwd(), "/Data/Iris_Data.csv", sep=""), header=TRUE)
head(data1)
str(data1)

# .txt 파일 불러오기
data2 <- read.table(paste(getwd(), "/Data/BRCA_prognosis.txt", sep=""), header=T, sep="\t")
head(data2)
str(data2)
####################################################################################################
# 수열 생성하기
rep(1, 3) # 첫 번째 인수를 두 번째 인수만큼 반복하는 숫자 벡터를 생성한다.

seq(1, 3) # 첫 번째 인수를 두 번째 인수까지 1씩 증가하는 숫자 벡터를 생성한다.
1:3 # seq(1, 3)
seq(1, 11, by=2) # by=n 옵션을 추가하여 1씩 증가하는 수열이 아닌 n씩 증가하는 수열을 생성한다.
seq(1, 11, length=6) # length=m 옵션을 추가하여 전체 수열의 개수가 m개가 되도록 자동적으로 증가하는 수열을 생성한다.
seq(1, 11, length=8)

rep(2:5, 3) # rep 함수에 연속 증가하는 seq 함수의 형태를 인수로 사용하여 반복되는 수열을 생성한다.
rep(c("하나", "둘", "셋"), 3)

# 기초적인 수치 계산
a <- 1:10

a
a+a
a-a
a*a
a/a

a <- c(2,7,3)
t(a)
A <- a%*%t(a)
A

mx <- matrix(c(23,41,12,35,67,1,24,7,53), nrow=3)

mx
5*mx
solve(mx)

a <- 1:10
a

mean(a) # 평균
var(a) # 분산
sd(a) # 표준편차
sum(a) # 합
median(a) # 중앙값
log(a) # 자연로그값

b <- log(a)
cov(a, b) # 공분산
cor(a, b) # 상관계수

summary(a)
####################################################################################################
# R 데이터 핸들링
# 벡터형 변수
b <- c("a", "b", "c", "d", "e")
b
b[2]
b[-4]
b[c(2,3)]

# 행렬/데이터 프레임 형태의 변수
income <- c(100, 200, 150, 300, 900)
car <- c("kia", "hyundai", "kia", "toyota", "lexus")
marriage <- c(FALSE, FALSE, FALSE, TRUE, TRUE)
mydat <- data.frame(income, car, marriage)
mydat
mydat[3,2]
mydat[,2]
mydat[4,]
####################################################################################################
# 반복 구문과 조건문
# for 반복 구문
a <- c()
for(i in 1:9){
  a[i] = i*i
}

isum=0
for(i in 1:100){
  isum = isum + i
}
cat("1부터 100까지의 합은", isum, "입니다.", "\n")

# while 반복 구문
x=1
while(x<5){
  x=x+1
  print(x)
}

# if~ else 조건문
StatScore = c(88,90,78,84,76,68,50,48,33,70,48,66,88,96,79,65,27,88,96,33,
              64,48,77,18,26,44,48,68,77,64,88,95,79,88,49,30,29,10,49,88)
over70 = rep(0,40)
for(i in 1:40){
  if(StatScore[i]>=70) over70[i]=1
  else over70[i]=0
}
over70
sum(over70)
####################################################################################################
# 사용자 정의 함수
addto = function(a){
  isum = 0
  for(i in 1:a){
    isum=isum+i
  }
  print(isum)
}
addto(100)
addto(50)
####################################################################################################
# 기타 유용한 기능들
# paste
number=1:10
alphabet=c("a", "b", "c")
paste(number, alphabet)
paste(number, alphabet, sep=" to the ")

# substr
substr("BigDataAnalysis", 8, 11)

# 자료형 데이터 구조 변환
as.integer(3.14) # 실수 데이터를 정수 데이터로 강제 형변환
as.numeric("foo") # 문자를 수치형 데이터로 강제 형변환
as.character(101) # 정수 데이터를 문자 데이터로 강제 형변환
as.numeric(FALSE) # 논리값을 수치형으로 강제 형변환
as.logical(0.45) # 수치값을 논리값으로 강제 형변환(0일 경우에만 FALSE)

mydat
as.matrix(mydat) # 데이터 프레임을 행렬로 강제 형변환; 모든 데이터가 문자형 데이터로 변환

# 문자열을 날짜로 변환
as.Date("2019-08-24") # yyyy-mm-dd
as.Date("08/24/2019", format="%m/%d/%Y") # 날짜 표현 서식이 다를 경우 형식을 지정해야 함

# 날짜를 문자열로 변환
as.Date("08/24/2019", format="%m/%d/%Y")
format(Sys.Date())
as.character(Sys.Date())
format(Sys.Date(), format="%m/%d/%Y")

format(Sys.Date(), '%a') # '%a'는 요일을 출력한다.
format(Sys.Date(), '%b') # '%b'는 월을 출력한다. =
format(Sys.Date(), '%m') # '%m'은 두자리 숫자로 월을 출력한다.
format(Sys.Date(), '%d') # '%d'는 두자리 숫자로 일을 출력한다.
format(Sys.Date(), '%y') # '%y'는 두자리 숫자로 연도를 출력한다.
format(Sys.Date(), '%Y') # '%Y'는 네자리 숫자로 된 연도를 출력한다.
####################################################################################################
# Scatter plot
height = c(170,168,174,175,188,165,165,190,173,168,159,170,184,155,165)
weight = c(68,65,74,77,92,63,67,95,72,69,60,69,73,56,55)
plot(height,weight)

# Scatter plot matrix
#install.packages("extrafont")
library(extrafont)
font_import()

pairs(iris[1:4], main = "대진이의 붓꽃 데이터(이제 내꺼임)", pch=21, bg=c("red","green3","blue")[unclass(iris$Species)])
#par(family="AppleGothic")

# Histogram and Boxplot
hist(StatScore, prob=T)
boxplot(StatScore, main="대진이의 박스플롯")
####################################################################################################