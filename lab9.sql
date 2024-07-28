---2 временную таблицу
alter session set "_oracle_script" = true;
alter database open;

create global temporary table TAV_TEMP(id int, data nvarchar2(30) )
insert into TAV_TEMP(id, data) values (1, 'aaa');
insert into TAV_TEMP(id, data) values (2, 'www'); 
insert into TAV_TEMP(id, data) values (3, 'eee');
insert into TAV_TEMP(id, data) values (4, 'rrr');
insert into TAV_TEMP(id, data) values (5, 'qqq');
insert into TAV_TEMP(id, data) values (6, 'sss');
select * from TAV_TEMP;

---3 —оздайте последовательность S1 (SEQUENCE) 
create sequence s1
start with 1000
increment by 10
nominvalue
nomaxvalue
nocycle
nocache
noorder;

select s1.nextval from dual;
select s1.currval from dual;

--- 4 последовательность S2 (SEQUENCE)

create sequence s2
start with 10
increment by 10
maxvalue 100
nocycle;

select s2.nextval from dual;
select s2.currval from dual;

--- 5 последовательность S3 (SEQUENCE)

create sequence s3
start with 10
increment by -10
maxvalue 10
minvalue -100
nocycle
order;

select s3.nextval from dual;
select s3.currval from dual;

--- 6 последовательность S4 (SEQUENCE)
create sequence s4
start with 1
increment by 1
minvalue 1
maxvalue 10
cycle
cache 5
noorder;

select s4.nextval from dual;
select s4.currval from dual;

--- 7 список всех последовательностей
select * from user_sequences;

--- 8 —оздайте таблицу T1
create table t1 (n1 number (20), n2 number (20), n3 number (20), n4 number (20))
cache
storage (buffer_pool keep);

alter sequence s1 restart;
alter sequence s2 restart;
alter sequence s3 restart;
alter sequence s4 restart;

insert into t1 (n1, n2, n3, n4) values (s1.nextval, s2.nextval, s3.nextval, s4.nextval);
insert into t1 (n1, n2, n3, n4) values (s1.nextval, s2.nextval, s3.nextval, s4.nextval);
insert into t1 (n1, n2, n3, n4) values (s1.nextval, s2.nextval, s3.nextval, s4.nextval);
insert into t1 (n1, n2, n3, n4) values (s1.nextval, s2.nextval, s3.nextval, s4.nextval);
insert into t1 (n1, n2, n3, n4) values (s1.nextval, s2.nextval, s3.nextval, s4.nextval);
insert into t1 (n1, n2, n3, n4) values (s1.nextval, s2.nextval, s3.nextval, s4.nextval);
insert into t1 (n1, n2, n3, n4) values (s1.nextval, s2.nextval, s3.nextval, s4.nextval);

select * from t1;

--- 9 —оздайте кластер ABC
create cluster abc (X number(10), V varchar2(12))
hashkeys 200;

-- 10.	—оздайте таблицу A
create table A(XA number(10), VA varchar2(12), YA int )
cluster abc(XA, VA);

-- 11.	—оздайте таблицу B
create table B(XB number(10), VB varchar(12), YB int)
cluster abc(XB, VB);

--12.	—оздайте таблицу —
create table C(XC number(10), VC varchar(12), YC int)
cluster abc(XC, VC);


--13. созданные таблицы и кластер 
select * from user_clusters
select * from user_segments
select * from user_tables

--14.	—оздайте частный синоним 
create table sys.C(id int, data nvarchar2(20));
create synonym CSYN for sys.C;

select * from sys.C;
select * from CSYN;

--15.	—оздайте публичный синоним
create table sys.P(id int, data nvarchar2(20));
create public synonym PSYN for sys.P

select * from sys.P
select * from PSYN

-- 16.	—оздайте две произвольные таблицы A и B 
create table A (id int, data varchar(20));
create table B (id int, data varchar2(20));

insert into A(id, data) values (1, 'qqq');
insert into A(id, data) values (2, 'aaa');

insert into B(id, data) values (2, 'www');
insert into B(id, data) values (2, 'www');
insert into B(id, data) values (2, 'www');
insert into B(id, data) values (3, 'rrr');
select * from A;
create view V1 
as 
select A.id, B.data
from A inner join B on A.id = B.id;

drop view V1
select * from V1;

-- 17 материализованное представление MV_XXX
--(pdb system)
create materialized view MV_TAV
refresh force start with sysdate next sysdate + interval '2' minute
enable query rewrite as
select A.id, B.data
from A inner join B on A.id = B.id;

drop view MV_TAV

insert into A(id, data) values (2, 'qqq1');
insert into B(id, data) values (1, 'www2');

select * from MV_TAV;



drop table TAV_TEMP;
drop sequence s1;
drop sequence s2;
drop sequence s3;
drop sequence s4;

drop table t1;
drop table A;
drop table B;
drop table C;

drop cluster ABC;
drop synonym CSYM;
drop public synonym BSYM;

drop view V1;
drop materialized view MV_TAV;
drop table A;
drop table B;

---- как добавл€ютс€ таблички в кластер
--18-19 задание

create database link univer
connect to testuser identified by Pa$$w0rd
USING '(DESCRIPTION=
          (ADDRESS=(PROTOCOL=TCP)(HOST=80.94.168.150)(PORT=1521))
          (CONNECT_DATA=(SERVICE_NAME=ora12w))
)';

select * from tav_test_l9@univer

insert into tav_test_l9@univer values (1);
insert into tav_test_l9@univer values (2);
insert into tav_test_l9@univer values (3);

delete tav_test_l9@univer where id = 2; 
update tav_test_l9@univer set id = 22 where id=3;


begin
   tav_printer@univer;
end;

