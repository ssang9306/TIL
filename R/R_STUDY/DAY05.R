# ... -> 가변인자
# 인자 들어올 개수를 한정하지 않음
new.user.func <- function(x, y){
  cat('x = ', x,'\n')
  cat('y = ', y ,'\n')
  result <- x + y
  return (result)
  }
# return을 명시하지 않으면 함수의 마지막이
# 반환된다. 

new.user.func <- function(...){
  # 가변인자는 list로 처리할 수 있다.
  args <- list(...)
  for(idx in args){
    print(idx)
  }
}

new.user.func(1,2,3)

iris.df <- iris

iris.df[4:10 , 3] <- NA
iris.df[1:5 , 4] <- NA
iris.df[60:70 , 5] <- NA
iris.df[97:103 , 5] <- NA
iris.df[133:138 , 5] <- NA
iris.df[140 , 3] <- NA

summary(iris.df)

# 결측치 비율을 계산하는 함수를 정의
# 행 및 열별로 비율을 계산


na.miss.func <- function(df){
  sum(is.na(df)) / length(df) * 100
}

(row.miss.per <- apply(iris.df, 1, na.miss.func))
(col.miss.per <- apply(iris.df, 2, na.miss.func))

barplot(col.miss.per)

# 조작함수
# cbind(), rbind(), merge() == join()

tmp.df01 <- data.frame(name = c('xiang','min','xi'),
                       math = c(100, 80, 60))


tmp.df02 <- data.frame(name = c('xi','xiang','min'),
                       eng = c(100, 70, 30))


tmp.df01
tmp.df02

cbind(tmp.df01,tmp.df02)
merge(tmp.df01,tmp.df02)

# mapply ->  sapply와 비슷 함
# apply (data , 방향, 함수)
# mapply : 다수의 인자를 함수에 넘겨줄 때

mapply( function(i, s){
    sprintf('%d , %s' , i , s)
} , 1: 3, c('a','b','c'))

apply(iris[,-5],2, mean)
mapply(mean, iris[,-5])

# doBy packages
# summaryBy, orderBy, splitBy, sampleBy
install.packages('doBy')
library(doBy)

summary(iris)

# 수치형 자료의 분포를 확인하는 함수
# quantile() 
quantile(iris$Sepal.Length)
quantile(iris$Sepal.Length, seq(0,1,by = 0.1))

?summaryBy
# 원하는 컬럼의 값을 특정 조건에 따라 요약
summaryBy(. ~Species, iris)

?orderBy
orderBy(~Species + Sepal.Length, iris)

# base package 

iris[order(iris$Sepal.Length),]

# 무작위 추출 sample()

sample(1:10, 5) # 비복원 추출
sample(1:10, 5, replace = T) # 복원 추출

sample(NROW(iris), NROW(iris)) # index shuffle
iris[sample(NROW(iris), NROW(iris)),]

# 그룹에서 일정 비율 추출 
# 층화추출?
# 각 Species 별 10%씩 iris에서 가져온다.
library(doBy)
test.sample <- sampleBy(~ Species, frac = 0.1, data = iris)
test.sample

# split
class( split(iris, iris$Species))
class( split(iris$Sepal.Length, iris$Species))
class( lapply( split(iris$Sepal.Length, iris$Species), mean) )

iris.vect <- unlist(lapply( split(iris$Sepal.Length, iris$Species), mean))
iris.vect

iris.mat <- matrix(iris.vect, ncol = 3, byrow = T)
iris.mat

iris.frm <- data.frame(iris.mat)
iris.frm

names(iris.frm) <- c('s_mean','color_mean','nica_mean')
iris.frm

iris.setosa.df <- subset(iris, Species == 'setosa')
iris.setosa.df

iris.setosa.df <- subset(iris, Species == 'setosa' & Sepal.Length > 5.0 , select = c(1,3,5))
iris.setosa.df

# order(), sort(), which(), which.max(), which.min()

(x <- c(20,11,33,50,47))
sort(x, decreasing = T)
x[order(x)]
order(iris$Sepal.Length)
head(iris[ order(iris$Sepal.Length, iris$Petal.Length),])

(x <- c(2,4,6,7,10))

# return idx
which(x %% 2 == 0)
which.min(x)
which.max(x)

x[which.min(x)]
