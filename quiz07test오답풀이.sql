--프로시저 시험 

drop table emps;
create table emps as (select * from employees where 1=2) ;

create or replace procedure emp_merge_proc
     (p_emp_id in emps.employee_id%type,
      p_last_name in emps.last_name%type,
      p_email in emps.email%type,
      p_hire_date in emps.hire_date%type,
      p_job_id in emps.job_id%type
      )    
is      
begin
merge into emps  a
    using (select p_emp_id as employee_id from dual)b
    on(a.employee_id =b.employee_id)
    when matched then
    update set a.last_name = p_last_name,
               a.email = p_email,
               a.hire_date =p_hire_date,
               a.job_id=p_job_id
    where a.employee_id=p_emp_id
    when not matched then
        insert (a.employee_id,a.last_name, a.email , a.hire_date, a.job_id)
        values (p_emp_id, p_last_name , p_email , p_hire_date , p_job_id);
    

end;
exec emp_merge_proc (110,'tak','thevanppp@naver.com',sysdate,130);
select * from emps;

--10번문제
--매출테이블
create table sales (
  sno number(5),
  name varchar2(30),
  total number (10),
  price number(10),
  regdate date default sysdate
);

--집계테이블
create table day_of_sales(
   regdate date, 
   final_total number(10)
   
);
   
--프로시저

create or replace procedure sales_proc
   (p_regdate in sales.regdate%type)--날짜 파라미터
is  
   v_final_total number :=0;--일자별 총합
begin
  --sales 의 날짜별 수량합계
  select sum (total*price) as v_final_total 
  into v_final_total
  from sales
  where to_char(regdate, 'YY/MM/DD')=to_char(p_regdate,'YY/MM/DD');
  
  merge into day_of_sales a
       using(select to_char(p_regdate,'YY/MM/DD')as regdate,
                    v_final_total as final_total
                    from dual) b
       on(to_char(a.regdate,'YY/MM/DD')=b.regdate )
    when matched then
      update set a.final_total=v_final_total
    when not matched then
      insert values(p_regdate, v_final_total);
end;

exec sales_proc(sysdate);
select * from day_of_sales;

drop table members;

create table members(
   id varchar2(30) primary key,
   pw varchar2(30),
   name varchar2(30),
   email varchar2(30)

);

insert into members values('kkk1234', '123', 'hong','naver' );
commit;