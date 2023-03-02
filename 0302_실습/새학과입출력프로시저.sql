use db0221
delimiter //
CREATE PROCEDURE 새학과(
	my학과번호 char(2),
    my학과명 char(20),
    my전화번호 char(20))
BEGIN
	INSERT INTO 학과(학과번호, 학과명, 전화번호)
		VALUES(my학과번호, my학과명, my전화번호);
END;
//
delimiter ;	

-- 프로시저 테스트
CALL 새학과('08','컴퓨터보안학과','022-200-7000');
SELECT * FROM 학과;

-- PRIMARY KEY 중복 테스트
CALL 새학과('04','컴퓨터보안학과','022-200-7000');