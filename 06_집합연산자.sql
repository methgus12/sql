--���տ����� (�� �Ʒ� column������ ��Ȯ�� ��ġ�ؾ� ��)
--union(������ �ߺ�x), union all(������ �ߺ�o), intersect(������), minus(������)

select employee_id, first_name from employees where hire_date like '04%'
union
select employee_id, first_name from employees where department_id = 20; -- michael, pat

select employee_id, first_name from employees where hire_date like '04%'
union all
select employee_id, first_name from employees where department_id = 20;

select employee_id, first_name from employees where hire_date like '04%'
intersect --������
select employee_id, first_name from employees where department_id = 20;

select employee_id, first_name from employees where hire_date like '04%'
minus --������
select employee_id, first_name from employees where department_id = 20;

--union, union all�� ������̺�� ���� ����ϴ� ��찡 ����.
select employee_id, first_name, salary from employees where department_id = 100
union all
select employee_id, first_name, salary from employees where salary > 10000
union all
select 300, 'hong', 10000 from dual
union all
select 400, 'kim', 20000 from dual;




