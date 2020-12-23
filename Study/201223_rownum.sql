/**************************
**********rownum***********
**************************/

--급여를 가장 많이 받는 5명의 직원의 이름을 출력하세요.

SELECT rownum num,
       employee_id,
       first_name,
       salary
FROM employees 
order by salary desc;

--정렬하고 rownum 사용
SELECT rownum num,
       employee_id,
       first_name,
       salary
FROM employees
order by salary desc; -- salary 로 정렬되어 있는 테이블 사용

SELECT
    *
FROM employees
order by salary desc; 

SELECT rownum num,
       employee_id,
       first_name,
       salary
FROM (SELECT
    *
FROM employees
order by salary desc);--order가 마지막 순서임으로 테이블을 정렬된 테이블로 불러온다

SELECT rownum num,
       o.id,
       o.name,
       o.salary
FROM (SELECT employee_id id,
             first_name name,
            salary
FROM employees
order by salary desc) o-- 불러온 테이블 네임 지정시 같이 변경해야함
where rownum >= 1 --where절 조건이 2부터는 불가능함(순서때문)
and rownum <=5;

SELECT ro.rnum,
       ro.id,
       ro.name,
       ro.salary
FROM (SELECT rownum rnum,
             o.id,
             o.name,
             o.salary
      FROM (SELECT employee_id id,
                   first_name name,
                   salary
            FROM employees
            order by salary desc) o
            ) ro
where ro.rnum >= 2
and ro.rnum <=5;


--07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은? 
--급여순 07년 입사자
--급여순 07년 입사자 넘버링
--최종

--1
SELECT
    *
FROM employees
where hire_date between '07/01/01' and '07/12/31'
order by salary desc;

--2
SELECT rownum rnum,
       e.first_name,
       e.hire_date,
       e.salary
FROM (SELECT
           *
       FROM employees
       where hire_date between '07/01/01' and '07/12/31'
       order by salary desc) e;
       
--3
SELECT r.rnum,
       r.first_name,
       r.hire_date
FROM (SELECT rownum rnum,
             e.first_name,
             e.hire_date
      FROM (SELECT first_name,
                   hire_date                 
             FROM employees
             where hire_date between '07/01/01' and '07/12/31'
             order by salary desc) e
      ) r
where r.rnum between 3 and 7;             