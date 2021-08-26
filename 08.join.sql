--조인 join 짱중요

select * from auth; 
select * from info ;

--이너조인

select * from info inner join auth on info.id =auth.id;
--select 문의 열을 선택할때 id만 쓰게 되면 모호하다.
--이럴때 컬럼에 테이블이름 , 컬럼명을 직접 지정해서 정상적으로 조회합니다.
select bno, title , content, info.id, name, job
from info 
inner join auth on info.id = auth.id;

--테이블명이 길 경우 엘리어스로 별칭사용 가능
select bno, title , content, i.id, name, job
from info i 
inner join auth a on i.id = a.id;

--조건절 사용도 가능
select bno , title , content, job
from info i
inner join auth a on i.id = a.id
where job ='전업주부';

desc info;
desc auth; 

--3개의 테이블도 조인이됩니당!~

select * from employees e
left outer join departments d 
on e.department_id=d.department_id
left outer join locations l 
on d.location_id = l.location_id;

 