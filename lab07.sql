-- Задание №1 Определите общий размер области SGA.
SELECT SUM(VALUE) FROM V$SGA;


-- Задание №2 Определите текущие размеры основных пулов SGA.
SELECT COMPONENT, CURRENT_SIZE 
FROM v$sga_dynamic_components
WHERE CURRENT_SIZE > 0
;


-- Задание №3 Определите размеры гранулы для каждого пула.
SELECT COMPONENT, GRANULE_SIZE
FROM v$sga_dynamic_components
WHERE CURRENT_SIZE > 0
;


-- Задание №4 Определите объем доступной свободной памяти в SGA.
SELECT * FROM v$sga_dynamic_free_memory;


-- Задание №5 Определите максимальный и целевой размер области SGA.
SHOW PARAMETER SGA;


-- Задание №6 Определите размеры пулов КЕЕP, DEFAULT и RECYCLE буферного кэша.
SELECT * 
FROM v$sga_dynamic_components
WHERE COMPONENT in ('DEFAULT buffer cache', 'KEEP buffer cache', 'RECYCLE buffer cache')
;


-- Задание №7 Создайте таблицу, которая будет помещаться в пул КЕЕP. Продемонстрируйте сегмент таблицы.
CREATE TABLE TAV_T_KEEP (
    ID INT
)
STORAGE (buffer_pool keep)
;

SELECT SEGMENT_NAME, SEGMENT_TYPE, TABLESPACE_NAME, BUFFER_POOL
FROM USER_SEGMENTS
WHERE SEGMENT_NAME = 'TAV_T_KEEP'
;


-- Задание №8 Создайте таблицу, которая будет кэшироваться в пуле default. Продемонстрируйте сегмент таблицы. 
CREATE TABLE TAV_T_DEFAULT (
    ID INT
)
STORAGE (buffer_pool default)
;

SELECT SEGMENT_NAME, SEGMENT_TYPE, TABLESPACE_NAME, BUFFER_POOL
FROM USER_SEGMENTS
WHERE SEGMENT_NAME = 'TAV_T_DEFAULT'
;


-- Задание №9 Найдите размер буфера журналов повтора.
SHOW PARAMETER log_buffer;


-- Задание №10 Найдите размер свободной памяти в большом пуле.
SHOW PARAMETER large_pool_size;


-- Задание №11 Определите режимы текущих соединений с инстансом (dedicated, shared).
SELECT USERNAME, SERVICE_NAME, SERVER
FROM v$session
WHERE USERNAME IS NOT NULL
;


-- Задание №12 Получите полный список работающих в настоящее время фоновых процессов.
SELECT *
FROM v$bgprocess
WHERE PADDR != HEXTORAW('00')
ORDER BY NAME
;


-- Задание №13 Получите список работающих в настоящее время серверных процессов.
SELECT * FROM v$process;


-- Задание №14 Определите, сколько процессов DBWn работает в настоящий момент.
SELECT * FROM v$process WHERE PNAME LIKE 'DBW%';


-- Задание №15 Определите сервисы (точки подключения экземпляра).
SELECT * FROM v$services;


-- Задание №16 Получите известные вам параметры диспетчеров.
SHOW PARAMETER dispatcher;
SHOW PARAMETER shared_server;


-- Задание №17 Укажите в списке Windows-сервисов сервис, реализующий процесс LISTENER.
-- Диспетчер задач -> службы


-- Задание №18 Продемонстрируйте и поясните содержимое файла LISTENER.ORA. 
-- %ORACLE_HOME%\NETWORK\ADMIN\LISTENER.ORA
-- D:\Programms\OracleDB\OracleDB19cHome\network\admin\listener.ora


-- Задание №19 Запустите утилиту lsnrctl и поясните ее основные команды. 
-- lsnrctl


-- Задание №20 Получите список служб инстанса, обслуживаемых процессом LISTENER.
-- lsnrctl services


-- Удаление таблиц
DROP TABLE TAV_T_KEEP;
DROP TABLE TAV_T_DEFAULT;
