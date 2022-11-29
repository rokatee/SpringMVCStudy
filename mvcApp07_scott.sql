SELECT USER
FROM DUAL;
--==>> SCOTT

SELECT USER
FROM DUAL;
--==>> SCOTT


--○ 기존 테이블 제거
DROP TABLE TBL_MEMBERLIST PURGE;
--==>> Table TBL_MEMBERLIST이(가) 삭제되었습니다.


--○ 실습 테이블 다시 생성
CREATE TABLE TBL_MEMBERLIST
( ID    VARCHAR2(30)
, PW    VARCHAR2(20)
, NAME  VARCHAR2(50)
, TEL   VARCHAR2(50)
, EMAIL VARCHAR2(100)
, CONSTRAINT TBLMEMBERLIST_ID_PK PRIMARY KEY(ID)
);
--==>> Table TBL_MEMBERLIST이(가) 생성되었습니다.


--○ 데이터 입력(TBL_MEMBERLIST)
INSERT INTO TBL_MEMBERLIST(ID, PW, NAME, TEL, EMAIL)
VALUES('admin', CRYPTPACK.ENCRYPT('java002$', 'java002$'), '장현성', '010-1111-1111', 'admin@test.com');
--> 한 줄 구성
INSERT INTO TBL_MEMBERLIST(ID, PW, NAME, TEL, EMAIL) VALUES('admin', CRYPTPACK.ENCRYPT('java002$', 'java002$'), '장현성', '010-1111-1111', 'admin@test.com')
;
--==>> 1 행 이(가) 삽입되었습니다.


--○ 확인
SELECT *
FROM TBL_MEMBERLIST;
--==>> admin	??{	장현성	010-1111-1111	admin@test.com


--○ 커밋
COMMIT;
--==>> 커밋 완료.

--○ 리스트 조회 쿼리문 구성(패스워드는 리스트 조회 항목에서 제외)
SELECT ID, NAME, TEL, EMAIL
FROM TBL_MEMBERLIST;
--> 한 줄 구성
SELECT ID, NAME, TEL, EMAIL FROM TBL_MEMBERLIST
;
--==>> admin	장현성	010-1111-1111	admin@test.com

--○ 인원 수 확인 쿼리문 구성
SELECT COUNT(*) AS COUNT
FROM TBL_MEMBERLIST;
--> 한 줄 구성
SELECT COUNT(*) AS COUNT FROM TBL_MEMBERLIST
;
--==>> 1

--○ 


--○ 



--○ 


--○ 


--○ 


--○ 

