-- ������� �1
SELECT * FROM TEACHER;

ALTER TABLE TEACHER
ADD (
    BIRTHDAY DATE,
    SALARY NUMBER(15, 2)
);

UPDATE TEACHER
SET 
    BIRTHDAY = TO_DATE('19.01.2000', 'DD.MM.YYYY'),
    SALARY = 10
WHERE PULPIT LIKE 'P%'
;

UPDATE TEACHER
SET 
    BIRTHDAY = TO_DATE('10.05.1969', 'DD.MM.YYYY'),
    SALARY = 14
WHERE PULPIT LIKE 'IS%'
;

UPDATE TEACHER
SET 
    BIRTHDAY = TO_DATE('11.01.2001', 'DD.MM.YYYY'),
    SALARY = 6
WHERE PULPIT LIKE 'O%'
;
                    
UPDATE TEACHER
SET 
    BIRTHDAY = TO_DATE('11.01.1993', 'DD.MM.YYYY'),
    SALARY = 13
WHERE PULPIT LIKE 'T%'
;

UPDATE TEACHER
SET 
    BIRTHDAY = TO_DATE('11.12.1986', 'DD.MM.YYYY'),
    SALARY = 17
WHERE 
    SALARY IS NULL
    AND BIRTHDAY IS NULL
;

COMMIT;

SELECT * FROM TEACHER;


-- ������� �2 �������� ������ �������������� � ���� ������� �.�. ��� ��������������, ���������� � �����������.
DECLARE
    CURSOR MONDAY_BIRTHDAY_TEACHERS_CURSOR IS
        SELECT
            TEACHER_NAME    NAME,
            BIRTHDAY        BIRTHDAY
        FROM TEACHER
        WHERE TO_CHAR(BIRTHDAY, 'D') = 1
    ;
    SELECTED_TEACHER MONDAY_BIRTHDAY_TEACHERS_CURSOR%ROWTYPE;
BEGIN
    FOR SELECTED_TEACHER IN MONDAY_BIRTHDAY_TEACHERS_CURSOR LOOP
        DBMS_OUTPUT.PUT_LINE(
            MONDAY_BIRTHDAY_TEACHERS_CURSOR%ROWCOUNT
        ||  '. '
        ||  REGEXP_SUBSTR(SELECTED_TEACHER.NAME, '[^ ]+', 1, 1)
        ||  ' '
        ||  SUBSTR(REGEXP_SUBSTR(SELECTED_TEACHER.NAME, '[^ ]+', 1, 2), 1, 1) || '.'
        ||  ' '
        ||  SUBSTR(REGEXP_SUBSTR(SELECTED_TEACHER.NAME, '[^ ]+', 1, 3), 1, 1) ||  '.'
        ||  ' - '
        ||  SELECTED_TEACHER.BIRTHDAY
        );
    END LOOP;
END;


-- ������� �3 �������� �������������, � ������� ��������� ������ ��������������, ������� �������� � ��������� ������ � �������� �� ���� �������� � ������� �DD/MM/YYYY�.
CREATE OR REPLACE VIEW V_NEXT_MONTH_BIRTHDAY_TEACHERS
AS
SELECT
    TEACHER_NAME                    TEACHER_NAME,
    TO_CHAR(BIRTHDAY, 'DD/MM/YYYY') BIRTHDAY
FROM TEACHER
WHERE EXTRACT(MONTH FROM BIRTHDAY) = EXTRACT(MONTH FROM SYSDATE) + 1
;

SELECT * FROM V_NEXT_MONTH_BIRTHDAY_TEACHERS;


-- ������� �4 �������� �������������, � ������� ��������� ���������� ��������������, ������� �������� � ������ ������, �������� ������ ������� ������.
CREATE OR REPLACE VIEW V_TEACHER_BIRTHDAY_MONTS
AS
SELECT
    TO_CHAR(BIRTHDAY, 'Month')  MONTH,
    COUNT(TEACHER_NAME)         TEACHERS
FROM TEACHER
GROUP BY TO_CHAR(BIRTHDAY, 'Month')
;

SELECT * FROM V_TEACHER_BIRTHDAY_MONTS;


-- ������� �5 ������� ������ � ������� ������ ��������������, � ������� � ��������� ���� ������ � ���������, ������� ��� �����������.
DECLARE
    CURSOR NEXT_YEAR_ANNIVERSARY_TEACHERS_CURSOR IS
        SELECT
            TEACHER_NAME NAME,
            BIRTHDAY BIRTHDAY,
            FLOOR(months_between(add_months(SYSDATE, 12), BIRTHDAY) / 12) AGE
        FROM TEACHER
        WHERE MOD(FLOOR(months_between(add_months(SYSDATE, 12), BIRTHDAY) / 12), 5) = 0
    ;
    SELECTED_TEACHER NEXT_YEAR_ANNIVERSARY_TEACHERS_CURSOR%ROWTYPE;
BEGIN
    FOR SELECTED_TEACHER IN NEXT_YEAR_ANNIVERSARY_TEACHERS_CURSOR LOOP
        DBMS_OUTPUT.PUT_LINE(
            NEXT_YEAR_ANNIVERSARY_TEACHERS_CURSOR%ROWCOUNT
        ||  '. '
        ||  SELECTED_TEACHER.NAME
        ||  ' - '
        ||  SELECTED_TEACHER.BIRTHDAY
        ||  ' (����������� '
        ||  SELECTED_TEACHER.AGE
        ||  ' ���)'
        );
    END LOOP;
END;


-- ������� �6 ������� ������ � ������� ������� ���������� ����� �� �������� � ����������� ���� �� �����, ������� ������� �������� �������� ��� ������� ���������� � ��� ���� ����������� � �����.
DECLARE
    CURSOR AVERANGE_SALARY_CURSOR IS
        SELECT
            PULPIT.FACULTY FACULTY,
            PULPIT.PULPIT PULPIT,
            FLOOR(AVG(TEACHER.SALARY)) SALARY
        FROM
            TEACHER
            INNER JOIN PULPIT ON PULPIT.PULPIT = TEACHER.PULPIT
        GROUP BY ROLLUP(
            PULPIT.FACULTY,
            PULPIT.PULPIT
        )
        ORDER BY
            PULPIT.FACULTY,
            PULPIT.PULPIT
    ;
    REC AVERANGE_SALARY_CURSOR%ROWTYPE;
BEGIN
    FOR REC IN AVERANGE_SALARY_CURSOR LOOP
        DBMS_OUTPUT.PUT_LINE(
            NVL(REC.FACULTY, '          ') 
        || '   ' 
        || NVL(REC.PULPIT, '          ') 
        || '    ' 
        || REC.SALARY
        );
    END LOOP;
END;


-- ������� �7 ������� ������������� ���� ��� ������� ���������� ������� ���� ����������. �������� ��������� �������� � �������� �� 0 ����� ���������� ZERO_DIVIDE. ������������� ���������������� ������ ��� �������� �������� 0.
DECLARE
    EX_ZERO_DVD EXCEPTION;

    a NUMBER := 3;
    b NUMBER := 0;
    c NUMBER;
BEGIN
    IF b = 0 THEN
        RAISE EX_ZERO_DVD;
    END IF;
    c := a / b;
    DBMS_OUTPUT.PUT_LINE('Result is: ' || c);
EXCEPTION
    WHEN ZERO_DIVIDE THEN BEGIN
        DBMS_OUTPUT.PUT_LINE('ZERO_DIVIDE');
        DBMS_OUTPUT.PUT_LINE(SQLCODE || ' ' || SQLERRM);
    END;
    WHEN OTHERS THEN BEGIN
        DBMS_OUTPUT.PUT_LINE('OTHERS');
        DBMS_OUTPUT.PUT_LINE(SQLCODE || ' ' || SQLERRM);
    END;
END;


-- ������� �8 ������� ������������� ���� � �������� SELECT�INTO ��� ������ ������������ ������������� �� ��������� ����. �������� ��������� ���������� NO_DATA_FOUND � ������� ���������� '������������� �� ������!'. ���������, ��� ���������� ��� ��������������� ����������.
DECLARE
    NO_DATA_FOUND EXCEPTION;

    TCHR TEACHER%ROWTYPE;
BEGIN
    SELECT * INTO TCHR FROM TEACHER WHERE TEACHER = 'GRMN+';
    DBMS_OUTPUT.PUT_LINE('FOUND: ' || TCHR.TEACHER_NAME);
EXCEPTION
    WHEN NO_DATA_FOUND THEN BEGIN
        DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND');
        DBMS_OUTPUT.PUT_LINE(SQLCODE || ' ' || SQLERRM);
    END;
    WHEN OTHERS THEN BEGIN
        DBMS_OUTPUT.PUT_LINE('OTHERS');
        DBMS_OUTPUT.PUT_LINE(SQLCODE || ' ' || SQLERRM);
    END;
END;


-- ������� �9a ������� �������� � ��������� ����. �������� � ��� ���������� � ������� �������, ������� � ����� ������ -20�001 � ������� PRAGMA EXCEPTION_INIT. ������������� ���������� �� ��������� �����, ���������� ��� � ��������. ��������� ��������, ����� ���������� �� ������� � ����� ������ � ����� ���������� ������������.
DECLARE
    EX_MYEX_TOP EXCEPTION;
    PRAGMA exception_init(EX_MYEX_TOP, -20001);
BEGIN
    DECLARE
        EX_MYEX_INNER EXCEPTION;
        PRAGMA exception_init(EX_MYEX_INNER, -20001);
    BEGIN
        RAISE EX_MYEX_INNER;
    END;
EXCEPTION
    WHEN EX_MYEX_TOP THEN BEGIN
        DBMS_OUTPUT.PUT_LINE('EX_MYEX_TOP');
        DBMS_OUTPUT.PUT_LINE(SQLCODE || ' ' || SQLERRM);
    END;
END;

-- ������� �9b
DECLARE
    EX_MYEX EXCEPTION;
BEGIN
    DECLARE
        EX_MYEX EXCEPTION;
    BEGIN
        RAISE EX_MYEX;
    END;
EXCEPTION
    WHEN EX_MYEX THEN BEGIN
        DBMS_OUTPUT.PUT_LINE('EX_MYEX');
        DBMS_OUTPUT.PUT_LINE(SQLCODE || ' ' || SQLERRM);
    END;
END;


-- ������� �10 ���������, ������������ �� ���������� NO_DATA_FOUND � ������� SELECT�INTO � PL/SQL ����� � �������������� ��������� �������, �������� MAX.
DECLARE
    MAX_SALARY TEACHER.SALARY%TYPE;
BEGIN
    SELECT MAX(SALARY) INTO MAX_SALARY FROM TEACHER WHERE TEACHER LIKE 'N%S';
    DBMS_OUTPUT.PUT_LINE('Max salary: ' || MAX_SALARY);
EXCEPTION
    WHEN NO_DATA_FOUND THEN BEGIN
        DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND');
        DBMS_OUTPUT.PUT_LINE(SQLCODE || ' ' || SQLERRM);
    END;
END;


-- ��������
DROP VIEW V_TEACHER_BIRTHDAY_MONTS;

DROP VIEW V_NEXT_MONTH_BIRTHDAY_TEACHERS;

ALTER TABLE TEACHER
DROP COLUMN SALARY;

ALTER TABLE TEACHER
DROP COLUMN BIRTHDAY;
