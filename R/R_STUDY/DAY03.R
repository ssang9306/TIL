(userInfo2 <- list(name = c('xiang','min'),
                   address = c('인천논현','소래포구'),
                   tel = c('010-9306-1195','010-9714-1195'),
                   age = c(27,27),
                   marriage = c(F,F) ) )

# List 값의 변경
userInfo2$age[1] <- 25
userInfo2$age

# 새로운 키, 값을 추가
(userInfo2$id <- c('1214','3330'))

# key 제거
userInfo2$id <- NULL
str(userInfo2)

# 서로다른 자료구조 (vector, matrix, array)
lst01 <- list(one = c('one','two','three'),
              two = matrix(1:9, nrow = 3),
              three = array(1:12, dim = c(2,3,2)))
str(lst01)              
lst01$one
lst01$two
lst01$two[2,2]
lst01$three[1,3,2]

lst02 <- list(1:5)
lst02
lst02[[1]][4]

# list -> vector
# vector -> list
# 형변환 as.

lst03 <- unlist(lst02)
lst03
class(lst03)

# apply
?lapply

lst04 <- list(1:5)
lst05 <- list(6:10)

lst04
lst05

class(lapply(X = c(lst04, lst05), FUN = sum))
sapply(X = c(lst04, lst05), FUN = sum )

res <- sapply(1:3, function(x) {x *2 })
res
class(res)

(res <- lapply(1:3, function(x) {x * 2}))
class(res)
class(unlist(res))

# data.frame

id <- c(100, 200, 300)
name <- c('xiang','min','xixi')
salary <- c(1000000, 2000000, 3000000)

(exDF <- data.frame(ID= id, NAME = name,
                   SALARY = salary))
exDF$ID

# matrix 를 이용한 방법
?matrix

(matDF <- matrix( data = c( 1, 'xiang',150,
                           2, 'min',150,
                           3, 'xixi', 150),
                 nrow = 3,
                 byrow = T))
class(matDF)

matDF <- data.frame(matDF)
class(matDF)
matDF

matDF$X1

str(matDF)

(sampleDF <- data.frame(x = c(1,2,3,4,5),
                       y = c(2,4,6,8,10)))

sampleDF$x
sampleDF$y
# indexing 가능
sampleDF[1,]

sampleDF[1,2]

sampleDF[c(1,3),2]
sampleDF[-1,c('x','y')]

class(sampleDF[-1,c('x','y')])
sampleDF[-1,'x']
class(sampleDF[-1,'x'])

# vector 리턴을 data.frame 형식으로 반환?
class(sampleDF[-1,'x'])
class(sampleDF[-1, c('x') , drop = F])

# rownames(), colnames()

(sampleDF <- data.frame(1:3,4:6))
sampleDF
colnames(sampleDF) <- c('feature01','feature02')
rownames(sampleDF) <- c('idx01','idx02','idx03')

class(names(sampleDF))

# 문자열을 인수로 할 경우 문제가 생긴다.

tmp.students <- c('Jhon','Mary','Ethan','Dora')
tmp.score <- c(76, 82, 84, 67)
tmp.grade <- c('C','B','B','D')

(tmp.class.df <- data.frame(tmp.students, tmp.score, tmp.grade))
str(tmp.class.df)

# 행의 수 nrow(), 열의 수 ncol()
ncol(tmp.class.df)
nrow(tmp.class.df)
names(tmp.class.df)

# 행 이름 지정
rownames(tmp.class.df) <- c('idx01','idx02','idx03','idx04')
tmp.class.df

# 열, 행 추가
# cbind(), rbind()
tmp.id <- c('100','200','300','400')
(tmp.class.df <- cbind(tmp.class.df, tmp.id))

tmp.class.df <- rbind(tmp.class.df , c('xiang',100,'A','500'))
tmp.class.df

rownames(tmp.class.df) <- c('idx01','idx02','idx03','idx04','idx05')

# factor
(tmp.factor <- c('A','O','AB','B','A','O','A'))
(blood.factor <- factor(tmp.factor))
class(blood.factor)

nlevels(blood.factor)
levels(blood.factor)
is.factor(blood.factor)
ordered(blood.factor)
?ordered
# 빈도수를 구하는 함수
table(blood.factor)
plot(blood.factor)


id <- c(1,2,3,4,5,6,7,8,9,10)
gender <- c('M','F','M','M','M','F','F','M','F','M')
age <- c(27,30,22,24,29,50,46,15,43,55)
area <- c('인천','서울','경기','강원','충청','경남','경북','전북','부산','전주')

(member.df <- data.frame(id,gender,age,area))

names(member.df)
member.df[,names(member.df) %in% c('gender','age')]

str(member.df)

member.df$gender <- as.factor(member.df$gender)
member.df$area <- as.factor(member.df$area)

str(member.df)

# levels 
levels(member.df$gender)
levels(member.df$gender)[1]
levels(member.df$gender)[2]

# iris data 이용, data.frame 확인
iris
class(iris)
str(iris)
levels(iris$Species)

mean(iris$Sepal.Length)
class(iris$Sepal.Length)

# 데이터 필드에 접근을 편하게 해줌
# with(dataset, 함수 | 표현식), within()
# with -> 읽기 전용 wthin -> 수정
# 데이터프레임 또는 리스트 내 존재하는 필드를 
# 손쉽게 접근하기 위한 함수
# with(dataset, tapply(vector, factor, func))

?with

mean(iris$Sepal.Length)
mean(iris$Sepal.Width)

# 하나의 함수(표현식)
with(iris, mean(Sepal.Length))
# 둘 이상의 함수(표현식 -> print)
with(iris, { print(mean(Sepal.Length))
             print(mean(Sepal.Width)) })

(x <- data.frame(val = c(1,2,3,4, NA, 5, NA)))

is.na(x$val)
mean(x$val)
mean(x$val, na.rm=T)

x <- within(x,
            valx <- ifelse(is.na(val), mean(x$val,na.rm = T), val))
x
x$val[is.na(x$val)] <- median(x$val, na.rm = T)

class(lapply(iris[,-5], mean))
class(sapply(x[,-5], mean)) 
x <- sapply(iris[,-5], mean)
(xx <- as.data.frame(t(x)))

class(xx)


iris
# iris[1,1] = 5.1
iris[1,1] = NA
head(iris)
setosa.df <- iris[iris$Species == 'setosa', ]
class(setosa.df)
setosa.df[is.na(setosa.df),is.na(setosa.df) ]  <- mean(setosa.df$Sepal.Length, na.rm = T)
mean(setosa.df$Sepal.Length, na.rm = T)

iris[iris$Species == 'setosa' & is.na(iris), is.na(iris)] <- mean(iris[iris$Species == 'setosa',])

# --------------------------
?split

# 각각의 factor로 분류된 list를 반환
class(split(iris$Sepal.Length, iris$Species))
split(iris$Sepal.Length, iris$Species)$setosa

iris.sl.median <- sapply(split(iris$Sepal.Length, iris$Species),
                         median,
                         na.rm = T)

iris <- within(iris,
               { 
                 Sepal.Length <- ifelse(is.na(Sepal.Length),
                                        iris.sl.median[Species],
                                        Sepal.Length)})
head(iris)

# subset()
# data.frame으로 부터 조건에 만족하는 행을 추출하여
# 추출된 내용을 data.frame으로 만드는 것
?subset
x <- 1:5
y <- 6:10

?letters
z <- letters[1:5]

(tmp.df <- data.frame(x,y,z))
(tmp.df.sub <- subset(tmp.df, x >=3 ))
class(tmp.df.sub)

tmp.df <- data.frame(x,y,z)
(tmp.df.sub <- subset(tmp.df, y<=8 , select = c('x','y'),drop = F))
class(tmp.df.sub)

# drop = T -> vector 반환
tmp.df <- data.frame(x,y,z)
(tmp.df.sub2 <- subset(tmp.df, y<=8 , select = c(x) ,drop = T))
class(tmp.df.sub2)


iris 
dim(iris)
str(iris)

# subset (1,3,5) 컬럼 대상 subset
# 3번 컬럼은 평균 이상 선택
iris.sub <- subset(iris, iris[,3] >= mean(iris[,3]), select = c(1,3,5))
str(iris.sub)

