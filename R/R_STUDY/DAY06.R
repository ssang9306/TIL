# data handling
# plyr pacakge, dplyr package
# filter() : 지정한 조건식에 맞는 데이터를 추출
# select() : 열의 추출
# mutate() : 열 추가
# arrange() : 정렬

install.packages('hflights')
library('plyr')
library('dplyr')
library('hflights')

# 휴스턴에서 출발하는 모든 비행기의 이착륙 기록(2011)
str(hflights)
head(hflights)

flight.df <- hflights

# tbl_df -> 테이블 형태로 변환
flight.tbl <- as_tibble(flight.df)
flight.tbl

# filter() 조건에 맞는 행 추출
# 1월 1일 데이터만 추출
?filter

filter(flight.tbl, Month == 1, DayofMonth == 1)
filter(flight.df , Month == 1, DayofMonth == 1)

# 1월 또는 2월 정보만 추출
filter(flight.tbl, Month == 1 | Month == 2)

# 열의 기준 기본 오름차순, 내림차순 desc()
arrange(flight.tbl, Month)
arrange(flight.tbl, desc(Month))

# 특정 열을 추출
select(flight.tbl, c(Year, Month, DayofMonth))
select(flight.tbl, -c(Year, Month, DayofMonth))

select(flight.tbl, (Year:DayofMonth))
select(flight.tbl, -(Year:DayofMonth)) # not vector, c (x)

# 열 추가 - 파생변수
# mutate
?mutate
mutate(flight.tbl, 
       gain <- ArrDelay - DepDelay,
       gain.per.hour <- gain/(AirTime/60))
# 특정 컬럼을 대상으로 파생변수 추가 가능
# 생선된 변수를 바로 계산식으로 활용 가능

# transform
# 새로운 변수를 바로 사용하지 못한다(mutate와의 차이)
transform(flight.tbl, 
       gain <- ArrDelay - DepDelay,
       gain.per.hour <- gain/(AirTime/60))


# summarise() -> return data frame -> input data frame
# 출발 지연시간 평균 및 합계
sum(is.na(flight.df$DepDelay))

summarise(flight.df,
          delay.avg = mean(DepDelay, na.rm = T),
          delay.sum = sum(DepDelay, na.rm = T))

str(flight.df)

# dplyr - 그룹별 집계 group_by
# TailNum : 항공기 일련번호
planes.df <- group_by(flight.df, TailNum)
str(planes.df)

# 항공기별 요약 통계량 : 평균비행거리, 평균도착지연시간
tmp.df <- summarise(planes.df,
                    count = n(), # count 함수 사용법법
                   dis = mean(Distance, na.rm = T),
                   delay = mean(ArrDelay, na.rm = T) )
tmp.df

# 편수가 20 이상이고 거리가 2000 이상인 데이터 추출
delay <- filter(tmp.df, count >= 20 , dis >= 2000)
str(delay)

# chain() 함수
# %>% 조작을 연결해서 한 번에 수행하는 함수
head(flight.df)

# step 1. group_by
# Year, Month, DayofMonth 의 수준별 그룹화
str(flight.df[, c('Year','Month','DayofMonth')])
ex1.df <- group_by(flight.df, Year, Month, DayofMonth)
ex1.df
# Step 2. select
# 그룹화 된 데이터로 Year 부터 
# DayofMonth, ArrDelay, DepDelay 열 선택
ex2.df <- select(ex1.df, Year:DayofMonth, ArrDelay, DepDelay)
ex2.df
# Step 3. summarise
# 평균 연착 시간과 평균 출발 지연시간을 구한다.
ex3.df <- summarise(ex2.df, 
                    arr = mean(ArrDelay, na.rm = T),
                    dep = mean(DepDelay , na.rm = T))
ex3.df
# Step 4. filter
# 평균 연착 시간과 평균 지연 시간 30분 이상 데이터
ex4.df <- filter(ex3.df, arr>30 | dep > 30)
ex4.df

# Use Chain Func
flight.df %>%
  group_by( Year, Month, DayofMonth) %>%
    select( Year:DayofMonth, ArrDelay, DepDelay) %>%
      summarise(arr = mean(ArrDelay, na.rm = T),
                dep = mean(DepDelay , na.rm = T)) %>%
        filter( arr>30 | dep > 30)
# 특정 함수가 다른 패키지 함수와 충돌된다면
# package::fucntion
flight.df %>%
  group_by( Year, Month, DayofMonth) %>%
  dplyr::select( Year:DayofMonth, ArrDelay, DepDelay) %>%
  dplyr::summarise(arr = mean(ArrDelay, na.rm = T),
            dep = mean(DepDelay , na.rm = T)) %>%
  filter( arr>30 | dep > 30)

# adply() -> input : array |  dataframe | list
# 데이터 분할(split) -> return vector
# 분할된 데이터에 함수를 적용(apply)
# 결과를 조합(combine)하는 함수
# return -> array | dataframe | list
# ** apply : margine- 행 1, 열 2 

apply(iris[, 1:4], 2, mean) 
apply(iris[1:5 ,1:4], 1, function(row){
  print(row)
} )

# Sepal.Length 가 5.0 이상, 
# Species가 setosa인 것들만 가져와서
# Sepal.5.setosa 새로운 열 추가

ex1.df <- iris %>% filter(Sepal.Length >= 5.0 & Species == 'setosa') %>%
         mutate(sepal.5.setosa = 'selected')

split(iris, iris$Species) # return list
ex1.df <- split(iris, iris$Species)$setosa
apply(ex1.df, 2, fucntion(x){
  x >= 5.0
})
ex1.df$Sepal.5.setosa <- 

adply(iris,
    1,
    function(row){
      data.frame(sepal.5.setosa = c(row$Sepal.Length >=5.0 &
                                      row$Species == 'setosa'))
    })

library(MASS)

# package::plyr 
# 병합함수:  join() key값을 기준으로 두개의 프레임 병합 
# inner join, left join, right join, full join

tmp.x.df <- data.frame(
  id = c(1,2,3,4,6),
  height = c(190, 183, 175, 158, 166)
)
tmp.y.df <- data.frame(
  id = c(5,4,3,2,1),
  weight = c(90, 75, 66, 50, 70)
)

(inner.df <- join(tmp.x.df, tmp.y.df, by = 'id', type = 'inner'))
(left.df <- join(tmp.x.df, tmp.y.df, by = 'id', type = 'left'))
(right.df <- join(tmp.x.df, tmp.y.df, by = 'id', type = 'right'))
(full.df <- join(tmp.x.df, tmp.y.df, by = 'id', type = 'full'))

# Cars93 데이터를 이용한 실습
library(MASS)
Cars93
str(Cars93)
head(Cars93)

# 컬럼 이름 확인
names(Cars93)

# distinct 중복없이 유일한 값을 리턴
Cars93$Origin

?distinct
dplyr::distinct(Cars93,Origin)
dplyr::distinct(Cars93, Type, Origin)
# 문) Cars93 데이터 프레임에서 '차종(Type)'과 '생산국-미국여부(Origin)' 변수를 기준으로 
#     중복없는 유일한 값을 추출하시오.
ex.df <- Cars93
dplyr::distinct(ex.df, Type, Origin)

# 문) Cars93 데이터 프레임(1~5번째 변수만 사용)에서 10개의 관측치를 무작위로 추출하시오.
ex.df[sample(nrow(ex.df),10), 1:5]
dplyr::sample_n(Cars93[, 1:5], 10)

# 문) Cars93 데이터 프레임(1~5번째 변수만 사용)에서 
# 10%의 관측치를 무작위로 추출하시오.

ex.df[sample(nrow(ex.df),0.1 * nrow(ex.df)), 1:5]
dplyr::sample_frac(Cars93[,1:5], 0.1)

# 문) Cars93 데이터 프레임(1~5번까지 변수만 사용)에서 
# 20개의 관측치를 무작위 복원추출 하시오.
ex.df[sample(nrow(ex.df),20, replace = T ), 1:5]
dplyr::sample_n(Cars93[, 1:5], 20, replace = T)

# 문) Cars93 데이터 프레임에서 
# '제조국가_미국여부(Origin)'의 'USA', 'non-USA' 요인 속성별로 
# 각 10개씩의 표본을 무작위 비복원 추출하시오.
ex.df[,c('Model','Origin')] %>%  group_by(Origin) %>%  sample_n(10)


# 문) Cars93 데이터프레임에서 
# 최소가격(Min.Price)과 최대가격(Max.Price)의 범위(range), 
# 최소가격 대비 최대가격의 비율(=Max.Price/Min.Price) 의 
# 새로운 변수를 생성하시오.
new.df <- Cars93[c(1:10), c('Model','Min.Price','Max.Price')]
new.df <- mutate(new.df,
                 Range.Price = Max.Price - Min.Price,
                 Ratio.Price = Min.Price / Max.Price)
new.df
mutate(ex.df,
       range = Max.Price - Min.Price,
       ratio =  Max.Price / Min.Price)

# 문) Cars93 데이터 프레임에서 
# 가격(Price)의 (a) 평균, (b) 중앙값, (c) 표준편차, (d) 최소값, 
# (e) 최대값 합계를 구하시오. 
# (단, 결측값은 포함하지 않고 계산함)
summarise(ex.df,
          mean.price = mean(Price, na.rm = T),
          median.price = median(Price, na.rm = T),
          std.price = sd(Price, na.rm = T),
          var.price = var(Price,na.rm = T),
          iqr.price = IQR(Price, na.rm = T))

# 문) Cars93_1 데이터 프레임에서 
# (a) 총 관측치의 개수, 
# (b) 제조사(Manufacturer)의 개수(유일한 값), 
# (c) 첫번째 관측치의 제조사 이름, 
# (d) 마지막 관측치의 제조사 이름, 
# (e) 5번째 관측치의 제조사 이름은?
nrow(ex.df)
dplyr::distinct(ex.df, Manufacturer)
ex.df[1,c('Manufacturer')]
ex.df[nrow(ex.df),c('Manufacturer')]
ex.df[5 ,c('Manufacturer')]

new.df <- Cars93[c(1:10), c('Model','Type','Manufacturer')]
summarise(new.df,
          total = n() ,# count -> n
          distinct_cnt = n_distinct(Manufacturer),
          first.obs = first(Manufacturer),
          last.obs = last(Manufacturer),
          nth.obs = nth(Manufacturer, 5)
          )

# 문) Cars93 데이터 프레임에서 
# '차종(Type)' 별로 구분해서 
# (a) 전체 관측치 개수, 
# (b) (중복 없이 센) 제조사 개수, 
# (c) 가격(Price)의 평균과 (d) 가격의 표준편차를 구하시오. 
# (단, 결측값은 포함하지 않고 계산함)

ex.df.group <- ex.df %>% group_by(Type) 
nrow(ex.df.group)
distinct(ex.df.group, Manufacturer)
summarise(ex.df.group,
          mean.price = mean(Price, na.rm = T),
          std.price = sd(Price, na.rm = T))

summarise(ex.df.group,
          total = n(),
          distinct_cnt = n_distinct(Manufacturer),
          price.mean = mean(Price, na.rm = T),
          price.sd = sd(Price, na.rm = T))

# ddply() in plyr package
# split data frame (grouping)
# apply function
# return data frame

?ddply
ddply(iris,
      .(Species),
      function(sub) {
        data.frame(sepal.width.mean = mean(sub$Sepal.Length) )
      })


ddply(iris,
      .(Species, Sepal.Length > 5.0 ), # Sepal.Length값 을 기준으로 그룹핑
      function(sub) {
        data.frame(sepal.width.mean = mean(sub$Sepal.Length) )
      })

baseball
str(baseball)

# id가 "ansonca01"인 선수의 기록 확인
baseball[baseball$id == "ansonca01",]
filter(baseball, id == "ansonca01")
subset(baseball, id == "ansonca01")

# ddply() 이용해서 각 선수가 출전한 게임수의 평균을 구하면
names(baseball)
ddply(baseball,
      .(id, g > 100),
      function(sub){  # input dataframe,
        data.frame(g.mean = mean(sub$g))
      }
      )

# 각 선수별 최대 게임을 플레이한 해의 기록을 구한다면?
names(baseball)
ddply(baseball,
      .(id),
      subset,
      g == max(g)
      )

# ddply의 인자로 함수, 함수에 적용되는 조건 입력  
ddply(baseball,
      .(id),
      summarise ,
      minyear = min(year),
      maxyear = max(year))

# reshape
# 프레임의 구조를 변경할 때 사용하는 함수
# melt, cast

library(reshape2)
View(french_fries)
str(french_fries)
head(french_fries)

# melt  
# id : time~ repe = 1:4
# id를 기준으로 나머지 변수는 variable, value로 묶인다
# 4 ~ 의 변수들에대해 각 측정치를 제공
# id, 측정대상 변수, 측정치 값

(french_fries.melt <- melt(id = 1:4, french_fries))
head(french_fries.melt)
tail(french_fries.melt)
View(french_fries.melt)
sum(is.na(french_fries.melt))

(french_fries.melt <- melt(id = 1:4, french_fries, na.rm = T))
sum(is.na(french_fries.melt))

# complete.cases() : 해당 행의 모든 값이 NA가 아닌경우 TRUE 반환 
# EDA 에서는 is.na보다는 complete.cases() 사용
french_fries[complete.cases(french_fries) , ]
french_fries[!complete.cases(french_fries) , ]

# cast() : 원상 복구
# 복구하고자 하는 타입에 따라서 dcast(frame), acast(vector | matrix | array) 사용 
?dcast
french_fries.dcast <- dcast(french_fries.melt, 
                            time + treatment + subject + rep ~ ... )
class(french_fries.dcast)

french_fries.acast <- acast(french_fries.melt, 
                            time + treatment + subject + rep ~ ... )
class(french_fries.acast)

# example
getwd()
setwd('c:/users/xiang/TIL/R/R_STUDY')
tmp.data <- read.csv('service_data_reshape.csv')
str(tmp.data)
head(tmp.data)

unique(tmp.data$Customer_ID)
length(unique(tmp.data$Customer_ID))

(tmp.data.melt <- melt(id = 1:2, tmp.data))
(tmp.data.dcast <- dcast(tmp.data.melt , 
                        Date + Customer_ID ~ ...))

wide <- dcast(tmp.data, Customer_ID ~ Date, sum)
wide
long <- melt(wide, id = 'Customer_ID')
long

# 테이블 형식 data.table -> head5, tail5를 보여줌
install.packages("data.table")
library(data.table)
(iris.table <- data.table(iris))
class(iris.table)

iris.table[1,]
iris.table[iris.table$Species == 'setosa']
