
select * from employees;

select first_name , last_name, job_id , 
department_id 
from employees where job_id ='IT_PROG';

select * from employees where first_name = 'Valli';
select * from employees where salary >= 15000;
select * from employees where department_id = 60;

--날짜형식 hire_date (년/월/일) 대소비교 가능 
select * from employees where hire_date >='08/01/01';

select * from employees where hire_date = '08/01/24';

--where 연산자 (between , in , like)

--between : -사이의 값
select* from employees where salary between 10000 and 20000;

select * from employees where hire_date between '05/01/31' and '05/12/31';

--in : 만족하면 출력 : in()

select * from employees where manager_id in (101,102,103);

SELECT*FROM employees WHERE job_id in ('AD_ASST', 'FI_MGR', 'IT_PROG');

--중요* like :검색할때 like'%단어%' , %는 단어 앞, 뒤 , 양쪽 다 가능
--'%단어%'는 사이가 아닌 단어를 포함하는 모든 것을 검색하는것임
select* from employees where first_name like 'A%'; --A로 시작하는것 
select * from employees where hire_date like '05%'; --05로 시작하는거 

select * from employees where hire_date like '%15'; --15로 끝나는
select * from employees where hire_date like '%07%'; --07이라는게 포함되는 전부

--사이의 값을 구하고 싶을 때 _를 이용하여 위치를 지정 _하나당 한칸
select * from employees where hire_date like '___07%';

--null인 값 찾기: IS NULL : =으로는 테스트 불가
select * from employees where commission_pct IS NULL;
--null이 아닌값 찾기: IS NOT NULL
select * from employees where commission_pct IS NOT NULL;

--여러조건 (AND 둘다 만족, OR하나만 만족해도됨)
--드물게 and 와 or 둘 다 같이 쓸 경우도 존재 and의 우선순위가 더 높음 , 즉 and 먼저 실행
select * from employees where job_id='IT_PROG' and salary >= 6000;
select * from employees where salary >= 10000 and salary <=20000;

select * from employees where job_id='AD_VP' or salary >= 15000;
--and가 먼저 실행되서 or가 먼저 실행되길 원할 경우 ()로 묶음
select * from employees where (job_id ='IT_PROG' or job_id ='AD_VP') and salary >=6000;


--데이터 정렬 : order by 문 
--asc:오름차순 , desc:내림차순

select * from employees order by first_name asc;
select * from employees order by hire_date asc;
select * from employees order by hire_date desc;

select * from employees 
where job_id in ('IT_PROG' , 'AD_VP') 
order by salary asc;

--급여가 5000이상인 사람들 중에서 직업아이디 기준으로 내림차순 정렬
select * from employees where salary >= 5000 order by employee_id desc;

--커미션이 null이 아닌 사람들 지원아이디 기준으로 오름차순
select * from employees 
where commission_pct is not null 
order by employee_id asc;

--order by 구문 동시에 쓰기 ,이용하면됨
--job_id 기준 오름차순 , 급여기준 내림차순:order by 쓰고 기준 , 기준
select*from employees order by job_id asc, salary desc;

--order by 절 별칭이용 :order by 메뉴명 정렬순서
--order by 절에서 엘리어스를 이용해서 정렬 가능
--as 메뉴명
select first_name ||' '|| last_name as 이름, 
salary , salary*12 as 연봉 
from employees
order by 연봉 desc;


