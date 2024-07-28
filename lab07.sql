-- ������� �1 ���������� ����� ������ ������� SGA.
SELECT SUM(VALUE) FROM V$SGA;


-- ������� �2 ���������� ������� ������� �������� ����� SGA.
SELECT COMPONENT, CURRENT_SIZE 
FROM v$sga_dynamic_components
WHERE CURRENT_SIZE > 0
;


-- ������� �3 ���������� ������� ������� ��� ������� ����.
SELECT COMPONENT, GRANULE_SIZE
FROM v$sga_dynamic_components
WHERE CURRENT_SIZE > 0
;


-- ������� �4 ���������� ����� ��������� ��������� ������ � SGA.
SELECT * FROM v$sga_dynamic_free_memory;


-- ������� �5 ���������� ������������ � ������� ������ ������� SGA.
SHOW PARAMETER SGA;


-- ������� �6 ���������� ������� ����� ���P, DEFAULT � RECYCLE ��������� ����.
SELECT * 
FROM v$sga_dynamic_components
WHERE COMPONENT in ('DEFAULT buffer cache', 'KEEP buffer cache', 'RECYCLE buffer cache')
;


-- ������� �7 �������� �������, ������� ����� ���������� � ��� ���P. ����������������� ������� �������.
CREATE TABLE TAV_T_KEEP (
    ID INT
)
STORAGE (buffer_pool keep)
;

SELECT SEGMENT_NAME, SEGMENT_TYPE, TABLESPACE_NAME, BUFFER_POOL
FROM USER_SEGMENTS
WHERE SEGMENT_NAME = 'TAV_T_KEEP'
;


-- ������� �8 �������� �������, ������� ����� ������������ � ���� default. ����������������� ������� �������. 
CREATE TABLE TAV_T_DEFAULT (
    ID INT
)
STORAGE (buffer_pool default)
;

SELECT SEGMENT_NAME, SEGMENT_TYPE, TABLESPACE_NAME, BUFFER_POOL
FROM USER_SEGMENTS
WHERE SEGMENT_NAME = 'TAV_T_DEFAULT'
;


-- ������� �9 ������� ������ ������ �������� �������.
SHOW PARAMETER log_buffer;


-- ������� �10 ������� ������ ��������� ������ � ������� ����.
SHOW PARAMETER large_pool_size;


-- ������� �11 ���������� ������ ������� ���������� � ��������� (dedicated, shared).
SELECT USERNAME, SERVICE_NAME, SERVER
FROM v$session
WHERE USERNAME IS NOT NULL
;


-- ������� �12 �������� ������ ������ ���������� � ��������� ����� ������� ���������.
SELECT *
FROM v$bgprocess
WHERE PADDR != HEXTORAW('00')
ORDER BY NAME
;


-- ������� �13 �������� ������ ���������� � ��������� ����� ��������� ���������.
SELECT * FROM v$process;


-- ������� �14 ����������, ������� ��������� DBWn �������� � ��������� ������.
SELECT * FROM v$process WHERE PNAME LIKE 'DBW%';


-- ������� �15 ���������� ������� (����� ����������� ����������).
SELECT * FROM v$services;


-- ������� �16 �������� ��������� ��� ��������� �����������.
SHOW PARAMETER dispatcher;
SHOW PARAMETER shared_server;


-- ������� �17 ������� � ������ Windows-�������� ������, ����������� ������� LISTENER.
-- ��������� ����� -> ������


-- ������� �18 ����������������� � �������� ���������� ����� LISTENER.ORA. 
-- %ORACLE_HOME%\NETWORK\ADMIN\LISTENER.ORA
-- D:\Programms\OracleDB\OracleDB19cHome\network\admin\listener.ora


-- ������� �19 ��������� ������� lsnrctl � �������� �� �������� �������. 
-- lsnrctl


-- ������� �20 �������� ������ ����� ��������, ������������� ��������� LISTENER.
-- lsnrctl services


-- �������� ������
DROP TABLE TAV_T_KEEP;
DROP TABLE TAV_T_DEFAULT;
