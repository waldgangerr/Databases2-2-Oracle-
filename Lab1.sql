CREATE TABLE TAV_t (
    some_id number(3),
    some_name varchar2(50),
    CONSTRAINT pk_TAV_t PRIMARY KEY (some_id)
);

-- ??????? ?12
INSERT INTO TAV_t(some_id, some_name)
VALUES (1, 'first name')
;
INSERT INTO TAV_t(some_id, some_name)
VALUES (2, 'second name')
;
INSERT INTO TAV_t(some_id, some_name)
VALUES (3, 'third name')
;
COMMIT;
SELECT * FROM TAV_t;

-- ??????? ?13
UPDATE TAV_t
SET some_name = 'Second Name'
WHERE some_id = 2;
UPDATE TAV_t
SET some_name = 'Third Name'
WHERE some_id = 3;
COMMIT;
SELECT * FROM TAV_t;

-- ??????? ?14
SELECT *
FROM TAV_t
WHERE some_id > 1;
SELECT SUM(some_id) AS ID_SUM
FROM TAV_t;
SELECT LISTAGG(some_name, ', ') AS Names
FROM TAV_t;

-- ??????? ?15
DELETE FROM TAV_t WHERE some_id = 1;
SELECT * FROM TAV_t;
ROLLBACK;
SELECT * FROM TAV_t;

-- ??????? ?16
CREATE TABLE TAV_t_child (
    some_id number(3),
    some_data varchar2(50),
    CONSTRAINT fk_TAV_t_child FOREIGN KEY (some_id) REFERENCES TAV_t(some_id)
);
INSERT ALL
    INTO TAV_t_child(some_id, some_data) VALUES (1, 'first data')
    INTO TAV_t_child(some_id, some_data) VALUES (2, 'second data')
SELECT * FROM DUAL;
COMMIT;
SELECT * FROM TAV_t_child;

-- ??????? ?17
SELECT *
FROM TAV_t LEFT JOIN TAV_t_child ON TAV_t.some_id = TAV_t_child.some_id;
SELECT *
FROM TAV_t INNER JOIN TAV_t_child ON TAV_t.some_id = TAV_t_child.some_id;

-- ??????? ?18
DROP TABLE TAV_t_child;
DROP TABLE TAV_t;