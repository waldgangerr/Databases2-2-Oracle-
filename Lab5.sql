-- (system)
ALTER SESSION SET "_oracle_script" = TRUE;


-- Задание №1 Получите список всех табличных пространств.
-- (system)
SELECT * FROM DBA_TABLESPACES;


-- Задание №2 Создайте табличное пространство с именем XXX_QDATA
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


-- Задание №3 Получите список сегментов табличного пространства XXX_QDATA. 
-- (system)
SELECT * FROM DBA_SEGMENTS WHERE TABLESPACE_NAME = 'TAV_QDATA';


-- Задание №4 Определите сегмент таблицы XXX_T1. 
-- (system)
SELECT * FROM DBA_SEGMENTS WHERE SEGMENT_NAME = 'TAV_T1';


-- Задание №5 Определите остальные сегменты.
-- (system)
SELECT * FROM DBA_SEGMENTS;
-- (TAV)
SELECT * FROM USER_SEGMENTS;


-- Задание №6 Удалите (DROP) таблицу XXX_T1.
-- (TAV)
DROP TABLE TAV_T1;


-- Задание №7 Получите список сегментов табличного пространства XXX_QDATA. Определите сегмент таблицы XXX_T1. Выполните SELECT-запрос к представлению USER_RECYCLEBIN, поясните результат.
-- (system)
SELECT * FROM DBA_SEGMENTS WHERE TABLESPACE_NAME = 'TAV_QDATA';
-- (TAV)
SELECT * FROM USER_RECYCLEBIN;


-- Задание №8 Восстановите (FLASHBACK) удаленную таблицу.
-- (TAV)
FLASHBACK TABLE TAV_T1 TO BEFORE DROP;
SELECT * FROM TAV_T1;


-- Задание №9 Выполните PL/SQL-скрипт, заполняющий таблицу XXX_T1 данными (10000 строк).
-- (TAV)
DELETE FROM TAV_T1 WHERE ID > 3;

BEGIN
    FOR i IN 1..10000
    LOOP
        INSERT INTO TAV_T1 VALUES ((10 + i), CONCAT('some data ', TO_CHAR((10 + i))));
    END LOOP;
END;

SELECT * FROM TAV_T1 ORDER BY ID;


-- Задание №10 Определите сколько в сегменте таблицы XXX_T1 экстентов, их размер в блоках и байтах. 
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


-- Задание №11 Получите перечень всех экстентов в базе данных.
-- (system)
SELECT * FROM DBA_EXTENTS;


-- Задание №12 Исследуйте значения псевдостолбца RowId в таблице XXX_T1 и других таблицах. Поясните формат и использование RowId.
-- (TAV)
SELECT ID, ROWID FROM TAV_T1;

-- (system)
SELECT ROWID FROM HELP;


-- Задание №13 Исследуйте значения псевдостолбца RowSCN в таблице XXX_T1 и других таблицах. 
-- (TAV)
SELECT ID, ROWID, ORA_ROWSCN FROM TAV_T1;


-- Задание №14 Измените таблицу так, чтобы для каждой строки RowSCN выставлялся индивидуально.
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


-- Задание №15 - 16
-- (system)
DROP USER TAV CASCADE;
DROP TABLESPACE TAV_QDATA;

