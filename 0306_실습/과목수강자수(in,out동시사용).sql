-- '수강신청내역' 테이블에서 과목별로 수강자수를 반환하는 저장프로시저를 작성하시오.
use db0221
delimiter //
CREATE PROCEDURE `과목수강자수`(
	IN my과목번호 char(6),
    OUT 수강자수 INTEGER
)
BEGIN
	-- 검색 결과 변수에 저장
    SELECT count(*) INTO 수강자수 FROM 수강신청내역 WHERE 과목번호=my과목번호;
END;
//
delimiter ;	

-- 프로시저 테스트
CALL 과목수강자수('K20002', @Count);
SELECT @Count '수강자수'; 
