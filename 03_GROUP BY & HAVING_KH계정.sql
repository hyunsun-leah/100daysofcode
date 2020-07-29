/*
    < GROUP BY 절 >
    그룹기준을 제시할 수 있는 구문 (해당 기준별로 그룹을 묶어줄 수 있다.)
    여러개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용 

*/
SELECT SUM(SALARY)
FROM EMPLOYEE;  --> 전체 사원을 하나의 그룹으로 묶어서 총합을 구한 결과!

-- 각 부서별 총급여합
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT COUNT(*)
FROM EMPLOYEE;  --> 전체 사원수 

-- 각 부서별 사원수
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;


-- 각 부서별 급여합
SELECT DEPT_CODE, SUM(SALARY) -- 3. SELECT절
FROM EMPLOYEE           -- 1. FROM절 
GROUP BY DEPT_CODE      -- 2. GROUP BY절
ORDER BY DEPT_CODE;     -- 4. ORDER BY절

-- 각 직급별 사원수
SELECT JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE ASC;

-- 각 직급별 보너스를 받는 사원수
SELECT JOB_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1 ASC;

-- 각 직급별 급여합
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

-- 각 직급별 급여 평균
SELECT JOB_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

-- 각 직급별 총사원수, 보너스를받는사원수, 급여합, 평균급여, 최고급여, 최저급여
SELECT JOB_CODE 직급, COUNT(*) 총사원수, COUNT(BONUS) 보너스받는사원수, 
       SUM(SALARY) 급여합, FLOOR(AVG(SALARY)) 평균급여, MAX(SALARY) 최고급여, MIN(SALARY) 최저급여
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

SELECT DEPT_CODE 부서, COUNT(*) 총사원수, COUNT(BONUS) 보너스받는사원수,
       SUM(SALARY) 급여합, FLOOR(AVG(SALARY)) 평균급여, 
       MAX(SALARY) 최고급여, MIN(SALARY) 최저급여
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1;


-- * 여러 컬럼을 제시해서 그룹기준 선정 가능
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY 1;

--------------------------------------------------------------------------

/*
    < HAVING 절 >
    그룹에 대한 조건을 제시할 때 사용하는 구문(주로 그룹함수한 결과를 가지고 비교수행)
*/

-- 각 부서별 평균급여 조회
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 부서별 평균급여가 300만원 이상인 부서들만 조회
SELECT DEPT_CODE, FLOOR(AVG(SALARY))-- 4
FROM EMPLOYEE                       -- 1
WHERE FLOOR(AVG(SALARY)) >= 3000000 -- 2
GROUP BY DEPT_CODE;                 -- 3
--> 에러 발생

SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) >= 3000000;

-- 직급별 총급여합
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

-- 부서별 보너스를받는사원이 없는 부서만을 조회
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

-----------------------------------------------------------------------

/*
    < 실행순서 > 
    5: SELECT     *|조회하고자하는 컬럼명 AS 별칭|계산식|함수식
    1: FROM       조회하고자하는 테이블명
    2: WHERE      조건식
    3: GROUP BY   그룹기준에 해당하는 컬럼명, 컬럼명
    4: HAVING     그룹함수식에 대한 조건식
    6: ORDER BY   컬럼명|별칭|컬럼순번  [ASC|DESC]  [NULLS FIRST|NULLS LAST]
*/

-------------------------------------------------------------------------------

/*
    < 집계 함수 >
    그룹별 산출한 결과 값의 중간집계를 계산하는 함수
    
    ROLLUP, CUBE
*/

-- 각 직급별 급여합
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 마지막 행에 전체 총급여합까지 같이 조회하고자 할 때
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE)
ORDER BY JOB_CODE;

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY JOB_CODE;

------ ROLLUP과 CUBE의 차이점 -------
-- ROLLUP(컬럼1, 컬럼2)
-- CUBE(컬럼1, 컬럼2)

-- 부서코드도 같고 직급코드도 같은 사원들을 그룹지어서 해당 급여합
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY 1;

-- ROLLUP(컬럼1, 컬럼2)   => 컬럼1을 가지고 다시 중간집계를 내는 함수
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;

-- CUBE(컬럼1, 컬럼2) => 컬럼1을 가지고 중간집계도 내고, 컬럼2를 가지고도 중간집계를 냄
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 2;


/*
    < GROUPING >
    ROLLUP이나 CUBE에 의해 산출된 값이 해당 컬럼의 집합의 산출물이면 0을반환하고, 아니면 1을 반환하는 함수
*/

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY), 
       GROUPING(DEPT_CODE) 부서별그룹묶인상태,
       GROUPING(JOB_CODE) 직급별그룹묶인상태
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY), 
       GROUPING(DEPT_CODE) 부서별그룹묶인상태,
       GROUPING(JOB_CODE) 직급별그룹묶인상태
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;

---------------------------------------------------------------------------------

/*
    < 집합 연산자 >
    SET OPERATION
    
    여러개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자
    
    - UNION     : OR | 합집합 (두 쿼리문 수행한 결과값을 더한 후 중복되는 교집합 한번 뺀거)
    - INTERSECT : AND | 교집합 (두 쿼리문 수행한 결과값에 중복된 결과값)
    - UNION ALL : OR 결과값에 AND 결과값이 더해진거 (합집합 + 교집합) --> 중복되는 부분이 두번 포함되게 됨
    - MINUS     : 선행 결과값에서 후행 결과값을 뺀 나머지 (차집합)
*/

-- 1. UNION 
-- EMPLOYEE 테이블에서 부서코드가 D5인 사원 또는 급여가 300만원 초과인 사원들 조회
-- 사번, 이름, 부서코드, 급여

-- EMPLOYEE 테이블에서 부서코드가 D5인 사원들만 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';         --> 6명 조회됨

-- EMPLOYEE 테이블에서 급여가 300만원 초과인 사원들만 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;         --> 8명 조회됨


SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 위의 쿼리문 대신 아래처럼 WHERE절에 OR 써도 해결가능!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;

-- 2. UNION ALL : 여러개의 쿼리 결과를 무조건 더하는 연산자
SELECT EMP_ID, EMP_NAME, DEPT_CODE, BONUS 보너스또는급여
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 3. INTERSECT (교집합)
-- EMPLOYEE테이블에서 부서코드가 D5이면서 급여까지도 300만원 초과인 사원 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 아래처럼 해결 가능!!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' AND SALARY > 3000000;

-- 4. MINUS : 선행 SELECT 결과에서 후행 SELECT 결과를 뺀 나머지 
-- 부서코드가 D5인 사원들 중 급여가 300만원 초과인 사원을 제외해서 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' AND SALARY <= 3000000;






