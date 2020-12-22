SELECT
    *
FROM employees, departments
where employees.department_id = departments.department_id;

SELECT e.first_name,
       d.department_name,
       e.department_id
FROM employees e, departments d
where e.department_id = d.department_id;

--예제
--모든 직원이름, 부서이름, 업무명을 출력하세요
SELECT em.first_name,
       jo.job_title,
       de.department_name
FROM employees em, jobs jo, departments de
WHERE em.job_id = jo.job_id
and em.department_id = de.department_id;

--left조인(null도 포함됨)
select  em.department_id, 
        em.first_name, 
        de.department_name
from employees em left outer join departments de
on em.department_id = de.department_id ; --where절

--rigth조인
select em.department_id,
       em.first_name,
       de.department_name
from employees em right outer join departments de
on em.department_id = de.department_id;

--right join --> 오라클 표현
select  emp.department_id, 
        emp.first_name, 
        dep.department_name
from employees emp, departments dep
where emp.department_id(+) = dep.department_id; 

--right 조인 --> left조인
SELECT em.first_name,
       em.department_id,
       de.department_id
FROM employees em left outer join departments de
on em.department_id = de.department_id;

--right join --> left join --> 오라클 표현
select  emp.department_id, 
        emp.first_name, 
        dep.department_name
from departments dep, employees emp
where dep.department_id = emp.department_id(+) ;


--full outer join
select  em.department_id,
        em.first_name,
        de.department_name,
        de.department_id
from employees em full outer join departments de
on em.department_id = de.department_id;
--on em.department_id(+) = de.department_id(+); 사용못함


--alias
SELECT de.department_id,
       em.first_name,
       de.department_name,
       de.department_id
FROM employees em, departments de
where em.department_id = de.department_id
order by em.department_id desc;

--join 실행순서 체크
SELECT de.department_id,
       em.first_name,
       de.department_name,
       de.department_id
FROM employees em, departments de
where em.department_id = de.department_id
order by em.department_id desc;



select emp.employee_id, emp.first_name,
       emp.manager_id, man.first_name as manager
FROM employees emp, employees man
where emp.manager_id = man.manager_id;



--from 절 whrer절 표현방법, (+) 오라클
/*
left/right/full outer join ~ on

inner join --> null은 제외
inner join ~ on
*/

select * 
from employees em inner join departments de
on em.department_id = de.department_id;

select em.first_name,
       em.department_id,
       de.department_name,
       de.department_id       
FROM employees em, departments de
where em.department_id =de.department_id;

/*
outer join --> 기준이 되는 쪽은 포함, 비교되는 쪽은 null표시
left outer join ~ on
right outer join ~ on
full outer join ~ on
*/