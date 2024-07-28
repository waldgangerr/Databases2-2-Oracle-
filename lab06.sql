-- Задание №1-2     1. Определите местоположение файла параметров инстанса. 
   -- 2. Убедитесь в наличии этого файла в операционной системе. 
SHOW PARAMETER spfile;
-- %ORACLE_HOME%\database\SPFILE%DBNAME%.ORA
-- D:\Progrmms\OracleDB\OracleDB19cHome\database\SPFILEORACLEDB.ORA
SELECT NAME, VALUE, DESCRIPTION FROM V$PARAMETER;


-- Задание №3-4     3. Сформируйте PFILE с именем XXX_PFILE.ORA. Исследуйте его содержимое. Поясните известные вам параметры в файле.
    --4. Измените какой-либо параметр в файле PFILE.
-- as sysdba
CREATE PFILE = 'D:\Study\Labs\Databases\Lab6\PFILEORACLEDB2.ORA' from SPFILE;


-- Задание №5-6     5. Создайте новый SPFILE.
    --6. Запустите инстанс с новыми параметрами.
-- as sysdba
CREATE SPFILE = 'D:\Study\Labs\Databases\Lab6\SPFILELAB.ORA' FROM PFILE = 'D:\Study\Labs\Databases\Lab6\PFILEORACLEDB.ORA';

SELECT NAME, VALUE, DESCRIPTION 
FROM V$PARAMETER
WHERE NAME = 'open_cursors'
;


-- Задание №7 Вернитесь к прежним значениям параметров другим способом.
ALTER SYSTEM SET open_cursors = 300 SCOPE = SPFILE;


-- Задание №8 Получите список управляющих файлов.
SELECT * FROM V$CONTROLFILE;


-- Задание №9 Создайте скрипт для изменения управляющего файла.
-- %ORACLE_HOME%\database\CONTROLFILE.TXT
-- D:\Programms\OracleDB\OracleDB19cHome\database\CONTROLFILE.TXT
ALTER DATABASE BACKUP CONTROLFILE TO TRACE AS 'CONTROLFILE4.TXT';


-- Задание №10-11     10. Определите местоположение файла паролей инстанса. 
    --11. Убедитесь в наличии этого файла в операционной системе.
-- %ORACLE_HOME%\database\PWD%DBNAME%.ora
-- D:\Programms\OracleDB\OracleDB19cHome\database\PWDoracledb.ora
SELECT * FROM V$PASSWORDFILE_INFO;


-- Задание №12 Получите перечень директориев для файлов сообщений и диагностики. 
SELECT * FROM V$DIAG_INFO;


-- Задание №13 Найдите и исследуйте содержимое протокола работы инстанса (LOG.XML), найдите в нем команды переключения журналов которые вы выполняли.
-- D:\Programms\OracleDB\OracleDB19c\diag\rdbms\oracledb\oracledb\alert\log.xml
SELECT * FROM V$DIAG_INFO WHERE NAME = 'Diag Alert';


-- Задание №14 Найдите и исследуйте содержимое трейса, в который вы сбросили управляющий файл.
-- D:\Programms\OracleDB\OracleDB19c\diag\rdbms\oracledb\oracledb\trace
