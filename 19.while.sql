--반복문(while , for , in), 탈출문 (exit , continue)

declare
    i number := 1;
     
begin
    while i <=9
    loop
    dbms_output.put_line(i);
    i := i+1; --제어변수 증감식
    end loop;

end;

--구구단 3단출력
declare 
    num number :=3;
    i number :=1;
begin
    while i <=9
    loop
    dbms_output.put_line(num ||'*'||i||'='||num * i);
    i := i+1;
    end loop;
end;

--탈출문 exit when 조건

declare
    i number :=1;
begin
    while i <= 10
    loop
          dbms_output.put_line(i);
          exit when i=5;--탈출
          i := i+1;
          
    end loop;

end;

--continue 문 (1-10까지 수 중에 짝수만 출력)

declare
    i number :=0;
begin 
    while i <10  
    loop 
    i := i+1;
    continue when mod (i,2) =1;
    dbms_output.put_line(i);
    
    end loop;

end;

--for문 for 변수 in 범위

declare

begin
    for i in 1..9
    loop
        dbms_output.put_line(3 || '*'|| i|| '='||3*i);
    end loop;

end;

/*
연습문제 1
2단부터 9단까지 모든 구구단 출력
*/

--for로 두개 써서 해도 가능!
declare
    dan number := 2;
begin
     while dan <=9
     loop
     for i in 1..9
     loop 
         dbms_output.put_line(dan || '*'|| i || '='||dan * i);
    end loop;
    dan := dan+1;
    exit when dan>=10;
    dbms_output.put_line('구구단' || dan ||'단');
    
    end loop; 

end;


--연습문제2
--아래테이블에 시퀀스를 이용해서 300행의 더미 테이블을 입력하세요 
create table test1(
        bno number(10) primary key,
        writer varchar2(30),
        title varchar(30)
        );

create sequence test_seq 
       increment by 1 
       start with 1 
       nocache 
       nocycle; 

insert into test1 values(test_seq.nextval, 'test', 'test');

declare 
     i number := 1;
begin
    while i <=100
    loop
    insert into test1 values(test_seq.nextval, 'test', 'test');
    insert into test1 values(test_seq.nextval, 'test', 'test');
    insert into test1 values(test_seq.nextval, 'test', 'test');
     i:=i+1;--증감식
    
    end loop;
    
    commit;--루프종료후 커밋

end;

--확인하기
select * from test1;


--예외처리 구문 
--exception when others then: others 모든 오류를 다 받아줌

declare
  v_num number := 0;

begin
  v_num :=10 /0;
  exception when others then 
  dbms_output.put_line('0으로 나눌수 없습니다.');

end;

        
        