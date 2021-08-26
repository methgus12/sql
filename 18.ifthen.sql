--랜덤수 뽑기
select dbms_random.value() from dual;
--0~10미만의 랜덤수
select trunc(dbms_random.value(0,10)) from dual;

--if 문(if (조건) then else end if)
set serveroutput on;
declare 
     num1 number := 5;
     num2 number := trunc(dbms_random.value(1,11));--랜덤수저장 
begin
    if num1 >= num2 then
      DBMS_OUTPUT.PUT_LINE(num1 ||'이 큰수입니다.');
    
    
    else
       DBMS_OUTPUT.PUT_LINE(num2 ||'이 큰수입니다.'); 
    end if;


end;

--elsif 문도 작성가능!
declare
    ran_num number := trunc(dbms_random.value(1,101));
    

begin
    if ran_num >= 90 then
        DBMS_OUTPUT.PUT_LINE('A학점입니다');
    elsif ran_num >=80 then
        dbms_output.put_line('B학점입니다.');
    elsif ran_num >=70 then
        DBMS_OUTPUT.PUT_LINE('C학점입니다.');
    else
       DBMS_OUTPUT.PUT_LINE('D학점입니다.');

    end if;


end;

/*
첫번째 값은 rownum을 이용하면 됩니다. 
1-120사이의 랜덤한 번호를 이용해서 랜덤department_id의 첫행만 select 합니다.
뽑은 사람의 salary 가 9000이상이면 높음 , 
5000이상이면 중간 나머지는 낮음으로 출력
*/

declare

    sal employees.salary%type;
    ran number := round(dbms_random.value(10,120),-1);

   
   
begin
   select salary 
   into sal
   from employees
   where department_id = ran and rownum=1;
   
   if sal >=9000 then
     dbms_output.put_line('높음');
   
   elsif sal >-5000 then
     dbms_output.put_line('중간');
   
   else
     DBMS_OUTPUT.PUT_LINE('낮음');
   end if;

end;

--case 문

declare
     sal employees.salary%type;
     ran number := round (dbms_random.value(10,120),-1);--양의자리수에서 반올림

begin 
    select salary
    into sal
    from employees
    where department_id = ran and rownum =1;
    
    case when sal>=9000 then --when절 뒤 조건 
         dbms_output.put_line('높음');
         when sal >=5000 then
         dbms_output.put_line('중간');
         else
         dbms_output.put_line('낮음');
    end case;

end;


