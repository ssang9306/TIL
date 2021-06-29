
txtVec <- c('BigData','Bigdata','bigdata','Data','dataMining','class1','class2')
txtVec

# nchar() : 각각의 인덱스 번지의 character 개수
nchar(txtVec)
str_length(txtVec)

# library download
install.packages('stringr')
# 삭제 -> remove.packages('<package_name>')

library(stringr)
str_length(txtVec)

?substr
greeting_msg <- 'hi, bigdata is very important'
substr(greeting_msg,5,11)
strsplit(greeting_msg,' ')

?str_extract
str_extract('abc123def456','[0-9]{3}')
str_extract_all('abc123def456','[0-9]{3}')
str_extract_all('abc123def456','[a-zA-Z]{3}')

# gsub -> global의 의미 = extract_all
gsub('[0-9]+','','abc123def456')
sub('[0-9]+','','abc123def456')

string_dummy <- '상민리ssang9306쌍쌍min95'

#영어 단어만 추출, 단어의 최소와 최대자리수를 지정가능
str_extract_all(string_dummy,'[a-zA-Z]{4,5}')

# Q1. 연속된 한글 3자 이상을 추출한다면?
str_extract_all(string_dummy, '[가-힣]{2}')
str_extract_all(string_dummy, '[가-힣]{2,}')
# Q2. 나이추출
str_extract_all(string_dummy,'[0-9]{2}')
# Q3. 숫자를 제외하고 추출
str_extract_all(string_dummy,'[^0-9]{1,}')
# Q4. 영문자를 제외한 한글 이름만
str_extract_all(string_dummy,'[^A-z]+')

# 메타문자
# 단어 \\w  ,  숫자 \\d  , 엔터\n  ,  탭키\t
# 특수문자 \\<해당특수문자> 
# [] 1회 {n} n반복

ssn <- '951129-1234567'
str_extract_all(ssn,'[0-9]{6}-[1-4][0-9]{6}')
str_extract_all(ssn,'\\d{6}-[1-4]\\d{6}')

email <- 'ssang9306@naver.com'
str_extract_all(email,'\\w{4,}@\\w{3,}.[A-z]{2,}')

str_msg <- '덤덤덤 아 자고싶다 졸려 상민 졸립다 잠온다다'
length(str_msg) # --> 1
str_length(str_msg) # -->25

# 문자열의 위치
str_locate_all(str_msg,'상민')
class(str_locate_all(str_msg,'상민'))

# 문자열 치환
str_replace(str_msg, '상민','상상')

# 부분 문자열
str_sub(str_msg,7,10)

# 특수문자 제외
num <- '$123,456'
gsub('[[:punct:]]','',num)

# 하나 이상의 특수문자를 연결 하는 것은 |(or)
str_replace_all(num,'\\$|\\,','')

# 반환 결과는 character
class(str_replace_all(num,'\\$|\\,',''))

# 형 변환 함수 as.
class(as.numeric(str_replace_all(num,'\\$|\\,','')))

# 행렬(matrix)
# matrix() , cbind() , rbind()
# apply()

var01 <- matrix(c(1:5))
class(var01)
nrow(var01)
var02 <- matrix(c(1:10),nrow = 2,byrow = T)
var02
var03 <- matrix(c(1:9),3,3)
var03

x <- c(1,2,3,4,5,6)
class(x)

var04 <- matrix(x,2,3)
var04
t(var04)

# row(), col() 각 인덱스 번지 확인
row(var04)
col(var04)

# 데이터 접근 [ row_idx, col_idx]
mode(var04[1,1])
var04[2,3]

var05 <- matrix(c(1:9),3,3)
var05

# 1,2행의 2열 성분만 출력
mode(var05[c(1:2),2])
var05[2,c(1,2)]
var05[-1,c(1,3)]
var05[-1,c(T,F,T)]

# 1, 3열을 제외한 행렬을 만든다면
xx <- as.matrix(var05[,-c(1,3)]) # x

var05[,2,drop = F]
class(var05[,2,drop = F])
var05[,-c(1,3),drop = F]
class(var05[,-c(1,3),drop = F])

x <- rbind(c(1,2,3),c(4,5,6))
y <- cbind(c(1,2,3),c(4,5,6))
class(x)
class(y)

# 자동완성 ctrl + space
yukhoe_mat <- matrix(c(1:9),
                     nrow = 3,
                     dimnames = list(c('row01','row02','row03'),
                                     c('col01','col02','col03')))

yukhoe_mat
# 행의 이름과 열의 이름을 이용하여 조회가 가능
yukhoe_mat['row03','col02']

# 행렬과 스칼라값 연산 가능
yukhoe_mat * 2

mat01 <- matrix(c(1:9), nrow = 3)
mat02 <- matrix(c(1:9), ncol = 3)

# 행렬과 행렬의 연산
mat01 %*% mat02

# apply(data, 방향, 함수)
# vector | matrix 데이터로 받아 임의의 함수를 적용한 결과를 얻는 것
# 방향 : 1 = 행 , 2 = 열열
# 함수 : sum, mean, userdefine function
?apply

mat01
apply(mat01,1,sum)
class(apply(mat01,1,sum))

apply(mat01,2,sum)

# 각 열에 대한 합, 평균, 중위수 등
data <- iris[,-c(5)]
class(iris)

apply(data, 2, sum)
apply(data, 2, mean)
apply(data, 2, median)
apply(data,2,max)

summary(data)

# rowSums(), colSums(), rowMeans(), colMeans()
colSums(iris[,-c(5)])
rowSums(data)
rowMeans(data)
colMeans(data)

# order() 정렬
?order

order(iris[ , 1], decreasing  = T)

iris[order(iris[,1], decreasing = T),]

?data.frame
exDF <- data.frame(x = c(1,2,3,4,5),
                  y = c('a','b','c','d','e'))
# 특정 행 가져오기
exDF[-c(2,4),]

# x의 값이 짝수인 행만 선택
exDF[exDF$x %%2 == 0, ]

# 배열- 단일형 변수
# array(), dim(c()) 
(m <- matrix(1:12, ncol=4)) # 괄호를 넣으면 선언과 동시에 실행
class(m)

?array
(arr <- array(1:12, dim = c(3,4)))
class(arr) # 2차원 배열은 matrix와 거의 같다

(arr <- array(1:12, dim = c(2,2,3)))
class(arr) # 3차원 부터는 배열

# arr[행 , 렬, 차원 요소]
arr[1,1,1]
arr[,,2]

# 행렬단위의 함수 적용 가능
apply(arr,2,mean)
apply(arr, c(1,2), mean)

iris3
dim(iris3)
mode(iris3)
class(iris3)

# list ( key = value , python-dict)
# list()
# lapply() -> return(list, key = value)
# sapply() -> return(list, value)
a = 10 # scalar
a = c(10) # vector 

(tmp_list <- list(name = 'xiang',
                 height = 188))
tmp_list$name
mode(tmp_list)
class(tmp_list)

(tmp_list <- list(name=  'xiang',
                 height = c(1,2,3,4)))
class(tmp_list$name)
class(tmp_list$height)

?list
# list의 구조 확인
str(tmp_list)

(tmp_list <- list(1:4, rep(3:5), 'dog'))
str(tmp_list)

# 이름을 부여 x 
tmp_list[[1]]

# 중첩구조
# 벡터의 값이 묶여서 하나로 생성되는 것이 아닌
# 벡터의 각 값이 하나씩 value가 된다.
new_list <- c( list(1,2,tmp_list),c(3,4))
str(new_list)
class(new_list)
(over_list2 <- list(a = list(e = c(1,2,3)),
                  b = list(f = c(1,2,3,4))))
 
over_list2$a$e
over_list2$b$f

(over_list1 <- list(a = list( c(1,2,3)),
                    b = list( c(1,2,3,4))))

over_list1$a[[1]]
over_list1$b[[1]][2:3]

(userInfo <- list(name = 'xiang',
                 address = '인천논현',
                 tel = '010-9306-1195',
                 age = 27,
                 marriage = F))
str(userInfo)
userInfo$name

class(userInfo[1]) # return list
class(userInfo$name) #return character
userInfo[1]$name # 이런식의 접근도 가능하긴 하다

(userInfo2 <- list(name = c('xiang','min'),
                  address = c('인천논현','소래포구'),
                  tel = c('010-9306-1195','010-9714-1195'),
                  age = c(27,27),
                  marriage = c(F,F) ) )
mode(userInfo2$name)
class(userInfo2$name)
length(userInfo2$name)  
userInfo2$name[1]
