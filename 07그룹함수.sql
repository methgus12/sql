--그룹함수 sum , avg, min, max, count
select sum (salary), avg(salary), min(salary), max(salary), count(salary) from employees;
--부서가 50인 사람들의 급여합
select sum(salary) from employees where department_id =50;

select count(*) from employees; --전체행수

select count (commission_pct) from employees;--null이 아닌 행수

select count(manager_id) from employees;--null이 아닌 행수

--group by 절
select * from employees;
select job_id from employees group by job_id;
--group by 절에서 그룹함수의 사용이가능함
select job_id , avg(salary) from employees group by job_id;--job_id 별 급여평균

--부서별 급여평균
select department_id, avg(salary) from employees group by department_id;

--주의할점
--그루핑이 되지않으면 그룹함수와 일반컬럼을 동시에 사용하지못함
select count(*), job_id from employees

--2개 이상의 group by 절
select * from employees;

select department_id , job_id from employees 
group by department_id , job_id 
order by department_id desc;

select department_id , job_id , avg(salary)
from employees
group by department_id, job_id
order by department_id;
--where 절은 일반행에대한 조건임
--having : 그룹화된 절의 조건 group by 와 짝꿍!
--having (그룹함수) 그룹함수의 조건

select department_id , sum(salary)
from employees 
group by department_id
having sum(salary) > 100000;

--job_id 별 개수
select job_id, count(*)
from employees
group by job_id
having count(*) >= 5 
order by count(*) desc; --내림차순 정렬

--부서아이디가 50이상인 행을 그루핑하고 
--부서별 평균급여 5000이상만 조회, 정렬

select department_id  , avg(salary) as 부서평균
from employees
where department_id >= 50
group by department_id 
having avg(salary) >=5000
order by 부서평균 desc;

--count(*) over(): 그룹핑 하지않고 예외적으로 총 행의 수를 붙여서 조회하는 구
select department_id , first_name , count(*) over()
from employees;

select * from employees;
--문제 1.
--1-1.사원 테이블에서 JOB_ID별 사원 수를 구하세요.
select job_id,count(*) as 사원수 from employees group by job_id; 

--1-2.사원 테이블에서 JOB_ID별 월급의 평균을 구하세요. 월급의 평균 순으로 내림차순 정렬하세요
select job_id , avg(salary) as 월급평균
from employees 
group by job_id order by 월급평균 desc;

--문제 2.
--사원 테이블에서 입사 년도 별 사원 수를 구하세요.

select to_char (hire_date,'YYYY') , count(*) as 년도별사원수
from employees
group by to_char (hire_date,'YYYY') 
order by to_char (hire_date,'YYYY') desc;

--문제 3.
--급여가 1000 이상인 사원들의 부서별 평균 급여를 출력하세요. 
--단 부서 평균 급여가 2000이상인 부서만 출력

select avg(salary) as 평균급여 , department_id from employees
where salary >= 1000
group by department_id
having avg(salary) >=2000
order by department_id ;

--문제 4.
--사원 테이블에서 commission_pct(커미션) 
--컬럼이 null이 아닌 사람들의 
--department_id(부서별) salary(월급)의 평균, 합계, count를 구합니다.
--조건 1) 월급의 평균은 커미션을 적용시킨 월급입니다. 
--조건 2) 평균은 소수 2째 자리에서 절삭 하세요.

select department_id as 부서, 
trunc (avg(salary+ salary * commission_pct),2) as 부서별월급평균, 
sum (salary + salary * commission_pct) as 부서별월급총합, 
count(*)as 사원수
from employees
where commission_pct is not null
group by department_id;



