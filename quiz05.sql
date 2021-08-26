--연습문제 *_*

--문제 1 depts 테이블의 다음을 추가하세요

insert into depts values (280, '개발', null, 800);
insert into depts values (290, '회계부', null, 1800) ;
insert into depts values (300, '재정', 301, 1800) ;
insert into depts values (310, '인사', 302, 1800) ;
insert into depts values (320, '영업', 303, 1700) ;

select * from depts; --추가확인
select * from departments;
--문제 2.
--DEPTS테이블의 데이터를 수정합니다
--1. department_name 이 IT Support 인 데이터의 
--department_name을 IT bank로 변경
select * from departments;

update depts set department_name ='IT bank'
where department_name ='IT Support';

--2. department_id가 290인 데이터의 manager_id를 301로 변경

update depts set manager_id = 301
where department_id= 290; 

--3. department_name이 IT Helpdesk인 데이터의 부서명을 IT Help로 , 
--매니저아이디를 303으로, 지역아이디를 1800으로 변경하세요

update depts set department_name ='IT Help',
                 manager_id=303,
                 location_id=1800
where department_name = 'IT Helpdesk';

--4. 이사, 부장, 과장, 대리 의 매니저아이디를 301로 한번에 변경하세요.

update depts set manager_id ='301'
where department_id in (select department_id from depts  where department_id between 290 and 320) ;

--문제 3.
--삭제의 조건은 항상 primary key로 합니다, 
--여기서 primary key는 department_id라고 가정합니다. 
--1. 부서명 영업부를 삭제 하세요

delete from depts where department_id =320;

--2. 부서명 NOC를 삭제하세요
delete from depts where department_id =220;

--문제 4
--1. Depts 사본테이블에서 department_id 가 200보다 큰 데이터를 삭제하세요.

delete from depts where department_id >200;


--2. Depts 사본테이블의 manager_id가 null이 아닌 데이터의 manager_id를 전부 100으로 변경하세요. 

update depts set manager_id =100
where manager_id is not null;

--3. Depts 테이블은 타겟 테이블 입니다.
--4. Departments테이블은 매번 수정이 일어나는 테이블이라고 가정하고 
--Depts와 비교하여 일치하는 경우 Depts의 부서명, 매니저ID, 지역ID를 
--업데이트 하고 새로유입된 데이터는 그대로 추가해주는 merge문을 작성하세요.

select * from departments;
merge into depts a 
using (select * from departments ) b
on(a.department_id= b.department_id)
when matched then
     update set 
             a.department_name= b.department_name,
             a.manager_id = b.manager_id,
             a.location_id=b.location_id
when not matched then
         insert  values 
         (b.department_id,
          b.department_name,
          b.manager_id,
          b.location_id);
          

--문제 5
--jobs_it 사본 테이블을 생성하세요 (조건은 min_salary가 6000보다 큰 데이터만 복사합니다) 
--jobs_it 테이블에 다음 데이터를 추가하세요
select * from jobs ;
create table  jobs_itt as( select * from jobs where min_salary > 6000);--테이블생성
rollback;

select * from jobs_itt;
insert into jobs_it (job_id , job_title, min_salary, max_salary)
values ('IT_DEV', '아이티 개발팀', 6000, 200000);

insert into jobs_it (job_id , job_title, min_salary, max_salary)
values ('NET_DEV', '네트워크 개발팀', 5000, 200000);
insert into jobs_it (job_id , job_title, min_salary, max_salary)
values ('SEC_DEV', '보안 개발팀', 6000, 190000);
          

--jobs_it은 타겟 테이블 입니다
--jobs테이블은 매번 수정이 일어나는 테이블이라고 가정하고 
--jobs_it과 비교하여 min_salary컬럼이 0보다 큰 경우 
--기존의 데이터는 min_salary, max_salary를 업데이트 하고 
--새로 유입된 데이터는 그대로 추가해주는 merge문을 작성하세요  

merge into jobs_itt j
using (select * from jobs where min_salary >0) k
on(j.job_id= k.job_id)
when matched then 
     update set 
             j.min_salary = k.min_salary,
             j.max_salary = k.max_salary
when not matched  then 
         insert values
         (k.job_id,
          k.job_title,
          k.min_salary,
          k.max_salary);
          
 select*from jobs_itt ;   --마지막확인!       
--이번퀴즈성공 ~~~>_<//

 commit;   

