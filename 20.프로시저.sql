/*
저장 프로시저 : 하나의 함수처럼 실행하기위한 쿼리의 집합.
만드는 과정 과 실행하는 구문이 따로 나누어져있습니다

*/
--create or replace procedure 프로시저명 is begin end;
create or replace procedure new_job_proc --(매개변수가 있다면)

is --변수의 선언영역 


begin--실행영역
     DBMS_OUTPUT.PUT_LINE('hello wordl!');

end;

--프로시저의 실행
exec new_job_proc;

--프로시저의 매개변수 in 구문
create or replace procedure new_job_proc
       (p_job_id in jobs.job_id%type, --매개변수명  in 테이블.어디와 타입이 똑같다
        p_job_title in jobs.job_title%type,
        p_min_sal in jobs.min_salary%type,
        p_max_sal in jobs.max_salary%type
       ) 
is
begin 
       insert into jobs 
       values (p_job_id, p_job_title, p_min_sal, p_max_sal);
end;

--프록시저 실행

EXEC NEW_JOB_PROC('SM_MANI', 'SAMPLE TEST', 1000, 5000);
select * from jobs ;

------프로시저의 In 변수를 활용(키 값이 있다면 update , 없다면 insert)
create or replace procedure new_job_proc 
   (p_job_id in jobs.job_id%type,
    p_job_title in jobs.job_title%type,
    p_min_salary in jobs.min_salary%type,
    p_max_salary in jobs.max_salary%type

   )
   
is
  v_count number := 0;--지역변수
begin
  select count(*)
  into v_count
  from jobs
  where job_id = p_job_id; --프로시저의 매개변수로 들어오는 값
  if v_count = 0 then 
    --insert 
    insert into jobs values (p_job_id , p_job_title , p_min_salary , p_max_salary);
  
  else 
    --update
    update jobs
    set job_title = p_job_title,
        min_salary =p_min_salary,
        max_salary= p_max_salary
    where job_id = p_job_id;
  
  end if;
end;

EXEC NEW_JOB_PROC('SM_MAN1', 'SAMPLE TEST', 1000, 5000);

------------------------------------------------------------
--매개값의 개수가 일치하지않아서 에러!
--exec new_job_proc('SM_kkk', 'sample');

--프로시저의 디폴트 매개값 설정----
create or replace procedure new_job_proc 
   (p_job_id in jobs.job_id%type,
    p_job_title in jobs.job_title%type,
    p_min_salary in jobs.min_salary%type :=0, --기본값 설정
    p_max_salary in jobs.max_salary%type :=1000

   )
   
is
  v_count number := 0;--지역변수
begin
  select count(*)
  into v_count
  from jobs
  where job_id = p_job_id; --프로시저의 매개변수로 들어오는 값
  if v_count = 0 then 
    --insert 
    insert into jobs values (p_job_id , p_job_title , p_min_salary , p_max_salary);
  
  else 
    --update
    update jobs
    set job_title = p_job_title,
        min_salary =p_min_salary,
        max_salary= p_max_salary
    where job_id = p_job_id;
  
  end if;
end;

exec new_job_proc('SA' , 'sample', 1000,2000);
--------------------------

--out 매개변수
--프로시저가 out 변수를 가지고 있다면 , 실행구문을 익명블록에서 실행합니다

create or replace procedure new_job_proc

    (p_job_id in jobs.job_id%type,
     p_job_title in jobs.job_title%type,
     p_min_sal in jobs.min_salary%type :=0,
     p_max_sal in jobs.max_salary%type :=1000,
     p_result out varchar2
     )

is
   v_count number :=0;--지역변수
   

begin

    select count(*)
    into v_count --지역변수
    from jobs
    where job_id =p_job_id;
    
    if v_count =0 then
       insert into jobs values (p_job_id, p_job_title , p_min_sal, p_max_sal);
       p_result := p_job_id ;--성공일 경우에는 아웃변수에 아이디를 저장
    else 
       update jobs 
       set  
           job_title=p_job_title,
           min_salary = p_min_sal,
           max_salary=p_max_sal
        where job_id =p_job_id;
        p_result := '존재하는 값이기 때문에 업데이트 되었습니다 ' ;--이미 존재하는 경우 문장저장
        end if;
       
end;

declare
   str varchar2(100);
begin
   new_job_proc('test1', 'test2', 1000,2000,str);
   dbms_output.put_line(str);--결과
   
end;

set serveroutput on;

--------------------------

--in out 변수 

create or replace procedure test_proc
     (p_var1 in varchar2, --입력변수 (반환불가)
      p_var2 out varchar2, --출력변수 (프로시저가 끝나기 전에는 값의 할당이 안됨)
      p_var3 in out varchar2 --입,출력변수 (둘다 가능)
      )
is
begin 
     dbms_output.put_line('p_var1의 값:' || p_var1);
     DBMS_OUTPUT.PUT_LINE('p_var2의 값:' || p_var2);
     dbms_output.put_line('p_var3의 값:'|| p_var3);
     
     --p_var := '결과1'; in 변수는 할당불가
     p_var2 := '결과2';
     p_var3 := '결과3';
     
end;

declare
    v_A varchar2(100) :='A';
    v_B varchar2(100) := 'B';
    v_C varchar2(100) := 'C';

begin
    test_proc(v_A , v_B, v_C);
    dbms_output.put_line('v_b변수:' || v_b);
    dbms_output.put_line('v_c변수:' || v_c);

end;

---------------프로시저의 종료 return
set serveroutput on;
create or replace procedure new_job_proc
   (p_job_id in jobs.job_id%type
   
   )
   
   
is
  v_count number :=0;
  v_min_total number :=0;
begin
--값이 없다면 출력후에, 플로시저를 종료 ,있다면 값 출력
  select count(*)
  into v_count
  from jobs
  where job_id like '%' || p_job_id || '%';--있는지 없는지 조회

  if v_count =0 then 
     dbms_output.put_line(p_job_id || '값이 없습니다.');
  else
     --P_JOB_ID 최소급여 전제합
     select sum(min_salary)
     into v_min_total
     from jobs
     where job_id like '%'|| p_job_id ||'%';
     dbms_output.put_line(p_job_id ||'의 min_salary 합:'||v_min_total);
  
  end if;

end;

exec new_job_proc('test');
exec new_job_proc('MAN');

--연습문제 
/*
employee_id 를 받아서 employees에 존재하면 극속년수를 출력
없다면 ,없습니다를 출력하는 프로시
*/

create or replace procedure new_emp_proc
          (p_employee_id in employees.employee_id%type)
          
is--프로시저 안에 사용할 매개변수 를 넣는 곳입니당!
     v_count number :=0;
     v_year number :=0;
     
begin
     select count(*)
     into v_count
     from employees
     where employee_id = p_employee_id;
     
     if v_count =0 then
        dbms_output.put_line(p_employee_id||'값이 없습니다');
    
    else 
        select trunc((sysdate- hire_date)/365)
        into v_year
        from employees
        where employee_id =p_employee_id;
            dbms_output.put_line(p_employee_id ||'의 근속년도 :'||v_year);


    end if;
    
    --예외처리
    exception when others then
       dbms_output.put_line('예외가 발생했습니당');
end;

exec new_emp_proc(108);