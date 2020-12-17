--단일주석
/*
*/
select * FROM employees;

SELECT* FROM departments;

--원하는 컬럼 조회하기

SELECT employee_id, 
       first_name, 
       last_name 
FROM employees;

select * FROM employees;

SELECT first_name,
       phone_number,
       hire_date,
       salary
FROM employees; 

SELECT first_name,
       last_name,
       salary,
       phone_number,
       email,
       hire_date   
FROM employees;

--출력할때 컬럼에 별명 사용하기 (as, but 생략가능_일관성있게 쓰기)

SELECT employee_id as empNo, 
       first_name "F-name", --특수문자, 공백, 대소문자 구분시 "이름" 으로 표기 
       salary "연봉"
    
FROM employees;

SELECT first_name 이름, 
       phone_number 전화번호, 
       hire_date 입사일,
       salary 급여
FROM employees;

SELECT employee_id 사원번호,
       first_name 이름, 
       last_name 성, 
       hire_date 급여,
       phone_number 전화번호, 
       email 이메일,
       hire_date 입사일
FROM employees;

--연결 연산자(Concatenation)로 컬럼들 붙이기

SELECT  first_name || last_name 성명
FROM employees;

SELECT  first_name || ' ' || last_name 성명 -- 공백넣기 || ' ' ||
FROM employees;

SELECT first_name || ' hire date is ' || hire_date
   
FROM employees;

--산술연산자 사용하기
SELECT first_name, salary 
    
FROM employees;

SELECT first_name,
       salary,
       salary*12
FROM employees;

SELECT first_name||' '||last_name "성명",
       salary*12 연봉,
       (salary+300) 인센티브
FROM employees;

--문자열은 산술연산 되지 않음
SELECT job_id*300
FROM employees;

select first_name || '_' || last_name 성명,
       salary 급여,
       salary*12 연봉,
       (salary*12+5000) 연봉2,
       phone_number 전화번호
FROM employees;

--select문 >where절
SELECT first_name
FROM employees
where department_id = 10;

SELECT first_name,
       last_name,
       salary
FROM employees
where salary >= 15000;

SELECT last_name, 
       hire_date
FROM employees
where hire_date >= '07/01/01';

select salary --Colum값
from employees
where first_name = 'Lex'; --low값

SELECT last_name, salary
FROM employees
where salary>=14000
and salary<=17000; 

SELECT last_name, hire_date
FROM employees
where hire_date>= '04/01/01'
and hire_date<='05/12/31';

SELECT last_name, salary
FROM employees
where salary between 14000 and 17000; --이상&이하 시 포함

select first_name, last_name
FROM employees
where first_name in ('Neena', 'Lex', 'John') ; -- =or

select first_name, last_name
FROM employees
where first_name = 'Neena'
or first_name = 'Lex'
or first_name = 'John';

select last_name, salary
FROM employees
where salary in (2100, 3100, 4100, 5100);

--Like 연산자
SELECT last_name
FROM employees
where first_name like 'A%';

SELECT first_name, last_name, salary
FROM employees
where first_name like '_o%'; --두번째 글자에 o가 오면 출력

SELECT first_name, last_name, salary
FROM employees
where first_name like '%am%'; --am를 포함하면 모두 출력

SELECT first_name, last_name, salary
FROM employees
where first_name like '_a'; -- 두글자, 두번째 글자가 a면 출력

--null
--직원 테이블에서 급여가 13000~15000
--직원의 이름, 급여, 커미션%, 급여*커미션 출력
select first_name,
       salary,
       commission_pct,
       salary*commission_pct
from employees
where salary BETWEEN 13000 and 15000;

SELECT
    *
FROM employees
where commission_pct is null;

SELECT last_name,
       salary*commission_pct   
FROM employees
where commission_pct is not null;

SELECT last_name
FROM employees
where manager_id is null
and commission_pct is null;

select email, employee_id
FROM employees
where employee_id = 110; --px

/*
select 문
 select 절
 from 절
 where 절
 order by 절 -->정렬
*/

SELECT
    *
FROM employees
order by salary desc;

SELECT
    *
FROM employees
order by employee_id asc;

SELECT
    *
FROM employees
WHERE salary>=9000
order by salary desc;

--asc 작->큰
--desc 큰->작

--부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
SELECT department_id, salary, last_name
FROM employees
order by department_id asc;

--급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
SELECT last_name
FROM employees
where salary>=10000
order by salary desc;

--부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호, 급여, 이름을 출력하세요  
SELECT department_id, salary, last_name
FROM employees
order by department_id asc, salary desc;