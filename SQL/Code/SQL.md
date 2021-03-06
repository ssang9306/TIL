--- #1. PROBLEM


CREATE TABLE MEMBER(
        MEMBER_ID NUMBER(10) PRIMARY KEY,
        NAME VARCHAR2(25) NOT NULL,
        ADDRESS VARCHAR2(100),
        CITY VARCHAR2(30),
        PHONE VARCHAR2(15), 
        JOIN_DATE DATE DEFAULT SYSDATE NOT NULL);
        

CREATE TABLE TITLE(
        TITLE_ID NUMBER(10) PRIMARY KEY,
        TITLE VARCHAR2(60) NOT NULL,
        DESCRIPTION VARCHAR2(400) NOT NULL,
        RATING VARCHAR2(20) CHECK (RATING IN ('18가', '15가' , '12가' ,'전체가')),
        CATEGORY VARCHAR2(20) CHECK (CATEGORY IN ('드라마', '코미디', '액션' ,'아동', 'SF', '다큐멘터리')),
        RELEASE_DATE DATE );
        
        
CREATE TABLE TITLE_COPY(
        COPY_ID NUMBER(10),
        TITLE_ID NUMBER(10),
        STATUS VARCHAR2(20) NOT NULL,
        PRIMARY KEY (COPY_ID, TITLE_ID),
        FOREIGN KEY (TITLE_ID) REFERENCES TITLE(TITLE_ID) );
        
CREATE TABLE RENTAL( 
        BOOK_DATE DATE DEFAULT SYSDATE NOT NULL,
        MEMBER_ID NUMBER(10), 
        COPY_ID NUMBER(10),
        TITLE_ID NUMBER(10),
        ACT_RET_DATE DATE,
        EXP_RET_DATE DATE DEFAULT SYSDATE+2,
        PRIMARY KEY(BOOK_DATE, MEMBER_ID, COPY_ID, TITLE_ID),
        FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID),
        FOREIGN KEY (COPY_ID, TITLE_ID) 
        REFERENCES TITLE_COPY(COPY_ID, TITLE_ID));
        
CREATE TABLE RESERVATION(
        RES_DATE DATE,
        MEMBER_ID NUMBER(10), 
        TITLE_ID NUMBER(10),
        PRIMARY KEY (RES_DATE, MEMBER_ID, TITLE_ID),
        FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID),
        FOREIGN KEY (TITLE_ID) REFERENCES TITLE(TITLE_ID));

--- #2. PROBLEM
   
CREATE SEQUENCE MEMBER_ID_SEQ
INCREMENT BY 1
START WITH 100
NOCACHE
NOCYCLE;
  
CREATE SEQUENCE TITLE_ID_SEQ
INCREMENT BY 1
START WITH 92
NOCACHE
NOCYCLE;
  

--- #3. PROBLEM
  
INSERT INTO TITLE VALUES (TITLE_ID_SEQ.NEXTVAL, '인어공주' ,'인어공주 설명', '전체가', '아동', '95/10/05');
INSERT INTO TITLE VALUES (TITLE_ID_SEQ.NEXTVAL, '매트릭스' ,'매트릭스 설명', '15가', 'SF', '95/05/19');
INSERT INTO TITLE VALUES (TITLE_ID_SEQ.NEXTVAL, '에이리언' ,'에이리언 설명', '18가', 'SF', '95/08/12');
INSERT INTO TITLE VALUES (TITLE_ID_SEQ.NEXTVAL, '모던타임즈' ,'모던타임즈 설명', '전체가', '코미디', '95/07/12');
INSERT INTO TITLE VALUES (TITLE_ID_SEQ.NEXTVAL, '러브스토리' ,'러브스토리 설명', '전체가', '드라마', '95/09/12');
INSERT INTO TITLE VALUES (TITLE_ID_SEQ.NEXTVAL, '람보' ,'람보 설명', '18가', '액션', '95/06/01');
COMMIT;


----
 SELECT * FROM TITLE; ---TITLE_ID, TITLE, DESCRIPTION, RATION, CAGEGORY, RELEASE_DATE 
----
  

--- #4. PROBLEM
  

INSERT INTO MEMBER VALUES (MEMBER_ID_SEQ.NEXTVAL, '김철수', '강남구', '서울', '899-6666', '90/03/08');
INSERT INTO MEMBER VALUES (MEMBER_ID_SEQ.NEXTVAL, '이영희', '서면', '부산', '355-8882', '90/03/08');
INSERT INTO MEMBER VALUES (MEMBER_ID_SEQ.NEXTVAL, '최진국', '동광양', '제주', '852-5764', '91/06/17');
INSERT INTO MEMBER VALUES (MEMBER_ID_SEQ.NEXTVAL, '강준호', '홍제동', '강릉', '559-7777', '90/04/07');
INSERT INTO MEMBER VALUES (MEMBER_ID_SEQ.NEXTVAL, '민병국', '전민동', '대전', '559-8741', '91/01/18');
INSERT INTO MEMBER VALUES (MEMBER_ID_SEQ.NEXTVAL, '오민수', '북구', '광주', '542-9988', '91/01/18');
COMMIT;

----
  SELECT * FROM MEMBER;  -- MEMBER_ID, NAME, ADDRESS, CITY, PHONE, JOIN_DATE 
----

--- #5. PROBLEM
  SELECT * FROM TITLE;  --- TITLE_ID, TITLE, DES , RA~ 
  
  SELECT * FROM TITLE_COPY;  ---COPY_ID, TITLE_ID, STATUS

--- 데이터 입력 
   
INSERT INTO TITLE_COPY VALUES 
 ( 1, (SELECT TITLE_ID FROM TITLE WHERE TITLE = '인어공주'), '대여가능');
 INSERT INTO TITLE_COPY VALUES 
 ( 1, (SELECT TITLE_ID FROM TITLE WHERE TITLE = '매트릭스'), '대여가능');
 INSERT INTO TITLE_COPY VALUES 
 ( 2, (SELECT TITLE_ID FROM TITLE WHERE TITLE = '매트릭스'), '대여중');
INSERT INTO TITLE_COPY VALUES 
 ( 1, (SELECT TITLE_ID FROM TITLE WHERE TITLE = '에이리언'), '대여가능');
INSERT INTO TITLE_COPY VALUES 
 ( 1, (SELECT TITLE_ID FROM TITLE WHERE TITLE = '모던타임즈'), '대여가능');
INSERT INTO TITLE_COPY VALUES 
 ( 2, (SELECT TITLE_ID FROM TITLE WHERE TITLE = '모던타임즈'), '대여가능');
INSERT INTO TITLE_COPY VALUES 
 ( 3, (SELECT TITLE_ID FROM TITLE WHERE TITLE = '모던타임즈'), '대여중');
INSERT INTO TITLE_COPY VALUES 
 ( 1, (SELECT TITLE_ID FROM TITLE WHERE TITLE = '러브스토리'), '대여가능');
INSERT INTO TITLE_COPY VALUES 
 ( 1, (SELECT TITLE_ID FROM TITLE WHERE TITLE = '람보'), '대여가능');
COMMIT;


--- #6. PROBLEM


INSERT INTO RENTAL VALUES 
 (SYSDATE-3, (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '김철수'), 
  (SELECT COPY_ID FROM TITLE_COPY JOIN TITLE USING (TITLE_ID) WHERE TITLE = '인어공주'),
  (SELECT TITLE_ID FROM TITLE_COPY JOIN TITLE USING (TITLE_ID) WHERE TITLE = '인어공주'),
  SYSDATE-2, SYSDATE-1);

INSERT INTO RENTAL(BOOK_DATE,MEMBER_ID, COPY_ID, TITLE_ID, EXP_RET_DATE)  VALUES 
 (SYSDATE-1, (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '최진국'), 2 ,
  (SELECT TITLE_ID FROM TITLE WHERE TITLE = '매트릭스'),
  SYSDATE+1);
  
INSERT INTO RENTAL(BOOK_DATE,MEMBER_ID, COPY_ID, TITLE_ID, EXP_RET_DATE)  VALUES 
 (SYSDATE-2, (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '강준호'), 3 ,
  (SELECT TITLE_ID FROM TITLE WHERE TITLE = '모던타임즈'),
  SYSDATE);
  
INSERT INTO RENTAL(BOOK_DATE,MEMBER_ID, COPY_ID, TITLE_ID, EXP_RET_DATE, ACT_RET_DATE)  VALUES 
 (SYSDATE-4, (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '민병국'), 1 ,
  (SELECT TITLE_ID FROM TITLE WHERE TITLE = '람보'),
  SYSDATE-2, SYSDATE-2);
    
    
--- #7. PROBLEM


CREATE OR REPLACE VIEW TITLE_AVAIL AS (
SELECT C.TITLE, D.COPY_ID, D.STATUS, D.EXP_RET_DATE 
FROM TITLE C 
LEFT JOIN 
                (SELECT A.COPY_ID, A.TITLE_ID, A.STATUS, B.EXP_RET_DATE 
                 FROM TITLE_COPY A
                 LEFT JOIN RENTAL B ON B.COPY_ID = A.COPY_ID 
                                                    AND B.TITLE_ID = A.TITLE_ID
                 ORDER BY A.TITLE_ID, COPY_ID) D 
ON D.TITLE_ID = C.TITLE_ID);



--- #8. PROBLEM

--- 8.A


INSERT INTO TITLE VALUES (TITLE_ID_SEQ.NEXTVAL, '스타워즈' ,'스타워즈 설명', '전체가', 'SF', '77/07/07');

INSERT INTO TITLE_COPY VALUES 
 ( 1, (SELECT TITLE_ID FROM TITLE WHERE TITLE = '스타워즈'), '대여가능');

INSERT INTO TITLE_COPY VALUES 
 ( 2, (SELECT TITLE_ID FROM TITLE WHERE TITLE = '스타워즈'), '대여가능');



--- 8.B


INSERT INTO RESERVATION VALUES 
 (SYSDATE, (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '이영희' ),
 (SELECT TITLE_ID FROM TITLE WHERE TITLE = '스타워즈'));
 
 INSERT INTO RESERVATION VALUES 
 (SYSDATE, (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '오민수' ),
 (SELECT TITLE_ID FROM TITLE WHERE TITLE = '러브스토리'));


----
SELECT * FROM RESERVATION;
----


--- 8.C 

DELETE FROM RESERVATION 
WHERE MEMBER_ID = (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '이영희');

INSERT INTO RENTAL(MEMBER_ID, COPY_ID, TITLE_ID)  VALUES (
    (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '이영희'), 
   1 , (SELECT TITLE_ID FROM TITLE WHERE TITLE = '스타워즈'));


UPDATE TITLE_COPY
SET STATUS = '대여중'
WHERE TITLE_ID = (SELECT TITLE_ID FROM TITLE WHERE TITLE = '스타워즈') AND COPY_ID = 1;



---VIEW 확인 

SELECT  * FROM TITLE_AVAIL;



--- #9. PROBLEM


ALTER TABLE TITLE 
ADD (PRICE NUMBER(5));

UPDATE TITLE
SET PRICE = 3000
WHERE TITLE_ID = (SELECT TITLE_ID FROM TITLE WHERE TITLE = '인어공주');

UPDATE TITLE
SET PRICE = 2500
WHERE TITLE_ID = (SELECT TITLE_ID FROM TITLE WHERE TITLE = '매트릭스');

UPDATE TITLE
SET PRICE = 2000
WHERE TITLE_ID = (SELECT TITLE_ID FROM TITLE WHERE TITLE = '에이리언');

UPDATE TITLE
SET PRICE = 3000
WHERE TITLE_ID = (SELECT TITLE_ID FROM TITLE WHERE TITLE = '모던타임즈');

UPDATE TITLE
SET PRICE = 3500
WHERE TITLE_ID = (SELECT TITLE_ID FROM TITLE WHERE TITLE = '러브스토리');

UPDATE TITLE
SET PRICE = 2000
WHERE TITLE_ID = (SELECT TITLE_ID FROM TITLE WHERE TITLE = '람보');

UPDATE TITLE
SET PRICE = 1500
WHERE TITLE_ID = (SELECT TITLE_ID FROM TITLE WHERE TITLE = '스타워즈');

ALTER TABLE TITLE
MODIFY PRICE NOT NULL;



--- #10. PROBLEM


SELECT B.NAME AS 회원명,
             C.TITLE AS 제목, 
             A.BOOK_DATE AS 대여일,
             (A.ACT_RET_DATE - A.BOOK_DATE) AS 기간 
FROM RENTAL A
JOIN MEMBER B ON B.MEMBER_ID = A.MEMBER_ID
JOIN TITLE C ON C.TITLE_ID = A.TITLE_ID;


