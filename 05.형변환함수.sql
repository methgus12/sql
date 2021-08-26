--형변환 함수 TO_CHAR , TO_DATE , TO_NUMBER

--TO_CHAR(날짜 , 날짜 포맷형식) : 날짜를 문자로 변경
select to_char (sysdate) from dual;
select to_char (sysdate, 'YYYY-MM-DD') from dual;
-- - / : 포맷형식으로 사용가능
select to_char (sysdate, 'YY-MM-DD HH:MI:SS') from dual;

--포맷형식이 아닌 문자는 쌍따옴표로 묶습니다 ""
select to_char (sysdate, 'YYYY"년"') from dual;

select first_name , hire_date from employees;
select first_name , to_char(hire_date, 'YYYY-MM-DD') from employees;
select first_name , to_char(hire_date, 'YY-MM-DD HH24:MI:SS') from employees;
select first_name , to_char(hire_date,'YYYY"년" MM"월" DD"일"') from employees;

--TO_CHAR (숫자 , 숫자형식) : 숫자를 문자로
--숫자표현 9는 자리수
select to_char(20000, '99999') from dual;
--자리수 부족은 표현이 안됩니다
select to_char(20000,'999') from dual; 
--소수점이면 .을 이용 형식에 맞게 작성
select to_char (20000.14, '99999.99') from dual;
-- , 는 자리수를 찍어줌 
select to_char (20000, '99,999') from dual;
--$는 $ 표현기호
select to_char (20000, '$99,999') from dual;
--L 각 나라의 원화기호
select to_char (20000, 'L99,999') from dual;

select to_char (salary, '$9999,999.99') from employees;

--TO_NUMBER (문자 , 숫자형식) : 문자를 숫자로 
--숫자표현식에서 지원하지않는 구문은 바꿀수없당!

select '2000' +2000 from dual; --자동형변환 ,문자를 숫자로 인식해주어 둘 을계산해줌

select to_number('2000') from dual;--명시적 형변환
--숫자 포맷형식을 사용해서 명시적 형변환
select to_number('$3,300', '$9,999')+2000 from dual;

-- -TO_DATE(문자, 날짜 표현형식) --문자를 날짜로

--날짜형식의 문자라면 포멧을 적지않더라도 가능합니
select to_date ('2021-03-31') from dual;
--일수
select sysdate -to_date('2021-03-25') from dual;

select to_date ('2021/03/25', 'YYYY/MM/DD') from dual;

select to_date('2021-03-25 14:51:24','YYYY/MM/DD HH24:MI:SS') from dual;

--'20201130','20201111' 날짜 차이를 구하여라
select (to_date('20201130','YYYYMMDD')- to_date('20201111','YYYYDDMM')) as 날짜차이 from dual;
--xxxx년 xx월 xx일로 출력
select to_char (to_date('20051002','YYYYMMDD'), 'YYYY"년" MM"월" DD"일"') from dual;

--MVL(컬럼, Null 일 경우 변환할값) *****
select nvl(200, 0) ,nvl(null,0) from dual;
--null 값들을 0으로 변환하여 출력합니다
select first_name, nvl(commission_pct,0) as commission_pct from employees;

--MVL2(컬럼 , null이 아닐경우 값 , null일 경우 값)****
select nvl2(null, 'null아님' , 'null임') from dual;

select first_name ,commission_pct,
nvl2(commission_pct, salary+(salary * commission_pct), salary) from employees;

--DECODE(컬럼, 값, 결과 , 값 ,결과 ..., default) ******
select decode('C', 'A', 'A입니다.','B','B입니다.','C', 'C입니다.', '전부아닙니다') from dual;

select first_name , 
salary,
job_id,
decode(job_id, 'IT_PROG', salary *0.5,'AD_VP', salary *0.4,salary * 0.1) as bonus
from employees;

--CASE 컬럼 WHEN 값 THEN 결과 END******

select first_name,
salary,
job_id,
(case job_id when 'IT_FROG' then salary * 0.5
            when 'AD_VP' then salary *0.4
            else salary * 0.1
 end) as bonus
 from employees;