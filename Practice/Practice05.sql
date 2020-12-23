--혼합 SQL 문제입니다.
/*
문제1.
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 
이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
(45건)
*/
--매니저 is not null, COMMISSION_PCT is null,  SALARY > 3000

select first_name 이름,
       manager_id 매니저아이디,
       commission_pct "커미션 비율",
       salary 월급
from employees
where manager_id is not null
and commission_pct is null
and salary > 3000;


/*
문제2. 
각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 급여(salary), 입사일(hire_date), 전화번호(phone_number), 
부서번호(department_id) 를 조회하세요 
-조건절비교 방법으로 작성하세요
-급여의 내림차순으로 정렬하세요
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다.
(11건)
*/
--최고급여 조회

SELECT department_id,
       max(salary)
FROM employees
group by department_id;

--전체 가상 테이블 생성
SELECT
    *
FROM employees e, (SELECT department_id,
       max(salary)
FROM employees
group by department_id) m
where e.department_id = m.department_id;


--각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 급여(salary), 입사일(hire_date), 전화번호(phone_number), 
--부서번호(department_id) 를 조회하세요 
--급여의 내림차순으로 정렬하세요
--입사일은 2001-01-13 토요일 형식으로 출력합니다.
--전화번호는 515-123-4567 형식으로 출력합니다.
SELECT e.employee_id 직원번호,
       e.first_name 이름,
       e.salary 급여,
       to_char(e.hire_date, 'yyyy-mm-dd day') 입사일,
       replace(e.phone_number, '.', '-') 전화번호,
       e.department_id 부서번호
FROM employees e, (SELECT department_id,
       max(salary)ms
FROM employees
group by department_id) m
where e.department_id = m.department_id
and e.salary = m.ms
order by e.salary desc;


/*
문제3
매니저별로 평균급여 최소급여 최대급여를 알아보려고 한다.
-통계대상(직원)은 2005년 이후의 입사자 입니다.
-매니저별 평균급여가 5000이상만 출력합니다.
-매니저별 평균급여의 내림차순으로 출력합니다.
-매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매니저별최대급여 입니다.
(9건)
*/

--평균급여 최소급여 최대급여
SELECT round(avg(salary),0) avs,
       min(salary) mins,
       max(salary) maxs
FROM employees;

--매니저별로 평균급여 최소급여 최대급여
SELECT manager_id,
       round(avg(salary),0) avs,
       min(salary) mins,
       max(salary) maxs
FROM employees
group by manager_id;


--매니저별로 평균급여 최소급여 최대급여
--매니저별 평균급여가 5000이상만 출력합니다.
--매니저별 평균급여의 내림차순으로 출력합니다.
--매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
SELECT manager_id,
       round(avg(salary),0) avs,
       min(salary) mins,
       max(salary) maxs
FROM employees
group by manager_id;

--매니저 아이디 -이름매치
SELECT e.employee_id,
       d.first_name,
       e.manager_id
FROM employees e, employees d
where e.manager_id = d.employee_id;


SELECT *
FROM employees e, employees d
where e.manager_id = d.employee_id;


--출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매니저별최대급여 입니다.

SELECT manager_id,
       round(avg(salary),0) avs,
       min(salary) mins,
       max(salary) maxs
FROM employees
group by manager_id;


--매니저별로 평균급여 최소급여 최대급여
--매니저별 평균급여가 5000이상만 출력합니다.
--매니저별 평균급여의 내림차순으로 출력합니다.
--매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
SELECT d.first_name,
       e.manager_id,
       e.avs,
       e.mins,
       e.maxs
FROM employees d,
     (SELECT manager_id,
             round(avg(salary),0) avs,
             min(salary) mins,
             max(salary) maxs
      FROM employees
      group by manager_id) e
where e.manager_id = d.manager_id
and e.avs > 5000
order by e.avs desc;



/*
문제4.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)
*/
SELECT e.employee_id 사번,
       e.first_name 이름,
       d.department_name 부서명
FROM employees e, departments d
where e.department_id = d.department_id;


SELECT d.first_name   
FROM employees e, employees d
where e.manager_id = d.employee_id;



SELECT c.num 사번,
       c.name 이름,
       c.depart 부서명,
       e.first_name 매니저이름
FROM employees e, (SELECT e.employee_id num,
                           e.first_name name,
                           d.department_name depart,
                           d.department_id did,
                           e.manager_id man
                   FROM employees e, departments d
                   where e.department_id= d.department_id(+)) c
where e.employee_id = c.man;


/*
문제5.
2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 
사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
*/

SELECT e.employee_id,
       e.first_name,
       d.department_name,
       e.salary,
       e.hire_date
FROM employees e, departments d
where e.department_id = d.department_id;

--2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
select r.employee_id 사번,
       r.first_name 이름,
       r.department_name 부서명,
       r.salary 급여,
       r.hire_date 입사일
from(SELECT rownum rnum,
            c.employee_id,
            c.first_name,
            c.department_name,
            c.salary,
            c.hire_date   
     FROM (SELECT e.employee_id,
                  e.first_name,
                  d.department_name,
                  e.salary,
                  e.hire_date
           FROM employees e, departments d
           where e.department_id = d.department_id
           and e.hire_date > '05/01/01'
           order by e.hire_date asc
           ) c
    ) r
where r.rnum between 11 and 20;


/*
문제6.
가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름(department_name)은?
 */

SELECT max(hire_date)  
FROM employees;

select first_name || ' ' || last_name 이름,
       salary 연봉,
       d.department_name 부서이름,
       hire_date
from employees e, DEPARTMENTS d
where hire_date = (SELECT max(hire_date)  
                   FROM employees)
and e.department_id = d.department_id;                   


/*
문제7.
평균연봉(salary)이 가장 높은 부서 직원들의 
직원번호(employee_id), 이름(firt_name), 성(last_name)과  업무(job_title), 연봉(salary)을 조회하시오.
*/
--부서별 평균연봉(salary)
select department_id,
       avg(salary)
from employees
group by department_id
order by avg(salary) desc;


--평균연봉(salary)이 가장 높은 부서
select reee.avs
from(SELECT rownum rnum,
       e.avs
FROM (select department_id,
       avg(salary) avs
from employees
group by department_id
order by avg(salary) desc)e
where rownum = 1) reee;


--직원번호(employee_id), 이름(firt_name), 성(last_name)과  업무(job_title), 연봉(salary)을 조회
SELECT em.employee_id,
       em.first_name,
       em.last_name,
       em.salary,
       j.job_title
FROM employees em, jobs j
where em.job_id = j.job_id;


--직원번호(employee_id), 이름(firt_name), 성(last_name)과  업무(job_title), 연봉(salary), 평균연봉을 조회
SELECT em.employee_id,
       em.first_name,
       em.last_name,
       em.salary,
       re.av,
       j.job_title
FROM employees em, jobs j, (select department_id,
                                   avg(salary) av
                            from employees
                            group by department_id
                            order by avg(salary) desc) re
where em.job_id = j.job_id
and em.department_id = re.department_id;


--평균연봉(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name), 성(last_name)과  업무(job_title), 연봉(salary)을 조회하시오.
SELECT ree.id 사번,
       ree.fname 이름,
       ree.lname 성,
       ree.sal 급여,
       ree.av "AVG_SALARY",
       ree.jtitle "JOB_TITLE"
FROM(SELECT em.employee_id id,
            em.first_name fname,
            em.last_name lname,
            em.salary sal,
            re.av,
            j.job_title jtitle
     FROM employees em, jobs j, (select department_id,
                                        avg(salary) av
                                 from employees
                                 group by department_id
                                 order by avg(salary) desc) re
     where em.job_id = j.job_id
     and em.department_id = re.department_id) ree
where ree.av =  (select reee.av
                  from(SELECT rownum rnum,
                              e.av
                  FROM (select department_id,
                               avg(salary) av
                        from employees
                  group by department_id
                  order by avg(salary) desc)e
                  where rownum = 1) reee);     



/*
문제8.
평균 급여(salary)가 가장 높은 부서는? 
*/

SELECT d.department_name 부서명
FROM (select rownum rnum,
       fi.id,
       fi.av 
from (SELECT department_id id,
             avg(salary) av
      FROM employees
      group by department_id
      order by av desc) fi
where rownum = 1) ro, departments d
where ro.id = d.department_id;

/*
문제9.
평균 급여(salary)가 가장 높은 지역은? 
*/
--지역번호 별 연봉
SELECT r.region_name name,
       e.salary sal
FROM employees e, countries c, regions r, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id
and c.region_id = r.region_id;

--지역번호 별 평균연봉
SELECT r.name,
       avg(r.sal)
FROM (SELECT r.region_name name,
             e.salary sal
      FROM employees e, countries c, regions r, departments d, locations l
      where e.department_id = d.department_id
      and d.location_id = l.location_id
      and l.country_id = c.country_id
      and c.region_id = r.region_id)r
group by r.name
order by avg(r.sal)desc;

--지역번호 별 평균연봉 넘버링
SELECT rownum rnum,
       re.name,
       re.avs
FROM(SELECT r.name,
            avg(r.sal) avs
     FROM (SELECT r.region_name name,
                  e.salary sal
           FROM employees e, countries c, regions r, departments d, locations l
           where e.department_id = d.department_id
           and d.location_id = l.location_id
           and l.country_id = c.country_id
           and c.region_id = r.region_id)r
     group by r.name
     order by avg(r.sal)desc) re
where rownum = 1;

평균 급여(salary)가 가장 높은 지역은? 
select ree.name 지역
from(SELECT rownum rnum,
            re.name,
            re.avs
     FROM(SELECT r.name,
                 avg(r.sal) avs
          FROM (SELECT r.region_name name,
                       e.salary sal
                FROM employees e, countries c, regions r, departments d, locations l
                where e.department_id = d.department_id
                and d.location_id = l.location_id
                and l.country_id = c.country_id
                and c.region_id = r.region_id)r
          group by r.name
          order by avg(r.sal)desc) re
      where rownum = 1)ree;


/*
문제10.
평균 급여(salary)가 가장 높은 업무는? 
*/
--직업별 평균연봉
SELECT job_id,
       avg(salary)
FROM employees
group by job_id
order by avg(salary) desc;

--평균 급여(salary)가 가장 높은 업무 
SELECT rownum rnum,
       e.id,
       e.sal       
FROM (SELECT job_id id,
       avg(salary) sal
      FROM employees
      group by job_id
      order by avg(salary) desc) e
where rownum = 1;
      
SELECT j.job_title 직업명
FROM(SELECT rownum rnum,
            e.id,
            e.sal       
     FROM (SELECT job_id id,
                  avg(salary) sal
           FROM employees
           group by job_id
           order by avg(salary) desc) e
     where rownum = 1) inf, jobs j
where inf.id = j.job_id;      

