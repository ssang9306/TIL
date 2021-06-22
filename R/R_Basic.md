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
```

가장 처음 헷갈린 점은 R의 벡터 개념이다.

간단하게, R의 벡터는 1차원 배열로 생각할 수 있다. 수학의 벡터개념의 의미와 다루는 방법이 같다.

또한 help를 통해 언제든지 관련 문서를 확인가능하다. 특히 별다른 구글링 없이 예제코드까지 확인가능하다는 점이 편리하다.

**!Tip**

 `ctrl` + `enter` window기준 R studio상에서 블록된 문장의 실행



#### 1-1  슬라이싱과 벡터생성

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

