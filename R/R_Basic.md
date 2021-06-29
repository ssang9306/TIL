# R 기본

## What

 R은 오픈소스로  통계 분석 프로그램이다.

 빅데이터 분석 도구로써 다양한 통계기법과 시각화 도구를 제공한다.

 C, 자바, 파이썬 등 다른 언어와 쉽게 연동하여 사용할 수 있다.

 프로그램 크기는 100mb이하(base 기준)로 가볍지만 강력한 기능을 제공한다.

 R studio툴 과 함께 사용하여 편리하게 이용가능

## Why?

1. 가볍고(100mb 이하) 강력한 성능
2. 오픈소스로 다양한 패키지 사용 가능
3.  쉽게 배우고 사용할 수 있다.

## How

### 1. 변수 생성과 변수 형태 확인

```R
x1 <- c(1,3,5,7,9) #벡터 생성
class(x1) #x1의 클래스를 확인
is.numeric(x1) 
is.integer(x1) 

x2 <- as.integer(x1) #x2에 x1을 정수형으로 생성

length(x1)
is.vector(x1)

#문자형과 다른 형태를 원소로 저장하면 문자열로 인식
xx <- c(1,2,3,"c")

#문자열 변수
"I like pork"
class("I like pork")

#도움!
help(vector)
help(boxplot)
?vector
?boxplot
```

가장 처음 헷갈린 점은 R의 벡터 개념이다.

간단하게, R의 벡터는 1차원 배열로 생각할 수 있다. 수학의 벡터개념의 의미와 다루는 방법이 같다.

또한 help를 통해 언제든지 관련 문서를 확인가능하다. 특히 별다른 구글링 없이 예제코드까지 확인가능하다는 점이 편리하다.

**!Tip**

 `ctrl` + `enter` window기준 R studio상에서 블록된 문장의 실행



#### 1-1  벡터 생성과 인덱스

 ```R
 x<-c(1,3,5,7,9)
 x[3]
 x[-1]
 
 x1 <- x[-c(1,2)]
 x2 <- x[-c(1:3)]
 
 ```

기본 슬라이싱은 python과 같이 []를 통해 가능하다.

인덱스 값으로 음수를 입력하면 해당 인덱스값의 제외를 의미한다. 즉, x[-1] 은 (3, 5, 7, 9)가 반환된다.

따라서 x1에는는 x의 (1,2) 인덱스 값을 제외한 원소들을 복제하여 저장된다.

또한, x2에는 x의 1~3 (3포함) 인덱스가 제외된  (7,9)만이 저장된다.

```R
#seq를 사용한 벡터 생성
y1 <- seq(0,10, length = 20)
y2 <- seq(0,10, by = 0.5)

#rep을 사용한 벡터 생성 - replication
z1 <- rep(1:4,2)

```

y1에는 0부터 10까지 20개의 원소가 만들어진다. 0과 10을 포함해야 하므로 정확히 0.5로 나누어지는 값이 아닌값들로 20개가 생성된다.

y2는 by 인자로 인해 0.5의 간격을 갖은 값들이 21개가 생성된다.



rep은 복제를 의미한다. rep(range, n)을 입력하면 range 범위를 n번 반복해서 만든다. 자료형은 정수형으로 저장된다.



#### 1-2 matrix

##### 1-2-1 기본 생성방법

```R
x <- seq(1,10,by = 2)
c1 <- c(2,4,6,8,10)
c2 <- cbind(x,c1)

c3 <- rbind(x,c1)
```

두 벡터를 컬럼방향, 로우방향에 맞춰서 bind할 수 있다. 생성된 matrix는 환경창에서 Data로써 확인 가능하다.

이때, 두 벡터의 차원이 맞지 않다면 경고 메시가 출력되지만, 억지로 차원을 맞춰서 생성된다.

```R
m1<- matrix(1:6,ncols = 3)
m2<- matrix(1:10,nrows = 2)
m3 <- matrix(1:6, nrows = 2, byrow =T)

```

matrix(range, nrows | ncols )를 통해 행렬을 생성할 수 있다. 

default값은 열방향으로 각 값들이 열방향으로 차례로 채워진다. (nrows ncols 모두 동일)"byrow = T"를 인자로 입력하면 행방향으로 차례로 값이 채워진다. 

이 방법 역시 자료의 개수와 행-열의 수가 맞지 않아도 ( ex)`mm <- matrix(1:10, ncols = 2)` ) 경고 메시지와 함께 행렬이 생성된다.

 --> 4x3행렬이 생성되고, 1~10 까지 열 방향으로 입력된 후 다시 1,2 가 입력된다.



```R
a1 <- array(c(1:18), dim = c(3,3,2))
a1[,,1]
a1[,,2]
```

고차원 행렬은 array와 dim인자를 통해 생성해낼 수 있다. 

고차원이라고 걱정하지 말고 c(3,3,2)는 3x3 matrix를 두 개 만드는것으로 간단하게 생각할 수 있다.

##### 1-2-2 matrix특징

```R
x <- matrix(rnorm(12),nrow = 4)
dim(x)
is.data.frame(x) # ->False
x <- as.data.frame(x)
is.data.frame(x) # ->True
```

matrix로 생성된 변수는 Data, matrix로써 생성되지만 datarame 형태로 저장되는 것은 아니다. 

```R
dimnames(x)[[2]] <- paste("x",1:3,sep ="")
dimnaems(x)[[1]] <- paste("id",1:4,sep = "")

y <- matrix(rnorm(12),nrow = 4)
colnames(y) <- c("y1","y2","y3")

```

dimnaems 를 통해 각 행과 열에 이름을 부여할 수 있다. dim차원에 맞춰 dim[[1]] 은 row, dim[[2]]는 col을 의미하며, colnames를 통해 열에 이름을 부여할 수 있다.

##### 1-2-3 apply

```R
# 각 행/열에 대해 함수 적용
# apply(data, 방향, 함수)
# vector | matrix를 데이터로 받아 임의의 함수 적용
# 함수: sum, mean, UserDefineFunction
# 방향: 1-행, 2-열

# ex
data <- iris[,-5]
apply(data, 2, sum)
apply(data, 2, median)

# easy way
summary(data)

# rowSums(), colSums(), rowMeans(), colMeans()
colSums(data)
colMenas(data)

# order() 정렬
order(data[, 1], decreasing = T) # return idx
data[order(data[,1], decreasing = T) , ]

# 특정 열 값이 짝수인 행만 선택
exDF[exDF$x %% == 0,]
```





#### 1-3 factor

 ```R
 gender <- c(1,2)
 names(gender) <- c("male","female")
 
 is.factor(gender) # ->False
 gender <- as.factor(gneder)
 is.factor(gender) # -> True
 ```

변수를 생성하고 names()를 통해 변수에 이름을 부여할 수 있다.

또한 factor자료형으로 변환 시켜줄 수 있는데, 명목변수와 같다. 순서가 없고 단순한 구분을 위한 변수로써 사용할 수 있다.

```R
survey <- c("불만족","보통","만족")
survey_factor <- factor(survey) # 명목변수로 변환
survey_factorlevel <- factor(survey, ordered = TRUE, levels = c("불만족","보통","만족"))
# 서열변수로써 변수 생성
```

위와 같이 ordered = True와 levels 값을 입력해주면, 불만족<보통<만족 으로 서열변수로써 변수가 생성할 수 있다.

#### 1-4 형 확인

```R
typeof(x)
mode(x)
string(x)
class(x)
```

#### 1-5 names

```R
# naems()로 각 자료의 셀에 이름 부여
x <- c(1,3,5)
col <- c('x1','x2','x3')
names(x) <- col
x # --> 자료의 이름과 데이터로 이루어진 벡터 확인가능

# 설정한 이름으로 데이터 조회
x[c('x1','x2')]

# names(변수) -> 셀의 이름을 반환
names(x)[1] # --> 인덱싱도 할 수 있다
```

#### 1-6 자료형 연산

```R
# 길이 확인 length(), nrow(), NROW()
length(x)
nrow(x) # -> matrix의 행 수 반환
NROW(x) # 단 1개의 행인 자료형에 대해 열의 개수를 반환

# R에서는 벡터 연산이 가능하다
# 어떤 값이 벡터에 포함됐는지 확인 %in%
a_vec <- 'f' %in% c('a','b','c')
a_vec  # -> FALSE

# 벡터에 대해 집합연산자도 사용가능
setdiff( c('a','b','c',),c('a','b')) # 차집합
union(c('a','b','c',),c('a','b')) # 합집합
intersect(c('a','b','c',),c('a','b')) # 교집합
setequal( c('a','b','c'),c('a','b')) # 두 집합이 같음?

# 앞/뒤 n개의 데이터 슬라이싱
x <- head(x,n) # 자료형으로 입력 가능
tail(x,n)

# Month의 이름을 가져오기
month.name # 정식 영어명칭 January, Feburary ...
month.abb  # 축약어 Jan, Feb ...
#이런 표현도 가능하다...
paste(month.abb, 1:12, c('st','nd','rd',rep('th',9)))

# 논리형 벡터 (T,F)
# &(and), |(or), !(not) xor
c(T,F,T, TRUE,FALSE)
c(T,F,T) | c(TRUE)  # (TRUE,TRUE,TRUE)
c(T,F,T) & c(TRUE)  # (TRUE,FALSE,TRUE)
!c(T,F,T) # (FALSE, TRUE, FALSE)
xor(c(T,F,T), C(TRUE)) # (FALSE TRUE FALSE)

```

#### 1-7 정규 표현식

```R
# 비정형 데이터를 handling할 때, 불순물 제거

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

# grp -> pattern에 맞는 것들을 x로부터 추출
# main option : ignore.case(대소 구분x), value
strvec <- c('gender','height','age','weight','eight')

# ei로 시작하는 데이터 추출
grep('^ei',strvec) # index를 추출
grep('^ei',strvec, value = T, ignore.case = T)
# ei로 시작하는 해당하는 값들을 대소문자 관계없이 모두 찾아 반환

# ei를 포함하는 문자열 추출
grep('ei',strvec,value = T)
grep('+ei+',strvec, value = T)
# + : 문자가 1 or more 있는 공간을 의미

# grepl -> return boolean
grepl('+ei',strvec)

txtVec <- c('BigDdata','Bigdata','bigdata','Data','dataMining','class1','class2')

# 문자열을 바꾸는 gsub
gsub('+big+','bigger',txtVec,ignore.case = T)

# 포함된 모든 숫자를 지우기
gsub('[0-9]','',txtVec)
gsub('[[:digit:]]','',txtVec)

sub('[0-9]','',txtVec)
sub('[[:digit:]]','',txtVec)
```

#### 1-8 stringr

```R
library(stringr)
# stringr package는 문자열 객체와 관련있는 다양한 함수가 있다

greeting_msg <- 'hello, bigdata is very important'
substr(greeting_msg, 5, 11)
strsplit(greeting_msg, ' ')

# 정규표현식을 사용하여 원하는 부분을 추출할 수 있다.
msg <- 'abc123def456'
# msg에서 숫자인 첫 3자리를 추출
str_extract(msg, '[0-9]{3}')
# msg 전체에서 숫자 3자리를 추출
str_extract_all(msg, '[0-9]{3}')
# str_extract = sub() / extract_all = gsub() g-global
sub('[a-z]+','','abc123def456')
gsub('[a-z]+','','abc123def456')

string_dummy <- '상민xiang9306 상상minplus 1995'
# 영어 단어만 추출, 단어의 최소와 최대자리수를 지정(4,5)
str_extract_all(string_dummy,'[a-zA-z]{4,5}')
# 연속된 한글 3자 이상 추출
str_extract_all(string_dummy,'[가-힣]{3,}')
# 숫자를 제외하고 추출
str_extract_all(string_dummy,'[^0-9]{1,}')

# 문자열 위치 return (list)
str_locate_all(string_dummy,'상민')

# 문자열 치환
str_replace(string_dummy, '상민','쌍쌍')

# 부분 문자열
str_sub(string_dummy,7,10)

# 특수문자 제외
num <- '$123,456'
gsub('[[:punct:]]','',num) # 공백으로 치환
str_replace_all(num, '\\$ | \\,' , '') 
# $ , 두 문자를 모두삭제 |(or)로 연결

```

#### 1-9 메타문자

```R
# 단어 : \\w 	숫자: \\d	 엔터: \n,  탭키: \t
# 특수문자 : \\<해당특수문자>
# [] 1회 {n} n회반복

# 똑같은 표현
ssn <- '951129-1234567'
str_extract_all(ssn,'[0-9]{6}-[1-4][0-9]{6}')
str_extract_all(ssn,'\\d{6}-[1-4]\\d{6}')

email <- 'ssang9306@naver.com'
str_extract_all(email,'\\w{4,}@\\w{3,}.[A-z]{2,}')
```

#### 1-10 배열 - 단일형 변수

```R
# array(), dim(c())
# 변수와 선언을 괄호로 묶으면 선언과 동시에 실행
(m <- matrix(c(1:12), ncol =4 )) 
class(m)  # -> 'matrix' : 'array'

(arr <- array(1:12, dim = c(3,4)) )
class(arr) # -> 'matrix' : 'array'
# ~ 2차원 array는 matrix와 유사하다. 거의 같다

( arr <- array(1:12, dim = c(2,2,3)) )
class(arr) # 3차원부터는 배열

# arr[행, 열, 차원요소(면)]
arr[1,1,1]
arr[,,2]

# apply 적용 가능
apply(arr, 2, mean)
apply(arr, c(1,2), mean)

```

#### 1-11 List

```R
# list( key = value)  like python - dict
# list()
# lapply() -> return(list, (key, value))
# sapply() -> return(list, value)

# 참고
a = 10 # scalar
a = c(10) # vector

( tmp_list <- list(name = 'xiang',
                  height = 188) )

# value selection
tmp_list$name
# type = list
mode(tmp_list)
class(tmp_list)

# type = data type
mode(tmp_list$name)
class(tmp_list$height)

# use str() check list structure
str(tmp_list)

# key를 부여하지 않는 경우
tmp_list <- list(1:4, rep(3:5), 'dog')
str(tmp_list)

# 숫자로 인덱싱이 가능함
tmp_list[[1]]
# value가 단일값이 아니라면 추가적 인덱싱도 가능
tmp_list[[1]][2:3]

```

##### 1-11-1 중첩구조

```R
# 벡터의 값이 묶여서 하나로 생성되는 것이 아닌
# 벡터의 각 값이 하나씩 value가 된다

new_list <- c( list(1,2,tmp_list),c(3,4))

over_list1 <- list(a = list(e = c(1,2,3)),
                 b = list(f = c(4,5,6)))
# data selection
over_list1$a$e
over_list1$b$f

over_list2 <- list(a = list(c(1,2,3)),
                  b = list(c(4,5,6)))
# data selection
over_list2$a[[1]]
over_list2$b[[2]][2:3]

( user_info <- list( name = c('Xiang','Min'),
                   address = c('Incheon','Nonhyeon'),
                   tel = c('010-9999-1111','179233'),
                   age = c(27,25),
                   marriage = (F,F)) )

user_info[1] # return list
user_info$name #return character vector
user_info[1]$name # 이런식으로 접근도 가능은 함

```





 ### 2. 기본 동작

```R
x1 <- c(1,4,9)
sqrt(x1)
min(x1)
max(x1)
mean(x1)

y1 = 2+x2
plot(x1,y1)
```

x1 벡터를 생성하고 기본통계 값을 확인하고 plot을 그릴 수 있다.

```R
ls()
rm(x1)

c1 <- "Upper lower 123"
tolower(c1)
toupper(c1)

x_random <- rnorm(100)
x_random2 <- rnorm(10000)

mean(x_random)
sd(x_random)
hist(x_random)

mean(x_random2)
sd(x_random2)
hist(x_random2)

```

ls() : 현재 생성된 변수목록 확인

rm(xx) : 변수 삭제, 여러 변수를 인자로 입력 가능하다



정규 분포를 따르는 random variable은 rnrom(n)으로 생성가능하다.

역시나 표본이 커질 수록 정규분포의 성질에 근사하게된다.

#### 2-1 기본 연산

```R
2^3 
4**3 # 제곱연산 
5%%2 # 나머지 연산 -> 1
5%/%2 # 몫 연산 -> 2
```

#### 2-2 행렬연산

 ```R
 m2 <- matrix(1:6, ncol = 3)
 tm2 <- t(m2) #전치행렬
 
 d1 <- matrix(1:4, nrow = 2, byrow = T)
 d1
 det(d1) #결정자 determinant 계산
 
 d1_inv <- solve(d1) #역행렬 생성
 d1_inv %*% d1 # 역행렬을 곱하므로 단위행렬이 출력
 
 solve(5,10) # 5 *x  = 10
 
 #역행렬을 통한 미지값 구하기
 a <- matrix(c(3,1,2,1), nrow = 2, ncol = 2)
 b < - matrix (c(8,2), nrow = 2, ncol =1)
 solve(a,b)
 
 #고유치(eigenvalue)와 고유벡터(eigenvector)
 x <- -matrix(c(-3,-2,0, 1, 2, 2, -3, -3, 0, 2, 2, 2, 5,7,4,0,-5,-11), nrow =6, ncol=3)
 
 e1 <- eigen(t(x)%*%x)
 
 ```

역행렬을 이용해 미지값 x,y를 구하는 식에 활용할 수 있다. 
$$
\left(
\begin{array}{cc|c}
3&2&x\\
1&1&y
\end{array}
\right) =


\begin{pmatrix}
8\\
2
\end{pmatrix}
$$
`solve` 함수를 활용하여 쉽게 구할 수 있다.

eigen을 통해 고유치와 고유 벡터 연산이 가능하고, 이를 통해 데이터의 특성 파악이 가능하다.

#### 2-3 디버깅

```R
# print(), paste(), sprintf()을 통한 디버깅

# print() 는 다른 행으로 출력된다
print('hi')
print('new line')

# Formatting -> sprintf : %d, %s, %f
sprintf('%d',10)
sprintf('%s : %f','pi',3.141592)

# paste (sep defualt =  ' ')
paste('a','b','c', sep = '')  # --> abc
paste('a','b','c', sep = '-') # --> a-b-c
```

#### 2-4 함수

```R
# user define function
myFunc <- function(){
    a <- 0
    cat('append')
    for(i in 1:10){
        a <- a + i
        cat(i,'...')
    }
    cat('end!','\n')
    return(a)
}
```

### 3. 패키지 설치와 실행

```R
install.packages("ggplot2")
library(ggplot2)
help(ggplot2)

ggplot(mpg, aes(displ, hwy, colour = class)) + 
  geom_point()
```

install.package("패키지명") 설치할때는 "" 가 필요하다. 

역시나, 설치는 최초 1회만 필요하고 import는 실행마다 library(패키지명)을 통해 실행해 줘야한다.

앞서 말한것과 같이 help를 통해 설치된 패키지의 도움말을 확인할 수 있고(online) 예제 코드까지 확인할 수 있다.

### 4.함수 생성 및 사용

```R
square <- function(x){
    return(x**x)
}

diff <- function(x,y){
    return(x-y)
}
square(diff(5,3))

# 기본 제공함수
# 대표적으로 round
round(3.141592) #default = 0
round(3.141592,3) #소수점 3자리까지
round(sqrt(10),2)
```

### 5. 루프 사용

```R
for(i in 1:10){
    if(i+1 > 6){
        break
    }
    if(i%%3 ==1){
        next() #next() : next iteration
    }
    print(i)
}
y = 0 
while(y< 5){ print( y <- y+1 ) }
# print(++y)와 동일 의미
# print( y = y+1)로 할 경우 오류 발생
```

### 6. Data Handling

#### 6-1 Load & Check Data

```R
data <- read.csv("filepath/filename.csv", na = " ", header = FALSE)
head(data)
dim(data)

#변수 빈도 확인
table(data$colname)
#attach()함수를 사용하면 데이터 명을 지정하지 않아도 됨
attach(data)
table(colname) # 위의 결과와 같다
hist(colname) #변수 분포 확인을 위해 히스토그램 생성가능
summary(data)
# 최소값, 25%값, 중위수, 평균, 75%값, 최대값 확인가능
# 이상치 탐지에 사용할 수 있다.
```

**!Tip**

```R
setwd("c:/users/filpath")
data <- read.csv("filename")
```

 setwd를 통해 현재 작업중인 경로를 설정해 놓으면 filepath 명시 없이 파일이름만으로 파일을 불러올 수 있다. 

 wd는 working directory 의 의미이며, `getwd()`를 통해 설정된 wd 를 확인할 수 있다.

#### 6-2 Subset & 요약통계

```R
data <- read.csv("filename")

data_sub1 <- subset(data, colname == condition)
#colname 컬럼을 조건에 맞춰 subset으로 분해(모든 비교연산자 사용가능)

aggregate(var1 ~ group, data, FUN = mean)
#group별 var1변수에 대해 mean 통계치를 보여준다.
#FUN을 활용하여 다양한 통계치 확인 가능

```

#### 6-3 테이블 내보내기

```R
write.table(data,file = "filename.csv", row.names = FALSE)
#filename.확장자명으로 파일을 내보낸다. csv,txt가능

write.csv(data,file = "filename.csv", row.names = TRUE)
#Row.names를 True로 설정하면 index가 새로운 컬럼으로 만들어진다.
write.table(data, file = "filename.txt",row.names = False)
```

#### 6-4 Using dplyr Subset

```R
#Using dplyr make subset

#1. select(data,var ....)
# 해당 변수로 이루어진 subset 생성
set1 <- select(data, var1, var2, ...)

#2. select(data, -var, -var,...)
# 해당 변수를 제외한 subset 생성
# start_with("xxx") -> xxx로 시작하는 변수명
set2 <- select(data, -start_with("xxx"))

#3. filter(data, col - condition)
# col값이 condition에 만족하는 데이터만 추출
set3 <- filter(data, col1 > 30)

#4. mutate(new_var = origin_var - transform)
#origin 기존 변수에서 적절한 변환을 가한다.
set4 <- mutate(data, km = mile * 1.609)
```

#### 6-5 dplyr - 파이프연산자

```R
data %>% condition .....
set4 <- data %>%
		filter(!is.na(col1)) %>%
		mutate(col2 = col3 * 2)
```

파이프 연산자는 이름처럼 파이프를 타고 데이터의 흐름을 나타낸다. 기존의 data를 `%>%`를 통해 전달 받고 condition에 맞게 처리를 한다는 뜻이다. 여러개의 추출, 변환을 수행할 수 있고 파이프로 연결해 주면 된다.

#### 6-6 summarize

```R
#예 ) 평균값 확인
data %>% summarize(mean(col1), mean(col2),mean(col3))

# summarize_all -> 요약치를 벡터화
# a1 평균값
a1 <- select(data, 1:4) %>% summarize_all(mean)
# a2 표준편차
a2 <- select(data, 1:4) %>% summarize_all(sd)
# a3 최소값
a3 <- select(data, 1:4) %>% summarize_all(min)
# a4 최대값
a4 <- select(data, 1:4) %>% summarize_all(max)

#벡터화된 통계치를 묶어 table: dataframe으로 만들 수 있음
table1 <- data.frame(rbind(a1,a2,a3,a4))
rownames(table) <- c("mean","std","min","max")

# group_by(col) 그룹별 요약통계량 추출 가능
data %>% 
	group_by(col1) %>%
	summarize(col_name = method(col, na.rm = T|F) 
```

### 7. R 그래픽

#### 7-1 데이터 시각화

- 정보의 요약된 형태를 그래프로 전달
- 인과 관계를 발견하는 등 인사이트 창출

**종류**

- 히스토그램 Histogram : 1차원 (univariate, 일변량)
- 상자그림 Box plot : 1차원 (데이터 분포 파악)
- 막대그림 Bar plot : 1차원 (범주형 데이터의 빈도분포)
- 파이차트 Pie chart : 1차원 (각 범주별 비율)
- 산점도 Scatter plot : 2차원( x와 y간의 관계 해석)

#### 7-2 그래픽 옵션

- par() : subplots - 그래프 출력 개수 , 마진 등 추가 옵션 가능
- pty : x축과 y축의 비율 "s" (동일), "m" (최대)
- legend : 범례, c("name","names")
- bty : box type 그래프 상자모양 설정, o, l, 7, c u
- pch : 포인트 모양, 1- 동그라미(기본값), 2 = 세모 ...
- lty : 선 모양, 1-직선, 2- 점선
- cex : 문자 - 점의 크기, 기본값 - 1
- mar : 여백 , (아래, 좌, 위, 우)

```R
# 기본형 색상, 제목, 변수 범위 분할
# ex - histogram
# 변수 범위를 10개로 나눈, 하늘색 그래프 표시, 제목 표시
hist(data, breaks = 10, col = "skyblue",main = "sample histogram")

# R에서 사용할 수 있는 색상 확인 
colors()

# 특정 계통의 색들을 확인
grep("blue",colors(), value = TRUE)

# R의 subplots
# n, m개의 공간을 만들어서 plot 출력
par(mfrow = (n,m))
```

####  7-2-2 Layout

```R
# par() plot 공간 생성 Like subplots
par(mfrow = c(n,m))
plot(x,y)

# 선 추가 abline
# v = n -> 수직선, h = m -> 수평선
abline(h = 20) # y = 20인 수평선 추가
abline(v = 3000) # x = 3000인 수직선 추가

# 기타 선 추가
abline(a = n, b = m) # 절편이 n, 기울기가 m인 직선
abline(lm(y~x)) # 회귀 선 추가

# layout(mt = matrix)각 행에 다른 개수의 그래프 출력
# matrix의 수 순서대로 각 행과 열에 그래프 생성
m <- matrix(c(1,2,3,3), ncol = 2, byrow= T))
# 2x2 matrix 생성
layout(mat = m) 
# 1행에 그래프 (1,2) 2개 출력, 2행에 (3) 1개 출력

# 범례 legend()
legend(xloc, yloc, legend = labels)
# labels은 변수에 맞춰 미리 생성
```

#### 7-3 Histogram & Density

```R
# histogram 
hist(data, | breaks = n, col = 'skyblue',main = 'sample'| )

# Density
# Density 함수는 plot()과 함께 사용
# 기타 옵션 동일
dy = density(data)
plot(dy)

```

#### 7-4  Boxplot & Barplot

- Boxplot는 사분위수를 시각화 해준다. 이를 통해 두 그룹 간의 분포차이, 이상치 등을 확인 가능하다.
- Barplot과 Piechart는 column에 속한 데이터 그룹의 빈도를 계산한다. 명목, 순위 변수에 활용 가능하다.

```R
# 두 그룹 이상 비교할때는 par()를 통해 subplot 공간 생성
boxplot(data, col = c("color1","color2",...),boxwex = n, main = "sample"  )

# 그룹이 많아지면 관리하기 까다로움으로 벡터와 table을 활용해서 관리한다.
par(mfrow=c(1,1))
table(car$cyl)
freq_cyl<-table(cyl)
names(freq_cyl) <- c ("3cyl", "4cyl", "5cyl", "6cyl",
                      "8cyl")
barplot(freq_cyl, col = c("lightblue", "mistyrose", "lightcyan",
                          "lavender", "cornsilk"))

pie(freq_cyl)

```

#### 7-5 Scatter plot & Add line

- 산점도는 x와 y의 관계를 확인을 돕는다.

- Python과 달리 R의 기본 plot형은 scatter이다.
- 산점도에 add line을 통해서 선을 시각화할 수 있다.

```R
#기본 산점도 
par(mfrow = c(1,1)) # 하나의 그래프 출력
x2 <- c(1,2,3)
y2 <- x2 + 1
plot(x2,y2) 

# sin, cos 산점도
par(mfrow = c(2,1)) # 2행 그래프 -> 2개 출력
x <- seq(0,2*pi, by = 0.001) # 간격이 좁아 선처럼 보인다.
y <- sin(x)
y2 <-cos(x)
plot(x,y,main = "sin curve")
plot(x,y2, main = "cosine curve")

# 실전
par(mfrow = c(2,1) , mar = c(4,4,2,2))
# mar: margin 그래프의 여백공간을 설정한다
plot(x1,x2, col = as.integer(x3))
# x3 그룹에 따라 색이 구분되고 x1, x2의 관계에 맞춰 산점도를 출력한다

# Conditioning plot -> 그룹별 산점도
data1 = subset(data, x3 == 1 | x3 == 2| x3 == 3)
# x3을 3개의 그룹으로 분리
coplot(x1 ~ x2| as.factor(data1$x3), data = data1)
# x1과 x2의 관계를 x3를 기준으로 그룹핑하여 보여준다.

# pairs - 여러 변수별 상관관계를 확인
pairs(data[ , :colnum], col = as.integer(data$x3))

# abline : 선 추가
plot(x1,x2, col = as.integer(x3))
abline(lm(x1 ~ x2)) # 선형 회귀선을 추가

# lowess 비선형 회귀 곡선 LOcally-WEighted polynomial resgreSSion
lines(lowess(x1,x2))

# lm(x1 ~ x2)는 회귀 결과 식을 반환 class(lm)
# lowess 는 계산 식을 반환 class(list)
```









