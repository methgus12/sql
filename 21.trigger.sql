/*
트리거는 테이블에 부착해서 사용하는 형태로 
insert , update , delete 작업이 수행될때
특정 코드가 동작하도록 하는 구문

트리거의 종류
alter -dml문 직후에 동작하는 트리거
before- dml문 이전에 동작하는 트리거
instead of -뷰에 부착하는 트리거

트리거 형태
create or replace trigger 트리거명
트리거 타입
부착시킬 테이블
option(for each row)
begin
end;
*/

set serveroutput on;

--트리거 테스트 테이블
create table tbl_test1(
       id number(10),
       text varchar2(50)
 );
 

 
create or replace trigger tbl_test1_tri
    after delete or update --삭제 or update이후 동작
    on tbl_test1 --부착테이블
    for each row --모든행에 적용하는 option
begin 
    dbms_output.put_line('트리거가 동작함');
end;

--트리거 동작확인

insert into tbl_test1 values (1,'홍길동');--동작 x
insert into tbl_test1 values (2,'이순신');--동작 x

update tbl_test1 set  text ='홍길자' where id =1;--동작yes
delete from tbl_test1 where id =2;--트리거 동작

/*
트리거 변수참조 키워드
:old- 참조 전 column 값 (insert: 입력 전 자료 , update : 수정전 자료 , delete :삭제전 자료)
:new-참조 후 coulumn 값(insert :입력 후 자료 , update 수정후 자료)
*/

create table tbl_user(
    id varchar2(30) primary key,
    name varchar2(30) 
    
);

create table tbl_user_backup(
       id varchar2(30),
       name varchar2(30),
       update_date date default sysdate,
       modify_type char(1),--변경 or 삭제 타입
       modify_user varchar2(30)--변경한 사
       

);

--after 트리거

create or replace trigger user_backup_tri
       after update or delete
       on tbl_user
       for each row
       
declare
     v_type varchar2(10); --트리거에서 사용될 변수
     
begin
     if updating  then --updating은 시스템에서 지원하는 구문
     
        v_type :='U';
     elsif deleting then --delete되었을때
        v_type := 'D';
     
     end if;
     --backup 테이블에서 동작할 기능
     insert into tbl_user_backup values(:old.id , :old.name, sysdate, v_type, user());--user()은 현재계정

end;
--트리거 확인
insert into tbl_user values ('test1', 'admin1');
insert into tbl_user values ('test2', 'admin2');
insert into tbl_user values ('test3', 'admin3');

update tbl_user set name='홍길동' where id= 'test1';
select * from tbl_user;

--before 트리거
--tbl_user 테이블에 이름이 저장될때 , **을 붙여서 저장

create or replace trigger user_insert_tri
    before insert
    on tbl_user
    for each row
    
declare

begin
    --insert에서 old는 전부 null
    :new.name := substr(:new.name,1,1) ||'***';
    dbms_output.put_line(:new.name);
end;

--트리거 동작 
insert into tbl_user values ('A123', '홍길동');
insert into tbl_user values ('B123', '이순신');
insert into tbl_user values ('C123', '박찬호');

select * from tbl_user;

-----------트리거 응용편
/*
주문테이블 생략 
주문 기록 테이블 :주문번호 50000번

*/

--주문상세
create table order_detail(
   detail_no number(5) primary key,--pk
   o_no number(5), --fk주문번호
   p_no number(5),--fk상품번호
   detail_total number(5),--주문수량
   detail_price number(10) --가격
   

);
--상품
create table product(
   p_no number(5) primary key,
   p_name varchar2(20),
   p_total number(5),--남은 수량
   p_price number(10)--가격
   
);

insert into product(p_no , p_name, p_total,p_price) values(1,'피자',100,10000);
insert into product(p_no , p_name, p_total,p_price) values(2,'치킨',100,15000);
insert into product(p_no , p_name, p_total,p_price) values(3,'햄버거',100,5000);

--주문이 들어오면 , 상품테이블에 수량감소 트리거

create or replace trigger order_detail_tri1
    after insert
    on order_detail
    for each row
    
declare
   v_detail_total number(5) := :new.detail_total;--주문에 들어오는 수량
   v_no product.p_no%type :=:new.p_no;

begin
    --상품테이블에 적용될 update 문
    update product set p_total =p_total - v_detail_total 
    where p_no = v_no ;

end;

--트리거 동작확인 (ex:50000번 주문에 대하여...)

insert into order_detail values (1,50000,1,5,50000);--pk,주문번호 , 상품번호 , 주문수량 ,전체가격
select * from order_detail;
desc order_detail;