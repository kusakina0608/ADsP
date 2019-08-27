####################################################################################################
# Clear all Variables and Clear console
rm(list = ls())
cat("\014")
####################################################################################################
# 데이터 탐색
data(iris)
head(iris)
head(iris, 10)
str(iris)
summary(iris)
cov(iris[,1:4])
cor(iris[,1:4])
####################################################################################################
# 결측값 처리
y <- c(1,2,3,NA)
is.na(y)
sum(is.na(y))

# 특정 값을 결측값으로 입력
mydata[mydata$v1==99,"v1"] <-NA # 행선택: 조건식 이용/열선택: 열 이름 명시("v1")

# 결측값 문제 해결 방안 1-1. 결측값 제외시키기
x <- c(1,2,NA,3)
mean(x)
mean(x, na.rm=T)

# 결측값 문제 해결 방안 1-2. complete.cases() 함수 사용
colSums(is.na(mydata))
mydata[!complete.cases(mydata),]

# Amelia를 사용한 결측값 처리
library(Amelia)

# 데이터 불러오기
data(freetrade)

# 데이터 살펴보기
head(freetrade)
str(freetrade)
is.na(freetrade)
colSums(is.na(freetrade))
rowSums(is.na(freetrade))

# 결측값 처리 방식 - Ignore the tuple
freetrade[complete.cases(freetrade),]

# 결측값 처리 방식 - Inputation
a.out <- amelia(freetrade, m=5, ts = "year", cs = "country")
hist(a.out$imputations[[3]]$tariff, col="grey", border="white")
save(a.out, file="imputations.RData")
write.amelia(obj=a.out, file.stem="outdata")

missmap(a.out)
freetrade$tariff <-a.out$imputations[[5]]$tariff
missmap(freetrade)

####################################################################################################
# 이상값 검색
x <- rnorm(100)
boxplot(x)

x <- c(x, 19, 28, 30)
outwith=boxplot(x)
outwith$out

# outliers 패키지를 사용한 이상값 검색
library(outliers)
set.seed(1234)

y=rnorm(100)
outlier(y)
outlier(y, opposite=T)

dim(y) = c(20,5)
outlier(y)
outlier(y, opposite=T)
boxplot(y)
####################################################################################################