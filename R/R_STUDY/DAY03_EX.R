# 1. 4,6,5,7,10,9,4,15를 R의 숫자형 벡터 x로 만드세요.
x1 <- c(4,6,5,7,10,9,4,15)

# 2. 아래의 두 벡터의 계산 결과는?
x1 = c(3,5,6,8)
x2 = c(3,3,3)
x1 + x2

# 3. Data Frame과 subset을 이용하여 다음의 결과를 도출하세요
Age <- c(22, 25, 18, 20)
Name <- c("James", "Mathew", "Olivia", "Stella")
Gender <- c("M", "M", "F", "F")

x1.df <- data.frame(Age,Name,Gender)
x1.df
(x1.df.sub <- subset(x1.df, Age >= 22))

# 4. 아래의 R코드를 실행한 결과는?
x <- c(2, 4, 6, 8)
y <- c(TRUE, TRUE, FALSE, TRUE)
sum(x[y])

# 5. 아래의 벡터에서 결측치의 수를 구하는 R코드를 작성하세요
x <- c(34, 56, 55, 87, NA, 4, 77, NA, 21, NA, 39)
sum(is.na(x))

# 6. 아래 두 벡터를 결합하는 코드이다. 결과는?
a=c(1,2,4,5,6)
b=c(3,2,4,1,9)
class(cbind(a,b))

# 7. 아래 두 벡터를 결합하는 코드이다. 결과는?
a=c(10,2,4,15)
b=c(3,12,4,11)
rbind(a,b)

# 9. 아래 R 코드의 결과는?
x=c(1:12)
length(x)

# 10. 아래 R 코드의 결과는?
x=c('blue',10,'green',20)
is.character(x)  

# 11. 아래의 세개의 벡터를 이용하여 아래의 결과가 나오도록 리스트(Date)를 만들어라.
year=c(2005:2016)
month=c(1:12)
day=c(1:31)

(Date <- list(year = year, month = month, day = day))

# 12. 아래의 행렬계산 결과는?
(M=matrix(c(1:9),3,3,byrow=T))
(N=matrix(c(1:9),3,3))

M%*%N

# 14. 아래의 데이터를 데이터프레임(Department)으로 만들어라.
did <- c(31,33,34,35)
dn <- c('영업부','기술부','사무부','마케팅')
df <- data.frame(DepartmentID = did, DepartmentName = dn)
df
