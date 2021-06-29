# install.packages('해당패키지')
# library(해당패키지)

# 디버깅 print(), paste(), sprintf(), cat()
# ?print

?letters
letters
month.abb
month.name

# 다른 행으로 출력되는 print()
print('hi')
print(' h i')

# formating : sprintf -> %d, %s, %f
sprintf("%d",10)
sprintf("%s : %f",'pi',3.141592)

# paste
paste('a','b','c',sep = '')
paste('a','b','c',sep = ' - ')

?cat
cat(c(1,3,5))
iter <- stats::rpois(1, lambda = 10)
## print an informative message
cat("iteration = ", iter <- iter + 1, "\n")

# make function
myFunc <- function() {
  total <- 0
  cat('append')
  for(i in 1:10){
    total <- total + i
    cat(i,'...')
  }
  cat('end!','\n')
  return (total)
}
myFunc()

# 변수 : 데이터를 담을 수 있는 그릇
# 변수명 (알파벳,숫자,_) & 첫글자는 문자 또는 . 
# 단일형 변수 : vector, matrix, array
# 복수형 변수(다양한 형) : list, dataframe

# vector
# c()

samplevec <- c(1,2,3,4,"5",TRUE)
samplevec

# naming
# sample_vec : snake 방식
# sampleVec : camel 방식

x <- c(0,1,4,9,16)

avg <- sum(x) / length(x)

x <- 1:10
y <- x^2

# 변수의 데이터형 확인 : typeof(), mode()
typeof(x)

# 논리형 벡터
ex_vec <- c(TRUE, FALSE, TRUE, FALSE)
typeof(ex_vec)
mode(ex_vec)

str_vec <- c('이상민','xiang')

# str()변수 타입, 속성 확인
str(str_vec)

sample_na_vec <- c(NA, NULL)
print(sample_na_vec)
is.na(sample_na_vec)

over_vec <- c(1,2,3, c(1,2,3))
over_vec
typeof(over_vec)
str(over_vec)
mode(over_vec)
class(over_vec)

# 수치형 벡터 데이터를 만들때
# start:end 형태로 생성 가능
x <- 1:10
x

# 반복된 값의 벡터를 만든다면
rep(1:5, 5)
rep(1:5, each = 3)

# seq(start, end , step)
seq(1,10,2)
seq(1,10, length.out = 3)

ex_seq_vec <-seq(1,100,by = 3)
ex_seq_vec

length(ex_seq_vec)

ex_seq_vec[2]
ex_seq_vec[length(ex_seq_vec)-4]

# 조건식을 이용한 인덱싱
ex_seq_vec[ex_seq_vec >= 10 & ex_seq_vec <= 30]

# ex_seq_vec의 홀수 번째 값 추출
ex_seq_odd <- ex_seq_vec[seq(1,length(ex_seq_vec),2)]
str(ex_seq_odd)                         

# 벡터의 각 셀에 이름부여
x <- c(1,3,5)
col <- c('x1','x2','x3')
names(x) <- col
x

# 컬럼이름으로 데이터 조회
x[c('x1','x3')]

# names()의 인덱싱을 통해 셀의 이름을 반환
names(x)[1]
names(x)

# 음수 값 인덱싱
# 해당 인덱스를 제외
x[-1]
x[c(-1,-3)]

# 길이 length(), nrow(), NROW()
length(x)
nrow(x) # matrix의 행 수를 반환
NROW(x) # 하나의 행인 행렬에 대해 각 열을 행으로 취급

# 벡터의 연산이 가능 %in%
# 어떤 값이 벡터에 포함됐는지를 알려주는 연산자
a_vec <- 'f' %in% c('a','b','c')
a_vec

# setdiff() union() intersect() setequal()
setdiff( c('a','b','c'),c('a','b'))
union( c('a','b','c'),c('a','b'))
intersect( c('a','b','c'),c('a','b'))
setequal( c('a','b','c'),c('a','b'))
setequal( c('a','b','c'),c('a','b','c'))
# 100에서 200으로 구성된 벡터 samplevec를 생성한 다음
# 각 문제를 수행하는 코드를 작성

x <- c(100:200)
x
# Q1) idx =10 값 출력
x[10]
# 1-1 슬라이싱싱
head(x,10)
x[1:10]
# Q2) 끝에서 10개의 값을 잘라내어 출력
x[(length(x)-10):length(x)]
tail(x,10)

# Q3) 홀수만 출력
x[x%%2 == 1]

# Q4) 3의 배수만 출력 ( %% 나머지 연산자)
x[x%%3 == 0]

# Q5) 앞에서 20개의 값을 잘라내어 변수 d.20에 저장하고 d.20 값을 출력
d.20 <- x[1:20]  #head(x,20)
d.20

# Q6) d.20의 5번째 값을 제외한 나머지 값들 출력
d.20[-5]

# Q7) d.20의 5, 7, 9 번째 값을 제외한 나머지 값들 출력
d.20[c(-5,-7,-9)]

# month.name 활용
?month.name
absent <- c(10,14,3,2,5,7,9,10,20,6,12,4)
length(absent)
names(absent) <- month.name
absent

# 5월(MAY)의 결석생 수를 출력하시오.
absent['May']

# 7월(JUL), 9월(SEP)의 결석생 수를 출력하시오.
absent['July'] + absent['September']
sum(absent[c('July','September')])

# 상반기(1~6월)의 결석생 수의 합계를 출력하시오.
sum(absent[1:6])
sum(head(absent))
# 하반기(7~12월)의 결석생 수의 평균을 출력하시오.
sum(absent[7:12])
sum(tail(absent))
absent[7:12]

# 논리형 벡터 (T,F)
# &(and) |(or) !(not) xor
c(T,F,T, TRUE,FALSE)
c(T,F,T) | c(TRUE)
c(T,F,T) & c(TRUE)
!c(T,F,T)
xor(c(T,F,T),c(TRUE))

?runif
x <- runif(3)
x
any(x > 0.7) # 하나라도 만족하는 값이 있으면 T
all(x < 0.7) # 모든 값이 만족해야 TRUE

# 문자형 벡터
c('a','b','c','d','e')

# 문자형 벡터는 기본적으로 아스키코드를 기반으로 순서가 있다
'a' > 'b'
strvec <- c('H','S','T','N','O')
strvec[3] < strvec[5]

# 문자열을 합쳐주는 paste 함수
?paste
paste('May I','help u?')

?month.abb
month.abb
paste(month.abb, 1:12)
paste(month.abb, 1:12, c('st','nd','rd',rep('th',9)))

paste('/user','local','bin',sep = '/')

# [정규표현식(regular expression)]

# *  0 or more.
# +  1 or more.
# ?  0 or 1.
# .  무엇이든 한 글자를 의미
# ^  시작 문자 지정 
# ex) ^[abc] abc중 한 단어 포함한 것으로 시작
# [^] 해당 문자를 제외한 모든 것 ex) [^abc] a,b,c 는 빼고
# $  끝 문자 지정
# [a-z] 알파벳 소문자 중 1개
# [A-Z] 알파벳 대문자 중 1개
# [0-9] 모든 숫자 중 1개
# [a-zA-Z] 모든 알파벳 중 1개
# [가-힣] 모든 한글 중 1개
# [^가-힣] 모든 한글을 제외한 모든 것
# [:punct:] 구두점 문자, ! " # $ % & ’ ( ) * + , - . / : ; < = > ? @ [ ] ^ _ ` { | } ~.
# [:alpha:] 알파벳 대소문자, 동등한 표현 [A-z]
# [:lower:] 영문 소문자, 동등한 표현 [a-z]
# [:upper:] 영문 대문자, 동등한 표현 [A-Z].
# [:digit:] 숫자, 0,1,2,3,4,5,6,7,8,9,
# [:xdigit:] 16진수  [0-9A-Fa-f]
# [:alnum:] 알파벳 숫자 문자, 동등한 표현[A-z0-9].
# [:cntrl:] \n, \r 같은 제어문자, 동등한 표현[\x00-\x1F\x7F].
# [:graph:] 그래픽 (사람이 읽을 수 있는) 문자, 동등한 표현
# [:print:] 출력가능한 문자, 동등한 표현
# [:space:] 공백 문자: 탭, 개행문자, 수직탭, 공백, 복귀문자, 서식이송
# [:blank:] 간격 문자, 즉 스페이스와 탭.

# 비정형데이터를 정제할때, 특수 문자와 제거해야 할 문자를
# 정규 표현식을 이용해서 작업한다.

# grep -> pattern에 맞는 것을 x-data로부터 추출
# main option : ignore.case , value
?grep

strvec <- c('gender','height','age','weight','eight')

# ei로 시작하는 데이터 추출
grep('^ei', strvec) # index를 추출
grep('^ei', strvec, value = T) # value 추출

grep('^EI',strvec, value= T) # 대문자 구분, return x
grep('^EI',strvec,ignore.case = T, value= T) # 대소문자 포함

# ei를 포함하는 문자열 추출
grep('ei', strvec,value = T)
grep('+ei+',strvec,value = T) # 문자가 1 or more -> like 

grepl('+ei+',strvec)
# grepl -> return boolean
txtVec <- c('BigDdata','Bigdata','bigdata','Data','dataMining','class1','class2')
txtVec

# 시작문자를 지정 ^
# 문자노출 회수(자리수) + * 
# 소문자 b로 시작하는 데이터를 추출
grep('^b+',txtVec,value = T)
grep('^b+',txtVec,value = T, ignore.case = T)

# 문자열을 바꾸는 gsub
# big 이 포함된 문자열을 찾아 big -> bigger로 바꾼다.
gsub('+big+','bigger',txtVec,ignore.case = T)
gsub('+big','bigger',txtVec)

# 숫자를 제거하고 싶다면?
gsub('[0-9]','', txtVec)
gsub('[[:digit:]]','', txtVec) # same

sub('[0-9]','', txtVec)
sub('[[:digit:]]','', txtVec) # same
