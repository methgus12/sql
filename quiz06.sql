set SERVEROUTPUT ON;
--1.구구단 3단을 출력하는 익명블록
declare 
  v1 number :=3;
begin
  DBMS_OUTPUT.PUT_LINE(v1||'*'||1 ||'='||v1 * 1);
  DBMS_OUTPUT.PUT_LINE(v1||'*'||2 ||'='||v1 * 2);
  DBMS_OUTPUT.PUT_LINE(v1||'*'||3 ||'='||v1 * 3);
  DBMS_OUTPUT.PUT_LINE(v1||'*'||4 ||'='||v1 * 4);
  DBMS_OUTPUT.PUT_LINE(v1||'*'||5 ||'='||v1 * 5);
  DBMS_OUTPUT.PUT_LINE(v1||'*'||6 ||'='||v1 * 6);
  DBMS_OUTPUT.PUT_LINE(v1||'*'||7 ||'='||v1 * 7);
  DBMS_OUTPUT.PUT_LINE(v1||'*'||8 ||'='||v1 * 8);
  DBMS_OUTPUT.PUT_LINE(v1||'*'||9 ||'='||v1 * 9);
  
end;

--2.사원테이블의 201번 사원의 이름과 이메일주소를 출력하는 블록
declare
  emp_name employees.last_name%type;
  emp_email employees.email%type;

begin
  select last_name , email 
  into emp_name, emp_email
  from employees
  where employee_id = 201;
  
  DBMS_OUTPUT.put_line(emp_name || '의 이메일은' || emp_email);
end;

--3.사원테이블에서 사원번호가 가장 큰 사원을 찾아낸 뒤에 
--이번호 + 1 번 아래 emps 테이블에 사원번호, 이름 , 이메일, 입사일, job_id만 insert 하면됨

--구조만 복사
create table emps as (select * from employees where 1=2);

declare
   A employees.employee_id%type ;
   B employees.last_name%type;
   C employees.email%type;
   D employees.hire_date%type;
   E employees.job_id%type;
    
begin
   select employee_id , last_name , email , hire_date , job_id
   into A,B,C,D,E
   from employees
   where employee_id =(select max (employee_id) from employees);

   insert into emps(employee_id , last_name, email , hire_date, job_id)
   values (A,B,C,D,E);
   commit;
   
end;




