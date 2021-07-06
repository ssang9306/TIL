# 외부 파일 & 데이터 가공 & 시각화
# 외부 파일 : csv, xls, txt

library(readxl)
getwd()
setwd('c:/users/xiang/TIL/R/R_STUDY')

# read_excel() - xl
# option : header, skip, nrows, sep
?file.choose
tmp.xl <- read_excel(file.choose())
class(tmp.xl)
View(tmp.xl)

tmp.xl.df <- as.data.frame(tmp.xl)
class(tmp.xl.df)

#read.table() - txt
# option : header, skip, nrows, sep
tmp.txt <- read.table('./data/service_data_tap_ex.txt', header = T
                      , nrows = 7 , sep= '\t')
class(tmp.txt)

# 데이터 로드 및 열 이름 부여
tmp2.txt <- read.table(file.choose(), sep = ','
                       ,col.names = c('ID','SEX','AGE','AREA'))
tmp2.txt

write.csv(tmp.txt, file = 'c:/users/xiang/TIL/R/R_STUDY/data/save_data.csv')
write.table(tmp.txt, file = 'c:/users/xiang/TIL/R/R_STUDY/data/save_data.txt')

ex.data <- read_excel(file.choose())
ex.data
str(ex.data)

ex.data$SEX <- as.factor(ex.data$SEX)
ex.data$AREA <- as.factor(ex.data$AREA)
ex.data.frm <- as.data.frame(ex.data)
class(ex.data.frm)

levels(ex.data.frm$SEX)
levels(ex.data.frm$AREA)
nlevels(ex.data.frm$AREA)

# chain, split
library(dplyr)
# 성별에 따른 AMT17 평균 이용 금액
ex.data.frm %>% group_by(SEX) %>%
  summarise(AMT17.mean = mean(AMT17))

sapply(split(ex.data.frm$AMT17, ex.data.frm$SEX),
       mean,
       na.rm = T)

# 지역에 따른 Y17_CNT 이용 건수의 합
ex.data.frm %>% group_by(AREA) %>%
  summarise(Y17.ALL = sum(Y17_CNT))

sapply(split(ex.data.frm$Y17_CNT, ex.data.frm$AREA),
       sum)

dim( ex.data.frm )

# rename()
# AMT17 -> Y17_AMT, AMT16 -> Y16_AMT
?rename
# rename(data, new_name = old_name)
# return data frame
ex.data.frm <- rename(ex.data.frm, Y17_AMT = AMT17, Y16_AMT = AMT16)
ex.data.frm

# 파생변수 추가
# AMT 합, CMT 합합
ex.data.frm <- mutate(ex.data.frm,
                      amt.sum = Y17_AMT + Y16_AMT,
                      cnt.sum = Y17_CNT + Y16_CNT)
# mutate - transform
# mutate는 계산된 결과를 메서드 내에서 바로 사용가능
# transform은 불가능
ex.data.frm.der
# 기본 문법
# ex.data.frm$AMT.sum <- ex.data.frm$Y16_AMT + ex.data.frm$Y17_AMT

# AGE50_YN 추가 나이가 50 이상 Y, 미만 N
(ex.data.frm <- ex.data.frm %>% 
  mutate(AGE50_YN = ifelse(AGE >50, 'Y','N')))

# 추가, chain은 dataframe을 반환, $는 벡터반환
class(ex.data.frm$ID)
class(ex.data.frm %>% select(ID) )

ex.data.frm %>%
  select(ID, AREA, Y17_CNT ) %>%
  filter(AREA == '서울' & Y17_CNT >=10 ) %>%
  arrange(desc(Y17_CNT))

# 데이터 결합
# step1 load file
ex.data.m <- read_excel(file.choose())
ex.data.f <- read_excel(file.choose())

# 가로결합 (join) 
# join -> plyr package , inner_join ->dplyr
ex.data.j <- plyr::join(ex.data.m, ex.data.f, by = 'ID', type = 'full')
ex.data <- ex.data.j

# 1. colRename 데이터 세트에서 ID 변수만 추출
ex.data$ID

# 2. colRename 데이터 세트에서 ID, AREA, Y17_CNT 변수 추출
ex.data[,c('ID','AREA','Y17_CNT')]
select(ex.data, c('ID','AREA','Y17_CNT'))

# 3. colRename 데이터 세트에서 AREA 변수만 제외하고 추출
select(ex.data, -c('AREA'))

# 4. colRename 데이터 세트에서 AREA, Y17_CNT 변수를 제외하고 추출
select(ex.data, -c('AREA','Y17_CNT'))
ex.data[,!(names(ex.data) == 'AREA'|names(ex.data) == 'Y17_CNT')]

# 5. colRename 데이터 세트에 AREA(지역)가 서울인 경우만 추출
filter(ex.data, AREA =='서울')
ex.data[ex.data$AREA == '서울', ]

# 6. colRename 데이터 세트에서 AREA(지역)가 서울이면서 
#    Y17_CNT(17년 이용 건수)가 10건 이상인 경우만 추출 
ex.data %>% filter(AREA =='서울') %>%
  filter(Y17_CNT >= 10)

# 7. colRename 데이터 세트의 AGE 변수를 오름차순 정렬
?arrange
arrange(ex.data, AGE)

# 8. colRename 데이터 세트의 Y17_AMT 변수를 내림차순 정렬
arrange(ex.data, desc(AMT17))

# 정렬 중첩 
# 9. colRename 데이터 세트의 AGE 변수는 오름차순, Y17_AMT 변수는 내림차순 정렬
arrange(ex.data, AGE, desc(AMT17))

# 데이터 요약하기
# 10. colRename 데이터 세트의 Y17_AMT(17년 이용 금액) 변수 값 합계를
# TOT_Y17_AMT 변수로 도출
summarise(ex.data,
          TOT_Y17 = sum(AMT17))

# 11. colRename 데이터 세트의 AREA(지역) 변수 값별로 
# Y17_AMT(17년 이용 금액)를 더해 SUM_Y17_AMT 변수로 도출
?split
sapply(split(ex.data$AMT17, ex.data$AREA),
       sum)
ex.data %>%
  split(AMT17, AREA)%>%
  

# 12. colRename 데이터 세트의 AMT를 CNT로 나눈 값을 
# colRename 데이터 세트의 AVG_AMT로 생성
ex.data %>% mutate(
  AMT.sum = AMT17 + AMT16,
  CNT.sum = Y16_CNT + Y17_CNT,
  AVG_AMT = AMT.sum / CNT.sum
)

# 13. colRename 데이터 세트에서 AGE 변수 값이 50 이상이면 “Y”
# 50 미만이면 “N” 값으로 colRename 데이터 세트에 AGE50_YN 변수 생성 
mutate(ex.data , 
       AGE50_YN = ifelse(AGE >= 50, 'Y','N'))


# ::나이분류
# 14. colRename 데이터 세트의 
# AGE 값이 50 이상이면 “50++”, 
# 40 이상이면 “4049”
# 30 이상이면 “3039”, 
# 20 이상이면 "2029”, 
# 나머지는 “0019”를 값으로 하는 AGE_GR10 변수 생성
ex.data$AGE_GR10 <- ifelse(ex.data$AGE >= 50 , '50++',
                           ifelse(ex.data$AGE >= 40 , '4049',
                                  ifelse(ex.data$AGE >= 30 , '3039',
                                         ifelse(ex.data$AGE >= 20 , '2029','0019'))))
ex.data

# 이산형 데이터의 시각화

# descr::freq() = > 빈도 분석
# 특정 값이 얼마나 반복되는지

install.packages('descr')
library(descr)
?freq

freq(ex.data$AREA)

chart.data <- c(380,520, 330, 390, 320, 460, 300, 405)
names(chart.data) <- c('2020 1Q','2020 2Q', '2020 3Q','2020 4Q','2021 1Q','2021 2Q','2021 3Q','2021 4Q')

chart.data
range(chart.data)
max(chart.data)
min(chart.data)
length(chart.data)

?barplot
# bar chart 세로
barplot(chart.data,
        ylim = c(0,600),
        col = rainbow(8),
        main = '2020 vs 2021',
        )
# bar chart 가로
barplot(chart.data,
        xlim = c(0,600),
        col = rainbow(8),
        main = '2020 vs 2021',
        horiz = T,
        ylab = '년도별 현황',
        xlab = '매출 현황황')

# dotchart
?dotchart
dotchart(chart.data,
         col = c('sky blue','hot pink'),
         lcolor = 'black',# line color
         pch = 1:8, # 마커 모양
         xlab = '매출액',
         cex = 1 ,
         main = 'TITLE')# 마커 크기기 

# pie chart
?pie
pie(chart.data,
    border = 'BLUE', #테두리 색상
    col = rainbow(8),
    cex = 1.2 # 확대 축소
    )         

# iris
table(iris)
table(iris$Species)
pie(table(iris$Species))

ex.data
table(ex.data$SEX)

barplot(table(ex.data$SEX),
        names = c('남','여'),
        main = '성별',
        xlab = 'gender',
        ylab = 'count')

# 연속형 -> 변수가 연속된 구간을 가지고 있다
# == 비율변수, 등간변수
# boxplot, histogram, scatter, plot()
ex.data

# boxplot -> 이상치 탐지
?boxplot
boxplot(ex.data$Y17_CNT, ex.data$Y16_CNT,)

iris
hist(iris$Sepal.Length,
     xlab = '꽃받침 길이',
     ylim = c(0,40))

# 산점도 scatter => plot()
?plot
x <- runinf(5, min = 0 , max= 1)
y <- x^2
plot(x,y)
plot(x,y, type = 'l')
plot(x,y, type = 'o', pch= 25)
plot(x,y,type = 'h')
plot(x,y, type = 's')

# pairs
?pairs
pairs(iris[1:4])

# 3차원 산점도
library(scatterplot3d)

scatterplot3d(iris$Sepal.Length,
              iris$Petal.Length,
              iris$Sepal.Width,
              type = 'h',
              color = rainbow(150))

#시각화 알아보기
install.packages('mlbench')
library(mlbench)
data('Ozone')
str(Ozone)

?Ozone
# 수치형 데이터 산점도
# xlim 설정 전 range를 사용하여 범위 확인
range(Ozone$V8, na.rm = T)
range(Ozone$V9, na.rm = T)

plot(Ozone$V8, Ozone$V9,
     xlab = 'Sandburg Temp',
     ylab = 'EI Monte Temp',
     main = 'Region Temp',
     pch = '+',
     cex = .5,
     col = 'red',
     xlim = c(20,100),
     ylim = c(25, 85))

# boxplot with iris
summary(iris$Sepal.Length)
boxplot(iris$Sepal.Length)

# IQR(3 사분위수 - 1 사분위수 Inner Quantile Range)
summary(iris$Sepal.Width)
boxplot(iris$Sepal.Width)

# 이상치 탐지를 위한 whisker
# low   whisker : median - (1.5 * IQR) : 2.25
# hight whisker : meidan + (1.5 * IQR) : 3.75
median(iris$Sepal.Width) - (1.5 * IQR(iris$Sepal.Width))
median(iris$Sepal.Width) + (1.5 * IQR(iris$Sepal.Width))

boxplot(iris$Sepal.Width,
        horizontal = T)

# iris의 setosa 종과 versicolor 종의 sepal.width 상자그림

flower2 <- iris[iris$Species == 'setosa'|iris$Species == 'versicolor',]
levels(flower2$Species)
boxplot(Sepal.Width ~ Species, data = flower2)

library(ggplot2)
tmp <- mpg
tmp$manufacturer <- as.factor(tmp$manufacturer)
levels(tmp$manufacturer)
