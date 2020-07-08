/*
    < GROUP BY �� >
    �׷������ ������ �� �ִ� ���� (�ش� ���غ��� �׷��� ������ �� �ִ�.)
    �������� ������ �ϳ��� �׷����� ��� ó���� �������� ��� 

*/
SELECT SUM(SALARY)
FROM EMPLOYEE;  --> ��ü ����� �ϳ��� �׷����� ��� ������ ���� ���

-- �� �μ��� �ѱ޿���
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT COUNT(*)
FROM EMPLOYEE;  --> ��ü ����� 

-- �� �μ��� �����
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;


-- �� �μ��� �޿���
SELECT DEPT_CODE, SUM(SALARY) -- 3. SELECT��
FROM EMPLOYEE           -- 1. FROM�� 
GROUP BY DEPT_CODE      -- 2. GROUP BY��
ORDER BY DEPT_CODE;     -- 4. ORDER BY��

-- �� ���޺� �����
SELECT JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE ASC;

-- �� ���޺� ���ʽ��� �޴� �����
SELECT JOB_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1 ASC;

-- �� ���޺� �޿���
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

-- �� ���޺� �޿� ���
SELECT JOB_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

-- �� ���޺� �ѻ����, ���ʽ����޴»����, �޿���, ��ձ޿�, �ְ�޿�, �����޿�
SELECT JOB_CODE ����, COUNT(*) �ѻ����, COUNT(BONUS) ���ʽ��޴»����, 
       SUM(SALARY) �޿���, FLOOR(AVG(SALARY)) ��ձ޿�, MAX(SALARY) �ְ�޿�, MIN(SALARY) �����޿�
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

SELECT DEPT_CODE �μ�, COUNT(*) �ѻ����, COUNT(BONUS) ���ʽ��޴»����,
       SUM(SALARY) �޿���, FLOOR(AVG(SALARY)) ��ձ޿�, 
       MAX(SALARY) �ְ�޿�, MIN(SALARY) �����޿�
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1;


-- * ���� �÷��� �����ؼ� �׷���� ���� ����
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY 1;

--------------------------------------------------------------------------

/*
    < HAVING �� >
    �׷쿡 ���� ������ ������ �� ����ϴ� ����(�ַ� �׷��Լ��� ����� ������ �񱳼���)
*/

-- �� �μ��� ��ձ޿� ��ȸ
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �μ��� ��ձ޿��� 300���� �̻��� �μ��鸸 ��ȸ
SELECT DEPT_CODE, FLOOR(AVG(SALARY))-- 4
FROM EMPLOYEE                       -- 1
WHERE FLOOR(AVG(SALARY)) >= 3000000 -- 2
GROUP BY DEPT_CODE;                 -- 3
--> ���� �߻�

SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) >= 3000000;

-- ���޺� �ѱ޿���
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

-- �μ��� ���ʽ����޴»���� ���� �μ����� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

-----------------------------------------------------------------------

/*
    < ������� > 
    5: SELECT     *|��ȸ�ϰ����ϴ� �÷��� AS ��Ī|����|�Լ���
    1: FROM       ��ȸ�ϰ����ϴ� ���̺��
    2: WHERE      ���ǽ�
    3: GROUP BY   �׷���ؿ� �ش��ϴ� �÷���, �÷���
    4: HAVING     �׷��Լ��Ŀ� ���� ���ǽ�
    6: ORDER BY   �÷���|��Ī|�÷�����  [ASC|DESC]  [NULLS FIRST|NULLS LAST]
*/

-------------------------------------------------------------------------------

/*
    < ���� �Լ� >
    �׷캰 ������ ��� ���� �߰����踦 ����ϴ� �Լ�
    
    ROLLUP, CUBE
*/

-- �� ���޺� �޿���
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- ������ �࿡ ��ü �ѱ޿��ձ��� ���� ��ȸ�ϰ��� �� ��
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE)
ORDER BY JOB_CODE;

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY JOB_CODE;

------ ROLLUP�� CUBE�� ������ -------
-- ROLLUP(�÷�1, �÷�2)
-- CUBE(�÷�1, �÷�2)

-- �μ��ڵ嵵 ���� �����ڵ嵵 ���� ������� �׷���� �ش� �޿���
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY 1;

-- ROLLUP(�÷�1, �÷�2)   => �÷�1�� ������ �ٽ� �߰����踦 ���� �Լ�
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;

-- CUBE(�÷�1, �÷�2) => �÷�1�� ������ �߰����赵 ����, �÷�2�� ������ �߰����踦 ��
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 2;


/*
    < GROUPING >
    ROLLUP�̳� CUBE�� ���� ����� ���� �ش� �÷��� ������ ���⹰�̸� 0����ȯ�ϰ�, �ƴϸ� 1�� ��ȯ�ϴ� �Լ�
*/

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY), 
       GROUPING(DEPT_CODE) �μ����׷칭�λ���,
       GROUPING(JOB_CODE) ���޺��׷칭�λ���
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY), 
       GROUPING(DEPT_CODE) �μ����׷칭�λ���,
       GROUPING(JOB_CODE) ���޺��׷칭�λ���
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;

---------------------------------------------------------------------------------

/*
    < ���� ������ >
    SET OPERATION
    
    �������� �������� ������ �ϳ��� ���������� ����� ������
    
    - UNION     : OR | ������ (�� ������ ������ ������� ���� �� �ߺ��Ǵ� ������ �ѹ� ����)
    - INTERSECT : AND | ������ (�� ������ ������ ������� �ߺ��� �����)
    - UNION ALL : OR ������� AND ������� �������� (������ + ������) --> �ߺ��Ǵ� �κ��� �ι� ���Եǰ� ��
    - MINUS     : ���� ��������� ���� ������� �� ������ (������)
*/

-- 1. UNION 
-- EMPLOYEE ���̺��� �μ��ڵ尡 D5�� ��� �Ǵ� �޿��� 300���� �ʰ��� ����� ��ȸ
-- ���, �̸�, �μ��ڵ�, �޿�

-- EMPLOYEE ���̺��� �μ��ڵ尡 D5�� ����鸸 ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';         --> 6�� ��ȸ��

-- EMPLOYEE ���̺��� �޿��� 300���� �ʰ��� ����鸸 ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;         --> 8�� ��ȸ��


SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- ���� ������ ��� �Ʒ�ó�� WHERE���� OR �ᵵ �ذᰡ��!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;

-- 2. UNION ALL : �������� ���� ����� ������ ���ϴ� ������
SELECT EMP_ID, EMP_NAME, DEPT_CODE, BONUS ���ʽ��Ǵ±޿�
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 3. INTERSECT (������)
-- EMPLOYEE���̺��� �μ��ڵ尡 D5�̸鼭 �޿������� 300���� �ʰ��� ��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- �Ʒ�ó�� �ذ� ����!!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' AND SALARY > 3000000;

-- 4. MINUS : ���� SELECT ������� ���� SELECT ����� �� ������ 
-- �μ��ڵ尡 D5�� ����� �� �޿��� 300���� �ʰ��� ����� �����ؼ� ��ȸ
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






