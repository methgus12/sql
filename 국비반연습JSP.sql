create table members(
   id varchar2(30) primary key,
   pw varchar2(30),
   name varchar2(10),
   phone1 varchar2(10),
   phone2 varchar2(10),
   phone3 varchar2(10),
   gender char(1) check(gender in ('f', 'm'))

);

