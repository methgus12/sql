--주석
--sql문은 oracle에서만 대소문자를 가리지 않습니다.wow!
--구문 마지막에 ; 마감 
--명령문실행 f9 , 스크립트 실행 f5(전체실행 - 주의해서사용)

select * from employees;

select employee_id, first_name , last_name from employees;

select employee_id, hire_date , salary from employees;

--null 값 확인
select employee_id , salary , commission_pct from employees;

--숫자 컬럼은 연산이 가능

select employee_id, salary, salary + salary *0.1 from employees;
select employee_id , salary , salary + salary *100 from employees;

--멜리어스 (컬럼명의 별칭) as

select employee_id as 사원아이디 ,
first_name as 이름 , 
last_name as 성,
salary + salary *0.1 as 급여 
from employees;

--컬럼연결 || , 문자열의 표현은 ''
--문자열안에서 인용부호 '홀따옴표 쓸때는 '' 이렇게 두번쓰면됩니당

select first_name || last_name from employees;
select first_name || ' ' || last_name from employees;
select first_name || ' ' || last_name || '''s salary is $' || salary as 급여내역 from employees;

--중복 행 제거 distinct

select distinct department_id from employees;
select distinct salary from employees;

-- 출력순서(rownum) , 데이터의 위치(rowid)

select rownum , rowid, employee_id , first_name from employees;
 



