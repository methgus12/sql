/*view 는 제한적인 자료만 보기위해서 사용하는 가상의 테이블입니다.
뷰는 물리적테이블을 이용한 가상 테이블이기 때문에 필요한 데이터만 저장해두면 조회에 이점을 가집니다
뷰를 이용해서 데이터에 접근하면 원본데이터는 안전하게 보호할수있습니다.
뷰는 계정에 생성권한이있어야 만들수 있습니다.*/

select * from user_role_privs;--사용자 권한 확인

--단순뷰 (하나의 테이블에서 필요한 데이터만 추출한 뷰)
create or replace view view_emp
as (select employee_id,
           first_name || ' '|| last_name as name, --엘리어스 필수!
           job_id,
           salary
        from employees
        where department_id=60);
        
select * from view_emp;

--복합뷰 (여러 테이블을 조인해서 필요한데이터만 저장한 뷰)
create or replace view view_emp_dept_job
as(select e.employee_id,
       first_name || ' '|| last_name as name, --엘리어스 필수
       e.salary,
       d.department_name,
       j.job_title
from employees e
join departments d on e.department_id = d.department_id 
join jobs j on e.job_id = j.job_id
);

--뷰의 수정 (create or replace view~)
--동일한 이름으로 만들면 데이터가 변경됩니다.

create or replace view view_emp_dept_job
as (select e.employee_id,
           first_name || ' ' || last_name as name,
           e.hire_date,
           e.salary,
           d.department_name,
           j.job_title
    from employees e
    join departments d on e.department_id =d.department_id
    join jobs j on e.job_id = j.job_id);
    
    
select * from view_emp_dept_job;

--뷰를 적절히 이용하면 데이터를 쉽게 조회할수있습니다.
select job_title, avg(salary)
from view_emp_dept_job
group by job_title;

--뷰삭제
drop view view_emp_dept_jobs;
/*전부 안되는 예시 주의!!*/
--name 가상열을 지니고 있는 경우 삽입불가.
--안되는 예시!!!!!
select * from view_emp;
insert into view_emp values (108,'TEST', 'IT_PROG',5000);

--안되는 예시 null을 허용하지않는 컬럼이있다면 삽입불가
insert into view_emp(employee_id , job_id , salary) 
values (108,'IT_PROG',5000);

--복합뷰의 경우에 한번에 야러 테이블에 대해 삽입불가
select * from view_emp_dept_job;
insert into view_emp_dept_job(employee_id , hire_date, salary , department_name, job_title) 
values(300,sysdate,8000,'TEST',TEST);

--with check option (조건절 컬럼의 수정을 막는 제약)
create or replace view view_emp_test
as (select employee_id, first_name, last_name, email , job_id , department_id
    from employees
    where department_id =100) with check option constraint view_emp_test_ck;


--department_id 에 제약조건이 걸리고 수정이안되는걸 확인
update view_emp_test set department_id =10 where employee_id =110;

--with read only (읽기전용뷰)
create or replace view view_emp_test
as (select employee_id, 
           first_name|| ' '|| last_name as name 
    from employees) with read only;
    

    
    