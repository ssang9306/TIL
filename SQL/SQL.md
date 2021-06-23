# SQL

### Join

- 물리적인 두 테이블을 연결하여 가상으로 하나의 테이블을 생성
- 부모의 기본키와 자식의 외래키를 조건으로 걸어준다. 
- 이 조건이 = equal이면 eq연산, 그렇지 않으면 Non-eq 연산이다. 일반적으로 eq조인이 많이 일어난다.

#### ANSI 표준

- `ON(<condition>)` , `USING(<col>)` 을 사용한다.

- ```sql
  FROM TABLE1
  JOIN TABLE2 ON (CONDITION)
  JOIN TABLE3 USING (COL)
  LEFT | RIGHT| FULL JOIN ON(CONDITION)
  LEFT | RIGHT| FULL JOIN USING(COL)
  ```

- ORACLE 에서는 FULL JOIN을 지원안한다.

- USING보단 ON 사용을 추천

- USING()에 입력되는 컬럼에는 테이블 명을 기입하지 않는다. 따라서 별칭을 사용하면 오류가 난다.

### SET Operator

- 서로다른 두 개 이상의 쿼리 결과를 하나로 결합시키는 연산자
- 각 쿼리의 결과물의 컬럼 개수, 데이터 타입은 일치해야한다.
  - => DUMMY COLUMN의 사용
- 각 쿼리의 결과물을 집합으로, 집합 연산의 개념으로 이해가능
- 이질적인 두 결과물을 MERGE하는 과정
- 결과물의 컬럼은 선행 쿼리 결과물을 따른다.
- 유형 : `UNION`	`UNION ALL` 	`INTERSECT`	`MINUS`
  - UNION : 합집합, 각 쿼리의 결과물을 모두 출력한다. (중복 제거)
  - UNION ALL: 합집합, 각 쿼리의 결과물을 모두 출력한다. (중복 포함)
  - INTERSECT : 교집합, 각 쿼리의 결과물 중 공통된 내용을 출력한다.
  - MINUS : 차집합, 선행 쿼리 결과물에서 후행 쿼리 결과물과 공통된 부분을 제외한다.

```sql
SELECT  EMP_ID,
        ROLE_NAME
FROM    EMPLOYEE_ROLE
UNION
SELECT  EMP_ID,
        ROLE_NAME
FROM    ROLE_HISTORY;

-- UNION ALL
SELECT  EMP_ID,
        ROLE_NAME
FROM    EMPLOYEE_ROLE
UNION ALL
SELECT  EMP_ID,
        ROLE_NAME
FROM    ROLE_HISTORY;

-- INTERSECT
SELECT  EMP_ID,
        ROLE_NAME
FROM    EMPLOYEE_ROLE
INTERSECT
SELECT  EMP_ID,
        ROLE_NAME
FROM    ROLE_HISTORY;

-- MINUS
SELECT  EMP_ID,
        ROLE_NAME
FROM    EMPLOYEE_ROLE
MINUS
SELECT  EMP_ID,
        ROLE_NAME
FROM    ROLE_HISTORY;
```

- 동일 컬럼 수를 위해 DUMMY COLUMN 사용

```sql
SELECT  EMP_NAME,
        JOB_ID,
        HIRE_DATE
FROM    EMPLOYEE
WHERE   DEPT_ID = '20'
UNION
SELECT  DEPT_NAME,
        DEPT_ID,
        NULL 
        -- DUMMY COLUMN
FROM    DEPARTMENT
WHERE   DEPT_ID = '20';
```

- SET OPERATOR의 ORDER 는 마지막에 한번 기술 가능

```sql
SELECT  EMP_NAME,
        JOB_ID,
        HIRE_DATE
FROM    EMPLOYEE
WHERE   DEPT_ID = '20'
UNION
SELECT  DEPT_NAME,
        DEPT_ID,
        NULL
FROM    DEPARTMENT
WHERE   DEPT_ID = '20'
ORDER BY 2;
```

- JOIN연산을 통해 SET OPERATOR와 동일한 결과를 출력 가능

```sql
-- JOIN
SELECT  ER.EMP_ID,
        ER.ROLE_NAME
FROM    EMPLOYEE_ROLE ER
JOIN    ROLE_HISTORY RH ON(ER.EMP_ID = RH.EMP_ID AND ER.ROLE_NAME = RH.ROLE_NAME)

-- SET OPERATOR
SELECT  EMP_ID,
        ROLE_NAME
FROM    EMPLOYEE_ROLE
INTERSECT
SELECT  EMP_ID,
        ROLE_NAME
FROM    ROLE_HISTORY;        
```

```sql
-- 사원테이블에서 대리직급의 이름, 직급과 사원직급의 이름, 직급을 조회(SET)
SELECT  E.EMP_NAME,
        J.JOB_TITLE
FROM    EMPLOYEE E
JOIN    JOB J ON(E.JOB_ID = J.JOB_ID)
WHERE   J.JOB_TITLE = '대리'
UNION
SELECT  E.EMP_NAME,
        J.JOB_TITLE
FROM    EMPLOYEE E
JOIN    JOB J ON(E.JOB_ID = J.JOB_ID)
WHERE   J.JOB_TITLE = '사원'
ORDER BY 2;

-- IS SAME
SELECT  E.EMP_NAME,
        J.JOB_TITLE
FROM    EMPLOYEE E
JOIN    JOB J ON(E.JOB_ID = J.JOB_ID)
WHERE   J.JOB_TITLE IN ('사원','대리')
ORDER BY 2;
```

### SUBQUERY

- 하나의 쿼리가 다른 쿼리에 포함되는 것
- SET OPER가 이질적인 두개의 쿼리 결과물을 합쳤다면 SUBQUERY는 쿼리에 쿼리가 들어가는 경우
- 일반적으로 SUBQUERY라 함은 WHERE절에 사용되는 SUBQUERY를 의미한다.

```sql
SELECT	(SUBQUERY) - AS SCALAR
FROM	(SUBQUERY) - AS INLINE VIEW
WHERE 	(SUBQUERY)
GROUP BY (SUBQUERY)
HAVING	(SUBQUERY)
```

- 주의사항 1 - 유형
  - 단일 행 서브쿼리  (단일 열, 다중 열)
    - 단일 행  반환
    - 단일 행 비교 연산자 사용 
  - 다중 행 서브쿼리 (단일 열, 다중 열)
    - 다중 행 반환
    - 다중 행 비교 연산자(`IN`, `ANY`, `ALL`)

```sql
-- SUBQUERY EXAMPLE1.
SELECT  EMP_NAME,
        JOB_ID,
        SALARY
FROM    EMPLOYEE
WHERE   JOB_ID = (SELECT  JOB_ID
                  FROM    EMPLOYEE
                  WHERE   EMP_NAME = '나승원')
AND     SALARY > (  SELECT SALARY 
                    FROM    EMPLOYEE
                    WHERE   EMP_NAME = '나승원')
```

- 단일 행 서브쿼리
  - 서브쿼리에 의해 필터링 되는 결과 건수가 1개 행이다.
  - 익숙한 연산자로 비교적 단순하다.

```sql
-- SUBQUERY EXAMPLE2.
SELECT  EMP_ID,
        EMP_NAME,
        '관리자' AS 구분
FROM    EMPLOYEE
WHERE   EMP_ID IN ( SELECT  DISTINCT MGR_ID
                    FROM    EMPLOYEE );
```

- 다중 행 서브쿼리
  - 서브쿼리에 의해 필터링 되는 결과 건수가 2개 이상
  - 1개 행과 N개 행의 비교에서 `=`, `>=`, `!=` 등의 단일 행 연산은 사용 불가능 하다. `IN`, `ANY`, `ALL` 을 사용해야 한다.

  - 연산자 `ALL`  & `ANY`
    - ANY는 주어진 범위 안에서 만족하는, ALL은 주어진 범위를 벗어나는 범위가 선택됨
  -  `X > ANY Y `는 Y의 최소값 보다 큰 X 를 뜻하므로 Y전체 값의 범위가 포함된다.
  - `X < ANY Y`는 Y최대값 보다 큰 X를 뜻하므로 Y값 전체 범위가 포함된다.
  - `X > ALL Y`는 Y최대값보다 큰 X를 뜻하므로 Y값 범위 밖에 있는 값을 의미한다.
  - `X < ALL Y`는  Y최소값보다 작은 X를 뜻하므로 Y값 범위 밖의 값을 의미한다.

- 다중 열 서브 쿼리

  - 서브쿼리로 반환되는 결과의 열이 2개 이상
  - 단일 행, 다중 행 서브쿼리의 결과로 모두 나올 수 있고, WHERE 조건절로 사용한다면 반환되는 열만큼의 X 조건열을 입력해야한다.

```SQL
-- 다중 열 서브쿼리
SELECT  EMP_NAME,
        JOB_TITLE,
        SALARY
FROM    EMPLOYEE 
JOIN    JOB USING(JOB_ID)
WHERE   (JOB_ID, SALARY) IN (   SELECT  JOB_ID, TRUNC(AVG(SALARY), -5)
                                FROM    EMPLOYEE 
                                GROUP BY JOB_ID) ;

```

- INLINE VIEW - SUBQUERY IN FROM
  - FROM절에 SUBQUERY로 가상 테이블을 입력할 수 있다.
  - 가상테이블은 다른 테이블과 마찬가지로 JOIN 연산 등이 가능하다.
  - 이렇게 FROM절에 SUBQUERY가 사용되는 것을 인라인뷰(INLINE VIEW)라고 한다.

```sql
SELECT	E.EMP_ID,
		E.EMP_NAME,
		J.JOB_TITLE,
		E.SALARY,
		V.JOBAVG
FROM	(	SELECT	JOB_ID ,
        			TRUNC(AVG(SALARY),-5) JOBAVG
        	FROM 	EMPLOYEE
        	GROUP BY JOB_ID) V 
-- INLINE VIEW V라는 별칭의 가상 테이블 생성
JOIN	EMPLOYEE E ON(V.JOB_ID = E.JOB_ID)
JOIN	JOB J ON (E.JOB_ID = J.JOB_ID)
```

- 상관관계 서브쿼리Correlated Subquery
  - 메인쿼리가 실행되고 메인 쿼리의 특정 컬럼값을 서브쿼리가 처리하여 다시 메인 쿼리로 반환하는 구조
  - 서브쿼리 => 메인쿼리 구조가 아닌 메인 => 서브 => 메인
  - 메인쿼리를 받아서 서브쿼리가 수행되기 때문에 메인 쿼리양이 클 때 불리하다.

```sql
SELECT  EMP_NAME,
        JOB_TITLE,
        SALARY
FROM    EMPLOYEE E
JOIN    JOB J ON (E.JOB_ID = J.JOB_ID)
WHERE   SALARY = (  SELECT  TRUNC(AVG(SALARY),-5) JOBAVG
                    FROM    EMPLOYEE S
                    WHERE   E.JOB_ID = S.JOB_ID
                    );
```

- EXISTS, NOT EXISTS 연산자
  - 상관관계 서브쿼리에서 사용하는 연산자
  - 결과집합이 중요한 것이 아닌, 데이터가 있고 없음을 판단한다

```sql
SELECT  EMP_ID,
        EMP_NAME,
        '관리자' 구분
FROM    EMPLOYEE E
WHERE   EXISTS ( SELECT -1
                 FROM    EMPLOYEE 
                 WHERE   E.EMP_ID = MGR_ID)
                 
-- SAME AS ...
SELECT	EMP_ID,
		EMP_NAME
		'관리자' 구분
FROM	EMPLOYEE E
WHERE 	EMP_ID IN ( SELECT 	DISTINCT MGR_ID 
                  	FROM 	EMPLOYEE
                  	WHERE 	MGR_ID IS NOT NULL)
```



