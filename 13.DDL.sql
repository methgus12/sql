--DDL (데이터베이스 정의문)
--트랜잭션을 적용할 수 없습니다.

--오라클은 테이블명의 대소문자를 가리지않습니다.
create table DEPT2(
      dpet_no number (2,0), --2자리수 , 소수점은 허용
      dpet_name varchar2(14),--14바이트 영어는 14글자 한글은 7글자
      loca varchar2(10),
      dept_date date ,
      dept_bonus number(10),--10자리수
      del_yn char(1)--고정문자 1개
      
);

desc dept2;

insert into dept2 values(99,'영업','서울',sysdate, 10000000, 'Y');

--테이블 열 추가 , 수정, 이름변경 , 삭제
--열추가
alter table dept2 add(dept_count number(3));
desc dept2;

--열 이름 변경 
alter table dept2 rename column dept_count to emp_count;

--열의 수정 (타입수정)
alter table dept2 modify (emp_count number (10));

--열 삭제
alter table dept2 drop column emp_count;

--테이블 삭제
--drop table dept2; 

--테이블 구조는 남기고 영구삭제
truncate table dept2;

select * from dept2;--확인

----테이블 생성과 제약조건-----------
--primary key는 테이블의 고유키 , 중복 X , null X
--unique (중복 X)
--not null : null 값을 허용하지않는다
--foreign key 참조하는 테이블에 pk를 저장하는 컬럼, 참조테이블의 pk 에 없다면 등록 불가 단 , null 은 허용
--check 정의된 형식만 저장되도록허용

drop table dept2;


create table dept2 (
             dept_no number(2)      constraint dept2_dept_no_pk primary key, --테이블 열 레벨의 제약조건 
             dept_name varchar2(15) not null,
             loca number(4)         constraint dept2_loca_locid_fk REFERENCES locations (location_id),
             dept_date date         default sysdate, --아무것도 입력안되면 자동으로 디폴트 값이 저장 (현재날짜)
             dept_bonus number(10),
             dept_phone varchar2(20)not null CONSTRAINT dept2_dept_phone_uk unique,
             dept_gender char(1)    constraint dept2_dept_gender_ck check (dept_gender in ('M','F'))
);

desc locations;
--열레벨 제약조건 , 열레벨에서는 constraint 구문이 생략가눙
create table dept2 (
             dept_no number(2) primary key, --테이블 열 레벨의 제약조건 
             dept_name varchar2(15) not null,
             loca number(4)  REFERENCES locations (location_id),
             dept_date date default sysdate, --아무것도 입력안되면 자동으로 디폴트 값이 저장 (현재날짜)
             dept_bonus number(10),
             dept_phone varchar2(20) not null unique,
             dept_gender char(1)  check (dept_gender in ('M','F'))
);

create table dept2(
       dept_no number(2),
       dept_name varchar2(15) not null,
       loca number (4),
       dept_date date default sysdate,
       dept_phone varchar2(20) not null,
       dept_gender char(1),
       --테이블 제약조건은 아래쪽에 제약조건만 분리해서 작성
       --슈퍼키를 테이블 레벨로 가능합니다. 
       
       constraint dept2_dept_no_pk primary key (dept_no/*,dept_name*/),
       constraint dept2_loca_locid_fk foreign key(loca) references locations(location_id),
       constraint dept2_phone_uk unique (dept_phone),
       constraint dept2_dept_gender_ck check (dept_gender in ('N', 'F'))
);

--안되는것 !! 개체 무결성 null과 중복을 허용하지 않는다는제약
select * from employees where employee_id =100;
insert into employees (employee_id , last_name , email, hire_date, job_id)
values(100,'test', 'test', sysdate, 'test');

--이것도 안됨!! 참조무결성(참조테이블 pk에 존재해야 fk에 들어갈수 있다느 제약)
insert into employees (employee_id , last_name , email, hire_date, job_id,department_id)
values(501,'test', 'test', sysdate, 'test',5);

--도메인무결성(캆에 컬럼에 정의된 속한 값이어야하다는 제약)
insert into employees (employee_id , last_name , email, hire_date, job_id,salary)
values(100,'test', 'test', sysdate, 'test',-10);


--제약조건 추가 , 삭제

drop table dept2;

create table dept2 (
             dept_no number(2) , --테이블 열 레벨의 제약조건 
             dept_name varchar2(15) ,
             loca number(4)  ,
             dept_date date default sysdate, --아무것도 입력안되면 자동으로 디폴트 값이 저장 (현재날짜)
             dept_bonus number(10),
             dept_phone varchar2(20) ,
             dept_gender char(1)  
);

--pk추가

alter table dept2 add constraint dept2_dept_no_pk primary key (dept_no);

--fk 추가
alter table dept2 add constraint dept2_dept_no_fk foreign key(loca) references locations(location_id);

--check 추가

alter table dept2 add constraint dept2_dept_gender_ck check (dept_gender in ('M','F'));

--unique 추가

alter table dept2 add constraint dept2_dept_phone_uk unique (dept_phone);

--not null 추가 modify 문으로 추가 :일반적으로 얼레벨로 정의
alter table dept2 modify dept_phone varchar2(20) not null;

--제약조건 삭제
--제약조건의 확인

select * from user_constraints where table_name ='DEPT2';

--제약조건의 삭제
alter table dept2 drop constraint dept2_dept_no_pk;

drop table dept2;
drop table members;

--문제1

create table members (
    m_name varchar2(20) not null,
    m_num number(3), 
    reg_date date not null,
    gender varchar2(1),
    loca number(4)
);
alter table members add constraint mem_num_pk primary key (m_num); --PK
alter table members add constraint mem_regdate_uk unique (reg_date); -- UK
alter table members add constraint mem_loca_loc_locid_fk foreign key (loca) references locations(location_id); --FK

select * from user_constraints where table_name = 'MEMBERS'; --Ȯ��

insert into members values('AAA', 1, to_date('2018/07/01', 'YYYY/MM/DD'), 'M', 1800);
insert into members values('BBB', 2, to_date('2018/07/02', 'YYYY/MM/DD'), 'F', 1900);
insert into members values('CCC', 3, to_date('2018/07/03', 'YYYY/MM/DD'), 'M', 2000);
insert into members values('DDD', 4, sysdate, 'M', 2000);
commit;

--문제2
select m.m_name,
       m_num,
       l.street_address,
       l.location_id
from members m
join locations l
on m.loca = l.location_id
order by m_num;