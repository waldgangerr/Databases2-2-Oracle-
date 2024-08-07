-- ������� �1 ������������ ��������� ��������� GET_TEACHERS (PCODE TEACHER.PULPIT%TYPE). ��������� ������ �������� ������ �������������� �� ������� TEACHER (� ����������� ��������� �����), ���������� �� ������� �������� ����� � ���������. ������������ ��������� ���� � ����������������� ���������� ���������.
DECLARE
    PROCEDURE GET_TEACHERS(
        PCODE TEACHER.PULPIT%TYPE
    )
    IS
        CURSOR TEACHERS_CURSOR
        IS
            SELECT *
            FROM TEACHER
            WHERE PULPIT = PCODE
        ;
        TEACHER_RECORD TEACHER%ROWTYPE;
    BEGIN
        FOR TEACHER_RECORD IN TEACHERS_CURSOR LOOP
            DBMS_OUTPUT.PUT_LINE(
                TEACHERS_CURSOR%ROWCOUNT
            ||  '. '
            ||  TEACHER_RECORD.PULPIT
            ||  ' '
            ||  TEACHER_RECORD.TEACHER
            ||  ' '
            ||  TEACHER_RECORD.TEACHER_NAME
            );
        END LOOP;
    END GET_TEACHERS;
BEGIN
    GET_TEACHERS(PCODE => 'ISiT');
    DBMS_OUTPUT.PUT_LINE('');
    GET_TEACHERS('POiSOI');
END;
/

-- ������� �2 ������������ ��������� ������� GET_NUM_TEACHERS (PCODE TEACHER.PULPIT%TYPE) RETURN NUMBER. ������� ������ �������� ���������� �������������� �� ������� TEACHER, ���������� �� ������� �������� ����� � ���������. ������������ ��������� ���� � ����������������� ���������� ���������.
DECLARE
    FUNCTION GET_NUM_TEACHERS(
        PCODE TEACHER.PULPIT%TYPE
    )
    RETURN NUMBER
    IS
        NUM_TEACHERS NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO NUM_TEACHERS
        FROM TEACHER
        WHERE PULPIT = PCODE
        ;
        RETURN NUM_TEACHERS;
    END GET_NUM_TEACHERS;
BEGIN
    DBMS_OUTPUT.PUT_LINE('ISiT: ' || GET_NUM_TEACHERS('ISiT'));
    DBMS_OUTPUT.PUT_LINE('POiSOI: ' || GET_NUM_TEACHERS('POiSOI'));
END;
/

-- ������� �3a ��������� ������ �������� ������ �������������� �� ������� TEACHER (� ����������� ��������� �����), ���������� �� ����������, �������� ����� � ���������. ������������ ��������� ���� � ����������������� ���������� ���������.
CREATE OR REPLACE PROCEDURE GET_TEACHERS(
    FCODE FACULTY.FACULTY%TYPE
)
IS
    CURSOR TEACHERS_CURSOR
    IS
        SELECT
            TEACHER,
            TEACHER_NAME,
            PULPIT.PULPIT,
            PULPIT.FACULTY
        FROM
            TEACHER
            INNER JOIN PULPIT ON PULPIT.PULPIT = TEACHER.PULPIT
        WHERE
            FACULTY = FCODE
    ;
    TEACHER_RECORD TEACHERS_CURSOR%ROWTYPE;
BEGIN
    FOR TEACHER_RECORD IN TEACHERS_CURSOR LOOP
        DBMS_OUTPUT.PUT_LINE(
            TEACHERS_CURSOR%ROWCOUNT
        ||  '. '
        ||  TEACHER_RECORD.FACULTY
        ||  ' '
        ||  TEACHER_RECORD.PULPIT
        ||  ' '
        ||  TEACHER_RECORD.TEACHER
        ||  ' '
        ||  TEACHER_RECORD.TEACHER_NAME
        );
    END LOOP;
END GET_TEACHERS;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('          GET_TEACHERS');
    GET_TEACHERS('IDiP');
    DBMS_OUTPUT.PUT_LINE('');
    GET_TEACHERS('TOV');
END;
/


-- ������� �3b ��������� ������ �������� ������ ��������� �� ������� SUBJECT, ������������ �� ��������, �������� ����� ������� � ���������. ������������ ��������� ���� � ����������������� ���������� ���������.
CREATE OR REPLACE PROCEDURE GET_SUBJECTS(
    PCODE SUBJECT.PULPIT%TYPE
)
IS
    CURSOR SUBJECTS_CURSOR
    IS
        SELECT *
        FROM SUBJECT
        WHERE PULPIT = PCODE
    ;
    SUBJECT_RECORD SUBJECTS_CURSOR%ROWTYPE;
BEGIN
    FOR SUBJECT_RECORD IN SUBJECTS_CURSOR LOOP
        DBMS_OUTPUT.PUT_LINE(
            SUBJECTS_CURSOR%ROWCOUNT
        ||  '. '
        ||  SUBJECT_RECORD.PULPIT
        ||  ' '
        ||  SUBJECT_RECORD.SUBJECT
        ||  ' '
        ||  SUBJECT_RECORD.SUBJECT_NAME
        );
    END LOOP;
END GET_SUBJECTS;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('          GET_SUBJECTS');
    GET_SUBJECTS('ISiT');
    DBMS_OUTPUT.PUT_LINE('');
    GET_SUBJECTS('POiSOI');
END;
/


-- ������� �4a ������� ������ �������� ���������� �������������� �� ������� TEACHER, ���������� �� ����������, �������� ����� � ���������. ������������ ��������� ���� � ����������������� ���������� ���������.
CREATE OR REPLACE FUNCTION GET_NUM_TEACHERS(
    FCODE FACULTY.FACULTY%TYPE
)
RETURN NUMBER
IS
    NUM_TEACHERS NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO NUM_TEACHERS
    FROM
        TEACHER
        INNER JOIN PULPIT ON PULPIT.PULPIT = TEACHER.PULPIT
    WHERE FACULTY = FCODE
    ;
    RETURN NUM_TEACHERS;
END GET_NUM_TEACHERS;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('          GET_NUM_TEACHERS');
    DBMS_OUTPUT.PUT_LINE('IDiP: ' || GET_NUM_TEACHERS('IDiP'));
    DBMS_OUTPUT.PUT_LINE('TOV: ' || GET_NUM_TEACHERS('TOV'));
END;
/


-- ������� �4b ������� ������ �������� ���������� ��������� �� ������� SUBJECT, ������������ �� ��������, �������� ����� ������� ���������. ������������ ��������� ���� � ����������������� ���������� ���������. 
CREATE OR REPLACE FUNCTION GET_NUM_SUBJECTS(
    PCODE SUBJECT.PULPIT%TYPE
)
RETURN NUMBER
IS
    NUM_SUBJECTS NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO NUM_SUBJECTS
    FROM SUBJECT
    WHERE PULPIT = PCODE
    ;
    RETURN NUM_SUBJECTS;
END GET_NUM_SUBJECTS;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('          GET_NUM_SUBJECTS');
    DBMS_OUTPUT.PUT_LINE('ISiT: ' || GET_NUM_SUBJECTS('ISiT'));
    DBMS_OUTPUT.PUT_LINE('POiSOI: ' || GET_NUM_SUBJECTS('POiSOI'));
END;
/


-- ��������
DROP FUNCTION GET_NUM_SUBJECTS;
DROP FUNCTION GET_NUM_TEACHERS;
DROP PROCEDURE GET_SUBJECTS;
DROP PROCEDURE GET_TEACHERS;
