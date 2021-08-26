--서브쿼리 (where 절에 들어가는) 
--서브쿼리 사용법
--1.(  )안에 반드시 작성함
--2.단일행 서브쿼리 절의 결과는 반드시 1행이어야합니다.
--3.조건절보다 오른쪽에 위치합니다.
--4.서브쿼리절을 먼저 해석하면됩니당!

--낸시의 급여보다 월급을 많이받는 사람을 조회

--먼저 낸시의 급여을 한번 보기
select salary from employees 
where first_name ='Nancy';

select * 
from employees
where salary >(select salary from employees where first_name='Nancy');

--직원아이디가 103번직원과 같은 job을 가진사람
select *
from employees
where job_id in (select job_id from employees where employee_id =103);

--행이 여러개인것은 단일 쿼리행을 사용불가 ~
--그럴경우 다중행 서브쿼리 이용!
--다중쿼리연산자 in , any, some , all
--in 완전히 같은 애들
select * from employees
where salary in (select salary from employees 
where first_name ='David');

-- >any: 최솟값보다 커야함
select first_name , salary from employees
where salary >any (select salary from employees 
where first_name ='David');

--< any: 최대 값보다 작아야함
select first_name , salary from employees
where salary < any (select salary from employees where first_name='David');

-- >all 최댓값보다 커야함 
select first_name , salary from employees
where salary > all (select salary from employees
where first_name ='David');

--<all 최댓값보다작아야함
select first_name , salary from employees
where salary <all (select salary from employees
where first_name ='David');

-------스칼라 쿼리 (select 리스트에 select 절이 들어가는 구문 , left other join과 동일한 결과) 
--스칼라 쿼리 사용방법
--where 절에 join의 조건 기술
 
select e.*,
(select department_name 
from departments d 
where d.department_id =e.department_id)as department_name
from employees e
order by first_name desc;

--위의 방법을 left outer join으로 쓴것!
select e.*, d.department_name
from employees e
left outer join departments d on e.department_id = d.department_id;

--left join(부서장의 이름)
select * from departments;
select * from employees;

select d.*,
e.frist_name
from departments d
left outer join employees e on d.manager_id = e.employee_id;

--스칼라쿼리 (부서장의 이름)

select d.*,
(select first_name from employees e 
where d.manager_id =e.employee_id )
from departments d
order by department_id ;

--스칼라 쿼리 (department테이블과 , locations 테이블의 city, address 정보)
select * from employees;
select * from departments;
select * from locations;

select d.*,
(select city from locations l where d.location_id= l.location_id)as city,
(select street_address from locations l where d.location_id = l.location_id)as 
from departments d;

--스칼라 쿼리 (각 부서별 사원수)-employees 그룹핑
select count(*) from employees group by department_id;

select d.*,
nvl((select count(*) from employees e 
where e.department_id =d.department_id
group by department_id),0) as 부서별사원수
from departments d;

-------인라인뷰 (from 절에 select 문이 들어가는 형태~~, from 절 이하문을 가상의 테이블로 생각하면 됩니당!!)

select * from (select * from employees);

--로우넘이 섞이는 문제
select rownum , first_name , job_id , salary from employees
order by salary;

--인라인뷰로 해결 ~_~ /
select rownum
       ,first_name
       ,job_id
       ,salary 
from (select first_name , job_id , salary
from employees
order by salary
);

--인라인뷰로 나온 결과에 대해서 10행까지만 출력 
select rownum,
a.*
from (select 
             first_name , 
             job_id , 
             salary 
      from employees 
      order by salary) a
where rownum <=10;
--인라인뷰로 나온 결과에 대해서 10~20행까지만 출력  
--rownum은 첫번째 행부터 조회할 수있어용 10-20을 출력하면결과가안나옵니당ㅜ


select *
from (select rownum as rn,
first_name , 
job_id , 
salary
from (select * from employees 
order by salary)
)
where rn > 10 and rn <=20; --11-20번 까지의 결과

--인라인 뷰 (이 가상테이블 기준 , 03월 01일 데이터만 추출)

select*
from (select name , to_char(to_date (test , 'YYYY/MM/DD'),'MM-DD') as mm
from (select '홍길동' as name , '20200211' as test from dual union all
select '이순신' , '20190301' from dual union all
select '탁소현','20200403' from dual union all
select '김유신 ', '20200403' from dual union all
select '홍길자', '20200301' from dual
)
)where mm= '03-01';

--응용 :join테이블의 위치로 인라인뷰 삽입가능 or 스칼라 쿼리와 혼용가능
--salary 가 10000이상인 직원의 이름 , 부서명, 부서의 주소, job_title 을 출력
--salary 기준 내림차순
select * from departments;
select * from locations;
select * from jobs;
select * from employees;



--join 방법으로
select e.*,
         d.department_id,
         l.street_address,
         j.job_title
from employees e
left outer join departments d 
on e.department_id = d.department_id
left outer join locations l on d.location_id = l.location_id
left outer join jobs j on e.job_id = j.job_id
where salary >=10000;

--두번째
select a.*,
       (select street_address from locations l where l.location_id = a.location_id)as at,
       (select job_title from jobs j where j.job_id = a.job_id)as jt
from   (select* 
        from employees e
        left outer join departments d 
        on e.department_id = d.department_id
        where salary >=10000
) a ;

--정리 where 절에 들어가는 서브쿼리문은 단일형 vs 다중행(in,any ,all)
--스칼라쿼리 -select 리스트에 들어가는 서브쿼리 (단일행의 결과로 쓰여야함 , left outer join 과 같은 역할)
--인라인 뷰 :from절에 들어가는 서브쿼리(안쪽에서 필요한 쿼리문을 작성 , 가상테이블의 형태)





