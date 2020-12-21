--테이블간 조인(JOIN) SQL 문제입니다.
/*
문제1.
직원들의 사번(employee_id), 이름(firt_name), 성(last_name)과 부서명(department_name)을 조회하여 부서이름(department_name) 오름차순, 사번(employee_id) 내림차순 으로 정렬하세요.
(106건)
*/
SELECT e.employee_id 사번,
       e.first_name 이름,
       e.last_name 성,
       d.department_name 부서명,
       d.department_id
FROM employees e, departments d
where e.department_id = d.department_id
order by department_name asc, employee_id desc; 


/*
문제2.
employees 테이블의 job_id는 현재의 업무아이디를 가지고 있습니다.
직원들의 사번(employee_id), 이름(firt_name), 급여(salary), 부서명(department_name), 현재업무(job_title)를 사번(employee_id) 
오름차순 으로 정렬하세요.
부서가 없는 Kimberely(사번 178)은 표시하지 않습니다.
(106건)
*/

SELECT e.employee_id 사번,
       e.first_name 이름,
       e.salary 급여,
       d.department_name 부서명,
       j.job_title 현재업무
FROM employees e, jobs j, departments d  
where e.job_id = j.job_id
and e.department_id = d.department_id
order by employee_id asc;


/*
문제2-1.
문제2에서 부서가 없는 Kimberely(사번 178)까지 표시해 보세요

employees 테이블의 job_id는 현재의 업무아이디를 가지고 있습니다.
직원들의 사번(employee_id), 이름(firt_name), 급여(salary), 부서명(department_name), 현재업무(job_title)를 사번(employee_id) 
오름차순 으로 정렬하세요.
(107건)
*/
SELECT e.employee_id 사번,
       e.first_name 이름,
       e.salary 급여,
       d.department_name 부서명,
       j.job_title 현재업무
FROM employees e, jobs j, departments d  
where e.job_id = j.job_id
and e.department_id = d.department_id(+)
order by employee_id asc;



/*
문제3.
도시별로 위치한 부서들을 파악하려고 합니다.
도시아이디(LOCATION_ID), 도시명(CITY), 부서명(department_name), 부서아이디(department_id)를 
도시아이디(오름차순)로 정렬하여 출력하세요 
부서가 없는 도시는 표시하지 않습니다.
(27건)
*/
SELECT l.LOCATION_ID 도시아이디,
       l.CITY 도시명,
       d.department_name 부서명,
       d.department_id 부서아이디
FROM locations l, departments d
where l.location_id = d.location_id 
order by l.LOCATION_ID asc;


/*
문제3-1.
문제3에서 부서가 없는 도시도 표시합니다. 
(43건)
*/
SELECT l.LOCATION_ID 도시아이디,
       l.CITY 도시명,
       d.department_name 부서명,
       d.department_id 부서아이디
FROM locations l left outer join departments d
on l.location_id = d.location_id 
order by l.LOCATION_ID asc;

/*
문제4.
지역(regions)에 속한 나라들을 지역이름(region_name), 나라이름(country_name)으로 출력하되 지역이름(오름차순), 나라이름(내림차순) 으로 정렬하세요.
(25건)
*/
SELECT r.region_name 지역이름,
       c.country_name 나라이름    
FROM regions r, countries c
where c.region_id = r.region_id
ORDER by r.region_name asc, c.country_name desc;


/*
문제5. 
자신의 매니저보다 채용일(hire_date)이 빠른 사원의 
사번(employee_id), 이름(first_name)과 채용일(hire_date), 매니저이름(first_name), 매니저입사일(hire_date)을 조회하세요.
(37건)
*/
SELECT e.employee_id 사번,
       e.first_name 이름,
       e.hire_date 채용일,
       m.first_name 매니저이름,
       m.hire_date 매니저입사일  
FROM employees e, employees m
where e.manager_id = m.employee_id
and e.hire_date < m.hire_date;


/*
문제6.
나라별로 어떠한 부서들이 위치하고 있는지 파악하려고 합니다.
나라명(COUNTRY_NAME), 나라아이디(COUNTRY_ID), 도시명(CITY), 도시아이디(COUNTRY_ID), 부서명(DEPARTMENT_NAME), 부서아이디(DEPARTMENT_ID)를 나라명(오름차순)로 정렬하여 출력하세요.
값이 없는 경우 표시하지 않습니다.
(27건)
*/
SELECT c.country_name 나라명,
       c.country_id 나라아이디,
       l.city 도시명,
       l.location_id 도시아이디,
       d.department_name 부서명,
       d.department_id 부서아이디
FROM locations l, countries c, departments d
where l.country_id = c.country_id
and l.location_id = d.location_id;

/*
문제7.
job_history 테이블은 과거의 담당업무의 데이터를 가지고 있다.
과거의 업무아이디(job_id)가 ‘AC_ACCOUNT’로 근무한 사원의 사번, 이름(풀네임), 업무아이디, 시작일, 종료일을 출력하세요.
이름은 first_name과 last_name을 합쳐 출력합니다.
(2건)
*/

SELECT e.employee_id 사번,
       e.last_name || e.first_name 이름,
       e.job_id 업무아이디,
       h.start_date 시작일,
       h.end_date 종료일
FROM employees e, job_history h
where e.employee_id = h.employee_id
and h.job_id = 'AC_ACCOUNT';

/*
문제8.
각 부서(department)에 대해서 부서번호(department_id), 부서이름(department_name), 
매니저(manager)의 이름(first_name), 위치(locations)한 도시(city), 나라(countries)의 이름(countries_name) 
그리고 지역구분(regions)의 이름(resion_name)까지 전부 출력해 보세요.
(11건)
*/
SELECT d.department_id 부서번호,
       d.department_name 부서이름,
       man.first_name 매니저이름,
       l.city 도시,
       c.country_name 나라이름,
       r.region_name 지역이름   
FROM departments d, locations l, countries c, regions r, employees man
where r.region_id = c.region_id 
and c.country_id = l.country_id
and l.location_id = d.location_id
and d.manager_id = man.employee_id;

/*
문제9.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 매니저(manager)의 이름(first_name)을 
조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)
*/
SELECT e.employee_id 사번,
       e.first_name 이름,
       d.department_name 부서명,
       man.first_name 매니저이름
FROM employees e, departments d, employees man
where e.department_id = d.department_id(+)
and e.manager_id = man.employee_id;

