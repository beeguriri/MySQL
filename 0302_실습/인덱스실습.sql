-- 테이블의 색인 정보를 확인
SHOW INDEX FROM dept_emp;

-- 테이블 정보 조회
SHOW TABLE STATUS LIKE 'dept_emp';

-- 인덱스 삭제
-- 기본키, 외래키 모두 삭제 후 DROP 명령을 통해 수행
ALTER TABLE dept_emp DROP FOREIGN KEY dept_emp_ibfk_1;
ALTER TABLE dept_emp DROP FOREIGN KEY dept_emp_ibfk_2;
DROP INDEX dept_no ON dept_emp;

-- 테이블 다시 분석해서, 관련정보 업데이트
ANALYZE TABLE dept_emp;

-- 테이블 기본키 정보 삭제
ALTER TABLE dept_emp DROP primary key;

-- 첫번째 행의 데이터 조회
SELECT * FROM dept_emp ORDER BY emp_no ASC LIMIT 1;
-- 마지막 행의 데이터 조회
SELECT * FROM dept_emp ORDER BY emp_no DESC LIMIT 1;

-- 인덱스가 없으면 Full Scan
SELECT COUNT(*) FROM dept_emp;
EXPLAIN SELECT * FROM dept_emp WHERE emp_no = 10001;
EXPLAIN SELECT * FROM dept_emp WHERE emp_no = 499999;

-- 인덱스가 없는 dept_no 데이터 조회
SELECT COUNT(*) FROM dept_emp WHERE dept_no = 'd006';
EXPLAIN SELECT * FROM dept_emp WHERE dept_no = 'd006';

-- 인덱스 만든 후 조회
CREATE INDEX dept_emp ON dept_emp(dept_no);
EXPLAIN SELECT * FROM dept_emp WHERE dept_no = 'd006';

-- 인덱스 있는 열과 없는 열의 복합
SELECT * FROM dept_emp WHERE dept_no='d006' AND from_date='1996-11-24';
EXPLAIN SELECT * FROM dept_emp WHERE dept_no='d006' AND from_date='1996-11-24';

-- 인덱스 만든 후 조회 (rows 37930 -> 57로 대폭축소 : 검색효율 좋아짐)
CREATE INDEX from_date ON dept_emp(from_date);
EXPLAIN SELECT * FROM dept_emp WHERE dept_no='d006' AND from_date='1996-11-24';

-- 테이블 조인 (dept_emp, employees)에 따른 실행계획
ALTER TABLE dept_emp DROP primary key;
ALTER TABLE dept_emp DROP INDEX dept_emp;
ALTER TABLE dept_emp DROP INDEX from_date;
ANALYZE TABLE dept_emp;
ALTER TABLE salaries DROP FOREIGN KEY salaries_ibfk_1;
ALTER TABLE dept_manager DROP FOREIGN KEY dept_manager_ibfk_1;
ALTER TABLE titles DROP FOREIGN KEY titles_ibfk_1;
ALTER TABLE employees DROP primary key;

/* rows 확인(b: 289741, a: 331008) : 조건유무 상관없이 Full Scan*/
EXPLAIN SELECT a.emp_no, b.first_name, b.last_name
FROM dept_emp a INNER JOIN employees b
ON a.emp_no = b.emp_no;

/* rows 확인(b: 289741, a: 331008) : 조건유무 상관없이 Full Scan*/
EXPLAIN SELECT a.emp_no, b.first_name, b.last_name
FROM dept_emp a INNER JOIN employees b
ON a.emp_no = b.emp_no
WHERE a.emp_no = 10001;

ALTER TABLE employees ADD PRIMARY KEY (emp_no);
ALTER TABLE dept_emp ADD PRIMARY KEY (emp_no, dept_no);

/* rows 확인(b: 299423, a: 1) */
EXPLAIN SELECT a.emp_no, b.first_name, b.last_name
FROM dept_emp a INNER JOIN employees b
ON a.emp_no = b.emp_no;

/* rows 확인(b: 1, a: 1) */
EXPLAIN SELECT a.emp_no, b.first_name, b.last_name
FROM dept_emp a INNER JOIN employees b
ON a.emp_no = b.emp_no
WHERE a.emp_no = 10001;


















