--오토커밋 확인
show autocommit;

--오토커밋 on 
set autocommit on;
--오토커밋 off
set autocommit off;

select * from depts ;
delete from depts where department_id =10;
rollback; --다시되돌리기

savepoint del1; -- 첫번째 저장지점 생성

delete from depts where department_id =20;
savepoint del2;

rollback to del1;
select * from depts;
rollback to del2;

commit;--테이블에 반영 커밋이후에는 어떤 방법을 써도 되돌림 불가! 실수 금지
