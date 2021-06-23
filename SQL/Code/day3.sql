-- ROUND 반올림
SELECT  ROUND(125.315)
FROM    DUAL;
SELECT  ROUND(126.349,1)
FROM    DUAL;
SELECT  ROUND(125.315,-1)
FROM    DUAL;
SELECT  ROUND(-125.315,2)
FROM    DUAL;
-- DATE TYPE, 실제 현업에서는 문자열을 주로 사용(Y2K PROBLEM 때문)
SELECT  SYSDATE
FROM    DUAL;
-- ADD MONTHS, SYSDATE, MONTHS_BETWEEN
SELECT  HIRE_DATE,
        ADD_MONTHS(HIRE_DATE, 120) AS "입사 후 10년"
FROM    EMPLOYEE;
-- 사원 테이블에서 근속연년수가 20년 이상인 사원의 정보를 조회
-- MONTHS_BETWEEN은 두 인자의 차이를 계산한다. (숫자형 RETURN)
SELECT  HIRE_DATE,
        TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12 ) AS 근속년수 
FROM    EMPLOYEE
WHERE   MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;
-- DATE TO CHAR
-- PM과 AM은 아무거나 입력해도 현재시간에 맞춰 표시된다.
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') 
FROM    DUAL;

SELECT  TO_CHAR(SYSDATE, 'MON DY, YYYY')
FROM    DUAL;
-- fM은 0을 제거함 ex) fr01 -> 1
SELECT  TO_CHAR(SYSDATE, 'YYYY-fMMM-DD DAY')
FROM    DUAL;
SELECT  TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY')
FROM    DUAL;

SELECT  TO_CHAR(SYSDATE, 'YEAR, Q')
FROM    DUAL;
-- 형 변환 후 원하는 형식에 맞춰서 표현하기 ""사용
SELECT  EMP_NAME,
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') AS "표현1",
        TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') AS "표현2"
FROM    EMPLOYEE;
-- 묵시적 형 변환에서, DATE TYPE에 시간이 추가되어 있다면 문자형으로 검색 불가
-- 시간이 저장되어있지 않다면 'YY/MM/DD/'를 통해 검색 가능
SELECT  EMP_NAME,
        HIRE_DATE,
        TO_cHAR(HIRE_DATE, 'YYYY/MM/DD HH24:MI:SS')
FROM    EMPLOYEE
WHERE   JOB_ID IN('J1','J2');

SELECT  EMP_NAME
FROM    EMPLOYEE
WHERE   HIRE_DATE = '04/04/30';
SELECT  EMP_NAME
FROM    EMPLOYEE
WHERE   HIRE_DATE = '90/04/01';
-- 이것을 검색해주기 위해서 HIRE_DATE를 원하는 형태로 변환
SELECT  EMP_NAME,
        HIRE_DATE
FROM    EMPLOYEE
WHERE   TO_CHAR(HIRE_DATE, 'YYMMDD') = '900401';
-- YY는 현재 세기에 맞춘다 따라서 98과 같이 년도를 입력하면, 2098년으로 입력된다. ->RR형식
SELECT  TO_CHAR(TO_DATE('980630','YYMMDD'),
        'YYYY.MM.DD')
FROM    DUAL;

SELECT  TO_DATE('980630','YYMMDD')
FROM    DUAL;

SELECT  TO_CHAR(TO_DATE('041030 143000', 'YYMMDD HH24MISS'),
        'DD-MON-YY HH:MI:SS PM')
FROM    DUAL;

SELECT  TO_CHAR('20100101', 'YYYY, MON')
FROM    DUAL;

SELECT  TO_DATE('20100101','YYYYMMDD')
FROM    DUAL;
-- RR형식(세기 맞추기) 
SELECT  SYSDATE AS 현재,
        '95/10/27' 입력,
        TO_CHAR(TO_DATE('95/10/27','YY/MM/DD'),'YYYY/MM/DD') AS YY형식1,
        TO_CHAR(TO_DATE('95/10/27','YY/MM/DD'),'RRRR/MM/DD') AS YY형식2,
        TO_CHAR(TO_DATE('95/10/27','RR/MM/DD'),'YYYY/MM/DD') AS RR형식1,
        TO_CHAR(TO_DATE('95/10/27','RR/MM/DD'),'RRRR/MM/DD') AS RR형식2
FROM    DUAL;
-- ORACLE에서 문자열을 더하면 묵지적 형변환으로 인해 숫자형을 더한것과 같다.
SELECT  EMP_NO,
        SUBSTR(EMP_NO,1,6) + SUBSTR(EMP_NO,8,7)
FROM    EMPLOYEE;
-- NVL 함수
SELECT  EMP_NAME, SALARY, BONUS_PCT, NVL(BONUS_PCT,0)
FROM    EMPLOYEE
WHERE   SALARY > 3500000;

SELECT  EMP_NAME,
        (SALARY *12) + ( (SALARY * 12)*BONUS_PCT ),
        (SALARY *12) + ( (SALARY * 12)* NVL(BONUS_PCT,0) )
FROM    EMPLOYEE
WHERE   SALARY > 3500000;
-- 조건에 맞춰 빠른 데이터 대응 함수 DECODE
SELECT  EMP_NAME,
        EMP_NO,
        DECODE(SUBSTR(EMP_NO,8,1), '1','남','여') 성별
FROM    EMPLOYEE;

SELECT  EMP_ID, EMP_NAME,
        DECODE(MGR_ID, NULL, '없음',MGR_ID) 관리자
FROM    EMPLOYEE
WHERE   JOB_ID = 'J4';
SELECT  EMP_ID, EMP_NAME,
        DECODE(MGR_ID, NULL, '없음',MGR_ID)
FROM    EMPLOYEE;

SELECT  EMP_ID, EMP_NAME,
        NVL(MGR_ID, '없음') 관리자
FROM    EMPLOYEE
WHERE   JOB_ID = 'J4';

-- 사원 테이블에서 사원의 직급에 따른 인상급여 조회
-- J1 : 10% , J2 : 20% 인상된 사원의 이름, 직급, 인상급여를 조회
SELECT  EMP_NAME 사원명,
        JOB_ID 직급,
        SALARY 기존급여,
        DECODE(JOB_ID, 'J1', (SALARY * 1.1), 
                       'J2', (SALARY * 1.2),SALARY) AS 인상급여
FROM    EMPLOYEE
WHERE   JOB_ID IN ('J1','J2');
-- ANSI 표준 CASE 
SELECT  EMP_NAME 사원명,
        JOB_ID  직급,
        SALARY 기존급여,
        CASE JOB_ID WHEN 'J1' THEN (SALARY * 1.1)
                    WHEN 'J2' THEN (SALARY * 1.2)
                    ELSE SALARY END AS 인상급여
FROM    EMPLOYEE;

SELECT  EMP_NAME 사원명,
        JOB_ID  직급,
        SALARY 기존급여,
        CASE  WHEN JOB_ID = 'J1' THEN (SALARY * 1.1)
              WHEN JOB_ID = 'J2' THEN (SALARY * 1.2)
              ELSE SALARY 
        END AS 인상급여
FROM    EMPLOYEE;

-- CASE EX2 -- 
-- 사원테이블에서 급여정보를 가지고 급여등급을 조회하려고 한다.
-- 급여가 300만원 이하면 C, 400이하 B, 400만원 초과면 A 등급, 사원의 이름, 급여, 급여등급을 출력
SELECT  EMP_NAME 사원명,
        SALARY   급여,
        CASE WHEN SALARY <= 3000000 THEN 'C'
             WHEN SALARY BETWEEN 3000001 AND 4000000 THEN 'B'
-- THEN을 RETURN이라고 생각하면 함수가 종료됨.
             ELSE 'A' 
             END AS 급여등급
FROM    EMPLOYEE;

-- 사원테이블에서 직원의 이름, 이메일, 이메일 아이디를 조회한다면?
SELECT  EMP_NAME 직원명,
        EMAIL 이메일,
        SUBSTR(EMAIL, 1,INSTR(EMAIL,'@')-1) 아이디
FROM    EMPLOYEE;

-- ORDER BY (컬럼명|인덱스|별칭) [ASC |DESC ],[(컬럼명|인덱스|별칭) [ASC |DESC ]]
-- ORDER BY는 문장의 맨 마지막에, 한번만
SELECT  EMP_NAME 사원명,
        SALARY   급여,
        CASE WHEN SALARY <= 3000000 THEN 'C'
             WHEN SALARY BETWEEN 3000001 AND 4000000 THEN 'B'
-- THEN을 RETURN이라고 생각하면 함수가 종료됨.
             ELSE 'A' 
             END AS 급여등급
FROM    EMPLOYEE
ORDER BY 급여등급 ASC, SALARY DESC;

-- 그룹함수: 여러개 행의 입력에 대해 하나의 행 반환
SELECT  SUM(SALARY), SUM(DISTINCT SALARY)
FROM    EMPLOYEE
WHERE   DEPT_ID = '50'
OR      DEPT_ID IS NULL;
-- SELECT 절에 집계함수가 사용된다면, 일반속성은 정의 될 수 없다.
-- 한개의 반환된 행, 여러 개수의 행이 일치되지 않기 때문

SELECT  COUNT(BONUS_PCT)
FROM    EMPLOYEE;
