-- 수강신청 테이블에서 수강신청번호를 반환하는 저장프로시저를 작성하시오.
-- 수강신청번호는 현재 이전 데이터의 다음 값을 주도록 한다.
use db0221
delimiter //
CREATE PROCEDURE `새수강신청`(
	IN p학번 char(7),
    OUT p수강신청번호 int
)
BEGIN
	-- 마지막 수강신청번호 조회
	SELECT MAX(수강신청번호) INTO p수강신청번호 FROM 수강신청 WHERE 학번=p학번;
	-- 수강신청번호 조건
     SET p수강신청번호 = p수강신청번호 + 1 ;
    -- 입력하는 쿼리
     INSERT INTO 수강신청 (수강신청번호, 학번, 날짜, 연도, 학기) 
 		VALUES (p수강신청번호, p학번, CURDATE(), '2023', '1');

END;
//
delimiter ;	

-- 프로시저 테스트
CALL 새수강신청('1804003', @수강신청번호);
SELECT @수강신청번호; 