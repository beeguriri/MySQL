use db0307;

CREATE TABLE account(
	accNum char(10) primary key,
    amount int not null default 0);
    
INSERT INTO account values('A', 45000);
INSERT INTO account values('B', 100000);

-- A계좌에서 B계좌로 40000원 송금하는 쿼리문
START TRANSACTION;
UPDATE account
set amount=amount - 40000
where accNum='A';
UPDATE account
set amount = amount + 40000
where accNum='B';
ROLLBACK;

-- 인출,송금 프로시저
delimiter // 
CREATE PROCEDURE `account_transaction` (
	in sender char(15),
    in recip char(15),
	in money int
)
BEGIN
	declare exit handler for sqlexception ROLLBACK;
    START TRANSACTION;
		UPDATE account
		SET amount=amount - money
		where accNum=sender;
		UPDATE account
		SET amount = amount + money
		where accNum=recip;
	COMMIT;
END
// delimiter ;

-- 프로시저 호출
CALL account_transaction ('A', 'B', 10000);	
# amount가 마이너스 됨
# 트리거가 없으면 예외처리 -> rollback으로 안넘어감

-- AMOUNT가 0미만이면 인출이 안되도록 하는 트리거
delimiter // 
CREATE TRIGGER `account_BEFORE_UPDATE`
BEFORE UPDATE ON `account` FOR EACH ROW 
BEGIN 
	IF (NEW.amount<0) THEN
		SIGNAL SQLSTATE '45000';	#which means “unhandled user-defined exception.”
    END IF;
END; 
// 
delimiter ;

-- 확인
UPDATE account SET amount = 20000 WHERE accNum = 'A';
UPDATE account SET amount = 100000 WHERE accNum = 'B';
CALL account_transaction ('A', 'B', 30000);		#A=20000, 실행이 일어나지않음
CALL account_transaction ('A', 'B', 20000);		#A=20000, 실행이 일어남

    