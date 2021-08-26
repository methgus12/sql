--사용자계정생성

create user user1 identified by user1;

--사용자 계정에 권한부여
--grant 권한 to 계정

grant create session, create table, create view, create sequence, create procedure to user1;
--테이블 스페이스 : 데이터가 저장되는 물리적 공간 !
--테이블 스페이스를 생성 or 기존에 있는 테이블 스페이스를 지정
--alter user 계정명 defauit tablespace 테이블 스페이스명 quota unlimited on 테이블 스페이스명
alter user user1 default tablespace users quota unlimited on users;

--사용자 계정에 권한을 회수
revoke create session, create table, create view, create sequence, create procedure  from user1;

--마우스로도 계정생성 , 권한부여 , 테이블 스페이스 지정이 가능합니다
--보기-DBA
--계정삭제 (계정이 사용하는 모든 테이블 , 시퀀스 등등 함께 삭제)
drop user user1 cascade;

-------------------------------

--2nd(롤을이용한 권한)
create user user1 identified by user1;
grant connect , resource /*DBA*/ to user1;

alter user user1 default tablespace users quota unlimited on users;




