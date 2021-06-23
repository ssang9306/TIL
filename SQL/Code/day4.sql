-- GROUP BY
-- GROUP BY COLUMN NAME | EXPR --> �ֹι�ȣ�� �̿��ؼ� ������ ���� �ϴ� �� ����
-- GROUP BY�� ���Ǹ� SELECT ���� �ϹݼӼ� ���Ұ�, 
-- GROUP BY�� ���� �÷��� ��� ���� (�÷� �̸��� ��� ����)

-- ������ ���� ��� �ӱ�
SELECT  CASE SUBSTR(EMP_NO,8,1) WHEN '1' THEN '��' ELSE '��' END AS ����,
        ROUND(AVG(SALARY),4)
FROM    EMPLOYEE
GROUP BY ROLLUP(CASE SUBSTR(EMP_NO,8,1)WHEN '1' THEN '��' ELSE '��' END);

-- ROLLUP�� ù��° �÷��� �������� �߰��߰� �Ұ谡 ���´�(COMPOSIT�� ���)

SELECT      DEPT_ID,
            EMP_NAME,
            COUNT(*)
FROM        EMPLOYEE
GROUP BY    ROLLUP(DEPT_ID, EMP_NAME)
ORDER BY    1;

SELECT      SUBSTR(TERM_NO, 1, 4) �⵵,
            SUBSTR(TERM_NO, 5, 2) �б�,
            ROUND(AVG(POINT),1) ����
FROM        TB_GRADE
WHERE       STUDENT_NO = 'A112113'
GROUP BY    ROLLUP( SUBSTR(TERM_NO,1,4), SUBSTR(TERM_NO,5,2) );

SELECT      DEPT_ID, SUM(SALARY)
FROM        EMPLOYEE
GROUP BY    DEPT_ID
HAVING      SUM(SALARY) > 9000000;

-- 1. WHERE���� GROUP �Լ��� ����� �� ����.
SELECT      DEPT_ID, SUM(SALARY)
FROM        EMPLOYEE
WHERE       SUM(SALARY) > 9000000
GROUP BY    DEPT_ID;

-- �м��Լ�() OVER(PARTITION BY, ORDER BY), 
-- ���ڵ��� ��ȯ ���� ��谪 Ȯ��
-- ROW_NUMBER() : ORDERBY�� PARTITION�� ��õ��� ���� ���� ����


-- RANK(), DENSE_RANK()
SELECT  DEPT_ID,
        EMP_NAME,
        SALARY,
        DENSE_RANK() OVER(PARTITION BY DEPT_ID ORDER BY SALARY DESC) "RANK"
FROM    EMPLOYEE;

-- ���� Ȯ�� CUME_DIST ����� ���� ����
-- ������� PERCENT_RANK() ����� ����


SELECT  *
FROM    SAL_GRADE;

SELECT *
FROM   DEPARTMENT;

SELECT  EMP_NAME,
        DEPT_NAME
FROM    EMPLOYEE E, DEPARTMENT D
WHERE   E.DEPT_ID = D.DEPT_ID;
-- ANSI ǥ�� USING, ON 
-- ON�� ���� ���� ��� ����, USING�� �÷��� ��� ���� 
-- USING: �θ��� �⺻Ű�� �ڽ��� �ܺ�Ű�� ������ ���

SELECT  EMP_NAME,
        DEPT_NAME
FROM    EMPLOYEE E
JOIN    DEPARTMENT D USING(DEPT_ID);

SELECT  EMP_NAME,
        DEPT_NAME,
        LOC_DESCRIBE,
        COUNTRY_NAME
FROM    EMPLOYEE E 
JOIN    DEPARTMENT D USING(DEPT_ID)
JOIN    LOCATION L ON (L.LOCATION_ID = D.LOC_ID)
JOIN    COUNTRY C USING(COUNTRY_ID);

-- ORACLE�� JOIN������ ����ϸ�, SELECT ������ ��Ī�� ��þ��ϸ� ��ȣ�� ���� �߻�
-- USING������ ��Ī�� ������� �ʰ�, SELECT�������� ��Ī�� ������� �ʾƵ� �ȴ�.

SELECT  EMP_NAME,
-- ORACLE JOIN�� ����Ұ��, ��ĪX -> ��ȣ�� ���� �߻�
        DEPT_ID
        DEPT_NAME
FROM    EMPLOYEE E, DEPARTMENT D
WHERE   E.DEPT_ID = D.DEPT_ID ;

SELECT  EMP_NAME,
        DEPT_NAME,
        DEPT_ID
-- ANSIǥ�� JOIN�� ���� ��Ī�� ������� �ʾƵ� �����ϴ�.
FROM    EMPLOYEE E
JOIN    DEPARTMENT D USING(DEPT_ID);

/* OUTER JOIN 
������ �����ͱ��� ����! 
LEFT | RIGHT | FULL  JOIN ~ ON(���ǽ�)
LEFT | RIGHT | FULL  JOIN ~ USING(�����÷�)
*/

SELECT  EMP_NAME,
        DEPT_NAME
FROM    EMPLOYEE E
FULL JOIN DEPARTMENT D USING (DEPT_ID);

-- SELF RECURSIVE JOIN
SELECT  E.EMP_NAME,
        M.EMP_NAME
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON(E.MGR_ID = M.EMP_ID);

SELECT  E.EMP_NAME,
        M.EMP_NAME
FROM EMPLOYEE E
JOIN EMPLOYEE M ON(E.MGR_ID = M.EMP_ID);

-- ���� �޿������ �˾ƺ����� �Ѵ�.
-- SAL_GRADE ���̺��� ���� �̸�, �޿�, �޿���� (SLEVEL)

-- ORACLE
SELECT  EMP_NAME �����,
        SALARY  �޿�,
        SLEVEL �޿����
FROM    EMPLOYEE E, SAL_GRADE SG
WHERE   E.SALARY BETWEEN SG.LOWEST AND HIGHEST;

-- ANSIǥ��
SELECT  EMP_NAME �����,
        SALARY  �޿�,
        SLEVEL �޿����
FROM    EMPLOYEE E
JOIN    SAL_GRADE SG ON (E.SALARY BETWEEN SG.LOWEST AND SG.HIGHEST);

-- ������ ���� ����
SELECT  E.EMP_NAME �����,
        J.JOB_TITLE ����,
        D.DEPT_NAME �μ�,
        L.LOC_DESCRIBE ����,
        C.COUNTRY_NAME ����,
        SG.SLEVEL �޿����
FROM    EMPLOYEE E
LEFT JOIN    JOB J USING(JOB_ID)
LEFT JOIN    DEPARTMENT D USING(DEPT_ID)
LEFT JOIN    LOCATION L ON(D.LOC_ID = L.LOCATION_ID)
LEFT JOIN    COUNTRY C USING(COUNTRY_ID)
LEFT JOIN    SAL_GRADE SG ON (E.SALARY BETWEEN SG.LOWEST AND SG.HIGHEST)
ORDER BY    SG.SLEVEL;