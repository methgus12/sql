--dual : 가상테이블
select 'hello world', 'world' from dual;

--문자조작함수
--lower , upper , initcap
--lower : 소문자 upper : 대문자 initcap :첫글자들만 대문자
select lower ('hello WOLRD') , upper('hello WOLRD'),
initcap('hello WOLRD') from dual;

select lower (first_name), upper(first_name),
initcap(first_name) from employees;

--함수는 where 조건절에도 들어갑니다.
select * from employees where lower (first_name)='ellen';

--length(문자) 문자열길이 , instr(문자 , 찾는 문자) 문자열찾기
select 'abcdef', length('abcdef'),instr('abcdef', 'f') from dual;
select first_name ,length(first_name), instr(first_name,'a') from employees;

--concat(문자 , 문자)
select concat('hello', 'world') from dual;
--문자열 붙이기:두개만 가능 세개는 중첩으로작성  
select concat(concat('hello', ' '),'world')from dual;
--문자열 붙이기 다른 방법
select 'hello' || 'world' from dual;

--substr(타켓 , 시작인덱스 , 자를개수)문자열 자르기
--0이아닌 1부터시작
select substr('abcdef', 2,5) from dual;

select first_name , concat(first_name, last_name), 
substr(first_name , 1,3) from employees;

--lpad(문자,채울자리수 , 채울문자) :좌측부터 지정된 문자열로 채우기
--rpad(문자, 채울자리수 , 채울문자) :우측 지정된 문자열로 채우기

select lpad ('abc',10,'*') from dual;
select rpad('abc', 10,'#') from dual;

--ltrim 왼쪽, rtrim 오른쪽, trim 전체: 공백제거
select ltrim('     hello world  ') from dual;--왼쪽 공백만제거
select rtrim ('  hello world        ') from dual;--오른쪽 공백만 제거
select trim (  'hello world  ') from dual;--전체 공백제거

--replace(문자열 , 바꿀타겟 , 바꿀내용):문자열 바꾸기
select replace('my dream is president', 'president', 'teacher') from dual;
select replace('my dream is president',' ', '') from dual;--공백 없애기

--중복replace 
select replace( 
replace('my dream is president','president','teacher'),' ','' )
from dual;

select replace(concat(first_name || ' ', last_name),' ','') from employees;

