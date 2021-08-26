--insert문

--테이블구조 확인 
desc departments;

--1nd

insert into departments (department_id , department_name, manager_id, location_id) values (290, '개발자',200, 1700 );
insert into departments (department_id ,department_name, location_id) values (300, '디자이너' , 1700);
insert into departments (department_id ,department_name, location_id) values (320, '학생' , 1700);
insert into departments (department_id ,department_name, location_id) values (330, '서버관리자' , 1700);

--2nd

insert into departments values (340, '퍼블러서', 200, 1700);
insert into departments values (350, '데이터분석가', 200, 1800);

select * from departments;

--DML 문장은 트랜잭션을 통해서 DML 이전으로 되돌릴수 있습니다
rollback;
select * from departments;


--테이블 구조 복사

create table managers as (select * from employees where 1 = 2);
select * from managers;

--3nd (다른테이블의 특정 행 , 서브쿼리절 insert)
insert into managers (select * from employees where job_id='IT_PROG');

insert into managers (employee_id , last_name, email, hire_date, job_id) 
(select employee_id , last_name, email, hire_date, job_id from employees where job_id ='FI_ACCOUNT');


select * from managers;

--update 문

desc employees;

--사본테이블 생성(데이터 까지 복사)

create table emps as (select * from employees where 1=1);
select * from emps;

update emps set salary = 30000; --전부다 바뀜 
rollback; --구원자.. 조심..

--update 문은 조건절을 반드시 명시합니다!
select * from emps where employee_id =103;

update emps set salary = salary * 1.1
where employee_id =100; --pk 기준

update emps set phone_number = '511.123.1111',
                hire_date = sysdate,
                commission_pct=0.1
            where employee_id =100;
            
select * from emps where employee_id =100;
            
--job_id 가 IT_PROG 인 사람의 커미션0.1로 업데이트

update emps set commission_pct = 0.1
where job_id = 'IT_PROG';

select * from emps where job_id = 'IT_PROG';--잘 되었는지 확인 !

--where 절에 서브쿼리
update emps set commission_pct =0.2 
where department_id = (select department_id from emps where first_name = 'Donald');

--확인
select * 
from emps where department_id =(select department_id from emps where first_name = 'Donald');

--set 절에 서브쿼리
--update emps set (컬럼대상) = (서브쿼리) where 조건
update emps set (job_id, salary , commission_pct, manager_id , department_id) =
                (select job_id , 
                        salary , 
                        commission_pct, 
                        manager_id, 
                        department_id 
                from employees where employee_id=103) 
where employee_id =102;

select * from employees where employee_id = 103 union all
select * from emps where employee_id =102;

rollback;

--delete 

select * from departments;

--(employees 테이블에서 50번부서를 참조하여 사용중이기 때문에 삭제이상)
--참조무결성 제약조건 위배
delete from department_id where department_id =50;--안됨

-- emps 에서 delete 실습 

delete from  emps where employee_id = 105;
rollback;

--where 절의 서브쿼리

select department_id from departments where department_name ='Shipping';-- 부서명 shipping의 부서번호

delete from emps where department_id = (select department_id from departments where department_name ='Shipping');
rollback ;

--조건을 잘못쓰면 안지워져요!
--기억할것

--1.
insert into table ()
values ()

--2.
update table set 
where

--3.
delete from table 
where
