--숫자함수
--round(수 , 올림할 자리수 )or (수) : 반올림
select round( 45.923,2), round(45.923 ,-1)from dual;

--trunc(수 , 나타낼 수 자리):절삭
select trunc (45.923,2), trunc(45.923), trunc (45.923,-1)from dual;

--abc(수) : 절대값
select abs (-34) from dual;

--ceil(수) : 올림 
select ceil(3.14) from dual;
--floor(수) : 내림
select floor (3.14) from dual;

--mod(수 , 나눌수 ):나머지

select  mod(10,2) from dual;

--날짜함수

select sysdate from dual; --일자
select systimestamp from dual;--시분초까지 

--날짜 연산이 가능합니다

select (sysdate - hire_date) from employees;
select (sysdate - hire_date) / 7 from employees;--몇주

select trunc((sysdate - hire_date)/365) from employees;

--날짜에도 trunc ,round 적용이 가능하다
select round(sysdate) from dual;
select round (sysdate, 'year') from dual;--년기준 반올림
select round (sysdate , 'month') from dual;--월 기준 반올림
select round (sysdate,'day') from dual;--일 기준 반올림(해당 주의 일요일 날짜 기준)

select trunc (sysdate) from dual;
select trunc (sysdate , 'year') from dual;-- 년 기준으로 절삭
select trunc (sysdate , 'month') from dual;
select trunc (sysdate , 'day') from dual;
