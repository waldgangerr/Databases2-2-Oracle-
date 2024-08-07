-- ������� �5 ������������ ����� TEACHERS, ���������� ��������� � �������:
CREATE OR REPLACE PACKAGE TEACHERS IS

    PROCEDURE GET_TEACHERS(FCODE FACULTY.FACULTY%TYPE);
    PROCEDURE GET_SUBJECTS(PCODE SUBJECT.PULPIT%TYPE);
    FUNCTION GET_NUM_TEACHERS(FCODE FACULTY.FACULTY%TYPE) RETURN NUMBER;
    FUNCTION GET_NUM_SUBJECTS(PCODE SUBJECT.PULPIT%TYPE) RETURN NUMBER;
    
END TEACHERS;
/
CREATE OR REPLACE PACKAGE BODY TEACHERS IS

    PROCEDURE GET_TEACHERS(
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
    
    PROCEDURE GET_SUBJECTS(
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
    
    FUNCTION GET_NUM_TEACHERS(
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
    
    FUNCTION GET_NUM_SUBJECTS(
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
    
END TEACHERS;
/

-- ������� �6 ������������ ��������� ���� � ����������������� ���������� �������� � ������� ������ TEACHERS.
BEGIN
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('          TEACHERS.GET_TEACHERS');
    TEACHERS.GET_TEACHERS('IDiP');
    DBMS_OUTPUT.PUT_LINE('');
    TEACHERS.GET_TEACHERS('TOV');
    
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('          TEACHERS.GET_SUBJECTS');
    TEACHERS.GET_SUBJECTS('ISiT');
    DBMS_OUTPUT.PUT_LINE('');
    TEACHERS.GET_SUBJECTS('POiSOI');
    
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('          TEACHERS.GET_NUM_TEACHERS');
    DBMS_OUTPUT.PUT_LINE('IDiP: ' || TEACHERS.GET_NUM_TEACHERS('IDiP'));
    DBMS_OUTPUT.PUT_LINE('TOV: ' || TEACHERS.GET_NUM_TEACHERS('TOV'));
    
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('          TEACHERS.GET_NUM_SUBJECTS');
    DBMS_OUTPUT.PUT_LINE('ISiT: ' || TEACHERS.GET_NUM_SUBJECTS('ISiT'));
    DBMS_OUTPUT.PUT_LINE('POiSOI: ' || TEACHERS.GET_NUM_SUBJECTS('POiSOI'));
END;
/

-- ��������
DROP PACKAGE TEACHERS;
