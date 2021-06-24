# R_ML

> R로 보는 Machine Learning 강의 시간이 얼마 남지않아 필요한 부분을 먼저 듣고 정리

## 1. 군집분석 & 유사성 척도

### 1-1 군집분석

- 속성변수(x, 원인변수) 들의 특징으로 변수를 군집화 한다.
  - 계층적 군집 : 사전에 군집수를 결정하지 않고 군집트리를 형성한다. 마지막 레벨부터 시작해서 적절한 군집 수를 선택해 간다.
  - 비계층적 군집 : 사전에 군집 수 k를 미리 정한 후 객체를 가장 적절한 군집에 배정한다.

### 1-2 유사성 척도

- 객체간 유사 정도를 정량적으로 나타내기 위한 척도
  - 거리 Distance 척도 : 거리로 유사성을 판단, 가까울수록 유사성이 높고 멀수록 유사성이 적다.
    - 유클리디안  : 가장 기본적
    - 민코프스키 : 유클리디안 거리를 일반화 한 것
    - 마할라노비스 : 변수 간의 상관관계가 존재할 때 확인
  - 상관계수 척도 : `객체` 간 상관계수가 클 수록 두 객체의 유사성이 커진다.

```R
# Euclidean Distance
d1 <- dist(data.frame)

# Minkowski distance
d2 <- dist(data.frame, method = 'minkowski', p = n)

# correlation coefficient
cor(matrix[n,], matrix[m,])
```

- R에는 dist 함수가 있다. 다른 옵션을 추가하지 않는다면 유클리디안 거리로 계산 된다.
- 민코프스키 거리는 p > 2 일때, 유클리디안 거리와 다르다고 할 수 있다.
- dist 함수에서 `method`옵션을 변경하면 다른 거리함수를 사용할 수 있다. 자세한것은 `help()` 명령어
- 상관계수는 상관계수와 비슷한데, `객체`에 대한 상관계수이므로 객체의 속성이 정의된 `matrix`에서 각 객체를 입력으로 넣어주면 된다.

### 1-3 계층적 군집분석

- 유사한 객체들을 군집으로 묶고, 다시 각 군집을 기반으로 유사한 군집들을 묶어 나가는 방법
  - 단일 연결법 : 유사성척도로 두 군집의 객체쌍 중 가장 가까운 거리를 사용
  - 완전 연결법 : 유사성척도로 두 군집의 객체쌍 중 가장 먼 거리를 사용
  - 평균 연결법 : 유사성척도로 모든 객체 쌍의 평균 거리를  사용
  - 중심 연결법 : 유사성척도로 두 군집의 중심 좌표의 거리를 사용
  - 워드 연결법 : 각 군집내 제곱합을 이용하여 군집을 형성
- => 어떤 연결법이 좋다는 것은 없지만, 최근에는 워드 연결법을 많이 사용한다.

### 1-4 덴드로그램

- 군집 그룹간 유사성 수준을 표시하는 트리 다이어그램
- 군집이 어떻게 형성되는지 확인하고 형성된 군집의 유사성 수준을 평가 
- 분석가가 덴드로그램을 확인하여 적절한 군집의 개수를 결정

```R
# use wages1833 data
data <- wages1833

# remove na
data <- na.omit(data)

# calculate distance Euclidean
dist_data <- dist(data) 

# basic linakge syntax
clust <- hclust(distance_data, method = ' ')

# complete linkage method
hc_c <- hclust(dist_data, method = 'complete')

# centroid linkage method
hc_d <- hclust(dist_data, method = 'centroid')

# average linage method
hc_a <- hclust(dist_data, method = 'average	')

# plot Syntax
plot(clust, hang = -1, cex = 0.7, main = ' ')
```

### 1-5 비계층적 군집분석

- 사전에 군집수 k를 정한 후 각 군집에 객체를 배정
  - `k-means` , `k-medoids` : `pam` , `clara`

#### 1-5-1 k-means

- 비계층 군집분석 중 가장 널리 사용
- k개 군집의 `중심좌표`를 고려하여 각 객체를 가장 가까운 군집에 배정하는 것을 반복
  1. 초기 중심 선정 - k 개의 객체를 무작위로 초기 군집 중심 좌표로 선정한다.
  2. 각 객체는 선정된 중심좌표와 거리를 계산한 후 가장 가까운 군집에 배정받는다.
  3. 형성된 군집의 중심 좌표를 계산한다.
  4. 계산된 중심 좌표값과 이전 중심 좌표값을 비교한다. 수렴조건에 들면 종료, 아니면 2번부터 다시 반복한다. 
     - 수렴조건? 이전 군집결과와 변화가 없는 등.. 
- 문제는 최적의 k 계산
- `silhouette 계수` , `gap_stat`, `wss`으로 산출

#### 1-5-2 k-medoids 

- 각 군집의 대표 객체 medoid를 고려하는 군집 분석 방법이다.
- 군집 대표는 군집 내 다른 객체들과의 거리가 최소가 되는 객체로 군집의 대표와 군집 내 객체간의 거리 총합을 최소화 하는 방향으로 진행된다
  - `pam` : 모든 객체에 대해 대표 객체 변화에 따라 발생하는 변화 거리 총합을 계산한다. 데이터가 많아질 수록 계산량이 크게 증가한다.
  - `clara` : 적절한 수의 객체를 샘플링하고 pam알고리즘을 사용하여 대표 객체를 선정한다. 샘플링은 여러번 시도하여 좋은 결과를 선택한다. 결국 표본이 모집단을 충분히 반영하는것이 중요하다.

```R
# to choose optimal k
library(factoextra)
# basic Syntax
fviz_nbclust(data, kmeans, method = )

fviz_nbclust(data, kmeans, method = 'wss')
fviz_nbclust(data, kmeans, method = 'silhouette')

# kmeans
km <- kmeans(data, k, nstart = )

# visualize
fviz_cluster(km, data)

# pam
p <- pam(data,k)

# frequency each cluster
table(p$clustering)
```

- `nstart `는 랜덤으로 선택되는 군집중심을 몇번 수행하는지 

## 2. 연관규칙 & 로지스틱 회귀

### 1.연관규칙

- 대용량 DB의 트랜잭션에서 빈번하게 발생하는 패턴 발견
- 거래간의 상호 관련성을 분석한다.
- 사건 A가 발생했을때 사건 B가 발생하는가? 에대한 분석

#### 개념

- 장바구니 : 고객이 구매한 물품 정보 (구매시기, 지불방법, 매장 정보 등)
- 트랜잭션 :  고객이 거래를 한 정보
- 장바구니 분석 : 장바구니 데이터롭터 연관규칙 탐색 분석

#### 척도

- 지지도Support : P(A `intersect` B) / n 
  - 전체 거래에서 두 거래가 차지하는 비율로 어느정도 수준에 도달해야 의미가 있다.
- 신뢰도 Confidence : P( B | A ) 
  - 조건부 확률로, A가 구매됐을때 B가 구매되는 비율을 의미한다. 신뢰도가 높을 경우 A -> B에서 항목 B의 확률이 커야 연관규칙 의미가 있다.
- 향상도 Lift : P(B | A ) / P(B)  = 신뢰도 / P(B)
  - A가 거래된 경우, 그 거래가 B를 포함하는 경우와 B가 임의로 거래되는 경우의 비율이다.
    - if (Lift == 1) : 두 항목 거래에 관련이 없음
    - if (Lift > 1 ) : 두 항목 거래간 긍정적 상관관계를 의미한다. 우연적이기 보다 앞서 한 항목이 거래되면 다음 항목이 거래될 가능성이 높다는 의미이다. 향상도 값이 클 수록 A거래 여부가 B거래 여부에 큰 영향을 미친다.
    - if (Lift <1 ) : 두 항목 거래간 부정적 상관관계를 의미한다. 

```R
library(arules)

# data format : 'transactions'
# DVD 데이터에는 거래ID 별 ITEM이 저장되어있다.
dvd <- read.csv('dvdtrans.csv', stringAsFactor = TRUE)
dvd.list <- split(dvd$item, dvd$id)
dvd.trans <- as(dvd.list, 'transactions')

# check transformed data
inspect(dvd.trans)
summary(dvd.trans)

# running dvdtrans data
dvd_rule <- apriori(dvd.trans,
                    parameter = list(supp = 0.2, conf = 0.2, minlen = 2))

# result
summary(dvd_rule)
inspect(dvd_rule)
```

- apriori (transactiondata)
  - parameter : 지지도와 신뢰도는 최소값을 입력해준다. minlen은 최소가 되는 A와 B의 아이템 개수이다. 
    - minlen 1을 입력하면 모든 아이템 각각에 대한 장바구니 분석부터 시작된다.





