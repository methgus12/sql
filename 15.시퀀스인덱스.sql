--시퀀스 (순차적으로 증가하는 값)
select * from user_sequences ;

--시퀀스 생성문
--create sequence dept2_seq; --자동생성
create sequence dept2_seq
   increment by 1 
   start with 1 --시작값
   maxvalue 10 --최댓값
   nocache --캐시 X
   nocycle; --사이클 X
   
create table dept2 (
     dept_no number(2) primary key,
     dept_name varchar2(20),
     loca number(4)
);
--시퀀스사용
--시퀀스 이름 .nextval
insert into dept2 values (dept2_seq.nextval, 'TEST',300);
insert into dept2 values (dept2_seq.nextval, 'TEST',300);
insert into dept2 values (dept2_seq.nextval, 'TEST',300);
select* from dept2;

--얼만큼 증가되어있는지 보여줌 select 시퀀스명.currval
select dept2_seq.currval from dual;

--증가
select dept2_seq.nextval from dual;

--시퀀스 변경 alter sequence 시퀀스명

alter sequence dept2_seq maxvalue 100000;--최대값변경
alter sequence dept2_seq increment by 100;--증가값 변경
alter sequence dept2_seq minvalue 1;--최솟값 변경
--alter table dept2 modify dept_no number(5);

--시퀀스 삭제 drop  sequence 시퀀스명
drop sequence dept2_seq;

--시퀀스를 다시 처음으로 되돌리는 방법
create sequence dept2_seq
     increment by 10
     nocache 
     nocycle;
     
select dept2_seq.nextval from dual;
--1.현재 시퀀스 확인
select dept2_seq.currval from dual;
--2.증가값을 현재 시퀀스 만큼  -1만큼 
alter sequence dept2_seq increment by -51;
--3.한번 nextval
select dept2_seq.nextval from dual;
--4.증가값을 1로변경
alter sequence dept2_seq increment by 1;

create table dept3 (
     dept_no varchar2(30) primary key,
     dept_name varchar2(30)
);

create sequence dept3_seq
       increment by 1
       start with 1
       maxvalue 30
       nocache
       nocycle;
       
     
insert into dept3 values (to_char(sysdate, 'YYYYMMDD'),'TEST');
select to_char (sysdate, 'YYYYMMDD' || '-' || lpad(dept2_seq.nextval,5,0)) from dual;
     
--자동인덱스는 primary key 또는 unique 제한 규칙에 자동적으로 생성되는 인덱스
--수동인덱스는 create index 명령을 실행해서 만드는 인덱스들입니다.


--인덱스
--인덱스 primary key, unique 제약조건을 사용할때 자동으로 생성되고
--또는 수동으로 직접 생성할 수 있습니다
--인덱스는 인덱스를 저장하는 추가적인공간을 가지고 생성되고 , 조회를 빠르게 합니다.
--다만 수정, 삭제 , 변경이 빈번하게 일어나는 컬럼에  적용하면 오히려 성능부하를 일으킬수 있습니다.

select * from emps where first_name ='Nancy';

--emps 에 first_name 에 인덱스 부여
create index emp_first_name_idx on emps(first_name);

--인덱스삭제

drop index emp_first_name_idx;

--인덱스를 hint 로 사용하는 SQL문

CREATE TABLE T_BOARD(
       BNO NUMBER(10) PRIMARY KEY, 
       WRITER VARCHAR2(20)

);
create sequence t_board_seq;
insert into t_board values (t_board_seq.nextval, 'TEST');
insert into t_board values (t_board_seq.nextval, 'TEST');
insert into t_board values (t_board_seq.nextval, 'TEST');
insert into t_board values (t_board_seq.nextval, 'TEST');
insert into t_board values (t_board_seq.nextval, 'TEST');
commit;

select count (*) from t_board;

select * from t_board;

--40-50번째 테이블
select *
from (select rownum rn,
              bno,
              writer
      from (select *
            from t_board 
            order by bno desc
             )
)where rn > 40 and rn <= 50;

--인덱스 이름변경
alter index SYS_C007092 rename to t_board_idx;

--hint 조회방법
select *
from (select /*index_desc (t_board t_board_idx)*/
        rownum rn, 
        bno,
        writer
from t_board 
) where rn > 40 and rn <= 50;

