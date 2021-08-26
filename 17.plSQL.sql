/*
PL / SQL은 프로그램 언어 SQL문입니다.
쿼리문들의 집합으로 어떤 동작을 일괄 처리하기위한 용도로 사용을 합니다.
절차형 SQL은 지정된 구문안에서 컴파일 하는 형식으로 실행합니다.
*/

set serveroutput on;--출력문 활성화

declare --변수선언문 
v1_num number; --변수명 타입 : 변수선언
begin --시작문
v1_num := 10; --  := 은 대입
DBMS_OUTPUT.PUT_line(V1_num);-- 출력문
end; --끝

--연산자 (+ , - , /,*,<>,==,**)

declare 
   A number := (2 * 3 + 2 )** 2;

begin
   dbms_output.put_Line('A=' || A);
end;
/*
DML 문과 혼용해서 사용
DDL문장은 사용할 수 없고 일반적으로 select 구문을 사용
특이한 점은 select 와 from 사이에 into 절을 사용합니다.
*/

declare
     emp_name varchar2(50);
     dep_name varchar2(50);
begin
    select e.first_name , d.department_name
    into emp_name , dep_name --받아올 변수 선정해주기
    from employees e
    left outer join departments d
    on e.department_id = d.department_id
    where employee_id =100;
    
    DBMS_OUTPUT.put_line(emp_name||'의 부서는 '|| dep_name);
end;

/*
선언한 변수와 select 로 조회결과의 데이터 타입이 다르면 오류로 발생시키는데 
해당 테이블의 컬럼과 동일한타입의 변수를 선언하려면 테이블%type 문을 사용
*/

declare
     emp_name employees.first_name%type;
     emp_hire employees.hire_date%type;
     emp_sal employees.salary%type;
begin
     select first_name , hire_date, salary 
     into emp_name, emp_hire, emp_sal
     from employees 
     where employee_id =100;
     DBMS_OUTPUT.put_line(emp_name ||'의입사일'|| emp_hire ||',급여:'||emp_sal);
end;

/*
select 문과 insert 문 dml문을 같이 사용할수있습니다.
*/
create table emp_sal(
   emp_years varchar2(50),
   emp_salary number(10)
   );
   
declare
   emp_sum employees.salary%type;
   emp_years emp_sal.emp_years%type :=2008;
begin
--select
   select sum(salary)
   into emp_sum
   from employees
   where to_char(hire_date,'yyyy' )=emp_years;

--insert
   insert into emp_sal values(emp_years, emp_sum);
    
--commit
   commit;
   
   
   DBMS_OUTPUT.PUT_LINE(emp_sum);
end;

select * from emp_sal;
