-- DQL (질의어) : 데이터 조회할때 사용 

-- select 컬럼명 
-- from 테이블명

-- 전체 데이터 조회 
select empno,ename,job,mgr,hiredate,comm,sal,deptno from emp; 
select * from emp;   -- *: 전체

-- 부분컬럼 데이터 조회
select empno,ename,sal from emp;
select deptno from emp;

-- 중복 데이터 제거 (DISTINCT)
select distinct deptno from emp;

select job from emp;
select DISTINCT job from emp;

-- 컬럼에 연산 가능 ( + , - , * , /  : 4가지만 제공 나머지 연산자는 없음) 컬럼을 대상으로 연산 
-- null 데이터는 연산할 수 없다. -> null 값과 기존 데이터를 연산하게되면 기존 데이터도 null값 으로 변경됨  
-- nvl (컬럼명 , null값일때 변경할 값 ) : null값이 들어있는 컬럼을 0으로 변경해서 연산 
-- 컬럼에 별칭을 사용할 수 있다.  as 별칭
select ename as 사원이름 ,sal as 월급 ,sal * 12 + nvl(comm,0)as 연봉 ,comm as 상여금 from emp;

-- 데이터 정렬
-- order by 컬럼명(정렬기준이 되는 값) asc(오름차순)/desc(내림차순);
select * from emp order by sal desc; -- 내림차순
select * from emp order by sal; -- 오름차순은 asc 생략 가능하다.(기본설정)
    --오름차순 기준: 숫자 (1~10), 날짜(과거날짜~최근날짜), 문자(사전순서)

================================================================================================================

-- 조건검색
-- where 조건식(컬럼명 = 값);     
-- [  < , > , = , != / <>(다르다는 두가지 표현이 있음) , <= , >=, and , or  ]

-- and : 두가지 이상의 조건이 모두 참인경우
select * from emp where sal >= 3000; -- 급여(sal)가 3000 이상인 사원
select * from emp where deptno = 30; -- 30번인 부서번호(deptno)에서 일하는 사람
select * from emp where deptno = 30 and job = 'SALESMAN'; -- 30번인 부서번호(deptno)에서 직업(job)이 SALESMAN인 사람
          --문자를 쓸때는 홑따옴표(')를 사용, 문자로 된 데이터 값은 대-소문자 구분하기!
            select * from emp where ename = 'ford'; -- 소문자 ford는 데이터에 존재하지 않기 때문에 조회가 안 됨!
            select * from emp where ename = 'FORD';
            
--or : 두가지 이상의 조건 중에 하나 이상이 참인 경우
select * from emp where deptno = 10 or sal >= 2000; -- 부서번호(deptno)가 10이거나 급여가 2000이상인 사람

 -- 날짜를 조건절에 사용할 때 
 -- (')사용
 -- 날짜도 크기가 있다
 -- 80/12/20 -> 1980 12 20 시간 분 초 요일
select * from emp where hiredate < '1982/01/01'; -- 1982년 01월 01일 이전에 입사한 사람

-- 문자열 대소 비교
select * from emp where ename >= 'F'; -- ENAME(ename) 열(데이터) 값의 첫 문자와 대문자 F를 비교했을 때
                                      -- 알파벳 순서상 F와 같거나 F보다 뒤에 있는 문자열을 출력한다.
                                      
-- not 논리부정 연산자
SELECT * FROM emp where sal != 3000;
SELECT * FROM emp where not sal = 3000; -- 급여(sal)가 3000이 아닌 사람.(둘 다 같음)

-- 범위 조건을 표현
-- and , or , between and , in 
 SELECT * FROM emp where sal >= 1000 and sal <= 3000; 
 SELECT * FROM emp where sal <= 1000 or sal >=3000;

-- between and (and 범위 조건을 더 간소화 가능)
SELECT * FROM emp where sal >= 1000 and sal <= 3000;
SELECT * FROM emp where sal BETWEEN 1000 and 3000;

-- in (or 범위 조건을 더 간소화 가능)
SELECT * FROM emp WHERE sal = 800 or sal = 3000 or sal = 5000;
SELECT * FROM emp WHERE sal in(800,3000,5000);

================================================================================================================

-- like 연산자
-- 값의 일부만 가지고 데이터를 조회
-- 와이드 카드를 사용한다 ( % , _ )
-- % : 모든 문자를 대체한다.
-- _ : 한 문자를 대체한다.
select * from emp where ename like 'F%'; -- 'F'로 시작하면서 뒤에 문자는 있어도 되고 없어도 된다.
select * from emp where ename like '%D'; -- 'D'로 끝나는 데이터 값, 'D' 앞에 문자는 있어도 되고 없어도 된다.
select * from emp where ename like '%O%'; -- 이름 중에 'O'가 어디든 들어가도 된다.

select * from emp where ename like '___D'; -- ('_'x3) 4글자 중 맨 뒤에 글자가 'D'인 사람 ex) WARD,FORD
select * from emp where ename like '______'; -- ('_'x6) 이름이 6글자인 사람

select * from emp where ename like 'M__%'; -- ('_'x2) 첫글자가 'M'인 앞 3글자는 반드시 들어가고, 뒤에는 있던 없던 상관없다.(M으로 시작하는 3글자이상의 이름) 
     
     
-- null연산자     
-- is null / is not null
select * from emp where comm = null; -- null 데이터는 비교 불가!

select * from emp where comm is null; -- null에 특화된 연산자 사용해야됨!
select * from emp where comm is not null;     

================================================================================================================

-- 집합 연산자 
-- 두개의 select 구문을 사용한다.
-- 컬럼의 갯수가 동일해야 한다.
-- 컬럼의 타입이 동일해야 한다.
-- 컬럼의 이름은 상관없다.
-- 합집합(union), 차집합(minus), 교집합(intersect)
select empno,ename,sal,deptno from emp where deptno = 10; -- 3명
select empno,ename,sal,deptno from emp where deptno = 20; -- 5명

--(1)
select empno,ename,sal,deptno from emp where deptno = 10 --세미콜론 지우기!
union -- (합집합 연산자)
select empno,ename,sal,deptno from emp where deptno = 20; -- 8명 

--(2)
select empno,ename,sal,deptno from emp where deptno = 10 union select empno,ename,sal,deptno from emp where deptno = 10; -- union 사용 시 중복되는 자료의 경우 한번만 조회
select empno,ename,sal,deptno from emp where deptno = 10 union all select empno,ename,sal,deptno from emp where deptno = 10; -- union all 사용 시 중복되어도 모든 값 조회

--(3)
select empno,ename,sal,deptno from emp -- 14명
minus -- (차집합 연산자)
select empno,ename,sal,deptno from emp where deptno = 20; -- 5명 결국 14-5 = 9명

--(4)
select empno,ename,sal,deptno from emp -- 14명
intersect -- (교집합 연산자)
select empno,ename,sal,deptno from emp where deptno = 20; -- 5명 결국 교집합은 5명


-- order by
-- where
-- 비교 연산자, 논리 연산자, 집합 연산자
-- < , > , <= , >= , = , != / <>
-- and, or, not, between and, in
-- like ( % , _ )
-- is null , is not null
-- UNION, UNION ALL, MINUS, INTERSECT


--p.125
--Q1
SELECT * FROM emp where ename like '%S';

--Q2
SELECT empno,ename,job,sal,deptno FROM emp where deptno = 30 and job = 'SALESMAN';

--Q3
SELECT empno,ename,job,sal,deptno FROM emp where deptno in (20, 30) and sal > 2000;

SELECT empno,ename,job,sal,deptno FROM emp where deptno = 20 and sal > 2000
union
SELECT empno,ename,job,sal,deptno FROM emp where deptno = 30 and sal > 2000;

--Q4
SELECT * FROM emp where not (sal >=2000 and sal <=3000);

SELECT * FROM emp where sal < 2000 or sal > 3000;
--Q5 
SELECT ename,empno,sal,deptno FROM emp where deptno = 30 and ename like '%E%' and sal not between 1000 and 2000;

SELECT ename,empno,sal,deptno FROM emp where deptno = 30 and ename like '%E%'
minus
SELECT ename,empno,sal,deptno FROM emp where sal between 1000 and 2000;

--Q6
SELECT * FROM emp where comm is NULL and job = 'MANAGER' or job ='CLERK'
intersect
SELECT * FROM emp where ename not like '_L%';

================================================================================================================

-- 함수
-- 문자함수: upper, lower, substr, instr, replace, rpad, lpad,concat,...
-- 숫자함수: round, trunc, ceil, floor, mod, ...
-- 날짜함수: sysdate, round, trunc,...

--문자함수==
select 'Welcom',upper('Welcom') from dual;
select lower(ename),upper(ename) from emp;

SELECT * FROM emp where ename = 'FORD';
SELECT * FROM emp where lower(ename) = 'scott';

SELECT ename, length(ename) from emp; -- length() 해당 컬럼 데이터의 문자열의 길이를 알려줌

--     -16     ~      -1  
--      1      ~      16 (띄어쓰기, 쉼표등도 포함)    ┌2번째 글자부터 3개의 글자 추출     ┌11번째 글자부터 뒷 글자 모두 추출           
SELECT 'Welcom to Oracle',substr('Welcom to Oracle',2,3), substr('Welcom to Oracle',11) FROM dual;
SELECT 'Welcom to Oracle',substr('Welcom to Oracle',-4,3), substr('Welcom to Oracle',-16) FROM dual;
--                                                 └뒤에서 4번째 글자부터 3개의 글자 추출 └-16번째 글자부터 뒷 글자 모두 추출
select instr('Welcom to Oracle','o') from dual;  -- 첫번째로 나오는 'o'의 인덱스 번호 = 5
select instr('Welcom to Oracle','o',6) from dual; -- 6번째 부터 시작해서 첫번째로 나오는 'o'의 인덱스 번호 = 9
select instr('Welcom to Oracle','e',1,2) from dual; -- 1번째 부터 시작해서 두번째로 나오는 'o'의 인덱스 번호 = 16

SELECT 'Welcom to Oracle', replace('Welcom to Oracle','to','of') from dual;-- to -> of
                   --  ┌ 메인    ┌공백문자
select 'oracle',lpad('oracle',10,'#'), rpad('oracle',10,'*'),lpad('oracle',10) from dual; 
                          --  └총 공간 수(메인 인덱스 수 + 공백문자)
-- lpad: 왼쪽 빈공간에 공백문자, rpad 오른쪽 빈공간에 공백문자, 공백문자 미설정 시 공백으로 나옴
select rpad('990103-',14,'*') from dual;

-- 연결할 때 쓰는 함수 & 연산자
-- concat() , ||   =  둘이 동일한 결과가 나옴(쓰기나름)
select concat(empno,ename), empno||''||ename from emp;
select concat(empno,concat(' ',ename)), empno||' '||ename from emp;

================================================================================================================

--숫자함수==
select
     --[ -3 -2 -1 0 1 2 3 ] = 정수부분은 '-'로 표시
        round(1234.5678),
        round(1234.5678,0), -- 소수점 0번째 자리까지 반올림하여 출력
        round(1234.5678,1),
        round(1234.5678,2), -- 소수점 2번째 자리까지 반올림하여 출력
        round(1234.5678,-1) -- 정수 부분을 반올림하여 출력
                             from dual;

select
        trunc(1234.5678),
        trunc(1234.5678,0), -- 소수점 0번째 자리까지만 살리고 나머지는 다 버린 뒤 출력
        trunc(1234.5678,1),
        trunc(1234.5678,2), -- 소수점 2번째 자리까지만 살리고 출력
        trunc(1234.5678,-1) 
                             from dual;

select
        ceil(3.14), -- 자신보다 큰 가장 가까운  정수 = 4
        floor(3.14), -- 자신보다 작은 가장 가까운 정수 = 3
        ceil(-3.14), -- = -3
        floor(-3.14) -- = -4
                             from dual;                             
                             
select  -- (a,b)
        mod(5,2),   -- a를 b로 나눈 나머지 구하기! 
        mod(10,4) 
                from dual;    
-- mod()함수 활용                
select * from emp where mod(empno,2) = 1; -- 사번(empno)이 홀수인 사람

================================================================================================================

--날짜함수==
select sysdate from dual; --오늘 날짜 조회

select sysdate -1 어제, select sysdate +1 내일 from dual;
    -- ┌오늘날짜  ┌입사날짜
select sysdate - HIREDATE as 근무일수 from emp; -- 차이가 일수 반환 

--근속년수
select trunc((sysdate - HIREDATE) / 365) as 근무일수 from emp;
    --  └ 정수 부분만 남기기 위한 함수(위에 정의되어 있음)

select sysdate, -- (교재 p.155 참고)
                round(sysdate, 'CC') as FORMAT_CC,
                round(sysdate, 'YYYY') as FORMAT_YYYY,
                round(sysdate, 'Q') as FORMAT_Q,
                round(sysdate, 'DDD') as FORMAT_DDD,
                round(sysdate, 'HH') as FORMAT_HH
        from dual;
        
 select sysdate, 
                trunc(sysdate, 'CC') as FORMAT_CC,
                trunc(sysdate, 'YYYY') as FORMAT_YYYY,
                trunc(sysdate, 'Q') as FORMAT_Q,
                trunc(sysdate, 'DDD') as FORMAT_DDD,
                trunc(sysdate, 'HH') as FORMAT_HH
        from dual;       
                
================================================================================================================

-- 자료형변환 함수
--to_char() // 날짜-> 문자 and 숫자 -> 문자
--to_ number() // 문자 -> 숫자 
--to_date() // 문자 -> 날짜

--    to_char()   to_date()
--  숫    ->    문   ->   날
--  자    <-    자   <-   짜
--   to_number()  to_char()

--to_char( [날짜 데이터] , [출력되길 원하는 문자 형태] ) // 날짜 -> 문자
select sysdate, to_char(sysdate,'YYYY-MM-DD HH24:MI:SS')as 현재시간 from dual;
select hiredate,to_char(hiredate,'YYYY-MM-DD HH24:MI:SS DAY')as 입사일자 from emp;

--to_char( [숫자 데이터] , [출력되길 원하는 문자 형태] ) // 숫자 -> 문자
select to_char(123456,'L999,999') from dual;
                   -- └ L은 현재 지역의 화패단위를 표시함
select sal, to_char(sal,'L999,999')from emp;                   

--to_number( [문자 데이터] , [인식될 숫자 형태] ) // 문자 -> 숫자 // 문자가 숫자 형식으로 되어있어야 변환가능
select '20000' - 10000 from dual; -- 자동형변환(암시적형변환)

select '20,000' - '5,000' from dual; -- to_number() 형변환을 해야한다.
      --  └ 숫자 사이에 (,)가 들어가서 숫자로 자동형변환이 되지 않는다.
select to_number('20,000' , '999,999')- to_number('5,000' , '999,999')from dual; 

--to_date( [문자 데이터] , [인식될 날짜 형태] ) // 문자 -> 날짜  // 문자가 날짜 형식으로 되어있어야 변환가능
select to_date('20221019','YYYY/MM/DD') from dual;
select * from emp where hiredate < 19820101; -- 이렇게 하면 숫자가 날짜형식이 아니라서 오류남
select * from emp where hiredate < to_date('19820101','YYYY-MM-DD');

================================================================================================================

-- null 데이터 처리
-- nvl( null , 바꾸고싶은 데이터 )
-- nvl은 nill 데이터의 타입과 같은 타입을 변경해야한다.
-- nvl(숫자,숫자) , nvl(문자,문자)
select ename 사원명, sal, sal*12, + nvl(comm,0) as 연봉, comm from emp;

select * from emp where mgr is null;   -- mgr = null
select ename,job,mgr from emp where mgr is null;  -- mgr = null
select ename,job,nvl(to_char(mgr,'9999'),'CEO') from emp where mgr is null;
                           └ mgr의 데이터는 숫자데이터이기 때문에 문자데이터로 변환을 해줘야된다.
select comm, nvl2(comm,'O','X') from emp; -- null일 땐 뒤에 값이, nill이 아닐 땐 앞에 값이 출력[nlv2()는 타입 상관없다]

================================================================================================================

-- 조건문 표현하는 함수
-- decode() -> switch   //컬럼으로 인식된다 
-- case -> if           //     "
select ename,job,deptno, decode(deptno,10,'AAA',20,'BBB',30,'CCC','기타') as 부서명 from emp;
                      -- └ deptno 컬럼의 값이 10이면 AAA, 20이면 BBB,..,이도저도 아니면 '기타'로 표시하고 해당 컬럼명을 '부서명'으로 정의

-- 범위를 조건식으로 설정할 수 있다
case 
     when 조건식  then 실행문
     when 조건식  then 실행문
     when 조건식  then 실행문
     else 실행문
end as 별칭   

select ename , job, deptno,
                          case when deptno = 10  then 'AAA'
                               when deptno = 20  then 'BBB'
                               when deptno = 30  then 'CCC'
                               else '기타'
                           end as 부서명 from emp;  
  
select ename , job, sal,
            case when sal between 3000 and 5000 then '임원'
                 when sal >= 2000 and sal < 3000 then '관리자'
                 when sal >= 500 and sal < 2000 then '사원'
                 else '기타' end as 직무 from emp;

================================================================================================================                

-- p.174
--Q1    
select empno,
            rpad(substr(empno,1,2),4,'*') as MASKING_EMPNO,
                         ename,
                              rpad(substr(ename,1,1),length(ename),'*') as MASKING_ENAME 
                                    from emp where length(ename) >= 5 and length(ename) < 6;  

--Q2 -- sal /21.5=하루일당
select empno,ename,sal,
trunc(sal /21.5,2) as Day_pay,
round(sal /21.5 / 8,1) as Time_pay
from emp; -- 쌤답

--Q4
select empno,ename,mgr,
                 case when mgr is null then '0000'
                      when substr(mgr,1,2) = '75' then '5555'
                      when substr(mgr,1,2) = '76' then '6666'
                      when substr(mgr,1,2) = '77' then '7777'
                      when substr(mgr,1,2) = '78' then '8888'
                      else to_char(mgr) -- 나머지 결과들은 문자타입이기 때문에 mgr(숫자타입)을 문자타입으로 바꿔줘야한다.
                      end as CHG_MGR from emp; 
                 
================================================================================================================
                
-- 단일행 함수 : 여러개의 값을 계산해 하나의 값으로 출력 
select sum(sal) from emp;

select avg(sal) from emp;               
                 
select count(*), count(comm)  -- count(*) : 테이블에 존재하는 전체 컬럼의 갯수
    from emp;                 -- count(컬럼): 컬럼을 변수로 넣을 시 그 컬럼에서 실제 데이터가 있는 행의 갯수를 구해준다  
                              --             (데이터 값이 null인 행을 제외)  
 
select max(sal),min(sal) from emp; -- 여러 함수를 동시에 실행할 수 있다         
                 
select ename,max(sal) from emp; -- 오류남: 일반 컬럼과 단일화 함수를 같이 쓸 수 없음.
                                --[데이터(값)의 갯수가 하나 밖에 없어서 데이터의 갯수 매칭이 안 되기 때문]
select min(hiredate), max(hiredate) from emp where deptno =20;                                               
    -- sum, avg, max, min, count
    -- 일반 컬럼과 같이 쓸 수 없다.
    -- 크기 비교가 가능, 모든 타입에 사용 가능
                 
================================================================================================================
--==실행순서!!!==

-- select 컬럼명
-- from 테이블명
-- where 조건식(그룹함수 사용 불가!)(group by, having 보다 먼저 실행)
-- group by 기준 컬럼명
-- having 조건식(그룹함수를 사용한다!)  = group by와 짝궁 (group by에 의해서 조회된 결과에 조건을 준다)
-- order by 컬럼명 정렬방식 => 맨 마지막에 작성

select avg(sal) from emp where deptno = 10     
union
select avg(sal) from emp where deptno = 20                      
union  -- 갯수와 타입만 일치하면 여러개 합집합 가능
select avg(sal) from emp where deptno = 30;      

select avg(sal) from emp group by deptno; -- 값이 3개
select deptno from emp group by deptno;  -- 값이 3개
select deptno,avg(sal) from emp group by deptno; -- 컬럼의 레코드(데이터) 갯수가 같으면
                                                 -- group by 뒤의 일반 컬럼은 단일화 함수와 같이 쓸 수 있다.
select deptno,avg(sal) 
from emp 
group by deptno
order by deptno;
                                                   
select deptno,job,avg(sal) 
from emp 
group by deptno,job    -- deptno로 선 그룹 후 그 각각의 그룹 안에서 job으로 한번 더 그룹
order by deptno, job desc;  -- deptno로 선 정렬 후 그 각각의 정렬 안에서 job으로 한번 더 정렬                                  
                                                 
select deptno,avg(sal) 
from emp 
group by deptno
having avg(sal) >= 2000; -- group by에 의해서 조회된 결과에 조건을 준다.                                   
                         -- 조건식을 작성할 때 그룹함수를 사용한다.                        
                                                 
select deptno,avg(sal) 
from emp 
where deptno != 10
group by deptno
having avg(sal) >= 2000;

================================================================================================================

-- 조인(Join)
-- 2개 이상의 테이블에서 데이터를 조회
-- from절에 두개 이상의 테이블을 작성한다. 
-- where에 조인 조건을 작성한다.
-- cross join (where 절 없이 조인)
-- equi join (where 등가연산자: =)
-- non equi join (where 범위연산자: and , or )
-- self join (where 하나의 테이블을 사용한다)
-- outer join (where에 누락되는 데이터를 같이 조회하기 위해: (+))

select ename, job, emp.deptno, dept.dname, loc -- 양쪽 테이블에 같은 이름의 컬럼이 존재 시 앞에 (테이블명.)을 붙여 구분해 줌
from emp,dept
where emp.deptno = dept.deptno; -- 조인 조건구문(등가조인)

select ename, job, e.deptno, d.dname, loc
from emp e,dept d  -- 테이블에 별칭 부여(별칭을 부여하면 원래 테이블 이름을 사용할 수 없다 - 오류발생) , (as는 컬럼에 별칭 부여 혼동 no)
where e.deptno = d.deptno
and sal >= 3000;

select ename, sal, grade, losal, hisal
from emp e, salgrade s
-- where e.sal >= s.losal and e.sal <= s.hisal;
where e.sal between s.losal and s.hisal;

-- 사번, 이름, 급여, 부서번호, 부서명, 급여등급
-- └ emp 테이블 ┘  └dept 테이블┘  └ salgrade 테이블 
select empno,ename,sal,d.deptno,dname,grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno
and e.sal between s.losal and s.hisal;

select e.empno, e.ename, e.mgr, m.ename
from emp e, emp m -- 반드시 별칭 부여(1개의 테이블을 2개의 태이블로 셀프조인!!)
where e.mgr = m.empno;

--scott과 같은 부서에 근무하는 사원
-- ename  ename
-- scott  smith
-- scott  jones
-- scott  adams
-- scott  ford

select work.ename, friend.ename
from emp work, emp friend
where work.deptno = friend.deptno
and work.ename = 'SCOTT'
and friend.ename != 'SCOTT';

-- 외부조인
-- 등가 시 누락된 데이터를 같이 조회하기 위해서 사용
select e.empno, e.ename, e.mgr, m.ename
from emp e, emp m 
where e.mgr = m.empno(+); -- 데이터가 없는 쪽에 (+)를 붙인다.
-- 반대편의 데이터가 누락되어도(값 = null) 조회해준다.

select ename, sal, d.deptno
from emp e, dept d
where e.deptno(+) = d.deptno;

================================================================================================================

-- ANSI-JOIN(국제적 표준 조인 방법)
-- cross join
-- natural join
-- inner join(equi, non equi, self)
-- outer join( (+) ) // [left, right, full]out join

select ename,sal,dname,loc
from emp e inner join dept d
on e.deptno = d.deptno;

select ename,sal,dname,loc
from emp e inner join dept d
using(deptno); -- 양쪽 테이블의 컬럼명이 동일한 경우(단, using 쓸려면 select절에도 해당 칼럼이름앞에 e나d를 붙히면 오류난다.)

select ename,sal,dname,loc
from emp e inner join dept d
using(deptno)
where ename = 'SCOTT'; -- 일반 조건은 where를 사용하여 추가

select e.empno, e.ename, e.mgr, m.ename
from emp e inner join emp m
on e.mgr = m.empno; --self join

select empno,ename,sal,grade
from emp e inner join salgrade s
on e.sal between s.losal and s.hisal;

select e.empno, e.ename, e.mgr, m.ename -- 해당 쪽의 데이터 + 교집합데이터
from emp e left outer join emp m  
on e.mgr = m.empno;          

/*outer join
기준 데이터에 중복이나 null이 있는 것은 레코드 갯수에 무관
조인 데이터에 중복이 있을 시 레코드 뻥튀기
조인 데이터에 null이 있거나 고유번호일 때 레코드값 동일*/ -- 참고만...내가 정의한 거 확실하지는 않음

select empno, ename, sal,d.deptno, dname, grade
from emp e inner join dept d
on e.deptno = d.deptno
inner join salgrade s
on e.sal between s.losal and hisal;


--select ename, sal, d.deptno
--from emp e, dept d
--where e.deptno(+) = d.deptno;  // 이것을 안시조인 방법으로 시행해보기

--(1)
select ename, sal, deptno
from emp e left outer join dept d
using(deptno);
--(2)
select ename, sal, d.deptno
from emp e right outer join dept d
on e.deptno = d.deptno;   -- 데이터가 있는 쪽을 지정한다.

--p.239
--Q1
select d.deptno, dname, empno, ename, sal
from emp e inner join dept d
--using(deptno) -- 별칭 사용 시 사용 불가 (e. d. s. 등등)
on e.deptno = d.deptno
where e.sal > 2000
order by deptno;

--Q2
select d.deptno, 
               dname, 
                    trunc(avg(sal)) as AVG_SAL,
                              max(sal) as Max_SAL, 
                                  min(sal) as MIN_SAL,
                                     count(*) as CNT
from emp e inner join dept d
on e.deptno = d.deptno
--using(deptno) -- 왠만하면 사용하지 말것 (다른 DBMS에서 인식 못할수 있음)
group by d.deptno, d.dname; -- d를 붙여 어느쪽 테이블로 그룹할 건지 지정해야됨.

--Q3 
select d.deptno, dname, ename, job, sal
from emp e right outer join dept d
on e.deptno = d.deptno
order by deptno, ename;

--Q4
select d.deptno, d.dname, e.empno, e.ename, e.mgr, e.sal, e.deptno as deptno_1, s.losal, s.hisal, s.grade, m.empno as MGR_EMPNO, m.ename as MGR_ENAME
from emp e right outer join dept d
on e.deptno = d.deptno
  full outer join salgrade s
on e.sal between s.losal and s.hisal
   left outer join emp m 
on e.mgr = m.empno
   order by deptno,empno;

================================================================================================================

-- 서브쿼리
-- select 구문을 중첩해서 사용하는 것(where)

select ename, max(sal)
form emp;

select deptno
from emp
where ename = 'SCOTT';   --  20
--    +   두개의 조건을 합치는 것
select dname
from dept
where deptno = 20;

select dname --메인쿼리문                         
from dept                             
where deptno = (                            
                select deptno         
                from emp                      
                where ename = 'SCOTT'           
               ); -- 서브쿼리문  (서브쿼리가 먼저 실행됨)         

select deptno,max(sal)
from emp
where ename = max(sal); -- where절에서는 집계함수(MAX,COUNT 등)를 못 쓴다

select deptno,sal
from emp
where sal = (
               select max(sal)
               from emp
               );   -- 서브쿼리를 이용해서 max() 적용


-- DALLAS 에서 근무하는 사원들의
-- 이름,부서번호 알아내기
select ename , deptno
from emp
where deptno = (
           select deptno
           from dept
           where loc = 'DALLAS'); -- 단일행 서브쿼리문(결과가 하나인 서브쿼리)

-- 자신의 직속상관이 KING인 사원의 이름과 급여를 조회하세요(서브쿼리)
select ename,sal
from emp
where mgr =(
select empno
from emp
where ename ='KING');

--다중행 서브쿼리 : 결과 값이 하나 이상의 행을 가지는 서브쿼리
-- in : 조건에 일치하는 것만 출력 (=)
-- any : 조건에 하나라도 만족하면 출력 (or)
-- all : 모든 조건이 만족해야 출력    (and)
-- exists : 결과가 존재하면 전체 출력 


--in (서브 쿼리 결과 중 같은 값이 포함되어 있으면 조회)
--not in (서브 쿼리 결과 중 같은 값이 포함되어 있지 않으면 조회)
select * 
from emp
where sal in ( -- 5000, 3000, 2850인 모든 사람
            select max(sal)
            from emp 
            group by deptno -- 결과 = 5000,3000,2850
            );
 --any(some) (조건식이 하나라도 만족하면 조회)
select * 
from emp
where sal > any ( -- >5000 or >3000 or >2850 => 5000보다 크거나, 3000보다 크거나, 2850보다 큰 값
             select max(sal)
             from emp 
             group by deptno -- 결과 = 5000,3000,2850
             );
 --all (조건식이 모두 만족하면 조회)
SELECT ename,sal
FROM emp
where sal > all( --  > 결과값 모두 만족  =>  > 2850(제일큰수) => 2850보다 큰 값
           select sal
           from emp
           where deptno = 30); -- 결과 = 1600,1250,1250,2850,1500,950
 
 
 select sal
           from emp
           where deptno = 30;
             
select * 
from emp
where (deptno,sal) in (
             select deptno,max(sal)
             from emp 
             group by deptno 
             );
             
================================================================================================================
             
-- DML(데이터 조작어) : insert, update, delete 

-- insert : 테이블에 데이터 삽입
-- insert into 테이블명 (컬럼명1,컬럼명2,...)
-- values(값1, 값2,...)
-- 컬럼과 값의 타입과 갯수가 일치해야한다.
-- 작성 순서대로 1:1 매칭된다.

create table dept_temp 
as
select * from dept; 
 
select * from dept_temp; -- 해당 컬럼(dept) 형식을 복사하여 테이블(dept_temp) 만들기!!
 
--데이터 삽입 유형
insert into dept_temp (deptno,dname,loc) 
values(50,'DATABASE','SEOUL');
 
insert into dept_temp(deptno,loc)-- 누락 컬럼 부분의 데이터는 자동으로 null데이터가 삽입된다.(암시적 null 삽입)
values(60,'JJJ'); 

insert into dept_temp --(deptno,dname,loc) 컬럼생략 -> 컬럼 생략 가능(모든 컬럼의 데이터를 삽입한다는 뜻)
values(70,'HTML','SEOUL');
 
insert into dept_temp 
values(80,NULL,'SEOUL'); -- 컬럼 생략 시에는 데이터가 누락된 부분은 NULL을 써줘야됨 (명시적 null 삽입)


create table emp_temp
as
select * from emp
where 1 != 1; -- 기존 테이블의 컬럼을 가져오지만 새로 만들려는 테이블의 행은 만들지 않는 방법(컬럼 구조만 가져오고 데이터가 비워진 상태)  -- != or <>

select * from emp_temp;

insert into emp_temp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
values (9999,'홍길동','PRESIDENT',NULL,'2001/01/01',5000,1000,10);
 
insert into emp_temp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
values (3111,'심청이','MANAGER',9999,sysdate,4000,null,10);


-- update : 컬럼의 데이터를 변경(수정)
-- update 테이블명
-- set 컬럼명 = 값, 컬럼명 = 값, ....
-- where 조건식
-- 조건절을 사용하지 않으면 해당 컬럼이 모두 변경된다.

create table dept_temp2
as
select * from dept;

select * from dept_temp2;

update dept_temp2
set loc = 'SEOUL' -- loc 컬럼의 모든 데이터가 'SEOUL' 바뀐다!! (실수 주의!)

drop table dept_temp2; -- 테이블 지우기(영구삭제는 X) 형식!!!

update dept_temp2
set dname = 'DATABASE', loc = 'SEOUL'
where deptno = 40; -- 부서번호 40인 행의 데이터만 수정하겠다는 뜻(조건절을 삽입하여 모든 데이터 수정 방지) 

-- delete(데이터 삭제)
-- delete from 테이블명
-- where 조건식
-- 조건절을 사용하지 않으면 모든 데이터가 삭제된다. 

drop table emp_temp2;

create table emp_temp2
as
select * from emp;

select * from emp_temp2;

delete from  emp_temp2;

delete from  emp_temp2 --(데이터 삭제)
where ename = 'SCOTT';

================================================================================================================

-- TCL (데이터의 영구저장 또는 취소)
-- 트랜잭션
-- commit, rollback, savepoint
-- commit: 데이터 영구 저장(테이블이 데이터 반영)
--         create구문을 사용해서 객체생성할때(자동)
-- rollback: 데이터 변경 취소(테이블이 데이터 미 반영) 원상복귀
--           천재지변,전기,전쟁(자동)
             
drop table dept01;

create table dept01
as
select * from dept;

select * from dept01;

delete from dept01; -- 데이터를 지움(영구적 삭제는 아님, rollback으로 복구 가능)

-- commit; -- 데이터를 영구저장(영구삭제됨)
rollback; -- commit 전에 rollback을 해야 복구 됨 (commit 후엔 복구 불가)


--트랜잭션 적용 가능 유무 차이
delete from dept01; -- 삭제 (영구삭제는 아님)
--  └rollback이 가능
truncate table dept01; -- delete + commit (영구삭제)
--  └rollback이 불가능

================================================================================================================

-- DDL(데이터 정의어): table(모든 객체)를 생성, 삭제, 변경하는 명령어
-- create(생성), alter(변경), drop(삭제)

-- (1)create(생성)

create table 테이블명(  -- table(객체)
    컬럼명1 타입,       -- column(속성)
    컬럼명2 타입,
    컬럼명3 타입
  );

create table emp_ddl( -- 직접적인 테이블의 생성
   --사번,이름,직책,관리자,입사일,급여,성과금,부서번호
    empno number(4), -- ()안의 숫자는 들어갈 데이터 숫자의 자리수
    ename varchar2(10), -- 크기= byte
    job varchar2(9),
    mgr number(4),
    hiredate date,
    sal number(7,2), -- 뒤에 숫자는 소수점자리를 나타냄
    comm number(7,2),
    deptno number(2)  -- 마지막 컬럼 뒤에는 , 붙이지 말기!
);
select * from emp_ddl;

insert into emp_ddl
values (9999,'이순신','MANAGER',1111,sysdate,1000,NULL,10);

create table dept_ddl -- 테이블의 복사
as
select * from dept;

create table dept_30
as
select * from dept
where deptno = 30;

create table dept_m
as
select dname,loc from dep;

create table dept_d
as
select * from dept
where 1 != 1;   --테이블의 구조만 복사한다.
------------------------------------------------------------------------------------
-- (2)alter(변경)

-- 테이블 변경(컬럼의 정보수정)
-- 새로운 컬럼 추가, 컬럼의 이름변경, 자료형의 변경,컬럼을 삭제

create table emp_alter
as
select * from emp;

select * from emp_alter;

alter table emp_alter
add address varchar2(100); -- 컬럼 추가

alter table emp_alter
rename column address to addr; -- 컬럼이름 변경
--rename emp_alter to emp_alter2; -- 테이블 이름 변경

alter table emp_alter
modify empno number(10); -- 기존 number(4) ->  number(10) 변경 (데이터 크기를 늘기기만 가능: 기존에 데이터가 있기 때문)
desc emp_alter;

alter table emp_alter
drop column addr;  -- 컬럼 삭제
------------------------------------------------------------------------------------
-- (3)drop(삭제)

drop table emp_alter; -- 테이블 삭제

select * from emp_alter;

================================================================================================================

--p.324
--Q1
create table emp_hw(
empno number(4),
ename varchar2(10),
job varchar2(9),
mgr number(4),
hiredate date,
sal number(7,2),
comm number(7,2),
dptno number(2)
);
SELECT * FROM emp_hw;

--Q2
alter table emp_hw
add bigo varchar2(20);   
SELECT * FROM emp_hw;

--Q3
alter table emp_hw
modify bigo varchar2(30);
desc emp_hw;

--Q4
alter table emp_hw
rename column bigo to remark;

--Q5
insert into emp_hw
--values emp;
select empno,ename,job,mgr,hiredate,sal,comm,deptno,NULL -- 겹치는 컬럼은 다 써주고 안 겹치는 건 NULL 적기
from emp;
SELECT * FROM emp_hw;

--Q6
drop table emp_hw;

================================================================================================================

--데이터 사전
desc user_tables;

select table_name
from user_tables;

select owner,table_name   -- 남이 위임한 테이블도 확인가능
from all_tables; 


-- index (검색속도를 향상하기 위해 사용하는 객체)
-- create , drop
-- select 구문의 검색속도를 향상 시킨다
-- 전체 레코드의 3%~5% 정도일때
-- index 객체를 컬럼에 생성해서 사용한다.

create index 인덱스명
on 테이블명(컬럼명);

create table emp01
as
select * from emp;

drop table emp01

select * from emp01;

insert into emp01
select * from emp01;

insert into emp01(empno,ename)
values (1111,'bts');

select empno,ename
from emp01
where ename = 'bts';
-- index 객체 생성 전 (0.036초)

create index idx_emp01_ename
on emp01(ename);

select empno,ename
from emp01
where ename = 'bts';
-- index 객체 생성 후 (0.005초)

drop index idx_emp01_ename;

================================================================================================================

-- 테이블 삭제 후 원복 [참고 - 왼쪽에 휴지통 메뉴 있음]
show recyclebin; --(휴지통에 버려진 테이블 정보가 나옴)

flashback table emp_alter --(휴지통에 버려진 테이블을 다시 살리는 명령어)
to before drop;   

purge recyclebin; -- (휴지통 비우기 명령어)

================================================================================================================

-- 제약조건(무결성) : 잘못된 데이터로 사용되는 것을 못하게 하는 것  (테이블의 컬럼절에 삽입)

-- not null : null 데이터를 삽입할 수 없게 한다 
-- unique : 같은 컬럼에 같은 데이터를 받을 수 없게 한다. but. null은 중복 허용 (ex-사번, 주민번호)
-- primary key(기본키) : = (not null + unique)
-- foreign key (외래키 / 참조키) : 두 테이블을 함께 쓸 때 연결하는 키(부모 테이블을 참조)
--      1.부모와 자식의 관계를 가지는 자식쪽 테이블의 컬럼에 설정한다.
--      2.부모쪽 테이블의 컬럼은 반드시 primary key 또는 unique해야 한다.
--      3.외래키 값은 NULL이거나 부모 테이블의 기본키 값과 동일해야한다.(부모컬럼에 있는 내용만 자식컬럼에 들어올 수 있다. BUT null은 허용)  
-- check : 컬럼 값에 제한범위를 부여
-- default : 기본값 부여


-- not null, unique, primary key
insert into emp
values (1111,'aaa','MANAGER',9999,sysdate,1000,NULL,50);
--무결성 제약조건(SCOTT.FK_DEPTNO)이 위배되었습니다- 부모 키가 없습니다

drop table emp02; -- 해당 테이블 삭제

delete from emp02; -- 해당 테이블의 데이터 삭제

create table emp02(-- ┌제약조건명 설정하는 방법[ constraint (제약조건명) (제약조건)]
   empno number(4) constraint emp04_empno_pk primary key, -- not null unique, -- 띄어쓰기로 구분하여 두개 이상의 제약조건도 허용함
   ename varchar2(10) constraint emp04_ename_nn not null,
   job varchar2(9),
   deptno number(2)
);
SELECT * FROM emp02;

insert into emp02
values (1111,'홍길동','MANAGER',30);

insert into emp02
values (2222,'홍길동','MANAGER',30); --사번이 다른 홍길동 동명인일 경우 

insert into emp02
values (2222,'옥동자','SALESMAN',10);

insert into emp02
values (null,'김유신','SALESMAN',20);

insert into emp02
values (null,null,'MANAGER',30);

--foreign key
create table dept07( -- 부모테이블
        deptno number(2)constraint dept07_deptno_pk primary key, --부모 테이블엔 primary key(or unique)가 존재해야됨
        dname varchar2(20)constraint dept07_dname_nn not null,
        loc varchar2(20)constraint dept07_loc_nn not null
);  -- 부모 테이블 먼저 생성
SELECT * FROM dept07;

create table emp07( -- 자식테이블 foreign key한 제약조건
   empno number(4) constraint emp07_ename_pk primary key,
   ename varchar2(9)constraint emp07_ename_nn not null,
   job varchar2(9),                        -- ┌ 컬럼 레벨에서는 foreign key 문구 생략가능(references만 쓴다)
   deptno number(2) constraint emp07_ename_fk references dept07(deptno)--참조할 부모 테이블
); -- 자식 테이블(references)에 foreign key가 존재
SELECT * FROM emp07;

-- 서브쿼리문을 사용한 데이터 삽입
insert into dept07
select * from dept; -- 부모 테이블 먼저 삽입

insert into emp07
select empno,ename,job,deptno from emp;

insert into emp07
values (1111,'aaa','MANAGER',9999,sysdate,1000,null,50);

-- check
create table emp08( 
   empno number(4) constraint emp08_ename_pk primary key,
   ename varchar2(10)constraint emp08_ename_nn not null,
   sal number(7)constraint emp08_sal_ck check(sal between 500 and 5000),
   gender varchar2(2)constraint emp08_gender_ck check(gender in ('M' , 'F'))
); 
SELECT * FROM emp08;

insert into emp08
values (1111,'hong',1000,'M');

insert into emp08
values (2222,'hong',200,'M');

insert into emp08
values (3333,'hong',1000,'A');

-- default
create table dept08( 
   deptno number(2) primary key,
   dname varchar2(10) not null,
   loc varchar2(15) default 'SEOUL'
); 
SELECT * FROM dept08;

insert into dept08(deptno,dname)
values (10,'SALES');

insert into dept08(deptno,dname,loc) -- default 'SEOUL'이라는 기본값을 부여했더라도 
values (20,'SALES','BUSAN');         -- 다른 값 삽입 시 삽입한 값으로 전환된다.

-- 제약조건 설정방식
 -- 컬럼 레벨의 설정(not null은 컬럼 레벨에서만 가능)
 -- 테이블 레벨의 설정(not null을 적용할 수 없다) : 테이블을 정의한 후 나중에 제약조건을 정의
 
 create table emp09(
    empno number(4),
    ename varchar2(20)constraint emp09_ename_nn not null,
    job varchar2(20),
    deptno number(20), -- 마지막 컬럼 뒤에도 (,)를 찍어야됨
    
    constraint emp09_empno_pk primary key(empno),
    constraint emp09_job_uk unique(job),
    constraint emp09_deptno_fk foreign key(deptno) references dept(deptno)
  --└ CONSTRAINT [CONSTRAINT_NAME] FOREIGN KEY (자식 테이블 컬럼 명) REFERENCES 참조테이블(부모 테이블 기본키명)
 ); 
SELECT * FROM emp09;

insert into emp09
values (3333,'hong','PRESIDENT',80);

-- 복합키 (기본키를 두개의 컬럼에 사용하는 경우)
-- 테이블 레벨 방식으로만 적용 가능
--   1.테이블 안에서 정의하는 방식
--   2.Alter 명령어를 사용하는 방식

-- (1)
create table member(
   name varchar2(10),
   address varchar2(30),
   hphone varchar2(10),
   
   constraint member_name_address_pk primary key(name,address)
);
-- (2)   
create table emp10(
    empno number(4),
    ename varchar2(20),
    job varchar2(20),
    deptno number(20)
);

alter table emp10
add constraint emp10_empno_pk primary key(empno);

alter table emp10
add constraint emp10_empno_fk foreign key(deptno)references dept(deptno);
  
-- not null은 변경의 개념( null -> not null), (add x , modify o)
alter table emp10
modify job constraint emp10_job_nn not null;  
    -- └ not null은 예외적으로 컬럼명을 앞에 둔다
    
alter table emp10
modify empno constraint emp10_empno_nn not null;      
    
-- drop 제약조건명(constraint) 또는 제약조건(primary key)
--        └중복 안됨                └중복 됨
alter table emp10    
drop constraint emp10_empno_pk;

drop table dept11;
create table dept11( 
   deptno number(2),
   dname varchar2(10),
   loc varchar2(15)
);
SELECT * FROM dept11;

alter table dept11    
add constraint dept11_deptno_pk primary key(deptno);

drop table emp11;
create table emp11(
    empno number(4),
    ename varchar2(20),
    job varchar2(20),
    deptno number(20)
);
SELECT * FROM emp11;

alter table emp11    
add constraint emp11_empno_pk primary key(empno);

alter table emp11
add constraint emp11_empno_fk foreign key(deptno)references dept11(deptno);

insert into dept11
select * from dept;

insert into emp11
select empno,ename,job,deptno
from emp;

delete from dept11
where deptno = 10;  -- foreign key로 참조되고 있는 자식 테이블이 있을 경우
                    -- 부모 테이블의 데이터를 지울 수 없다.
alter table dept11
disable primary key cascade;    -- primary key 비활성화 = 연결된 자식테이블(foreign key)도 비활성화 
--└ 비활성화          └층진구조  -- 제약조건이 비활성화되었으므로 데이터 삭제가 가능해짐. 

alter table dept11
drop primary key; -- 위의 절차 후 데이터를 지울 수는 있지만 참조되어있는 제약조건을 제거 할 수 없음(비활성화만 시킨 상태임)

alter table dept11
drop primary key cascade;  -- 참조로 연결된 제약조건들을(dept11 - primary key , emp11 - foreign key) 모두 지워서 제약조건을 지움

--p.395
--Q1
drop table DEPT_CONST;
create table DEPT_CONST(
      deptno number(2),
      dname varchar2(14),
      loc varchar2(13) constraint DEPTCONST_loc_nn not null,
      
     constraint DEPTCONST_deptno_pk primary key(deptno),
     constraint DEPTCONST_dname_unq unique(loc)
); 

drop table EMP_CONST;
create table EMP_CONST(
      empno number(4),
      ename varchar2(10),
      job varchar2(9),
      tel varchar2(20),
      hiredate date,
      sal number(7,2),
      comm number(7,2),
      deptno number(2)     
); 

alter table EMP_CONST
add constraint EMPCONST_empno_pk primary key(empno);

alter table EMP_CONST
modify ename constraint EMPCONST_ename_nn not null;

alter table EMP_CONST
add constraint EMPCONST_tel_unq unique(tel);

alter table EMP_CONST
add constraint EMPCONST_sal_ck check(sal between 1000 and 9999);

alter table EMP_CONST
add constraint EMPCONST_deptno_fk foreign key(deptno)references DEPT_CONST(deptno);

================================================================================================================

--CRUD (목적:데이터의 변경)
-- C (create) = insert, DML
-- R (read) = select,  DQL
-- U (update), DML
-- D (delete), DML

-- 객체: table, index, view = create 명령어를 사용하여 만들어서 사용

--뷰(view) : 보기 위한 목적(컬럽을 선택하여 보기 위해)
 --1.보안
 --2.범위(변경불가)

-- create or replace view 뷰테이블명(alias)
-- as
-- 서브쿼리(select) ┌ 단순뷰(테이블1개)
--                 └ 복합뷰(ex-조인,...)
-- [with check option] (필수x)
-- [with read only]    (필수x)

drop table detp_copy;
create table detp_copy
as
select * from dept;

drop table emp_copy;
create table emp_copy -- 복사되어 생성된 테이블은 제약조건은 안 넘어온다.
as
select * from emp;

create or replace view emp_view30
as
select empno, ename, sal, deptno from emp_copy
where deptno = 30;

grant create view -- [view 테이블을 생성할 수 있는 권한부여(system 계정에서 실행)]
to scott;

select * from emp_copy; -- 14
select * from emp_view30; -- 6

insert into emp_view30  -- 뷰테이블에 삽입을 하지만 실제 원본테이블에 삽입됨(나머지 컬럼엔 값이 null로 삽입됨)
values(1111,'hong',1000,30); 

alter table emp_copy -- 원본테이블을 foreign key로 제약 걸어준다
add constraint emp_copy_deptno_fk foreign key(deptno) references dept(deptno);

insert into emp_view30( empno, ename, sal) -- foreign key로 제약되는 중 
values(2222,'hong',2000);  -- deptno의 값 = null, 따라서 삽입 가능!
 
insert into emp_view30( empno, ename, sal, deptno) -- foreign key로 제약되는 중 (deptno = 10,20,30 and null)
values(2222,'hong',2000,50); -- deptno의 값 = 50, 값이 원본 테이블의 범위가 아니기 때문에 제약에 의해 오류가 발생!

 create or replace view emp_view(사원번호, 사원명, 급여, 부서번호) -- 뷰 테이블에서 컬럼에 별칭부여(alias)
 as
 select empno,ename,sal,deptno
 from emp_copy;
 
select * from emp_view
where 부서번호 = 20;
--where deptno = 20; -> error 별칭 부여하면 원래의 컬럼명을 사용할 수 없다.


create or replace view emp_dept_view
as
select empno,ename,sal,e.deptno,dname,loc
from emp e inner join dept d
on e.deptno = d.deptno
order by empno desc;

select * from emp_dept_view;

--Q 부서별 최소급여와 최대급여
-- dname,min_sal,max_sal
create or replace view sal_view --(dname,min_sal,max_sal) 별칭 as를 써도됨
as
select dname,min(sal)as min_sal,max(sal) as max_sal
from emp e inner join dept d
on e.deptno = d.deptno
group by d.dname;
 
select * from sal_view;

drop view sal_view;

-- 모든 객체의 이름은 중복될 수 없다.
-- but(or replace)가 있으면 같은 이름으로 덮어쓸 수 있다.(정보 추가 가능)
-- (or replace)는 생략도 가능하다.그러나 생략 시 덮어쓰기 불가
create or replace view sal_view 
as
select dname,min(sal)as min_sal,max(sal) as max_sal,avg(sal) as avg_sal -- avg(sal) as avg_sal를 추가
from emp e inner join dept d
on e.deptno = d.deptno
group by d.dname;


-- /with check option/
drop view view_chk30;
create or replace view view_chk30
as
select empno,ename,sal,comm,deptno
from emp_copy
where deptno = 30 with check option; -- 조건절의 컬럼을 수정하지 못하게 한다.(with check option)

update view_chk30 -- 뷰도 업데이트 가능
set deptno = 10;  -- but, with check option에 의해 업데이트 불가
--// 뷰의 WITH CHECK OPTION의 조건에 위배 됩니다. //

-- /with read only/
drop view view_read30;
create or replace view view_read30
as
select empno,ename,sal,comm,deptno
from emp_copy
where deptno = 30 with read only; -- 모든 컬럼에 대한 C U D가 불가 
                                  -- R(read, 조회)만 가능
update view_read30
set deptno = 10;
--//읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.//(insert,update,delete)

================================================================================================================

-- 뷰의 활용
-- TOP - N 조회하기
-- ROWNUM(의사 컬럼): 직접 정의하지 않았지만 사용가능한 컬럼(가짜컬럼)
select * from emp; 

-- 입사일이 가장 빠른 5명의 사원 조회
select * from emp
order by hiredate asc;

select * from emp
where hiredate <= '81/05/01';

-- 입사일이 가장 빠른 7명의 사원 조회
select rownum, empno,ename,hiredate
from emp
where rownum <= 7;  -- rownum으로 정렬(입사일로 정렬되어있지는 않음)

select rownum, empno,ename,hiredate
from emp
where rownum <= 7
order by hiredate asc; -- 날짜대로 정렬되지만 rownum 순서가 변경 됨.

--(view & rownum활용)
create or replace view view_hiredate
as
select empno,ename,hiredate
from emp
order by hiredate asc; -- 입사일로 정렬 된 view를 먼저 생성

select * from view_hiredate;

select rownum,empno,ename,hiredate
from view_hiredate
where rownum <= 7; -- view에 rownum을 적용

-- 입사일이 가장 빠른 2~5번째 사원를 순서대로 조회
select rownum,empno,ename,hiredate
from view_hiredate
where rownum between 2 and 5; -- rownum을 조건절에 직접 사용 시 반드시 1을 포함하는 조건식을 만들어야된다.
                              -- rownum은 1을 포함하지 않은 범위 조회가 안됨.
--(rownum에 별칭 부여)
create or replace view view_hiredate_rm -- rownum에 별칭을 부여하고 내로운 view를 만듦
as                                      
select rownum rm,empno,ename,hiredate
from view_hiredate;

select rm,empno,ename,hiredate   -- 별칭으로는 rm(rownum)에 범위부여 가능
from view_hiredate_rm
where rm >= 2 and rm <= 5;


-- 중첩

/*  select  (select) = 일반쿼리
     from   (select) = 인라인뷰 : 일회성
    wherer  (select) = 서브쿼리          */

-- 인라인 뷰
select rm , b.* --(empno,ename,hiredate)
from (  
        select rownum rm , a.* --(empno,ename,hiredate)   
        from(
               select empno,ename,hiredate 
               from emp
               order by hiredate asc
              ) a
       ) b
where rm >= 2 and rm <= 5; --or (where rm between 2 and 5;)

--입사일이 가장 빠른 5명 조회(인라인뷰형식) 
select rownum,empno,ename,hiredate
from( 
     select empno,ename,hiredate
     from emp
     order by hiredate asc
    )
where rownum <=5;          

================================================================================================================
/*
-- 시퀀스
-- 자동으로 번호를 증가시키는 기능수행
-- create, drop 
-- nextval,currval

create sequence 시퀀스명
start with 시작값 => 1(기본값) 
increment by 증가치 => 1
maxvalue 최대값 => 10의 1027승
minvalue 최소값 => 10의 -1027승
*/ 

create sequence dept_deptno_seq -- 설정하기 않은 값들은 다 기본값으로 만들어짐
increment by 10
start with 10;

select dept_deptno_seq.nextval -- 증가값 조회
from dual;

select dept_deptno_seq.currval -- 현재값 조회
from dual;

create sequence emp_seq
start with 1
increment by 1
maxvalue 1000;

drop table emp01;
create table emp01
as
select empno,ename,hiredate from emp
where 1 != 1;

select * from emp01;

insert into emp01
values (emp_seq.nextval,'hong',sysdate);

drop table product;
create table product(
   pid varchar2(10),
   pname varchar2(10),
   price number(5)
   
   constraint product_pid_pk primary key
);

create sequence idx_product_id
start with 1000;

insert into product
values ('pid' ||IDX_PRODUCT_ID.nextval,'치즈',3000);

select * from product;

drop sequence idx_product_id;

================================================================================================================

-- 사용자 관리(객체) // (system 계정에서)  
-- create, alter, drop
-- create user 계정명 identified by 패스워드 (계정만들기)
-- alter user 계정명 identified by 패스워드 (계정 수정)
-- drop user 계정명 cascade (계정 삭제)

create user user01 identified by 1234;
--user USER01 lacks CREATE SESSION privilege; logon denied

-- DCL(제어어) - 'Data Control Language'
-- grant(권한부여), revoke(권한회수)
-- grant 시스템권한 to 계정명
-- revoke 시스템권한 from 계정명

grant CREATE SESSION -- 데이터베이스에 접근할 수 있는 권한
to user01;

grant create table -- 테이블 만들 권한부여
to user01;

revoke create table -- 테이블 만들 권한회수
from user01;

alter user user01 identified by tiger; -- 계정 패스워드 변경(1234 -> tiger)

drop user user01 CASCADE; --(CASCADE = 강제로 계정을 지울수잇게 붙인다)
----------------------------------------------------------------------

-- 시스템 권한(create ...) p.403 참고
-- 객체 권한(select,...) p.407 참고

================================================================================================================

/*
1. 계정의 테이블 스페이스 생성
create tablespace [tablespace_name]
datafile '/home/oracle/oradata/DANBEE/[file_name].dbf' size 500m;

예)CREATE TABLESPACE ADMIN DATAFILE 'D:\ORACLE\ORADATA\XE\ADMIN.dbf' SIZE? 500M ;


2. 오라클 유저 만들기
CREATE USER [user_name] 
IDENTIFIED BY [password]
DEFAULT TABLESPACE [tablespace_name]
TEMPORARY TABLESPACE TEMP;

예)CREATE USER nextree IDENTIFIED BY nextree DEFAULT TABLESPACE NEXTREE TEMPORARY TABLESPACE TEMP;


3. 생성한 USER에 권한주기
GRANT connect, resource, dba TO [user_name];

예)grant connect, dba, resource to 유저명; (모든 권한 주기)

GRANT CREATE SESSION TO 유저명  // 데이터베이스에 접근할 수 있는 권한
GRANT CREATE DATABASE LINK TO 유저명
GRANT CREATE MATERIALIZED VIEW TO 유저명
GRANT CREATE PROCEDURE TO 유저명
GRANT CREATE PUBLIC SYNONYM TO 유저명
GRANT CREATE ROLE TO 유저명
GRANT CREATE SEQUENCE TO 유저명
GRANT CREATE SYNONYM TO 유저명
GRANT CREATE TABLE TO 유저명  // 테이블을 생성할 수 있는 권한
GRANT DROP ANY TABLE TO 유저명? // 테이블을 제거할 수 있는 권한
GRANT CREATE TRIGGER TO 유저명 
GRANT CREATE TYPE TO 유저명 
GRANT CREATE VIEW TO 유저명

GRANT
CREATE SESSION,
CREATE TABLE,
CREATE SEQUENCE,
CREATE VIEW
TO 유저명;


4. 생성한 USER로 ORACLE에 접속하기
sqlplus nextree/nextree[@db_sid]


5. 계정 삭제하기
drop user 사용자계정 cascade;
-------------------------------------------------------------------------------

-- 테이블 스페이스 크기 확장해주는 쿼리문
alter database 
datafile 'D:\oracle\oradata\XE\ADMIN.DBF'? resize 900M;

--테이블 스페이스 정보 보는 쿼리문
SELECT file_name, tablespace_name, bytes, status FROM? DBA_DATA_FILES;

--테이블 명시적 인덱스 생성
--1번째 방법
CREATE INDEX MSID_IDX1 ON TEST(MSID)
--2번째 방법
create index test1_test on test1(test)
tablespace users
storage(
        initial 10k
        next 10k 
        pctincrease 0)
pctfree 10

--테이블 정보 보는 쿼리
select * from user_constraints-- where table_name = upper('test1');

--ORA-00054: 자원이 사용중이고, NOWAIT가 지정되어 있습니다 해결 방법
select a.sid, a.serial#
from v$session a, v$lock b, dba_objects c
where a.sid=b.sid and b.id1=c.object_id and b.type='TM' and c.object_name='CAR_INFO'; 

alter system kill session '12, 27846'; 

-- CAR_INFO에는 있는 값을 DASH_BOARD에 넣기
INSERT INTO DASH_BOARD(CAR_LICEN_NUM)
SELECT CAR_LICEN_NUM 
FROM CAR_INFOMINUS
SELECT CAR_LICEN_NUM 
FROM DASH_BOARD

SYSTEM 계정 패스워드 변경하기
사용자계정 : /as sysdba

alter user system identified by "암호";
일반 스트링은 관계없지만 특수문자가 있을경우 반드시 "" 따옴표로 감싸준다.  */
================================================================================================================

-- 롤
create user user02 identified by 1234;

grant connect,resource
to user02;

-- 사용자 정의 롤
-- 관리자(system) 계정에서만 가능
-- create role 롤명
-- grant 권한 to 롤명

-- 시스템 권한 (관리자 계정에서)
create role mrole; -- mrole이라는 롤 생성

grant create session, create table, create view -- 만든 롤에 데이터베이스에 접근,테이블 생성,뷰생성의 권한을 묶어 줌
to mrole;

create user user04 identified by 1234; -- user04 계정 생성

grant mrole
to user04; -- user04에 권한들이 묶인 롤 부여 => user04는 데이터베이스에 접근,테이블 생성,뷰생성dl 가능

-- 시스템(관리자) 권한에서 롤 생성
create role mrole2; -- mrole2이라는 롤 생성(시스템 계정에서)

-- 객체 권한은 해당 사용자 계정에서 가능
-- scott 접속
grant select
on emp
to mrole2;  -- scott의 emp 컬럼 조회 권한을 mrole2에 묶어준다.(scott 계정에서)
 
-- 롤 권한은 관리자 계정에서만 가능
grant mrole2
to user04 -- mrole2에 정의 된 권한을 user04에 부여 (시스템 계정에서)

revoke role mrole2
from user04;  -- user04에 부여 된 권한 회수(시스템 계정에서)

================================================================================================================

-- PL/SQL(확장되어진 SQL언어)
-- 변수, 조건문, 반복문
/*
set serveroutput on;  -- 실행 결과를 화면에 출력

declare
    변수 정의
begin  --변수의 초기화는 begin구문에서 해준다
    SQL구문 작성
    출력구문 작성 -- 쿼리문의 수행결과를 반드시 출력함수를 통해서 확인해야 한다.
exception
    예외처리 구문 작성
end;
/  -- (/) 빼먹지 말기!! , (;)아래쪽에 넣기
*/
-----------------------------------------------------
set serveroutput on; 

begin
    dbms_output.put_line('Hello World'); -- 출력함수
end;
/
-----------------------------------------------------
declare
    -- vempno number(4);  -- 변수의 선언
    -- vename varchar2(10);
    
    -- 선언과 초기화 한번에
    vempno constant number(4) := 7777; -- 상수의 정의(constant)
    vename varchar2(10) not null := 'SCOTT';  -- null 값을 변수로 사용할 수 없다. 
begin 
   -- vempno := 7777;   -- 변수의 초기화 (:= 대입연산자)
   -- vempno := 'SCOTT'; 
   
   dbms_output.put_line(' 사원 / 이름 ');
   dbms_output.put_line(vempno||' '||vename);
   
end;
/
-----------------------------------------------------
declare
    -- 스칼라 방식
    -- vempno number(4);
    
    -- 레퍼런스 방식
       vempno emp.empno%type := 7777; -- 기존 테이블의 컬럼 타입을 참조한다.
begin  
    --vempno := 7777;
    dbms_output.put_line(vempno);
end;
/  
-----------------------------------------------------
declare
    -- 레퍼런스 방식
       vempno emp.empno%type;
       vename emp.ename%type;
begin  
    select empno, ename into vempno,vename -- 변수에 하나 값만 대입하기 위해서 반드시 where절을 적어줘야 됨!
    from emp                               --(변수는 하나의 값만 받을 수 있음 그러나 레퍼런스 방식의 경우 대입
    where empno =7788;  -- 필수             -- 컬럼의 모든 데이터를 불러오기 때문에 조건절을 부여해서 제한해줌)
    
    dbms_output.put_line('사번 / 이름');       
    dbms_output.put_line(vempno||' '||vename);
end;
/  
------------------------- 예외처리 하기↓ -------------------------------
declare
    -- 레퍼런스 방식
       vempno emp.empno%type;
       vename emp.ename%type;
begin  
    select empno, ename into vempno,vename 
    from emp;                               
    -- where empno =7788; --필수           
    
    -- dbms_output.put_line('사번 / 이름');       
    -- dbms_output.put_line(vempno||' '||vename);
exception
    when Too_MANY_ROWS then dbms_output.put_line('행의 수가 여러개 입니다.');
    when OTHERS then dbms_output.put_line('모든 예외에 대한 처리.');
end;
/   
-----------------------------------------------------
declare
   -- 테이블 type(사용자 정의 변수의 타입)
   -- 배열의 형식
   -- vempno varchar2(10)
   
   type ename_table_type is table of emp.ename%type
   index by binary_integer;
   
   type job_table_type is table of emp.job%type
   index by binary_integer;
   
   type empno_table_type is table of emp.empno%type
   index by binary_integer;
   
   type mgr_table_type is table of emp. mgr%type
   index by binary_integer;
   
   type hiredate_table_type is table of emp.hiredate%type
   index by binary_integer;
   
   type sal_table_type is table of emp.sal%type
   index by binary_integer;
   
   type comm_table_type is table of emp.comm%type
   index by binary_integer;
   
   type deptno_table_type is table of emp.deptno%type
   index by binary_integer;
    
   enameArr ename_table_type; -- 배열 형식의 변수 선언
   jobArr job_table_type;
   empnoArr empno_table_type;
   mgrArr mgr_table_type;
   hiredateArr hiredate_table_type;
   salArr sal_table_type;
   commArr comm_table_type;
   deptnoArr deptno_table_type;
   
   i binary_integer := 0;
begin  
   for k in (select ename, job, empno, mgr, hiredate, sal, comm, deptno from emp) loop
   i := i+1;
   enameArr(i) := k.ename;
   jobArr(i) := k.job;
   empnoArr(i) := k.empno;
   mgrArr(i) := k.mgr;
   hiredateArr(i) := k.hiredate;
   salArr(i) := k.sal;
   commArr(i) := k.comm;
   deptnoArr(i) := k.deptno;
   end loop;
  
   for j in 1..i loop
     dbms_output.put_line(enameArr(j)||' / '||jobArr(j)||' / '
     ||empnoArr(i)||' / '||mgrArr(i)||' / '||hiredateArr(i)
     ||' / '||salArr(i)||' / '||commArr(i)||' / '||deptnoArr(i));       
   end loop;
end;
/   
-----------------------------------------------------
declare
   -- 레코드 type(여러개의 변수를 묶어서 사용한다) => 사용자 정의 변수 타입
   -- 클래스랑 유사하다.
   
   type emp_record_type is record(  -- 타입
        v_empno emp.empno%type,
        v_ename emp.ename%type,
        v_job emp.job%type,
        v_deptno emp.deptno%type
   );
--  ┌emp_record가 변수명
   emp_record emp_record_type; -- 레코드 타입의 변수 선언;
begin  
   select empno,ename,job,deptno
   into emp_record
   from emp
   where empno = 7788;
   
   dbms_output.put_line(emp_record.v_empno||' / '||emp_record.v_ename
                 ||' / '||emp_record.v_job||' / '||emp_record.v_deptno);
end;
/   
-----------------------------------------------------
create table dept_record
as
select * from dept;

select * from dept_record;

declare -- insert
    type rec_dept is record(  
        v_deptno dept_record.deptno%type,
        v_dname dept_record.dname%type,
        v_loc dept_record.loc%type
   );

   dept_rec rec_dept; 
begin  
  dept_rec.v_deptno := 50;
  dept_rec.v_dname := 'DEV';
  dept_rec.v_loc := 'BUSAN';
  
  insert into dept_record
  values dept_rec;
end;
/   

select * from dept_record;

declare --update
    type rec_dept is record(
        v_deptno dept_record.deptno%type not null := 99, -- null 데이터를 임의숫자로 초기화
        v_dname dept_record.dname%type,
        v_loc dept_record.loc%type
    );
    
    dept_rec rec_dept;
begin
    dept_rec.v_deptno := 50;
    dept_rec.v_dname := 'INSA';
    dept_rec.v_loc :=  'SEOUL';
    
    update dept_record 
    set dname = dept_rec.v_dname , loc = dept_rec.v_loc
    where deptno = dept_rec.v_deptno;
end;
/

declare -- 스칼라방식 삭제
    v_deptno dept_record.deptno%type := 50;
begin  
    delete from dept_record
    where deptno = v_deptno;
end;
/   
-----------------------------------------------------

--조건문

declare 
    vempno number(4);
    vename varchar2(10);
    vdeptno number(10);
    vdname varchar2(10):= null;
begin  
    select empno,ename,deptno
    into vempno,vename,vdeptno
    from emp
    where empno = 7788;
    
   /* if(조건식) then  -- ( )이 참이면 실행문 실행
            실행문  
      end if;   */
    
    if(vdeptno = 10) then  
        vdname := 'AAA';   
    end if;       

    if(vdeptno = 20) then  
        vdname := 'BBB';  
    end if;        
    
    if(vdeptno = 30) then  
        vdname := 'CCC';  
    end if;
  
    if(vdeptno = 40) then  
        vdname := 'DDD';  
    end if;    
    
    dbms_output.put_line(vdname);
end;
/   


declare
   -- %ROWTYPE : 테이블의 모든 컬럼의 이름과 타입을 참조하겠다.
   -- 컬럼명이 변수명으로 사용되고 컬럼의 타입을 변수의 타입으로 사용한다.
   
   vemp emp%rowtype;
   
begin
   select *
   into vemp
   from emp
   where empno = 7788;
   
   dbms_output.put_line(vemp.empno);
   dbms_output.put_line(vemp.ename);
   dbms_output.put_line(vemp.deptno);
end;
/


declare
   vemp emp%rowtype;
   annsal number(7,2);
   
begin  
   dbms_output.put_line(' 사번 / 이름 / 연봉 ');
   dbms_output.put_line('------------------');
   
   select*
   into vemp
   from emp
   where empno =7788;

   /*
   --해당 사원의 연봉을 출력하세요. 단 커미션이 null인 경우 0으로 계산되게 하세요.
   --계산된 연봉을 변수 annsa에 넣어서 출력하세요.
   if(vemp.comm is null) then
        vemp.comm := 0;
   end if;
   
   annsal := vemp.sal * 12 + vemp.comm;
  */
  
  -- if - else 구문으로 풀어보기 ↓
  if(vemp.comm is null) then
      annsal := vemp.sal *12;
  else
      annsal := vemp.sal *12 + vemp.comm;
  end if;
  dbms_output.put_line(vemp.empno||' / '||vemp.ename||' / '||annsal); 
  
end;
/


-- 다중 elsif문 (오라클에서는 'else if'가 아닌 'elsif'로 쓴다) 
declare
   vemp emp%rowtype;
   vdname varchar2(10);  
begin  
   select *
   into vemp
   from emp
   where empno = 7788;
   
   if(vemp.deptno = 10) then
        vdname := 'AAA';
   elsif(vemp.deptno = 20) then
        vdname := 'BBB';
   elsif(vemp.deptno = 30) then
        vdname := 'CCC'; 
   elsif(vemp.deptno = 40) then
        vdname := 'DDD';
   end if;
   
   dbms_output.put_line(vdname);
end;
/
-----------------------------------------------------

-- 반복문

/*   loop
     실행문(무한 반복문)
     무한 반복분의 제어
      1.EXIT WHEN 조건식;
      2.IF THEN END IF;
     end loop;            */

declare
  n number(10):= 1;
begin
  loop
       dbms_output.put_line(n);
       n := n+1;
       exit when n > 10; -- 반복문을 멈추기 위한 조건
  end loop;            
end;
/

-- for문을 사용
declare
  
begin                     -- n은 변수(in 뒤의 값을 받아온다)
                          -- in구문 뒤에 작성되는 값이 반복 횟수를 결정한다.
  /* for n in 1..10 loop  -- (in 시작값..종료값) 1씩 증가 => in 1~10(10회 반복)
        dbms_output.put_line(n);
     end loop; */
  
  for n in reverse 1..10 loop -- in reverse 구문 => 1씩 감소 => in 10~1(10회 반복)
     dbms_output.put_line(n); -- 종료값에서 시작값까지 1씩 감소시켜 줌
  end loop;
  
end;
/


declare
    vdept dept%rowtype;
begin  
  for n in 1..4 loop 
    select*
    into vdept
    from dept
    where deptno = 10*n;
    dbms_output.put_line(vdept.deptno||' '||vdept.dname||' '||vdept.loc);
  end loop;
end;
/

-- while문을 사용
declare
    n number := 1;
begin  
 /* while (조건식) loop
        실행문;
    end loop;       */
    
   while(n <= 10) loop
     dbms_output.put_line(n);
     n := n+1;
   end loop;  
end;
/

declare
    vdept dept%rowtype;
    n number := 1;
begin  
   while(n <= 4)loop
   select *
   into vdept
   from dept
   where deptno = 10*n;
   n := n+1;
   
   dbms_output.put_line(vdept.deptno||' '||vdept.dname||' '||vdept.loc);
   end loop;  
end;
/
-----------------------------------------------------

--최종정리

/*
select empno, ename,.... => [변수에 적용할 컬럼(타입)]   ┬ 둘의 수와 타입은 같아야 됨
into vempno, vename,...  => [변수들(이름은 재량으로 설정)]┘
from emp                 => [변수에 적용시킬 컬럼(타입)을 가져올 테이블]
  
--%ROWTYPE: 테이블의 모든 컬럼의 이름과 타입을 참조하겠다.
declare에 [vemp emp%rowtype;] - 변수를 선언

select *   => [모든 컬럼 참조]   
into vemp  => [해당 테이블의 모든 컬럼 참조를 위한 변수(이름은 재량으로 설정)]
from emp   => [변수에 적용시킬 컬럼을 가져올 테이블] 
*/

-- 스칼라 방식 : 변수명, 타입 둘 다 지정
-- 레퍼런스 방식 : 변수명은 지정하고 타입은 참조
--  1. emp.empno%type
--  2. emp%rowtype

-- 사용자 정의 변수 타입
--  1.테이블 type
--  2.레코드 type

-- 조건문
-- if then end if;
-- if then else end if;
-- if then elsif then end if;

-- 반복문
-- loop end loop;
-- for in loop end loop;
-- while loop end loop;
-----------------------------------------------------

-- 저장 프로시져
-- 1.생성(create)
-- 2.실행(execute or exe)

/*   create or replace procedure 프로시져명(매개변수)

     is(or as)
         변수 정의
     begin
         SQL
         출력구문
         조건문, 반복문
     end;
     /
*/
drop table emp01;

create table emp01
as
select * from emp;

set serveroutput on;  -- 출력을 위해 실행(출력이 안 될 때마다 해줘야됨)

create or replace procedure emp01_print  -- 생성단계
is
   vempno number(10);
   vename varchar2(10);
begin
   vempno := 1111;
   vename := 'Hong';
   
   dbms_output.put_line(vempno||' '||vename);
end;
/

execute emp01_print;  

exec emp01_print;

create or replace procedure emp01_del -- 삭제를 위한 procedure 생성
is
begin
  delete from emp01;
end;
/

exec emp01_del; 
-- 전체 데이터 삭제를 위한 procedure 실행

select * from emp01;


--매개변수 이용(특정 데이터 삭제)                ┌in(기본값이라서 생략) 
create or replace procedure del_ename(vename emp01.ename%type) -- 이름을 통해 특정 사원 삭제
is
   
begin
   delete from emp01
   where ename = vename;
end;
/

exec del_ename('SCOTT');

select * from emp01
where ename = 'SCOTT';

exec del_ename('SMITH');

select * from emp01;
--where ename = 'SMITH';

--저장 프로시져의 매개변수 유형
-- in, out, in out
-- in : 값을 전달받는 용도
-- out : 프로시져 내부의 실행 결과를 실행할 쪽으로 전달
-- in out : in + out

-- 사번을 통해서 특정 사원 조회
create or replace procedure sel_empno 
( 
   vempno in emp.empno%type,
   vename out emp.ename%type,
   vsal out emp.sal%type,
   vjob out emp.job%type
)
as

begin
   select ename, sal, job
   into vename, vsal, vjob
   from emp
   where empno = vempno;
end;
/

-- 바인드 변수 말들기 (주석을 포함시키면 가끔 실행 안됨 => 실행문구만 드래그해서 실행하기)
variable var_ename varchar2(15);
variable var_sal number; -- 바인드 변수 지정 시 넘버는 타입만 지정 (크기 지정x)
variable var_job varchar2(9);    

--실행              in         out          out         out
exec sel_empno(입력하는 값, :바인드 변수1, :바인드 변수2, :바인드 변수3);
                     --   └ (:)앞에 붙여주기
exec sel_empno(7499, :var_ename, :var_sal, :var_job);

print var_name;
print var_sal;
print var_job;

--Q 사원 정보를 저장하는 저장 프로시져 만드세요
-- 사번,이름,직책,매니져,부서
-- 사원 정보는 매개변수를 사용해서 받아온다.
drop table emp02;

create table emp02
as
select empno,ename, job, mgr, deptno
from emp
where 1 != 1; -- 테이블의 데이터는 가져오지 않음(false)

create or replace procedure emp02_save
(
   vempno emp02.empno%type,
   vename emp02.ename%type,
   vjob emp02.job%type,
   vmgr emp02.mgr%type,
   vdeptno emp02.deptno%type
)
is
begin
  insert into emp02(empno,ename, job, mgr, deptno)
  values( vempno, vename, vjob, vmgr, vdeptno);
  
end;
/

exec emp02_save (9999,'hong','MANAGER',9998,20); 
exec emp02_save (1111,'NANG','MANAGER',1112,10);

select empno,ename, job, mgr, deptno
from emp02;


-- 저장 함수
-- 저장함수와 저장 프로시져의 차이점: return값 유무
-- 1.생성(create)
-- 2.실행(execute)
/*
create or replace procedure 함수명(매개변수)
    return 값의 타입  -- 세미콜론 생략
                     -- 리턴 구문에서 타입의 크기를 지정하면x
is

begin

    SQL구문
    출력함수
    조건문 , 반복문
    
    return 리턴값;   --세미콜론 사용
end;
/
*/

create or replace function cal_bonuss(vempno emp.empno%type)
   return number  -- 리턴 구문에서 타입의 크기를 지정하면x
is
   vsal number(7,2);
begin
   select sal
   into vsal
   from emp
   where empno = vempno;
   
   return vsal * 200;
end;
/

variable var_res number;

exec :var_res := cal_bonuss(7788); -- exec 뒤쪽에 바이드 변수를 선언해야한다.
                                  -- 리턴값은 바인드 변수에 넣어 출력해야됨.
print :var_res;

drop procedure emp02_save;

drop function cal_bonus;

-- 커서 : 사용할 데이터의 위치를 가르킴 (select 구문이 실행하는 결과를 가리킨다.)
/*
declare 
   cursor 커서명 is sql구문(select); -- 커서선언 => sql구문(select)을 가르킴
begin
   open 커서명;
   loop
      fetch 커서명 into 변수명; -- 테이블로부터 가져와서 변수에 저장하는 역할
      exit when 커서명%notfound;
    
   end loop;
   close 커서명;
enl;
/
*/

declare 
   cursor c1 is select * from emp;
   vemp emp%rowtype;
begin
   open c1;
   loop
      fetch c1 into vemp; -- 테이블로부터 가져와서 변수에 저장하는 역할
      exit when c1%notfound;
      
      dbms_output.put_line(vemp.empno||' '||vemp.ename||' '||vemp.job||' '||
      vemp.mgr||' '||vemp.hiredate||' '||vemp.sal||' '||vemp.comm||' '||vemp.deptno);
   end loop;
   close c1;
end;
/

--for문 이용
declare 
   cursor c1 is select * from dept;
   vdept dept%rowtype;
begin
   for vdept in c1 loop
      exit when c1%notfound;
      dbms_output.put_line(vdept.deptno||' '||vdept.dname||' '||vdept.loc);
   end loop;
end;
/
---------------------------------------------------------------------------------

-- hr 계정에서 실행

SELECT
    * FROM departments;
    
아이디, 이름, 이름의 성, 부서이름

-- employees, departments

-- 조인방식
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_NAME, e.DEPARTMENT_ID
from employees e inner join departments d
on e.DEPARTMENT_ID = d.DEPARTMENT_ID
where e.DEPARTMENT_ID = 100;

select count(*) from employees;
select count(DEPARTMENT_ID) from employees;

select * from employees
where DEPARTMENT_ID is null;


--서브쿼리
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME,DEPARTMENT_ID,(
                                                    select DEPARTMENT_NAME
                                                    from departments d
                                                    where e.DEPARTMENT_ID =d.DEPARTMENT_ID
                                                         ) as dep_names
from employees e
where e.DEPARTMENT_ID = 100;


-- 프로시져(함수) => (매개변수와 리턴구문에서 스칼라 방식을 쓸 경우 타입의 크기를 주지않는다!)
create or replace function get_dep_name(dept_id number)--매개 변수 지정 시 스칼라 방식을 쓸 경우 타입의 크기를 주지않음                                              
   return varchar2 --리턴 구문에서 타입의 크기를 지정하지 않음
is
   sDepName varchar2(30); -- 부서 이름을 받을 수 있는 변수(스칼라 방식으로 일반적인 변수 설정 시 타입 크기 부여) 
begin
   select DEPARTMENT_NAME
   into sDepName
   from departments d
   where DEPARTMENT_ID = dept_id;
   
   return sDepName;
end;
/

variable var_depname varchar2(30);

exec :var_depname := get_dep_name(100);

print var_depname
         
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME,get_dep_name(DEPARTMENT_ID) 
from employees e                        --  └프로시져 함수를 쿼리문에 사용할 수 있다
where e.DEPARTMENT_ID = 100;

--Q
-- employees, jobs
-- 사원아이디, 이름, 성, 잡타이틀
-- 조인,서브쿼리,프로시져함수(get_job_title()) 방식으로 조회

-- 1. 조인 방식
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_TITLE
from employees e inner join jobs j
on e.JOB_ID = j.JOB_ID
order by EMPLOYEE_ID;

-- 2. 서브쿼리 방식
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, (
                     select JOB_TITLE
                     from jobs j
                     where e.JOB_ID = j.JOB_ID
                     ) as JOB_TITLE
from employees e
order by EMPLOYEE_ID;

--3. 프로시져 함수 방식
create or replace function get_job_title(jt_id jobs.JOB_ID%type)
   return varchar2
is
   jt varchar2(50);
begin
   select JOB_TITLE
   into jt
   from jobs
   where JOB_ID = jt_id;
   
   return jt;
end;
/

variable job_t varchar2(50);

exec :job_t := get_job_title('AD_VP');

print job_t;

select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, get_job_title(JOB_ID)
from employees e
order by EMPLOYEE_ID;









