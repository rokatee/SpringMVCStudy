SELECT USER
FROM DUAL;

--○ 테이블 삭제
--DROP TABLE MEMBERLIST;
--==>> Table TBL_MEMBERLIST이(가) 삭제되었습니다.

--○ 실습 테이블 다시 생성
CREATE TABLE MEMBERLIST
( ID    VARCHAR2(30)
, PW    VARCHAR2(20)
, NAME  VARCHAR2(50)
, TEL   VARCHAR2(50)
, EMAIL VARCHAR2(100)
, CONSTRAINT MEMBERLIST_ID_PK PRIMARY KEY(ID)
);
--==>> Table TBL_MEMBERLIST이(가) 생성되었습니다.


--○ 데이터 입력
INSERT INTO MEMBERLIST(ID, PW, NAME, TEL, EMAIL)
VALUES('superman', CRYPTPACK.ENCRYPT('1234567', '1234567'), '김태민', '010-1111-1111', 'ktm@test.com');
INSERT INTO MEMBERLIST(ID, PW, NAME, TEL, EMAIL)
VALUES('superwoman', CRYPTPACK.ENCRYPT('java002$', 'java002$'), '정미경', '010-2222-2222', 'mcw@test.com');
--> 한 줄 구성
INSERT INTO MEMBERLIST(ID, PW, NAME, TEL, EMAIL) VALUES('superwoman', CRYPTPACK.ENCRYPT('java002$', 'java002$'), '정미경', '010-2222-2222', 'mcw@test.com')
;
--==>> 1 행 이(가) 삽입되었습니다. * 2

--○ 확인
SELECT ID, PW, NAME, TEL, EMAIL
FROM MEMBERLIST;
--> 한 줄 구성
SELECT ID, PW, NAME, TEL, EMAIL FROM MEMBERLIST
;
--==>>
/*
superman	=o???	김태민	010-1111-1111	ktm@test.com
superwoman	??{	정미경	010-2222-2222	mcw@test.com
*/

--○ MEMBERRECORD 테이블 생성
CREATE TABLE MEMBERRECORD
( SCOREID   NUMBER
, KOR       NUMBER(3)
, ENG       NUMBER(3)
, MAT       NUMBER(3)
, ID        VARCHAR2(20)
, CONSTRAINT MEMBERRECORD_SCOREID_PK PRIMARY KEY(ID)
, CONSTRAINT MEMBERRECORD_KOR_CK CHECK(KOR>=0 AND KOR<=100)
, CONSTRAINT MEMBERRECORD_ENG_CK CHECK(ENG>=0 AND ENG<=100) 
, CONSTRAINT MEMBERRECORD_MAT_CK CHECK(MAT>=0 AND MAT<=100) 
, CONSTRAINT MEMBERRECORD_ID_FK FOREIGN KEY(ID)
                REFERENCES MEMBERLIST(ID)
);

--○ MEMBERRECORDSEQ 시퀀스 생성
CREATE SEQUENCE MEMBERRECORDSEQ
NOCACHE;
--==>> Sequence MEMBERRECORDSEQ이(가) 생성되었습니다.

--○ MEMBERRECORD 데이터 입력
INSERT INTO MEMBERRECORD(SCOREID, KOR, ENG, MAT, ID)
VALUES (MEMBERRECORDSEQ.NEXTVAL, 90, 80, 70 , 'superman');
--> 한 줄 구성
INSERT INTO MEMBERRECORD(SCOREID, KOR, ENG, MAT, ID) VALUES (MEMBERRECORDSEQ.NEXTVAL, 90, 80, 70 , 'superman')
;
--==>> 1 행 이(가) 삽입되었습니다.

--○ 확인
SELECT SCOREID, KOR, ENG, MAT, ID
FROM MEMBERRECORD
ORDER BY SCOREID;
--> 한 줄 구성
SELECT SCOREID, KOR, ENG, MAT, ID FROM MEMBERRECORD ORDER BY SCOREID
;
--==>> 1   90   80   70   superman

--○ 커밋
COMMIT;
--==>> 커밋 완료.

--○ 학생 데이터 삭제 쿼리문 구성 (ID로 학생 데이터 삭제)
SELECT *
FROM MEMBERLIST
WHERE ID = 'superman';
--==>> superman	=o???	김태민	010-1111-1111	ktm@test.com
DELETE
FROM MEMBERLIST
WHERE ID = 'superman';
--> 한 줄 구성
DELETE FROM MEMBERLIST WHERE ID = 'superman'
;
--==>> ORA-02292: integrity constraint (SCOTT.MEMBERRECORD_ID_FK) violated - child record found

--○ 학생 데이터 수정 쿼리문 구성 (ID로 학생 정보 변경)
UPDATE MEMBERLIST
SET PW = CRYPTPACK.ENCRYPT('1234567', '1234567')
  , NAME = '홍길동'
  , TEL = '010-1234-1234'
  , EMAIL = 'email@address.com'
WHERE ID = 'superman';
--> 한 줄 구성
UPDATE MEMBERLIST SET PW = CRYPTPACK.ENCRYPT('1234567', '1234567'), NAME = '홍길동', TEL = '010-1234-1234', EMAIL = 'email@address.com'WHERE ID = 'superman'
;
--==>> 1 행 이(가) 업데이트되었습니다.

--○ 아이디로 학생 검색 쿼리문 구성
SELECT ID, NAME, TEL, EMAIL
FROM MEMBERLIST
WHERE ID = 'superman';
--> 한 줄 구성
SELECT ID, NAME, TEL, EMAIL FROM MEMBERLIST WHERE ID = 'superman'
;
--==>> superman	=o???	김태민	010-1111-1111	ktm@test.com	1

--○ 성적 데이터 삭제 쿼리문 구성 (ID로 성적 데이터 삭제)
SELECT *
FROM MEMBERRECORD
WHERE ID = 'superman';
--==>> 1	90	80	70	superman
DELETE
FROM MEMBERRECORD
WHERE ID = 'superman';
--> 한 줄 구성
DELETE FROM MEMBERRECORD WHERE ID = 'superman'
;
--==>> 1 행 이(가) 삭제되었습니다.

--○ 성적 데이터 수정 쿼리문 구성 (ID로 성적 정보 변경)
UPDATE MEMBERRECORD
SET KOR = 99
  , ENG = 99
  , MAT = 99
WHERE ID = 'superman';
--> 한 줄 구성
UPDATE MEMBERRECORD SET KOR = 98, ENG = 99, MAT = 99 WHERE ID = 'superman'
;
--==>> 1 행 이(가) 업데이트되었습니다. 

ROLLBACK;
--==>> 롤백 완료.

--○ 아이디로 성적 검색 쿼리문 구성
SELECT SCOREID, KOR, ENG, MAT, ID
FROM MEMBERRECORD
WHERE ID = 'superman'
ORDER BY SCOREID;
--> 한 줄 구성
SELECT SCOREID, KOR, ENG, MAT, ID FROM MEMBERRECORD WHERE ID = 'superman' ORDER BY SCOREID
;
--==>> 1   90   80   70   superman

--※ 기존 테이블 구조 변경 수행
--①-1. GRADE 컬럼 추가 → 기본값을 1(일반사원)로 구성
ALTER TABLE MEMBERLIST
ADD GRADE NUMBER(1) DEFAULT 1;
--==>> Table MEMBERLIST이(가) 변경되었습니다.

SELECT *
FROM MEMBERLIST;
--==>>
/*
superman	=o???	김태민	010-1111-1111	ktm@test.com	1
superwoman	??{	정미경	010-2222-2222	mcw@test.com	1
*/

--①-2. 김태민 학생을 관리자로 임명(설정)
UPDATE MEMBERLIST
SET GRADE = 0
WHERE ID = 'superman';
--==>> 1 행 이(가) 업데이트되었습니다.

SELECT *
FROM MEMBERLIST;
--==>>
/*
superman	=o???	김태민	010-1111-1111	ktm@test.com	0
superwoman	??{	정미경	010-2222-2222	mcw@test.com	1
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.

--○ 데이터 입력 (학생 데이터 입력) - 컬럼의 구조가 변경된 사항을 기반으로 다시 구성
INSERT INTO MEMBERLIST(ID, PW, NAME, TEL, EMAIL)
VALUES('batman', CRYPTPACK.ENCRYPT('1234567', '1234567'), '민찬우', '010-3333-3333', 'mcw@test.com');
--> 한 줄 구성
INSERT INTO MEMBERLIST(ID, PW, NAME, TEL, EMAIL) VALUES('batman', CRYPTPACK.ENCRYPT('1234567', '1234567'), '민찬우', '010-3333-3333', 'mcw@test.com')
;
--==>> 1 행 이(가) 삽입되었습니다.

--○ 커밋
COMMIT;
--==>> 커밋 완료.

--○ 비밀번호 일치 쿼리문 구성
SELECT NAME, CRYPTPACK.DECRYPT(PW, '1234567') AS PW
FROM MEMBERLIST
WHERE ID = 'superman';
--> 한 줄 구성
SELECT CRYPTPACK.DECRYPT(PW, '1234567') AS PW FROM MEMBERLIST WHERE ID = 'superman'
;
--==>> 김태민	1234567

-- 일반학생 로그인 쿼리문 구성(아이디, 패스워드)
-- ID, PW
SELECT NAME
FROM MEMBERLIST
WHERE ID = 아이디
  AND PW = 패스워드;

SELECT NAME
FROM MEMBERLIST
WHERE ID = 'superwoman'
  AND PW = CRYPTPACK.ENCRYPT('java002$', 'java002$');
--==>> 정미경
--> 일반사원으로 로그인 성공

SELECT NAME
FROM MEMBERLIST
WHERE ID = 'superwoman'
  AND PW = CRYPTPACK.ENCRYPT('java112$', 'java112$');
--==>> 조회 결과 없음
--> 일반사원으로 로그인 실패

SELECT NAME
FROM MEMBERLIST
WHERE ID = 'superman'
  AND PW = CRYPTPACK.ENCRYPT('1234567', '1234567');
--==>> 김태민
--> 관리자 이지만, 일반사원으로도 로그인 성공

-- 일반사원 로그인 쿼리문 한 줄 구성
SELECT NAME FROM MEMBERLIST WHERE ID = 'ID문자열' AND PW = CRYPTPACK.ENCRYPT('PW문자열', 'PW문자열')
;


-- 관리자 로그인 쿼리문 구성(아이디, 패스워드, 등급)
-- ID, PW, GRADE
SELECT NAME
FROM MEMBERLIST
WHERE ID = 아이디
  AND PW = 패스워드
  AND GRADE = 0;

SELECT NAME
FROM MEMBERLIST
WHERE ID = 'superwoman'
  AND PW = CRYPTPACK.ENCRYPT('java002$', 'java002$')
  AND GRADE = 0;
--==>> 조회 결과 없음
--> 관리자로 로그인 실패

SELECT NAME
FROM MEMBERLIST
WHERE ID = 'superman'
  AND PW = CRYPTPACK.ENCRYPT('1234567', '1234567')
  AND GRADE = 0;
--==>> 김태민
--> 관리자 로그인 성공

-- 관리자 로그인 쿼리문 한 줄 구성
SELECT NAME FROM MEMBERLIST WHERE ID = 'ID문자열' AND PW = CRYPTPACK.ENCRYPT('PW문자열', 'PW문자열') AND GRADE = 0
;

-- 일반 회원의 리스트 조회 쿼리문 구성
SELECT L.ID AS ID
     , L.NAME AS NAME
     , L.TEL AS TEL
     , L.EMAIL AS EMAIL
     , (SELECT KOR
        FROM MEMBERRECORD
        WHERE ID = L.ID) AS KOR
     , (SELECT ENG
        FROM MEMBERRECORD
        WHERE ID = L.ID) AS ENG
     , (SELECT MAT
        FROM MEMBERRECORD
        WHERE ID = L.ID) AS MAT
FROM MEMBERLIST L;

--○ 뷰 생성
CREATE OR REPLACE VIEW MEMLISTVIEW
AS
SELECT L.ID AS ID
     , L.NAME AS NAME
     , L.TEL AS TEL
     , L.EMAIL AS EMAIL
     , (SELECT KOR
        FROM MEMBERRECORD
        WHERE ID = L.ID) AS KOR
     , (SELECT ENG
        FROM MEMBERRECORD
        WHERE ID = L.ID) AS ENG
     , (SELECT MAT
        FROM MEMBERRECORD
        WHERE ID = L.ID) AS MAT
FROM MEMBERLIST L;
--==>> View MEMLISTVIEW이(가) 생성되었습니다.

--○ 확인
SELECT ID, NAME, TEL, EMAIL, KOR, ENG, MAT
FROM MEMLISTVIEW;
--> 한 줄 구성
SELECT ID, NAME, TEL, EMAIL, KOR, ENG, MAT FROM MEMLISTVIEW
;
--==>>
/*
batman	    민찬우	010-3333-3333	mcw@test.com			
batwoman	김유림	010-1234-1234	kyr@test.com			
superman	김태민	010-1111-1111	ktm@test.com	90	80	70
superwoman	정미경	010-2222-2222	mcw@test.com			
id1	        id1	    010-1234-1234	id1@test.com			
*/

--○ 학생 정보 조회 쿼리문 구성
--   (특정 학생 데이터 삭제 가능여부 확인)
SELECT L.ID AS ID
     , L.PW AS PW
     , L.NAME AS NAME
     , L.TEL AS TEL
     , L.EMAIL AS EMAIL
     , L.GRADE AS GRADE
     , (SELECT COUNT(*)
        FROM MEMBERRECORD
        WHERE ID = L.ID) AS DELCHECK
FROM MEMBERLIST L;

--○ 뷰 생성
CREATE OR REPLACE VIEW MEMBERLISTVIEW
AS
SELECT L.ID AS ID
     , L.PW AS PW
     , L.NAME AS NAME
     , L.TEL AS TEL
     , L.EMAIL AS EMAIL
     , L.GRADE AS GRADE
     , (SELECT COUNT(*)
        FROM MEMBERRECORD
        WHERE ID = L.ID) AS DELCHECK 
FROM MEMBERLIST L;
--==>> View MEMBERLISTVIEW이(가) 생성되었습니다.

--○ 확인
SELECT ID, PW, NAME, TEL, EMAIL, DELCHECK
FROM MEMBERLISTVIEW;
--> 한 줄 구성
SELECT ID, PW, NAME, TEL, EMAIL, DELCHECK FROM MEMBERLISTVIEW
;
--==>>
/*
superman	=o???	김태민	010-1111-1111	ktm@test.com	1
superwoman	??{	정미경	010-2222-2222	mcw@test.com	1
batman	    =o???	민찬오	010-3333-4444	mcw@test1.com	1
test	    ?Q??	test	010-1234-1234	test@test.com   0
*/

DESC MEMBERLIST;

DESC MEMBERRECORD;

CREATE OR REPLACE VIEW MEMBERLIST_VIEW
AS
SELECT L.ID AS ID
     , L.NAME AS NAME
     , L.TEL AS TEL
     , L.EMAIL AS EMAIL
     , L.GRADE AS GRADE
     , (SELECT COUNT(*) 
        FROM MEMBERRECORD
        WHERE ID = L.ID) AS DELCHECK
FROM MEMBERLIST L
ORDER BY ID;

CREATE OR REPLACE VIEW MEMBERRECORD_VIEW
AS
SELECT L.ID AS ID
     , L.NAME AS NAME
     , R.KOR AS KOR
     , R.ENG AS ENG
     , R.MAT AS MAT
     , (R.KOR + R.ENG + R.MAT)/3 AS AVG
     , R.SCOREID AS SCOREID
     , L.GRADE AS GRADE
FROM MEMBERLIST L LEFT JOIN MEMBERRECORD R
  ON L.ID = R.ID
ORDER BY NAME;