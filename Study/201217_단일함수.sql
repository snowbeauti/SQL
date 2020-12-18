--단일행 함수

--initcap(컬럼명)
SELECT email,
       initcap(email),
       department_id
FROM employees
where department_id = 100;

--문자함수 – LOWER(컬럼명) / UPPER(컬럼명)
select first_name,
       lower(first_name),
       upper(first_name)
From employees
where department_id = 100;

--문자함수 – SUBSTR(컬럼명, 시작위치, 글자수)
select first_name,
       substr(first_name,2,4),
       substr(first_name,-3,2)
FROM employees
where department_id = 100;

--문자함수 – LPAD(컬럼명, 자리수, ‘채울문자’) /  RPAD(컬럼명, 자리수, ‘채울문자’)
SELECT first_name,
       lpad(first_name,10, '*'),--10개로 만들고 없는건 *로 채움, 10자리가 넘으면 생략
       rpad(first_name,10,'*')--뒷자리를 *로 채움, 10자리가 넘으면 생략    
FROM employees;

--문자함수 – REPLACE (컬럼명, 문자1, 문자2)
select first_name,
       replace(first_name, 'a', '**')--글자수와 상관없이 a를 **으로 바꿈(앞을 뒤로)
FROM employees
where department_id = 100;

--함수 조합
SELECT first_name,
       replace(first_name, 'a', '*'),
       substr(first_name, 2, 3),
       replace(first_name, substr(first_name, 2, 4), '****')
FROM employees
where department_id = 100;

--숫자함수 – ROUND(숫자, 출력을 원하는 자리수) 
SELECT round(123.456, 2)r2, --소수점 둘째자리까지 표기, 반올림
       round(123.456, 0)r0, --소수점x(반올림)
       round(123.456,-1)"r-1" --일의자리에서 반올림 
FROM dual; --dual은 가상의 데이터(자리 채우려고 만듦)

SELECT salary,
       round(salary, -3)--백의자리에서 반올림
FROM employees;

--숫자함수 – TRUNC(숫자, 출력을 원하는 자리수) 
SELECT trunc(123.456, 2) as r2, --소수점 둘째자리까지 표기(버리기)
       trunc(123.456, 0) as r0,
       trunc(123.456, -1) as "r-1"
FROM dual;

--날짜함수 – SYSDATE
SELECT sysdate
FROM dual;

SELECT sysdate,
       first_name
FROM employees;

--단일함수>날짜함수 – MONTH_BETWEEN(d1, d2) 
SELECT sysdate,
       hire_date, 
       trunc(months_between(sysdate, hire_date), 0) as workMonth 
FROM employees
where department_id = 100;

--날짜함수 -Last_DAY (d1) 해당월의 마지막일자
SELECT last_day('19/02/06'),
       LAST_DAY(SYSDATE)    
FROM dual;

--TO_CHAR(숫자, ‘출력모양’)  숫자형문자형으로 변환하기
select last_name,
       salary*12,
       to_char(salary*12, '$999,999,00'),--888,888,00은 안됨
       to_char(salary*12, '$099,999,00')--0은 표기됨
from employees
where department_id = 100;

--변환함수>TO_CHAR(날짜, ‘출력모양’)  날짜문자형으로 변환하기
SELECT sysdate, 
       to_char(sysdate, 'yyyy-mm-dd') "Date",
       to_char(sysdate, 'yy-mm-dd') "Date(Short)",
       to_char(sysdate, 'Month')Month,
       to_char(Sysdate, 'day') day,
       to_char(sysdate, 'yyyy"년" mm"월" dd"일"') "date",
       to_char(sysdate, 'hh') hour,
       to_char(sysdate, 'HH24:MI:SS') Time
FROM dual;

--년월일 시분초
Select to_char(sysdate, 'yyyy"년" mm"월" dd"일"') "date",
       to_char(sysdate, 'HH24:MI:SS') Time
FROM dual;

SELECT first_name,
       hire_date,
       to_char(hire_date, 'yyyy-mm-dd')    
FROM employees;

--일반함수>NVL(컬럼명, null일때값)/NVL2(컬럼명, null아닐때값, null일때 값)
SELECT first_name,
       commission_pct,
       NVL(commission_pct, 0)--null 일때 0으로 표기해줌
FROM employees;






