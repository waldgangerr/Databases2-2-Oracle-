-- ������� �1-2     1. ���������� �������������� ����� ���������� ��������. 
   -- 2. ��������� � ������� ����� ����� � ������������ �������. 
SHOW PARAMETER spfile;
-- %ORACLE_HOME%\database\SPFILE%DBNAME%.ORA
-- D:\Progrmms\OracleDB\OracleDB19cHome\database\SPFILEORACLEDB.ORA
SELECT NAME, VALUE, DESCRIPTION FROM V$PARAMETER;


-- ������� �3-4     3. ����������� PFILE � ������ XXX_PFILE.ORA. ���������� ��� ����������. �������� ��������� ��� ��������� � �����.
    --4. �������� �����-���� �������� � ����� PFILE.
-- as sysdba
CREATE PFILE = 'D:\Study\Labs\Databases\Lab6\PFILEORACLEDB2.ORA' from SPFILE;


-- ������� �5-6     5. �������� ����� SPFILE.
    --6. ��������� ������� � ������ �����������.
-- as sysdba
CREATE SPFILE = 'D:\Study\Labs\Databases\Lab6\SPFILELAB.ORA' FROM PFILE = 'D:\Study\Labs\Databases\Lab6\PFILEORACLEDB.ORA';

SELECT NAME, VALUE, DESCRIPTION 
FROM V$PARAMETER
WHERE NAME = 'open_cursors'
;


-- ������� �7 ��������� � ������� ��������� ���������� ������ ��������.
ALTER SYSTEM SET open_cursors = 300 SCOPE = SPFILE;


-- ������� �8 �������� ������ ����������� ������.
SELECT * FROM V$CONTROLFILE;


-- ������� �9 �������� ������ ��� ��������� ������������ �����.
-- %ORACLE_HOME%\database\CONTROLFILE.TXT
-- D:\Programms\OracleDB\OracleDB19cHome\database\CONTROLFILE.TXT
ALTER DATABASE BACKUP CONTROLFILE TO TRACE AS 'CONTROLFILE4.TXT';


-- ������� �10-11     10. ���������� �������������� ����� ������� ��������. 
    --11. ��������� � ������� ����� ����� � ������������ �������.
-- %ORACLE_HOME%\database\PWD%DBNAME%.ora
-- D:\Programms\OracleDB\OracleDB19cHome\database\PWDoracledb.ora
SELECT * FROM V$PASSWORDFILE_INFO;


-- ������� �12 �������� �������� ����������� ��� ������ ��������� � �����������. 
SELECT * FROM V$DIAG_INFO;


-- ������� �13 ������� � ���������� ���������� ��������� ������ �������� (LOG.XML), ������� � ��� ������� ������������ �������� ������� �� ���������.
-- D:\Programms\OracleDB\OracleDB19c\diag\rdbms\oracledb\oracledb\alert\log.xml
SELECT * FROM V$DIAG_INFO WHERE NAME = 'Diag Alert';


-- ������� �14 ������� � ���������� ���������� ������, � ������� �� �������� ����������� ����.
-- D:\Programms\OracleDB\OracleDB19c\diag\rdbms\oracledb\oracledb\trace
