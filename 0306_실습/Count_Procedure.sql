-- 수강신청 테이블의 총 학생 수, 교수 수, 과목 수를 계산하는 "통계“ stored procedure를 만드시오
use db0221
delimiter //
CREATE PROCEDURE `통계`(
	OUT 학생수 INTEGER,
    OUT 과목수 INTEGER
)
BEGIN
	-- 검색 결과 변수에 저장
    SELECT count(학번) INTO 학생수	FROM 수강신청;
    SELECT count(distinct (과목번호))	INTO 과목수	FROM 수강신청내역;    
END;
//
delimiter ;	

-- 프로시저 테스트
CALL 통계(@a, @b);
SELECT @a '학생수', @b '과목수'; 