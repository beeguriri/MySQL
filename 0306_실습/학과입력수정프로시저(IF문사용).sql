use db0221
delimiter //
CREATE PROCEDURE `학과_입력_수정`(
	IN my학과번호 char(2),
    IN my학과명 char(20),
    IN my전화번호 char(20))
BEGIN
	-- 학과가 있는 경우는 업데이트, 없는 경우 입력이 되도록 하는 프로시저
    -- 학과번호가 존재하는지에 대한 결과를 변수에 저장해놓고
    DECLARE cnt INT;			-- 변수 선언
    SELECT count(*) INTO cnt	-- 검색 결과 변수에 저장 
    FROM 학과 
    WHERE 학과번호 = my학과번호;
    
	-- 조건에 따라 쿼리문 작성
    IF (cnt=0) THEN
		INSERT INTO 학과(학과번호, 학과명, 전화번호)
			VALUES(my학과번호, my학과명, my전화번호);
	ELSE 
		UPDATE 학과 SET 학과명=my학과명 , 전화번호=my전화번호 WHERE 학과번호=my학과번호;
	END IF;
END;
//
delimiter ;	

-- 프로시저 테스트
CALL 학과_입력_수정('08','컴퓨터보안학과','022-333-4000');
CALL 학과_입력_수정('16','컴퓨터보안2학과','022-123-4567');
SELECT * FROM 학과;