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
--INTERSECT
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

-- 동일 컬럼 수 -> DUMMY COLUMN 활용
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
WHERE   DEPT_ID = '20';

SELECT  EMP_ID,
        EMP_NAME,
        '관리자' AS 구분
FROM    EMPLOYEE
WHERE   EMP_ID = '141'
AND     DEPT_ID = '50'
UNION
SELECT  EMP_ID,
        EMP_NAME,
        '직원' AS 구분
FROM    EMPLOYEE
WHERE   DEPT_ID = '50'
AND     EMP_ID != '141';

-- DECODE(COL, CON, V, DEFAULT VALUE)
SELECT  EMP_ID,
        EMP_NAME,
        DECODE(EMP_ID, '141','관리자','직원') 구분
FROM    EMPLOYEE
WHERE   DEPT_ID = '50'


SELECT  EMP_ID,
        EMP_NAME,
        MGR_ID
FROM    EMPLOYEE
WHERE   DEPT_ID = '50';

-- JOIN을 이용하여 INTERSECT 결과 출력?
SELECT  ER.EMP_ID,
        ER.ROLE_NAME
FROM    EMPLOYEE_ROLE ER
JOIN    ROLE_HISTORY RH ON(ER.EMP_ID = RH.EMP_ID AND ER.ROLE_NAME = RH.ROLE_NAME)

SELECT  EMP_ID,
        ROLE_NAME
FROM    EMPLOYEE_ROLE
INTERSECT
SELECT  EMP_ID,
        ROLE_NAME
FROM    ROLE_HISTORY;        
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

-- SUBQUERY EX1
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
                    
-- 사원 테이블에서 최소급여를 받는 사원의 정보를 조회한다면?
SELECT  EMP_NAME,
        SALARY,
        JOB_ID
FROM    EMPLOYEE
WHERE   SALARY  =   (SELECT MIN(SALARY)
                     FROM   EMPLOYEE);
                     
-- 부서별 급여 총합을 조회
SELECT  DEPT_ID, SUM(SALARY) 총합
FROM    EMPLOYEE
GROUP BY DEPT_ID 
ORDER BY 1;

SELECT  MAX(SUM(SALARY))
FROM    EMPLOYEE
GROUP BY DEPT_ID;

SELECT  DEPT_NAME,
        SUM(SALARY)
FROM    EMPLOYEE
JOIN    DEPARTMENT USING(DEPT_ID)
GROUP BY DEPT_NAME
HAVING SUM(SALARY) = (  SELECT  MAX(SUM(SALARY))
                        FROM    EMPLOYEE
                        GROUP BY DEPT_ID)

SELECT  EMP_ID,
        EMP_NAME,
        '관리자' AS 구분
FROM    EMPLOYEE
WHERE   EMP_ID IN ( SELECT  DISTINCT MGR_ID
                    FROM    EMPLOYEE );
                    

SELECT  EMP_ID,
        EMP_NAME,
        '관리자' 구분
FROM    EMPLOYEE
WHERE   EMP_ID IN(  SELECT  DISTINCT MGR_ID
                    FROM    EMPLOYEE
                    WHERE   MGR_ID IS NOT NULL)
UNION
SELECT  EMP_ID,
        EMP_NAME,
        '직원' 구분
FROM    EMPLOYEE
WHERE   EMP_ID NOT IN ( SELECT  DISTINCT MGR_ID
                        FROM    EMPLOYEE
                        WHERE   MGR_ID IS NOT NULL);
                        

SELECT  EMP_ID,
        EMP_NAME,
        CASE WHEN EMP_ID IN (SELECT MGR_ID FROM EMPLOYEE)THEN '관리자'
            ELSE '직원' END AS 구분
FROM    EMPLOYEE

-- 다중 열 서브쿼리
SELECT  EMP_NAME,
        JOB_TITLE,
        SALARY
FROM    EMPLOYEE 
JOIN    JOB USING(JOB_ID)
WHERE   (JOB_ID, SALARY) IN (   SELECT  JOB_ID, TRUNC(AVG(SALARY), -5)
                                FROM    EMPLOYEE 
                                GROUP BY JOB_ID) ;

SELECT  E.EMP_NAME,
        J.JOB_TITLE,
        E.SALARY,
        V.JOBAVG
FROM    (   SELECT  JOB_ID,
            TRUNC(AVG(SALARY),-5) AS JOBAVG
            FROM    EMPLOYEE
            GROUP BY JOB_ID ) V
JOIN    EMPLOYEE E ON (V.JOB_ID = E.JOB_ID AND E.SALARY = V.JOBAVG)
JOIN    JOB J ON(E.JOB_ID = J.JOB_ID)

SELECT  EMP_NAME,
        JOB_TITLE,
        SALARY
FROM    EMPLOYEE E
JOIN    JOB J ON (E.JOB_ID = J.JOB_ID)
WHERE   SALARY = (  SELECT  TRUNC(AVG(SALARY),-5) JOBAVG
                    FROM    EMPLOYEE S
                    WHERE   E.JOB_ID = S.JOB_ID
                    );


SELECT  EMP_ID,
        EMP_NAME,
        '관리자' 구분
FROM    EMPLOYEE
WHERE   EMP_ID IN(  SELECT  DISTINCT MGR_ID
                    FROM    EMPLOYEE
                    WHERE   MGR_ID IS NOT NULL)
UNION
SELECT  EMP_ID,
        EMP_NAME,
        '직원' 구분
FROM    EMPLOYEE
WHERE   EMP_ID NOT IN ( SELECT  DISTINCT MGR_ID
                        FROM    EMPLOYEE
                        WHERE   MGR_ID IS NOT NULL);
                    
SELECT  EMP_ID,
        EMP_NAME,
        '관리자' 구분
FROM    EMPLOYEE E
WHERE   EXISTS ( SELECT -1
                 FROM    EMPLOYEE 
                 WHERE   E.EMP_ID = MGR_ID)
UNION
SELECT  EMP_ID,
        EMP_NAME,
        '사원' 구분
FROM    EMPLOYEE E
WHERE   NOT EXISTS  (   SELECT -1
                        FROM    EMPLOYEE
                        WHERE   E.EMP_ID = MGR_ID);
                        