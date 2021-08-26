--사본테이블
create table emps_it as (select * from employees where 1=2);

desc emps_it;
insert into emps_it(employee_id,last_name , email , hire_date , job_id) 
values (103,'gildong', 'kkk', sysdate, 'IT_PROG');

select * from emps_it;
--merge into 타켓 엘리어스
--using (병합시킬 테이블의 데이터)
--on (두 테이블의 연결조건)
--wher match then(일치할 경우 수행할 작업)
--when not match then(일치하지않을 경우 수행할 작업)

merge into emps_it a
using (select *
       from employees 
       where job_id = 'IT_PROG') b
on (a.employee_id = b.employee_id)
when matched then 
    update set
        a.first_name = b.first_name,
        a.last_name = b.last_name,
        a.email = b.email,
        a.phone_number = b.phone_number,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id,
        a.job_id = b.job_id,
        a.hire_date = b.hire_date
when not matched then
    insert (employee_id, first_name, last_name, email, phone_number, manageR_id, department_id, job_id, hire_date) 
    values 
        (b.employee_id,
         b.first_name, 
         b.last_name, 
         b.email, 
         b.phone_number, 
         b.manager_id,
         b.department_id,
         b.job_id,
         b.hire_date
        );
        
select * from emps_it ;

--실습
--employees 테이블이 매번 수정되는 테이블이라고 가정 , 주마다 업데이트 시킨다
--emps_it을 업데이트
--기존의 데이터는 email , phone , salary , commission, manager_id , department_id는 업데이트 되도록 처리
--새로 유입된 데이터는 모든 컬럼을 그대로 추가

insert into emps_it (employee_id , first_name , last_name, email, hire_date, job_id) 
values (102,'홍', '길동', 'hong', '01/04/06', 'AD_VP');

insert into emps_it (employee_id , first_name , last_name, email, hire_date, job_id) 
values (101,'김', '나나', 'kim', '20/03/06', 'AD_VP');
select * from emps_it;
rollback;

merge into emps_it a
using (select * from employees) b --병합시킬데이터
on (a.employee_id = b.employee_id) --두테이블 연결조건
when matched then
     update set 
            a.email = b.email,
            a.phone_number = b.phone_number,
            a.salary = b.salary,
            a.commission_pct=b.commission_pct,
            a.manager_id = b.manager_id,
            a.department_id = b.department_id
when not matched then
      insert /*전부다들어가면 생략*/ values
           (b.employee_id,
            b.first_name,
            b.last_name,
            b.email,
            b.phone_number,
            b.hire_date,
            b.job_id,
            b.salary,
            b.commission_pct,
            b.manager_id,
            b.department_id
            );
            
select * from emps_it;
            
--CTAS (사본테이블) --pk와 fk와 같은 키는 복사하지 않습니다!(null 여부만 복사)

create table depts  as (select * from departments /*where 1=2*/ );
select * from depts;

