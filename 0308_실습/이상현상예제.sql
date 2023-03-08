-- 이상현상 실습
use db0307;

DROP TABLE IF EXISTS Summer;
CREATE TABLE Summer ( 
	sid INTEGER, 
    class VARCHAR(20), 
    price INTEGER );

INSERT INTO Summer VALUES (100, 'FORTRAN', 20000); 
INSERT INTO Summer VALUES (150, 'PASCAL', 15000); 
INSERT INTO Summer VALUES (200, 'C', 10000); 
INSERT INTO Summer VALUES (250, 'FORTRAN', 20000);

SELECT * FROM Summer;

/* [삭제이상] 200번 학생의 수강신청 취소. */
/* C 강좌 수강료 조회 */ 
SELECT price "C 수강료" FROM Summer WHERE class='C';
/* 200번 학생의 수강신청 취소 */ 
DELETE FROM  Summer WHERE  sid=200;
/* C 강좌 수강료 다시 조회 */
SELECT price "C 수강료" FROM Summer WHERE class='C';
	-- 결과 없음!
/* 다음 실습을 위해 200번 학생 자료 다시 입력 */ 
INSERT INTO Summer VALUES (200, 'C', 10000);

/* [삽입이상] 계절학기에 새로운 자바 강좌를 개설하시오. */
INSERT INTO Summer VALUES (NULL, 'JAVA', 25000);

-- NULL 값이 있는 경우 주의할 질의 : 투플은 다섯 개지만 수강학생은 총 네 명임
SELECT COUNT(*) "수강인원" FROM Summer;	-- 결과 5 (X)
SELECT COUNT(sid) "수강인원" FROM Summer;	-- 결과 4 (O)
SELECT count(*) "수강인원" FROM Summer WHERE sid IS NOT NULL;	-- 결과 4 (O)

/* 다음 실습을 위해 sid가 NULL인 투플 삭제 */ 
DELETE FROM   Summer WHERE   sid IS NULL;

/* [수정이상] FORTRAN 강좌의 수강료를 20,000원에서 15,000원으로 수정하시오.*/
/* FORTRAN 강좌 수강료 수정 */ 
UPDATE Summer SET price=10000 WHERE class='FORTRAN';
SELECT * FROM Summer;
	-- 강의명 FORTRAN 둘다 10000으로 바뀜

SELECT DISTINCT price "FORTRAN 수강료" FROM Summer WHERE class='FORTRAN';

/* 다음 실습을 위해 FORTRAN 강좌의 수강료를 다시 20,000원으로 복구 */ 
UPDATE Summer SET price=20000 WHERE class='FORTRAN';

/* 만약 UPDATE 문을 다음과 같이 작성하면 데이터 불일치 문제가 발생함 */ 
UPDATE Summer SET price=15000 WHERE class='FORTRAN' AND sid=100;
	-- SID 100의 FROTRAN 가격만 15000으로 바뀜
    

/* 이상현상 제거 */
DROP TABLE IF EXISTS SummerPrice; 
DROP TABLE IF EXISTS SummerEnroll;

/* SummerPrice 테이블 생성 */ 
CREATE TABLE SummerPrice (
   class VARCHAR(20), 
   price INT );
INSERT INTO SummerPrice VALUES ('FORTRAN', 20000); 
INSERT INTO SummerPrice VALUES ('PASCAL', 15000); 
INSERT INTO SummerPrice VALUES ('C', 10000);
SELECT * FROM SummerPrice;

/* SummerEnroll 테이블 생성 */ 
CREATE TABLE SummerEnroll (
   sid INT,
   class VARCHAR(20) );
INSERT INTO SummerEnroll VALUES (100, 'FORTRAN'); 
INSERT INTO SummerEnroll VALUES (150, 'PASCAL'); 
INSERT INTO SummerEnroll VALUES (200, 'C'); 
INSERT INTO SummerEnroll VALUES (250, 'FORTRAN');
SELECT * FROM SummerEnroll;

