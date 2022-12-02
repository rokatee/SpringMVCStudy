SELECT USER
FROM DUAL;
--==>> SCOTT

/*
   - 사용 계정 : scott
   - 테이블 : TBL_STUDENT
     ·테이블 구조 : SID	NUMBER		-- PK
                    , NAME	VARCHAR2(30)
                    , TEL	VARCHAR2(40)

   - 테이블 : TBL_GRADE
     ·테이블 구조 : SID	NUMBER		-- PK/FK
                    , SUB1	NUMBER(3)
                    , SUB2	NUMBER(3)
                    , SUB3	NUMBER(3)

   - 뷰 : STUDENTVIEW
     ·뷰 구조 : SID, NAME, TEL, SUB
                                  --- 참조 레코드 수
 
   - 뷰 : GRADEVIEW	
    ·뷰 구조 : SUD, NAME, SUB1, SUB2, SUB3, TOT, AVG, CH
                                              ---  ---  --
                                             총점 평균 등급(합격, 과락, 불합격)
*/


--○ 실습 테이블 생성
CREATE TABLE TBL_STUDENT
( SID   NUMBER
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(40)
, CONSTRAINT STUDENT_SID_PK PRIMARY KEY(SID)
);
--==>> Table TBL_STUDENT이(가) 생성되었습니다.


--○ 샘플 데이터 입력
INSERT INTO TBL_STUDENT(SID, NAME, TEL)
VALUES(1, '민찬우', '010-1111-1111');
INSERT INTO TBL_STUDENT(SID, NAME, TEL)
VALUES(2, '유동현', '010-2222-2222');
INSERT INTO TBL_STUDENT(SID, NAME, TEL)
VALUES(3, '김태민', '010-3333-3333');
INSERT INTO TBL_STUDENT(SID, NAME, TEL)
VALUES(4, '홍길동', '010-4444-4444');
--==>> 1 행 이(가) 삽입되었습니다. * 4

--○ 확인
SELECT *
FROM TBL_STUDENT;

--○ 실습 테이블 생성
CREATE TABLE TBL_GRADE
( SID   NUMBER
, SUB1  NUMBER(3)
, SUB2  NUMBER(3)
, SUB3  NUMBER(3)
, CONSTRAINT GRADE_SID_PK PRIMARY KEY(SID)
, CONSTRAINT GRADE_SID_FK FOREIGN KEY(SID)
             REFERENCES TBL_STUDENT(SID)
, CONSTRAINT GRADE_SUB1_CK CHECK(SUB1 BETWEEN 0 AND 100)
, CONSTRAINT GRADE_SUB2_CK CHECK(SUB2 BETWEEN 0 AND 100)
, CONSTRAINT GRADE_SUB3_CK CHECK(SUB3 BETWEEN 0 AND 100)
);
--==>> Table TBL_GRADE이(가) 생성되었습니다.

--○ 샘플 데이터 입력
INSERT INTO TBL_GRADE(SID, SUB1, SUB2, SUB3)
VALUES(1, 90, 80, 70);  -- 합격
INSERT INTO TBL_GRADE(SID, SUB1, SUB2, SUB3)
VALUES(2, 70, 60, 50);  -- 합격
INSERT INTO TBL_GRADE(SID, SUB1, SUB2, SUB3)
VALUES(3, 50, 40, 30);  -- 과락(3번 성적이 40점 미만)
INSERT INTO TBL_GRADE(SID, SUB1, SUB2, SUB3)
VALUES(4, 74, 64, 40);  -- 불합격(평균 60점 미만)
--==>> 1 행 이(가) 삽입되었습니다. * 4

--○ 확인
SELECT *
FROM TBL_GRADE;

--○ 커밋
COMMIT;
--==>> 커밋 완료.

--○ 뷰 생성(STUDENTVIEW)
CREATE OR REPLACE VIEW STUDENTVIEW
AS
SELECT S.SID AS SID
     , S.NAME AS NAME
     , S.TEL AS TEL
     , (SELECT COUNT(*)
        FROM TBL_GRADE
        WHERE SID = S.SID) AS SUB
FROM TBL_STUDENT S;
--==>> View STUDENTVIEW이(가) 생성되었습니다.


--○ 뷰 생성(GRADEVIEW)
-- 나
SELECT G.SID AS SID
     , (SELECT NAME
        FROM TBL_STUDENT
        WHERE SID = G.SID) AS NAME
     , G.SUB1 AS SUB1
     , G.SUB2 AS SUB2
     , G.SUB3 AS SUB3
     , (G.SUB1 + G.SUB2 + G.SUB3) AS TOT
     , ROUND((G.SUB1 + G.SUB2 + G.SUB3)/3,2) AS AVG
     , CASE WHEN G.SUB1 < 40 OR G.SUB2 < 40 OR G.SUB3 < 40 THEN '과락'
            WHEN (G.SUB1 + G.SUB2 + G.SUB3)/3 < 60 THEN '불합격'
            ELSE '합격'
       END AS CH
FROM TBL_GRADE G;
--==>> View GRADEVIEW이(가) 생성되었습니다.

-- 샘
CREATE OR REPLACE VIEW GRADEVIEW
AS
SELECT S.SID AS SID
     , S.NAME AS NAME
     , G.SUB1 AS SUB1
     , G.SUB2 AS SUB2
     , G.SUB3 AS SUB3
     , (G.SUB1 + G.SUB2 + G.SUB3) AS TOT
     , ROUND((G.SUB1 + G.SUB2 + G.SUB3)/3,2) AS AVG
     , CASE WHEN G.SUB1 < 40 OR G.SUB2 < 40 OR G.SUB3 < 40 THEN '과락'
            WHEN (G.SUB1 + G.SUB2 + G.SUB3)/3 < 60 THEN '불합격'
            ELSE '합격'
       END AS CH
FROM TBL_STUDENT S JOIN TBL_GRADE G
ON S.SID = G.SID;

--○ 뷰 조회(STUDENTVIEW)
SELECT SID, NAME, TEL, SUB
FROM STUDENTVIEW;
--==>>
/*
1	민찬우	010-1111-1111	1
2	유동현	010-2222-2222	1
3	김태민	010-3333-3333	1
4	홍길동	010-4444-4444	1
*/

--○ 뷰 조회(GRADEVIEW)
SELECT SID, NAME, SUB1, SUB2, SUB3, TOT, AVG, CH
FROM GRADEVIEW;
--==>>
/*
1	민찬우	90	80	70	240	80	    합격
2	유동현	70	60	50	180	60	    합격
3	김태민	50	40	30	120	40	    과락
4	홍길동	74	64	40	178	59.33	불합격
*/

--○ 인원 수 확인
SELECT COUNT(*) AS COUNT
FROM TBL_STUDENT;
--==>> 4

