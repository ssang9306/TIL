/*
1. �� ������б��� �а� �̸��� �迭�� ǥ���Ͻÿ�. ��, ��� ����� "�а� ��", "�迭" ���� ǥ���ϵ��� �Ѵ�.
*/
SELECT DEPARTMENT_NAME "�а� ��", CATEGORY �迭
FROM TB_DEPARTMENT;

/*
2. �а��� �а� ������ ������ ���� ���·� ȭ�鿡 ����Ѵ�.
*/
SELECT DEPARTMENT_NAME||'�� ������ '||CAPACITY||'�� �Դϴ�.'
FROM TB_DEPARTMENT;

/*
3. "������а�" �� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û�� ���Դ�. �����ΰ�? 
(�����а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã�� ������ ����)
*/
SELECT S.STUDENT_NAME
FROM TB_STUDENT S, TB_DEPARTMENT D
WHERE D.DEPARTMENT_NAME = '������а�'
AND D.DEPARTMENT_NO = S.DEPARTMENT_NO
AND S.ABSENCE_YN = 'Y' 
AND STUDENT_SSN LIKE '______-2%';

/*
4. ���������� ���� ���� ��� ��ü�� ���� ã�� �̸��� �Խ��ϰ��� �Ѵ�.
�� ����ڵ��� �й��� ������ ���� �� ����ڵ��� ã�� ������ SQL ������ �ۼ��Ͻÿ�.
*/
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119');
/*
5. ���������� 20�� �̻� 30�� ������ �а����� �а� �̸��� �迭�� ����Ͻÿ�.
*/
SELECT  DEPARTMENT_NAME, CATEGORY
FROM    TB_DEPARTMENT
WHERE   CAPACITY BETWEEN 20 AND 30 ;

/*
6. �� ������б��� ������ �����ϰ� ��� �������� �Ҽ� �а��� ������ �ִ�. 
�׷� �� ������б� ������ �̸��� �˾Ƴ� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT  PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;
/*
7. Ȥ�� ������� ������ �а��� �����Ǿ� ���� ���� �л��� �ִ��� Ȯ���ϰ��� �Ѵ�. 
��� SQL ������ ����ϸ� �� ������ �ۼ��Ͻÿ�.
*/
SELECT  STUDENT_NAME
FROM    TB_STUDENT
WHERE   DEPARTMENT_NO IS NULL ;
/*
8. ������û�� �Ϸ��� ����. �������� ���θ� Ȯ���ؾ� �ϴµ�, 
���������� �����ϴ� ������� � �������� �����ȣ�� ��ȸ�غ��ÿ�.
*/
SELECT  CLASS_NO
FROM    TB_CLASS
WHERE   PREATTENDING_CLASS_NO IS NOT NULL;
/*
9. �� ���п��� � �迭(CATEGORY)���� �ִ��� ��ȸ�غ��ÿ�.
*/
SELECT DISTINCT CATEGORY
FROM    TB_DEPARTMENT;
/*
10. 02�й� ���� �����ڵ��� ������ ������� ����. 
������ ������� ������ �������� �л����� �й�, �̸�, �ֹι�ȣ�� ����ϴ� ������ �ۼ��Ͻÿ�.
*/
SELECT  STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM    TB_STUDENT
WHERE   ABSENCE_YN = 'N'
AND     STUDENT_ADDRESS LIKE '���ֽ�%'
AND     TO_CHAR(ENTRANCE_DATE,'YYMMDD') BETWEEN '020101' AND '021231';
-- FUNCTION �Լ�
/*
1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� 
���� �⵵�� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
( ��, ����� "�й�", "�̸�", "���г⵵" �� ǥ�õǵ��� �Ѵ�.)
*/
SELECT  STUDENT_NO �й�,
        STUDENT_NAME �̸�,
        TO_CHAR(ENTRANCE_DATE,'YYYY-MM-DD') ���г⵵
FROM    TB_STUDENT
WHERE   DEPARTMENT_NO = '002'
ORDER BY ENTRANCE_DATE;
/*
2. �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� �Ѵ�.
�� ������ �̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����.
(* �̶� �ùٸ��� �ۼ��� SQL ������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)
*/
SELECT  PROFESSOR_NAME,
        PROFESSOR_SSN
FROM    TB_PROFESSOR
WHERE   PROFESSOR_NAME NOT LIKE '___';
/*
3. �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�. 
�� �̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�. 
(��, ���� �� 2000�� ���� ����ڴ� ������ ��� ����� "�����̸�", "����"�� �Ѵ�. 
���̴� ���������� �������.)
*/
-- TO DATE�� RRRR���� ����, �ٽ� TO_CHAR������ RRRR���� ���� �ʿ�
SELECT  PROFESSOR_NAME �����̸�,
        TO_NUMBER(TO_CHAR(SYSDATE, 'YY')) + 
        (100 - TO_NUMBER(TO_CHAR(TO_DATE(SUBSTR(PROFESSOR_SSN,1,2),'YY'),'YY')))
        AS ����
FROM    TB_PROFESSOR
WHERE   SUBSTR(PROFESSOR_SSN,8,1) = '1'
ORDER BY 2
/*
4. �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. 
��� ����� ?'�̸�? �� �������� �Ѵ�. (���� 2���� ���� ������ ���ٰ� �����Ͻÿ�)
*/
SELECT  SUBSTR(PROFESSOR_NAME,2,LENGTH(PROFESSOR_NAME)) �̸�
FROM    TB_PROFESSOR;
/*
5. �� ������б��� ����� �����ڸ� ���Ϸ��� �Ѵ�. ��� ã�Ƴ� ���ΰ�? 
�̶�, 19�쿡 �����ϸ� ����� ���� ���� ������ �����Ѵ�.
*/
SELECT  STUDENT_NO, STUDENT_NAME
FROM    TB_STUDENT
WHERE   TO_CHAR(ENTRANCE_DATE, 'RRRR') -
        TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN,1,2),'RRRR'),'RRRR') > 19;
/*
6. 2020�� ũ���������� ���� �����ΰ�?
*/
SELECT  '2020�� ũ���������� ' || 
        TO_CHAR(TO_DATE('201225','RRMMDD'),'DAY')|| ' �Դϴ�.'
FROM    DUAL;
/*
TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') 
�� ���� �� �� �� �� �� ���� �ǹ��ұ�?
�� TO_DATE('99/10/11','RR/MM/DD'), TO_DATE('49/10/11','RR/MM/DD') 
�� ���� �� �� �� �� �� ���� �ǹ��ұ�?
*/
SELECT  TO_CHAR(TO_DATE('99/10/11','YY/MM/DD'),'YYYY "��" MM "��" DD"��"') AS "99YY",
        TO_CHAR(TO_DATE('49/10/11','YY/MM/DD'),'YYYY "��" MM "��" DD"��"') AS "49YY",
        TO_CHAR(TO_DATE('99/10/11','RR/MM/DD'), 'YYYY "��" MM "��" DD"��"')AS "99RR",
        TO_CHAR(TO_DATE('49/10/11','RR/MM/DD'), 'YYYY "��" MM "��" DD "��"') AS "49RR"
FROM    DUAL;
/*
8. �� ������б��� 2000�⵵ ���� �����ڵ��� �й��� A�� �����ϰ� �Ǿ��ִ�. 
2000�⵵ ���� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT  STUDENT_NO, STUDENT_NAME
FROM    TB_STUDENT
WHERE   TO_CHAR(ENTRANCE_DATE,'RRRR') < '2000';
/*
9. �й��� A517178 �� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. 
��, �̶� ��� ȭ���� ����� "����" �̶�� ������ �ϰ�, 
������ �ݿø��Ͽ� �Ҽ��� ���� �� �ڸ������� ǥ���Ѵ�.
*/
SELECT  ROUND((SUM(POINT)/COUNT(*)),1) ����
FROM    TB_GRADE
WHERE   STUDENT_NO = 'A517178'
/*
10. �а��� �л����� ���Ͽ� "�а���ȣ", "�л���(��)" �� 
���·� ����� ����� ������� ��µǵ��� �Ͻÿ�.
*/
SELECT DEPARTMENT_NO �а���ȣ,
        COUNT(*) AS "�л���(��)"
FROM    TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1
/*
11. ���� ������ �������� ���� �л��� ���� 
�� �� ���� �Ǵ� �˾Ƴ��� SQL ���� �ۼ��Ͻÿ�.
*/
SELECT  COUNT(*)
FROM    TB_STUDENT
WHERE   COACH_PROFESSOR_NO IS NULL;
/*
12. �й��� A112113�� ���� �л��� �⵵ �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�.
��, �̶� ��� ȭ���� ����� "�⵵", "�⵵ �� ����" �̶�� ������ �ϰ�, 
������ �ݿø��Ͽ� �Ҽ��� ���� �� �ڸ������� ǥ���Ѵ�.
*/
SELECT SUBSTR(TERM_NO,1,4) �⵵,
        ROUND((SUM(POINT)/COUNT(*)),1) "�⵵ �� ����"
FROM TB_GRADE
WHERE   STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY 1;

SELECT  TO_CHAR(TO_DATE(SUBSTR(TERM_NO,1,4),'RRRR'),'RRRR') �⵵,
        ROUND((SUM(POINT)/2),1) "�⵵ �� ����"
FROM    TB_GRADE
WHERE   STUDENT_NO = 'A112113'
GROUP BY TO_CHAR(TO_DATE(SUBSTR(TERM_NO,1,4),'RRRR'),'RRRR')
ORDER BY 1;
/*
13. �а� �� ���л� ���� �ľ��ϰ��� �Ѵ�.
�а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT  DEPARTMENT_NO �а��ڵ��,
        COUNT(CASE WHEN ABSENCE_YN = 'Y' THEN 1 
                    ELSE NULL END) as "���л� ��"
FROM    TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;
/*
14. �� ���б��� �ٴϴ� ��������(��٣���) �л����� �̸��� ã���� �Ѵ�. 
� SQL ������ ����ϸ� �����ϰڴ°�?
*/
SELECT  STUDENT_NAME �����̸�,
        COUNT(*) "������ ��"
FROM    TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1;
/*
15. �й��� A112113 �� ���� �л��� �⵵, �б� �� ������ �⵵ �� ���� ���� ,
�� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1�ڸ������� �ݿø��Ͽ� ǥ���Ѵ�.)
*/
SELECT  SUBSTR(TERM_NO,1,4) �⵵,
        NVL(SUBSTR(TERM_NO,5,2),' ') �б�,
        ROUND(SUM(POINT)/COUNT(*),1) ����
FROM    TB_GRADE
WHERE   STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO,1,4),SUBSTR(TERM_NO,5,2));
--JOIN ����
/*
1. �л��̸��� �ּ����� ǥ���Ͻÿ�. 
��, ��� ����� "�л� �̸�", "�ּ���"�� �ϰ�, ������ �̸����� �������� ǥ���ϵ��� �Ѵ�.
*/
SELECT  STUDENT_NAME "�л� �̸�",
        STUDENT_ADDRESS �ּ���
FROM    TB_STUDENT
ORDER BY 1;
/*
2. �������� �л����� �̸��� �ֹι�ȣ�� ���̰� ���� ������ ȭ�鿡 ����Ͻÿ�.
*/
SELECT  STUDENT_NAME,
        STUDENT_SSN
FROM    TB_STUDENT
WHERE   ABSENCE_YN = 'Y'
ORDER BY SUBSTR(STUDENT_SSN,1,6) DESC;
/*3. �ּ����� �������� ��⵵�� �л��� �� 
1900��� �й��� ���� �л����� �̸��� �й�, �ּҸ� �̸��� ������������ ȭ�鿡 ����Ͻÿ�. 
��, ���������� "�л��̸�","�й�", "������ �ּ�" �� ��µǵ��� �Ѵ�.
*/
SELECT  STUDENT_NAME �л��̸�,
        STUDENT_NO  �й�,
        STUDENT_ADDRESS "������ �ּ�"
FROM    TB_STUDENT
WHERE   (STUDENT_ADDRESS LIKE '����%'
OR       STUDENT_ADDRESS LIKE '���%')
AND     SUBSTR(TO_CHAR(ENTRANCE_DATE,'RRRR'),1,3) = '199'
ORDER BY 1;
/*
4. ���� ���а� ���� �� ���� ���̰� ���� ������� �̸��� Ȯ���� �� �ִ� SQL ������ �ۼ��Ͻÿ�. 
(���а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã�� ������ ����)
*/
SELECT  P.PROFESSOR_NAME,
        P.PROFESSOR_SSN
FROM    TB_DEPARTMENT D
JOIN    TB_PROFESSOR P USING(DEPARTMENT_NO)
WHERE   D.DEPARTMENT_NAME = '���а�'
ORDER BY SUBSTR(PROFESSOR_SSN,1,6) ;
/*
5. 2004��2�б⿡ 'C3118100' ������ ������ �л����� ������ ��ȸ�Ϸ��� �Ѵ�. 
������ ���� �л����� ǥ���ϰ�, ������ ������ �й��� ���� �л����� ǥ���ϴ� ������ �ۼ��غ��ÿ�.
*/
-- �Ҽ��� 0�� ǥ���Ϸ��� TO_CHAR, '99.999'�� 9�� ���ϴ� �ڸ���ŭ ����
SELECT  STUDENT_NO,
        TO_CHAR(G.POINT, '9.99') POINT
FROM    TB_STUDENT S
JOIN    TB_GRADE G USING(STUDENT_NO)
WHERE   CLASS_NO = 'C3118100'
AND     TERM_NO = '200402'
ORDER BY POINT DESC, STUDENT_NO;
/*
6. �л� ��ȣ, �л� �̸�, �а� �̸��� 
�л� �̸����� �������� �����Ͽ� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
*/
SELECT  STUDENT_NO,
        STUDENT_NAME,
        DEPARTMENT_NAME
FROM    TB_DEPARTMENT D
JOIN    TB_STUDENT S USING(DEPARTMENT_NO)
ORDER BY STUDENT_NAME;
/*
7. �� ������б��� ���� �̸��� ������ �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT  CLASS_NAME,
        DEPARTMENT_NAME
FROM    TB_CLASS C
JOIN    TB_DEPARTMENT D USING(DEPARTMENT_NO);
/*
8. ���� ���� �̸��� ã������ �Ѵ�. 
���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
*/
SELECT  CLASS_NAME,
        PROFESSOR_NAME
FROM    TB_CLASS C
JOIN   TB_CLASS_PROFESSOR PC USING(CLASS_NO)
JOIN   TB_PROFESSOR P USING(PROFESSOR_NO);
/*
17
9. 8���� ��� �� ���ι���ȸ�� �迭�� ���� ������ ���� �̸��� ã������ �Ѵ�. 
�̿� �ش��ϴ� ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
*/
SELECT  CLASS_NAME,
        PROFESSOR_NAME
FROM    TB_CLASS C
JOIN    TB_CLASS_PROFESSOR PC USING(CLASS_NO)
JOIN    TB_PROFESSOR P USING(PROFESSOR_NO)
JOIN    TB_DEPARTMENT D ON(D.DEPARTMENT_NO = P.DEPARTMENT_NO)
WHERE   D.CATEGORY = '�ι���ȸ';
/*
10. �������а��� �л����� ������ ���Ϸ��� �Ѵ�.
�����а� �л����� "�й�", "�л� �̸�", "��ü ����"�� ����ϴ� SQL ������ �ۼ��Ͻÿ�. 
(��, ������ �Ҽ��� 1�ڸ������� �ݿø��Ͽ� ǥ������.)
*/
SELECT  STUDENT_NO �й�,
        STUDENT_NAME "�л� �̸�",
        ROUND(SUM(G.POINT)/COUNT(*),1) "��ü ����"
FROM    TB_STUDENT S
JOIN    TB_DEPARTMENT D USING(DEPARTMENT_NO)
JOIN    TB_GRADE G USING(STUDENT_NO)
WHERE   DEPARTMENT_NAME = '�����а�'
GROUP BY STUDENT_NO, STUDENT_NAME
ORDER BY 1;
/*
11. �й��� A313047�� �л��� �б��� ������ ���� �ʴ�. 
���� �������� ������ �����ϱ� ���� �а� �̸�, �л� �̸��� ���� ���� �̸��� �ʿ��ϴ�. 
�̶� ����� SQL ���� �ۼ��Ͻÿ�. 
��, �������� ?�а��̸�?, ?�л��̸�?, ?���������̸�?���� ��µǵ��� ����.
*/
SELECT  DEPARTMENT_NAME �а��̸�,
        STUDENT_NAME �л��̸�,
        PROFESSOR_NAME ���������̸�
FROM    TB_STUDENT S
JOIN    TB_PROFESSOR P ON (P.PROFESSOR_NO = S.COACH_PROFESSOR_NO)
JOIN    TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE   STUDENT_NO = 'A313047';
/*
12. 2007�⵵�� '�ΰ������' ������ ������ �л��� ã�� 
�л��̸��� �����б⸧ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT  STUDENT_NAME,
        TERM_NO "TERM_NAME"
FROM    TB_CLASS C
JOIN    TB_GRADE USING (CLASS_NO)
JOIN    TB_STUDENT USING (STUDENT_NO)
WHERE   CLASS_NAME = '�ΰ������'
AND     SUBSTR(TERM_NO,1,4) = '2007';
/*
13. ��ü�� �迭 ���� �� ���� ��米���� �� �� �������� ���� ������ ã�� 
�� ���� �̸��� �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT  CLASS_NAME,
        DEPARTMENT_NAME
FROM    TB_DEPARTMENT D
JOIN    TB_CLASS C USING(DEPARTMENT_NO)
LEFT JOIN    TB_CLASS_PROFESSOR USING (CLASS_NO)
WHERE   CATEGORY = '��ü��' 
AND     PROFESSOR_NO IS NULL;
/*
14. �� ������б� ���ݾƾ��а� �л����� ���������� �Խ��ϰ��� �Ѵ�. 
�л��̸��� �������� �̸��� ã�� ���� ���� ������ ���� �л��� ��� 
"�������� ������?���� ǥ���ϵ��� �ϴ� SQL ���� �ۼ��Ͻÿ�.
��, �������� ?�л��̸�?, ?��������?�� ǥ���ϸ� ���й� �л��� ���� ǥ�õǵ��� �Ѵ�.
*/
SELECT      S.STUDENT_NAME �л��̸�,
            (CASE WHEN P.PROFESSOR_NAME IS NULL THEN '�������� ������'
                  ELSE P.PROFESSOR_NAME 
                  END) AS ��������
FROM        TB_STUDENT S
LEFT JOIN   TB_PROFESSOR P ON(S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
JOIN        TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE       D.DEPARTMENT_NAME = '���ݾƾ��а�'
ORDER BY    S.ENTRANCE_DATE;
/*
15. ���л��� �ƴ� �л� �� ������ 4.0 �̻��� �л��� ã�� 
�� �л��� �й�, �̸�, �а� �̸�, ������ ����ϴ� SQL ���� �ۼ��Ͻÿ�.
*/
SELECT  S.STUDENT_NO �й�,
        S.STUDENT_NAME �̸�,
        D.DEPARTMENT_NAME �а��̸�,
        G.GRADE ����
FROM    TB_STUDENT S
JOIN    TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
JOIN    (   SELECT      STUDENT_NO, 
                        ROUND((SUM(POINT)/ COUNT(*)),2) GRADE
            FROM        TB_GRADE
            GROUP BY    STUDENT_NO ) G ON(S.STUDENT_NO = G.STUDENT_NO)
WHERE   S.ABSENCE_YN = 'N'
AND     G.GRADE >= 4.0
ORDER BY    1;
/*
16. ȯ�������а� ����������� 
���� �� ������ �ľ��� �� �ִ� SQL ���� �ۼ��Ͻÿ�.*/
SELECT  C.CLASS_NO,
        C.CLASS_NAME,
        G.POINTS
FROM    TB_CLASS C
JOIN    TB_DEPARTMENT D ON (C.DEPARTMENT_NO = D.DEPARTMENT_NO)
JOIN    (SELECT  CLASS_NO,
                 ROUND((SUM(POINT) / COUNT(*)),2) AS POINTS
         FROM    TB_GRADE
        GROUP BY CLASS_NO) G ON (C.CLASS_NO = G.CLASS_NO)
WHERE   D.DEPARTMENT_NAME = 'ȯ�������а�'
AND     C.CLASS_TYPE LIKE '����%'
ORDER BY 1;
/*
17. �� ������б��� �ٴϰ� �ִ� �ְ��� �л��� ���� �� �л����� 
�̸��� �ּҸ� ����ϴ� SQL ���� �ۼ��Ͻÿ�.*/
SELECT  STUDENT_NAME,
        STUDENT_ADDRESS
FROM    TB_STUDENT 
WHERE   DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                         FROM   TB_STUDENT
                         WHERE  STUDENT_NAME = '�ְ���');
/*
18. ������а����� �� ������ ���� ���� �л��� 
�̸��� �й��� ǥ���ϴ� SQL���� �ۼ��Ͻÿ�.*/

 
SELECT  S.STUDENT_NO,
        S.STUDENT_NAME
FROM    TB_DEPARTMENT D
JOIN    TB_STUDENT S ON(D.DEPARTMENT_NO = S.DEPARTMENT_NO)
JOIN    (   SELECT  STUDENT_NO
                    , (SUM(POINT) / COUNT(*)) AS GRADE
            FROM    TB_GRADE
            GROUP BY STUDENT_NO ) G ON(S.STUDENT_NO = G.STUDENT_NO)
WHERE   D.DEPARTMENT_NAME = '������а�'
AND     G.GRADE = 
(SELECT  MAX(G.GRADE)
FROM    TB_DEPARTMENT D
JOIN    TB_STUDENT S ON(D.DEPARTMENT_NO = S.DEPARTMENT_NO)
JOIN    (   SELECT  STUDENT_NO
                    , (SUM(POINT) / COUNT(*)) AS GRADE
            FROM    TB_GRADE
            GROUP BY STUDENT_NO ) G ON(S.STUDENT_NO = G.STUDENT_NO)
WHERE D.DEPARTMENT_NAME = '������а�'
            )




--------------------
/*19. �� ������б��� "ȯ�������а�"�� ���� ���� �迭 �а����� 
�а� �� �������� ������ �ľ��ϱ� ���� ������ SQL ���� ã�Ƴ��ÿ�. 
��, �������� "�迭 �а���", "��������"���� ǥ�õǵ��� �ϰ�, 
������ �Ҽ��� �� �ڸ������� �ݿø��Ͽ� ǥ�õǵ��� �Ѵ�.*/
SELECT  D.DEPARTMENT_NAME "�迭 �а� ��",
        ROUND( (SUM(G.GRADE) / COUNT(*)), 1) ��������
FROM    TB_DEPARTMENT D
JOIN    TB_CLASS C ON(D.DEPARTMENT_NO = C.DEPARTMENT_NO)
JOIN    (   SELECT  CLASS_NO,
                    ROUND( SUM(POINT)/ COUNT(*),1) AS GRADE
            FROM    TB_GRADE
            GROUP BY CLASS_NO) G ON (C.CLASS_NO = G.CLASS_NO)
WHERE   C.CLASS_TYPE LIKE '����%'
AND     D.CATEGORY = (  SELECT  CATEGORY
                        FROM    TB_DEPARTMENT
                        WHERE   DEPARTMENT_NAME = 'ȯ�������а�')
GROUP BY    D.DEPARTMENT_NAME;