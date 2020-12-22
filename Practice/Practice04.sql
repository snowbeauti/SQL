--서브쿼리(SUBQUERY) SQL 문제입니다.
/*
문제1.
평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요.
(56건)
*/
--1.평균급여
--2.평균급여보다 적은 급여
--2.직원명수
--3 평균급여보다 적은급여 받는 직원 명수

--1
SELECT avg(salary)
FROM employees;

--2
SELECT employee_id
FROM employees
where salary < (SELECT avg(salary)
FROM employees);

--3
SELECT count(employee_id)
FROM employees;

--4
SELECT count(employee_id)
FROM employees
where salary < (SELECT avg(salary)
FROM employees);


/*
문제2. 
평균급여 이상, 최대급여 이하의 월급을 받는 사원의 
직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를 급여의 오름차순으로 정렬하여 출력하세요 
(51건)
*/
--1. 평균급여 
--2. 평균 급여 이상 사원
--3. 최대급여
--4. 최대급여 이하 사원
--5. 정보 정렬 및 출력

--1
SELECT avg(salary)
FROM employees;

--2
SELECT employee_id 직원번호,
       first_name 이름,
       salary 급여
FROM employees
where salary > (SELECT avg(salary)
                FROM employees);

--3
select max(salary)
from employees;

--4
SELECT employee_id 직원번호,
       first_name 이름,
       salary 급여
FROM employees
where salary <= (select max(salary)
                 from employees);

--5
SELECT employee_id 직원번호,
       first_name 이름,
       salary 급여
FROM employees
where salary > (SELECT avg(salary)
                FROM employees)
      and salary <= (select max(salary)
                 from employees)          
order by salary asc;



/*
문제3.
직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소를 알아보려고 한다.
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주(state_province), 
나라아이디(country_id) 를 출력하세요(1건)
*/
--1 직원중 Steven(first_name) king(last_name) 소속부서코드(department_id) 추출
--2 도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주(state_province), 나라아이디(country_id) 를 출력
--3직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소를 알아보려고 한다.도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주(state_province), 나라아이디(country_id) 를 출력

--1
SELECT department_id
FROM employees
where first_name = 'Steven' and last_name = 'King';

--2
SELECT l.location_id 도시아이디,
       l.street_address 거리명,
       l.postal_code 우편번호,
       l.city 도시명,
       l.state_province 주,
       l.country_id 나라아이디
FROM employees e, departments d, locations l
where e.department_id = d.department_id
      and d.location_id = l.location_id; 
      
--3 
SELECT l.location_id 도시아이디,
       l.street_address 거리명,
       l.postal_code 우편번호,
       l.city 도시명,
       l.state_province 주,
       l.country_id 나라아이디
FROM departments d, locations l
where d.department_id = (SELECT department_id
                        FROM employees
                        where first_name = 'Steven' and last_name = 'King')
      and d.location_id = l.location_id;
      
      

/*
문제4.
job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번,이름,급여를 급여의 내림차순으로 출력하세요  -ANY연산자 사용
(74건)
*/
--1job_id 가 'ST_MAN' 인 직원의 급여
--2 직원의 사번,이름,급여를 급여의 내림차순으로 출력하세요

--1
SELECT salary
FROM employees
WHERE job_id = 'ST_MAN';

--2
SELECT employee_id 사번,
       first_name 이름,
       salary 급여
FROM employees
order by salary desc;

--3
SELECT employee_id 사번,
       first_name 이름,
       salary 급여
FROM employees
where salary < any(SELECT salary
               FROM employees
               WHERE job_id = 'ST_MAN')
order by salary desc;

/*
문제5. 
각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name)과 급여(salary) 
부서번호(department_id)를 조회하세요 
단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 
조건절비교, 테이블조인 2가지 방법으로 작성하세요
(11건)
*/
--1.각 부서별로 최고의 급여를 받는 사원
--2.직원번호(employee_id), 이름(first_name)과 급여(salary) 부서번호(department_id)를 조회 급여의 내림차순

--1
SELECT department_id,
       max(salary)
FROM employees
group by department_id;

--2
SELECT employee_id 직원번호,
       first_name 이름,
       salary 급여,
       department_id 부서번호
FROM employees
order by salary desc;

--3 
SELECT employee_id 직원번호,
       first_name 이름,
       salary 급여,
       department_id 부서번호
FROM employees 
where (department_id, salary) in (SELECT department_id,
                                         max(salary)
                                  FROM employees
                                  group by department_id)
order by salary desc;



/*
문제6.
각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오 
(19건)
*/
--1. 각 업무(job) 별로 연봉(salary)의 총합 내림차순
--2. 업무명(job_title)
--3. 연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합

--1
SELECT job_id 업무,
       sum(salary) 연봉합
FROM employees
group by job_id
order by sum(salary) desc;

--2
SELECT job_title 업무명,
       j.job_id 업무
FROM jobs j;



--3 select하기..(못함)
SELECT *
FROM jobs j, (SELECT job_id,
                     sum(salary)
               FROM employees
               group by job_id) e
where j.job_id = e.job_id;


/*
문제7.
자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 직원번호(employee_id), 이름(first_name)과 급여(salary)을 조회하세요 
(38건)
*/
--1. 부서 평균 급여
--2. 부서에 평균 급여 가상테이블 생성
--2. 자신의 부서 평균 급여보다 연봉(salary)이 많은 직원
--3. 자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 직원번호(employee_id), 이름(first_name)과 급여(salary)을 조회

--1
SELECT department_id,
       avg(salary)
FROM employees
group by department_id;

--2
SELECT e.department_id 직원번호,
       e.salary 연봉
FROM employees e, (SELECT department_id,
       avg(salary)
FROM employees
group by department_id) c
where e.department_id = c.department_id;


--2
SELECT *
FROM employees e, (SELECT department_id,
       avg(salary)
FROM employees
group by department_id) c
where e.department_id = c.department_id;


--3 못함.. 쩝...


/*
문제8.
직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력하세요
*/


