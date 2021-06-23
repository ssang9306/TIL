-- ROUND �ݿø�
SELECT  ROUND(125.315)
FROM    DUAL;
SELECT  ROUND(126.349,1)
FROM    DUAL;
SELECT  ROUND(125.315,-1)
FROM    DUAL;
SELECT  ROUND(-125.315,2)
FROM    DUAL;
-- DATE TYPE, ���� ���������� ���ڿ��� �ַ� ���(Y2K PROBLEM ����)
SELECT  SYSDATE
FROM    DUAL;
-- ADD MONTHS, SYSDATE, MONTHS_BETWEEN
SELECT  HIRE_DATE,
        ADD_MONTHS(HIRE_DATE, 120) AS "�Ի� �� 10��"
FROM    EMPLOYEE;
-- ��� ���̺��� �ټӿ������ 20�� �̻��� ����� ������ ��ȸ
-- MONTHS_BETWEEN�� �� ������ ���̸� ����Ѵ�. (������ RETURN)
SELECT  HIRE_DATE,
        TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12 ) AS �ټӳ�� 
FROM    EMPLOYEE
WHERE   MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;
-- DATE TO CHAR
-- PM�� AM�� �ƹ��ų� �Է��ص� ����ð��� ���� ǥ�õȴ�.
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') 
FROM    DUAL;

SELECT  TO_CHAR(SYSDATE, 'MON DY, YYYY')
FROM    DUAL;
-- fM�� 0�� ������ ex) fr01 -> 1
SELECT  TO_CHAR(SYSDATE, 'YYYY-fMMM-DD DAY')
FROM    DUAL;
SELECT  TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY')
FROM    DUAL;

SELECT  TO_CHAR(SYSDATE, 'YEAR, Q')
FROM    DUAL;
-- �� ��ȯ �� ���ϴ� ���Ŀ� ���缭 ǥ���ϱ� ""���
SELECT  EMP_NAME,
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') AS "ǥ��1",
        TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"') AS "ǥ��2"
FROM    EMPLOYEE;
-- ������ �� ��ȯ����, DATE TYPE�� �ð��� �߰��Ǿ� �ִٸ� ���������� �˻� �Ұ�
-- �ð��� ����Ǿ����� �ʴٸ� 'YY/MM/DD/'�� ���� �˻� ����
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
-- �̰��� �˻����ֱ� ���ؼ� HIRE_DATE�� ���ϴ� ���·� ��ȯ
SELECT  EMP_NAME,
        HIRE_DATE
FROM    EMPLOYEE
WHERE   TO_CHAR(HIRE_DATE, 'YYMMDD') = '900401';
-- YY�� ���� ���⿡ ����� ���� 98�� ���� �⵵�� �Է��ϸ�, 2098������ �Էµȴ�. ->RR����
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
-- RR����(���� ���߱�) 
SELECT  SYSDATE AS ����,
        '95/10/27' �Է�,
        TO_CHAR(TO_DATE('95/10/27','YY/MM/DD'),'YYYY/MM/DD') AS YY����1,
        TO_CHAR(TO_DATE('95/10/27','YY/MM/DD'),'RRRR/MM/DD') AS YY����2,
        TO_CHAR(TO_DATE('95/10/27','RR/MM/DD'),'YYYY/MM/DD') AS RR����1,
        TO_CHAR(TO_DATE('95/10/27','RR/MM/DD'),'RRRR/MM/DD') AS RR����2
FROM    DUAL;
-- ORACLE���� ���ڿ��� ���ϸ� ������ ����ȯ���� ���� �������� ���ѰͰ� ����.
SELECT  EMP_NO,
        SUBSTR(EMP_NO,1,6) + SUBSTR(EMP_NO,8,7)
FROM    EMPLOYEE;
-- NVL �Լ�
SELECT  EMP_NAME, SALARY, BONUS_PCT, NVL(BONUS_PCT,0)
FROM    EMPLOYEE
WHERE   SALARY > 3500000;

SELECT  EMP_NAME,
        (SALARY *12) + ( (SALARY * 12)*BONUS_PCT ),
        (SALARY *12) + ( (SALARY * 12)* NVL(BONUS_PCT,0) )
FROM    EMPLOYEE
WHERE   SALARY > 3500000;
-- ���ǿ� ���� ���� ������ ���� �Լ� DECODE
SELECT  EMP_NAME,
        EMP_NO,
        DECODE(SUBSTR(EMP_NO,8,1), '1','��','��') ����
FROM    EMPLOYEE;

SELECT  EMP_ID, EMP_NAME,
        DECODE(MGR_ID, NULL, '����',MGR_ID) ������
FROM    EMPLOYEE
WHERE   JOB_ID = 'J4';
SELECT  EMP_ID, EMP_NAME,
        DECODE(MGR_ID, NULL, '����',MGR_ID)
FROM    EMPLOYEE;

SELECT  EMP_ID, EMP_NAME,
        NVL(MGR_ID, '����') ������
FROM    EMPLOYEE
WHERE   JOB_ID = 'J4';

-- ��� ���̺��� ����� ���޿� ���� �λ�޿� ��ȸ
-- J1 : 10% , J2 : 20% �λ�� ����� �̸�, ����, �λ�޿��� ��ȸ
SELECT  EMP_NAME �����,
        JOB_ID ����,
        SALARY �����޿�,
        DECODE(JOB_ID, 'J1', (SALARY * 1.1), 
                       'J2', (SALARY * 1.2),SALARY) AS �λ�޿�
FROM    EMPLOYEE
WHERE   JOB_ID IN ('J1','J2');
-- ANSI ǥ�� CASE 
SELECT  EMP_NAME �����,
        JOB_ID  ����,
        SALARY �����޿�,
        CASE JOB_ID WHEN 'J1' THEN (SALARY * 1.1)
                    WHEN 'J2' THEN (SALARY * 1.2)
                    ELSE SALARY END AS �λ�޿�
FROM    EMPLOYEE;

SELECT  EMP_NAME �����,
        JOB_ID  ����,
        SALARY �����޿�,
        CASE  WHEN JOB_ID = 'J1' THEN (SALARY * 1.1)
              WHEN JOB_ID = 'J2' THEN (SALARY * 1.2)
              ELSE SALARY 
        END AS �λ�޿�
FROM    EMPLOYEE;

-- CASE EX2 -- 
-- ������̺��� �޿������� ������ �޿������ ��ȸ�Ϸ��� �Ѵ�.
-- �޿��� 300���� ���ϸ� C, 400���� B, 400���� �ʰ��� A ���, ����� �̸�, �޿�, �޿������ ���
SELECT  EMP_NAME �����,
        SALARY   �޿�,
        CASE WHEN SALARY <= 3000000 THEN 'C'
             WHEN SALARY BETWEEN 3000001 AND 4000000 THEN 'B'
-- THEN�� RETURN�̶�� �����ϸ� �Լ��� �����.
             ELSE 'A' 
             END AS �޿����
FROM    EMPLOYEE;

-- ������̺��� ������ �̸�, �̸���, �̸��� ���̵� ��ȸ�Ѵٸ�?
SELECT  EMP_NAME ������,
        EMAIL �̸���,
        SUBSTR(EMAIL, 1,INSTR(EMAIL,'@')-1) ���̵�
FROM    EMPLOYEE;

-- ORDER BY (�÷���|�ε���|��Ī) [ASC |DESC ],[(�÷���|�ε���|��Ī) [ASC |DESC ]]
-- ORDER BY�� ������ �� ��������, �ѹ���
SELECT  EMP_NAME �����,
        SALARY   �޿�,
        CASE WHEN SALARY <= 3000000 THEN 'C'
             WHEN SALARY BETWEEN 3000001 AND 4000000 THEN 'B'
-- THEN�� RETURN�̶�� �����ϸ� �Լ��� �����.
             ELSE 'A' 
             END AS �޿����
FROM    EMPLOYEE
ORDER BY �޿���� ASC, SALARY DESC;

-- �׷��Լ�: ������ ���� �Է¿� ���� �ϳ��� �� ��ȯ
SELECT  SUM(SALARY), SUM(DISTINCT SALARY)
FROM    EMPLOYEE
WHERE   DEPT_ID = '50'
OR      DEPT_ID IS NULL;
-- SELECT ���� �����Լ��� ���ȴٸ�, �ϹݼӼ��� ���� �� �� ����.
-- �Ѱ��� ��ȯ�� ��, ���� ������ ���� ��ġ���� �ʱ� ����

SELECT  COUNT(BONUS_PCT)
FROM    EMPLOYEE;
