-- (system)
ALTER SESSION SET "_oracle_script" = TRUE;


-- ������� �1 �������� ������ ���� ��������� �����������.
-- (system)
SELECT * FROM DBA_TABLESPACES;


-- ������� �2 �������� ��������� ������������ � ������ XXX_QDATA
-- (system)
CREATE TABLESPACE TAV_QDATA
DATAFILE 'D:\Study\Labs\Databases\Lab5\TAV_QDATA1.dbf'
    SIZE 10m
OFFLINE
;

ALTER TABLESPACE TAV_QDATA ONLINE;

CREATE USER TAV
IDENTIFIED BY 1234
DEFAULT TABLESPACE TAV_QDATA
;

GRANT
    CREATE SESSION,
    CREATE TABLE
TO TAV;

ALTER USER TAV
QUOTA 2m ON TAV_QDATA
;

-- (TAV)
CREATE TABLE TAV_T1 (
    ID int,
    DATA varchar2(30),
    
    CONSTRAINT TAV_T1_PK PRIMARY KEY (ID)
);

INSERT INTO TAV_T1(ID, DATA) VALUES (1, 'some data 1');
INSERT INTO TAV_T1(ID, DATA) VALUES (2, 'some data 2');
INSERT INTO TAV_T1(ID, DATA) VALUES (3, 'some data 3');

SELECT * FROM TAV_T1;


-- ������� �3 �������� ������ ��������� ���������� ������������ XXX_QDATA. 
-- (system)
SELECT * FROM DBA_SEGMENTS WHERE TABLESPACE_NAME = 'TAV_QDATA';


-- ������� �4 ���������� ������� ������� XXX_T1. 
-- (system)
SELECT * FROM DBA_SEGMENTS WHERE SEGMENT_NAME = 'TAV_T1';


-- ������� �5 ���������� ��������� ��������.
-- (system)
SELECT * FROM DBA_SEGMENTS;
-- (TAV)
SELECT * FROM USER_SEGMENTS;


-- ������� �6 ������� (DROP) ������� XXX_T1.
-- (TAV)
DROP TABLE TAV_T1;


-- ������� �7 �������� ������ ��������� ���������� ������������ XXX_QDATA. ���������� ������� ������� XXX_T1. ��������� SELECT-������ � ������������� USER_RECYCLEBIN, �������� ���������.
-- (system)
SELECT * FROM DBA_SEGMENTS WHERE TABLESPACE_NAME = 'TAV_QDATA';
-- (TAV)
SELECT * FROM USER_RECYCLEBIN;


-- ������� �8 ������������ (FLASHBACK) ��������� �������.
-- (TAV)
FLASHBACK TABLE TAV_T1 TO BEFORE DROP;
SELECT * FROM TAV_T1;


-- ������� �9 ��������� PL/SQL-������, ����������� ������� XXX_T1 ������� (10000 �����).
-- (TAV)
DELETE FROM TAV_T1 WHERE ID > 3;

BEGIN
    FOR i IN 1..10000
    LOOP
        INSERT INTO TAV_T1 VALUES ((10 + i), CONCAT('some data ', TO_CHAR((10 + i))));
    END LOOP;
END;

SELECT * FROM TAV_T1 ORDER BY ID;


-- ������� �10 ���������� ������� � �������� ������� XXX_T1 ���������, �� ������ � ������ � ������. 
-- (TAV)
SELECT 
    SEGMENT_NAME,
    EXTENT_ID,
    BLOCKS,
    BYTES
FROM 
    USER_EXTENTS 
WHERE
    SEGMENT_NAME = 'TAV_T1'
;


-- ������� �11 �������� �������� ���� ��������� � ���� ������.
-- (system)
SELECT * FROM DBA_EXTENTS;


-- ������� �12 ���������� �������� ������������� RowId � ������� XXX_T1 � ������ ��������. �������� ������ � ������������� RowId.
-- (TAV)
SELECT ID, ROWID FROM TAV_T1;

-- (system)
SELECT ROWID FROM HELP;


-- ������� �13 ���������� �������� ������������� RowSCN � ������� XXX_T1 � ������ ��������. 
-- (TAV)
SELECT ID, ROWID, ORA_ROWSCN FROM TAV_T1;


-- ������� �14 �������� ������� ���, ����� ��� ������ ������ RowSCN ����������� �������������.
-- (TAV)
DELETE FROM TAV_T1;

DROP TABLE TAV_T1;

CREATE TABLE TAV_T1 (
    ID int,
    DATA varchar2(30),
    
    CONSTRAINT TAV_T1_PK PRIMARY KEY (ID)
) ROWDEPENDENCIES;

BEGIN
    FOR i IN 1..20
    LOOP
        INSERT INTO TAV_T1 VALUES (i, CONCAT('some data ', TO_CHAR(i)));
        COMMIT;
    END LOOP;
END;

SELECT ID, ROWID, ORA_ROWSCN FROM TAV_T1;


-- ������� �15 - 16
-- (system)
DROP USER TAV CASCADE;
DROP TABLESPACE TAV_QDATA;

