SELECT USER
FROM DUAL;

--�� ���̺� ����
--DROP TABLE MEMBERLIST;
--==>> Table TBL_MEMBERLIST��(��) �����Ǿ����ϴ�.

--�� �ǽ� ���̺� �ٽ� ����
CREATE TABLE MEMBERLIST
( ID    VARCHAR2(30)
, PW    VARCHAR2(20)
, NAME  VARCHAR2(50)
, TEL   VARCHAR2(50)
, EMAIL VARCHAR2(100)
, CONSTRAINT MEMBERLIST_ID_PK PRIMARY KEY(ID)
);
--==>> Table TBL_MEMBERLIST��(��) �����Ǿ����ϴ�.


--�� ������ �Է�
INSERT INTO MEMBERLIST(ID, PW, NAME, TEL, EMAIL)
VALUES('superman', CRYPTPACK.ENCRYPT('1234567', '1234567'), '���¹�', '010-1111-1111', 'ktm@test.com');
INSERT INTO MEMBERLIST(ID, PW, NAME, TEL, EMAIL)
VALUES('superwoman', CRYPTPACK.ENCRYPT('java002$', 'java002$'), '���̰�', '010-2222-2222', 'mcw@test.com');
--> �� �� ����
INSERT INTO MEMBERLIST(ID, PW, NAME, TEL, EMAIL) VALUES('superwoman', CRYPTPACK.ENCRYPT('java002$', 'java002$'), '���̰�', '010-2222-2222', 'mcw@test.com')
;
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 2

--�� Ȯ��
SELECT ID, PW, NAME, TEL, EMAIL
FROM MEMBERLIST;
--> �� �� ����
SELECT ID, PW, NAME, TEL, EMAIL FROM MEMBERLIST
;
--==>>
/*
superman	=o???	���¹�	010-1111-1111	ktm@test.com
superwoman	??{	���̰�	010-2222-2222	mcw@test.com
*/

--�� MEMBERRECORD ���̺� ����
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

--�� MEMBERRECORDSEQ ������ ����
CREATE SEQUENCE MEMBERRECORDSEQ
NOCACHE;
--==>> Sequence MEMBERRECORDSEQ��(��) �����Ǿ����ϴ�.

--�� MEMBERRECORD ������ �Է�
INSERT INTO MEMBERRECORD(SCOREID, KOR, ENG, MAT, ID)
VALUES (MEMBERRECORDSEQ.NEXTVAL, 90, 80, 70 , 'superman');
--> �� �� ����
INSERT INTO MEMBERRECORD(SCOREID, KOR, ENG, MAT, ID) VALUES (MEMBERRECORDSEQ.NEXTVAL, 90, 80, 70 , 'superman')
;
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� Ȯ��
SELECT SCOREID, KOR, ENG, MAT, ID
FROM MEMBERRECORD
ORDER BY SCOREID;
--> �� �� ����
SELECT SCOREID, KOR, ENG, MAT, ID FROM MEMBERRECORD ORDER BY SCOREID
;
--==>> 1   90   80   70   superman

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� �л� ������ ���� ������ ���� (ID�� �л� ������ ����)
SELECT *
FROM MEMBERLIST
WHERE ID = 'superman';
--==>> superman	=o???	���¹�	010-1111-1111	ktm@test.com
DELETE
FROM MEMBERLIST
WHERE ID = 'superman';
--> �� �� ����
DELETE FROM MEMBERLIST WHERE ID = 'superman'
;
--==>> ORA-02292: integrity constraint (SCOTT.MEMBERRECORD_ID_FK) violated - child record found

--�� �л� ������ ���� ������ ���� (ID�� �л� ���� ����)
UPDATE MEMBERLIST
SET PW = CRYPTPACK.ENCRYPT('1234567', '1234567')
  , NAME = 'ȫ�浿'
  , TEL = '010-1234-1234'
  , EMAIL = 'email@address.com'
WHERE ID = 'superman';
--> �� �� ����
UPDATE MEMBERLIST SET PW = CRYPTPACK.ENCRYPT('1234567', '1234567'), NAME = 'ȫ�浿', TEL = '010-1234-1234', EMAIL = 'email@address.com'WHERE ID = 'superman'
;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

--�� ���̵�� �л� �˻� ������ ����
SELECT ID, NAME, TEL, EMAIL
FROM MEMBERLIST
WHERE ID = 'superman';
--> �� �� ����
SELECT ID, NAME, TEL, EMAIL FROM MEMBERLIST WHERE ID = 'superman'
;
--==>> superman	=o???	���¹�	010-1111-1111	ktm@test.com	1

--�� ���� ������ ���� ������ ���� (ID�� ���� ������ ����)
SELECT *
FROM MEMBERRECORD
WHERE ID = 'superman';
--==>> 1	90	80	70	superman
DELETE
FROM MEMBERRECORD
WHERE ID = 'superman';
--> �� �� ����
DELETE FROM MEMBERRECORD WHERE ID = 'superman'
;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

--�� ���� ������ ���� ������ ���� (ID�� ���� ���� ����)
UPDATE MEMBERRECORD
SET KOR = 99
  , ENG = 99
  , MAT = 99
WHERE ID = 'superman';
--> �� �� ����
UPDATE MEMBERRECORD SET KOR = 98, ENG = 99, MAT = 99 WHERE ID = 'superman'
;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�. 

ROLLBACK;
--==>> �ѹ� �Ϸ�.

--�� ���̵�� ���� �˻� ������ ����
SELECT SCOREID, KOR, ENG, MAT, ID
FROM MEMBERRECORD
WHERE ID = 'superman'
ORDER BY SCOREID;
--> �� �� ����
SELECT SCOREID, KOR, ENG, MAT, ID FROM MEMBERRECORD WHERE ID = 'superman' ORDER BY SCOREID
;
--==>> 1   90   80   70   superman

--�� ���� ���̺� ���� ���� ����
--��-1. GRADE �÷� �߰� �� �⺻���� 1(�Ϲݻ��)�� ����
ALTER TABLE MEMBERLIST
ADD GRADE NUMBER(1) DEFAULT 1;
--==>> Table MEMBERLIST��(��) ����Ǿ����ϴ�.

SELECT *
FROM MEMBERLIST;
--==>>
/*
superman	=o???	���¹�	010-1111-1111	ktm@test.com	1
superwoman	??{	���̰�	010-2222-2222	mcw@test.com	1
*/

--��-2. ���¹� �л��� �����ڷ� �Ӹ�(����)
UPDATE MEMBERLIST
SET GRADE = 0
WHERE ID = 'superman';
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM MEMBERLIST;
--==>>
/*
superman	=o???	���¹�	010-1111-1111	ktm@test.com	0
superwoman	??{	���̰�	010-2222-2222	mcw@test.com	1
*/

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� ������ �Է� (�л� ������ �Է�) - �÷��� ������ ����� ������ ������� �ٽ� ����
INSERT INTO MEMBERLIST(ID, PW, NAME, TEL, EMAIL)
VALUES('batman', CRYPTPACK.ENCRYPT('1234567', '1234567'), '������', '010-3333-3333', 'mcw@test.com');
--> �� �� ����
INSERT INTO MEMBERLIST(ID, PW, NAME, TEL, EMAIL) VALUES('batman', CRYPTPACK.ENCRYPT('1234567', '1234567'), '������', '010-3333-3333', 'mcw@test.com')
;
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� ��й�ȣ ��ġ ������ ����
SELECT NAME, CRYPTPACK.DECRYPT(PW, '1234567') AS PW
FROM MEMBERLIST
WHERE ID = 'superman';
--> �� �� ����
SELECT CRYPTPACK.DECRYPT(PW, '1234567') AS PW FROM MEMBERLIST WHERE ID = 'superman'
;
--==>> ���¹�	1234567

-- �Ϲ��л� �α��� ������ ����(���̵�, �н�����)
-- ID, PW
SELECT NAME
FROM MEMBERLIST
WHERE ID = ���̵�
  AND PW = �н�����;

SELECT NAME
FROM MEMBERLIST
WHERE ID = 'superwoman'
  AND PW = CRYPTPACK.ENCRYPT('java002$', 'java002$');
--==>> ���̰�
--> �Ϲݻ������ �α��� ����

SELECT NAME
FROM MEMBERLIST
WHERE ID = 'superwoman'
  AND PW = CRYPTPACK.ENCRYPT('java112$', 'java112$');
--==>> ��ȸ ��� ����
--> �Ϲݻ������ �α��� ����

SELECT NAME
FROM MEMBERLIST
WHERE ID = 'superman'
  AND PW = CRYPTPACK.ENCRYPT('1234567', '1234567');
--==>> ���¹�
--> ������ ������, �Ϲݻ�����ε� �α��� ����

-- �Ϲݻ�� �α��� ������ �� �� ����
SELECT NAME FROM MEMBERLIST WHERE ID = 'ID���ڿ�' AND PW = CRYPTPACK.ENCRYPT('PW���ڿ�', 'PW���ڿ�')
;


-- ������ �α��� ������ ����(���̵�, �н�����, ���)
-- ID, PW, GRADE
SELECT NAME
FROM MEMBERLIST
WHERE ID = ���̵�
  AND PW = �н�����
  AND GRADE = 0;

SELECT NAME
FROM MEMBERLIST
WHERE ID = 'superwoman'
  AND PW = CRYPTPACK.ENCRYPT('java002$', 'java002$')
  AND GRADE = 0;
--==>> ��ȸ ��� ����
--> �����ڷ� �α��� ����

SELECT NAME
FROM MEMBERLIST
WHERE ID = 'superman'
  AND PW = CRYPTPACK.ENCRYPT('1234567', '1234567')
  AND GRADE = 0;
--==>> ���¹�
--> ������ �α��� ����

-- ������ �α��� ������ �� �� ����
SELECT NAME FROM MEMBERLIST WHERE ID = 'ID���ڿ�' AND PW = CRYPTPACK.ENCRYPT('PW���ڿ�', 'PW���ڿ�') AND GRADE = 0
;

-- �Ϲ� ȸ���� ����Ʈ ��ȸ ������ ����
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

--�� �� ����
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
--==>> View MEMLISTVIEW��(��) �����Ǿ����ϴ�.

--�� Ȯ��
SELECT ID, NAME, TEL, EMAIL, KOR, ENG, MAT
FROM MEMLISTVIEW;
--> �� �� ����
SELECT ID, NAME, TEL, EMAIL, KOR, ENG, MAT FROM MEMLISTVIEW
;
--==>>
/*
batman	    ������	010-3333-3333	mcw@test.com			
batwoman	������	010-1234-1234	kyr@test.com			
superman	���¹�	010-1111-1111	ktm@test.com	90	80	70
superwoman	���̰�	010-2222-2222	mcw@test.com			
id1	        id1	    010-1234-1234	id1@test.com			
*/

--�� �л� ���� ��ȸ ������ ����
--   (Ư�� �л� ������ ���� ���ɿ��� Ȯ��)
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

--�� �� ����
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
--==>> View MEMBERLISTVIEW��(��) �����Ǿ����ϴ�.

--�� Ȯ��
SELECT ID, PW, NAME, TEL, EMAIL, DELCHECK
FROM MEMBERLISTVIEW;
--> �� �� ����
SELECT ID, PW, NAME, TEL, EMAIL, DELCHECK FROM MEMBERLISTVIEW
;
--==>>
/*
superman	=o???	���¹�	010-1111-1111	ktm@test.com	1
superwoman	??{	���̰�	010-2222-2222	mcw@test.com	1
batman	    =o???	������	010-3333-4444	mcw@test1.com	1
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