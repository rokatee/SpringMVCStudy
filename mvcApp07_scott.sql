SELECT USER
FROM DUAL;
--==>> SCOTT

SELECT USER
FROM DUAL;
--==>> SCOTT


--�� ���� ���̺� ����
DROP TABLE TBL_MEMBERLIST PURGE;
--==>> Table TBL_MEMBERLIST��(��) �����Ǿ����ϴ�.


--�� �ǽ� ���̺� �ٽ� ����
CREATE TABLE TBL_MEMBERLIST
( ID    VARCHAR2(30)
, PW    VARCHAR2(20)
, NAME  VARCHAR2(50)
, TEL   VARCHAR2(50)
, EMAIL VARCHAR2(100)
, CONSTRAINT TBLMEMBERLIST_ID_PK PRIMARY KEY(ID)
);
--==>> Table TBL_MEMBERLIST��(��) �����Ǿ����ϴ�.


--�� ������ �Է�(TBL_MEMBERLIST)
INSERT INTO TBL_MEMBERLIST(ID, PW, NAME, TEL, EMAIL)
VALUES('admin', CRYPTPACK.ENCRYPT('java002$', 'java002$'), '������', '010-1111-1111', 'admin@test.com');
--> �� �� ����
INSERT INTO TBL_MEMBERLIST(ID, PW, NAME, TEL, EMAIL) VALUES('admin', CRYPTPACK.ENCRYPT('java002$', 'java002$'), '������', '010-1111-1111', 'admin@test.com')
;
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_MEMBERLIST;
--==>> admin	??{	������	010-1111-1111	admin@test.com


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� ����Ʈ ��ȸ ������ ����(�н������ ����Ʈ ��ȸ �׸񿡼� ����)
SELECT ID, NAME, TEL, EMAIL
FROM TBL_MEMBERLIST;
--> �� �� ����
SELECT ID, NAME, TEL, EMAIL FROM TBL_MEMBERLIST
;
--==>> admin	������	010-1111-1111	admin@test.com

--�� �ο� �� Ȯ�� ������ ����
SELECT COUNT(*) AS COUNT
FROM TBL_MEMBERLIST;
--> �� �� ����
SELECT COUNT(*) AS COUNT FROM TBL_MEMBERLIST
;
--==>> 1

--�� 


--�� 



--�� 


--�� 


--�� 


--�� 

