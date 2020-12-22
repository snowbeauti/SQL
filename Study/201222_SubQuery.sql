/****************************************************************
subquery 서브쿼리
****************************************************************/
--SubQuery : 하나의 SQL 질의문 속에 다른 SQL 질의문이 포함되어 있는 형태

--10000보다 급여가 많은 사람의 이름과 급여
SELECT employee_id,
       first_name,
       salary
FROM employees
where salary > 10000;

--‘Den’ 급여
SELECT employee_id,
       first_name,
       salary
FROM employees
where first_name = 'Den'; -->11000

--‘Den’ 보다 급여를 많은 사람의 이름과 급여는?
SELECT employee_id,
       first_name,
       salary
FROM employees
where salary > (select salary
                from employees
                where first_name = 'Den');
                
/*
예제) 
급여를 가장 적게 맏는 사람의 이름, 급여, 사원번호는?
1. 가장 적은 급여 액수 -->2100
2. 2100을 받는 직원의 이름, 급여, 사원번호는?
*/

--1
SELECT MIN(SALARY)
FROM employees;

--2
SELECT first_name,
       salary,
       employee_id
FROM employees
where salary = 2100;

--3
SELECT first_name,
       salary,
       employee_id
FROM employees
where salary = (SELECT MIN(SALARY)
                FROM employees);
                
--평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요?
--1. 평균급여   3000
--2. 3000보다 작은 사람 리스트
--3. 조합

--1 (6461.83)
select avg(salary)
from employees;

--2
SELECT first_name,
       salary
FROM employees
where salary < 6461.83;

--3
SELECT first_name,
       salary
FROM employees
where salary <(SELECT avg(salary)
               from employees);
               
--부서번호가 110인 직원의 급여와 같은 모든 직원의
--사번, 이름, 급여를 출력하세요
--부서번호가 110인 직원의 이름, 급여... 리스트

--1
select first_name,
       salary,
       department_id
from employees
where department_id = 110;

--2
SELECT employee_id,
       first_name,
       salary
FROM employees
where salary = 12008
or salary = 8300;

--3
SELECT employee_id,
       first_name,
       salary
FROM employees
where salary in (select salary
                 from employees
                 where department_id = 110);


--각 부서별로 최고급여를 받는 사원을 출력하세요
--1. 부서별로 최고급여 열마인지? (누구인지는 아직 못구함)


SELECT department_id,
       max(salary)       
FROM employees
group by department_id;


--2. 전체 사원 테이블에서 부서번호와 급여 같은 사람을 찾는다.
--부서별 최고 급여 리스트 기준으로
SELECt first_name,
       employee_id,
       salary,
       department_id
FROM employees
where (department_id , salary) in (SELECT department_id,
                                          max(salary)       
                                   FROM employees
                                   group by department_id);



/*
예제
부서번호가 110인 직원의 급여보다 큰 모든 직원의
사번, 이름, 급여를 출력하세요 (or연산 --> 8300보다 큰)
*/ 

--부서번호 100인 직원의 급여리스트
select *
FROM employees 
where department_id = 100; -- 12008, 8310

SELECT
    *
FROM employees
where salary > 12008;

SELECT employee_id,
       first_name,
       salary
FROM employees
where salary > any (select salary
                    from employees
                    where department_id = 110);
            
            
SELECT employee_id,
       first_name,
       salary
FROM employees
where salary > all (select salary
                    from employees
                    where department_id = 110);
                    
            
--sub Quesry로 테이블 만들기 -->join 사용
--각 부서별로 최고급여를 받는 사원을 출력하세요
--1. 각 부서별로 최고 급여 테이블

SELECT department_id,
       max(salary)
FROM employees
group by department_id;

--2직원 테이블 (1)테이블을 join 한다.
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.department_id,
       d.department_id,
       d.salary
FROM employees e, (SELECT department_id,
                            max(salary) salary
                     FROM employees
                     group by department_id) d
where e.department_id = d.department_id            
and e.salary = d.salary;