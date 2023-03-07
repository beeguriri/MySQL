-- 입출고 수량에 따라 상품테이블의 "재고수량" 변동
use db0307;

-- [입고] 테이블에 상품이 입고가 되면 [상품]테이블에 상품의 재고수량이 수정되는 트리거
delimiter // 
CREATE TRIGGER AfterInsert입고
AFTER INSERT ON 입고 FOR EACH ROW 			#데이터가 삽입되면 자동적으로 실행됨
BEGIN 
	UPDATE 상품
    SET 재고수량 = 재고수량 + NEW.입고수량
	WHERE 상품코드 = NEW.상품코드;
END; 
// 
delimiter ;

-- 입고테이블에 자료 추가 테스트
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (1, 'AAAAAA', '2004-10-10', 5,   50000);
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (2, 'BBBBBB', '2004-10-10', 15, 700000);
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (3, 'AAAAAA', '2004-10-11', 15, 52000);
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (4, 'CCCCCC', '2004-10-14', 15,  250000);
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (5, 'BBBBBB', '2004-10-16', 25, 700000);

-- [입고] 테이블에 수량이 수정 되면 [상품]테이블에 상품의 재고수량이 수정되는 트리거
delimiter // 
CREATE TRIGGER AfterUpdate입고
AFTER UPDATE ON 입고 FOR EACH ROW 			#데이터가 삽입되면 자동적으로 실행됨
BEGIN 
	UPDATE 상품
    SET 재고수량 = 재고수량 + (NEW.입고수량 - OLD.입고수량)
	WHERE 상품코드 = NEW.상품코드;
END; 
// 
delimiter ;

-- 입고테이블 수량수정 테스트
UPDATE 입고 SET 입고수량 = 10 WHERE 입고번호 = 1;
UPDATE 입고 SET 입고수량 = 5 WHERE 입고번호 = 1;
UPDATE 상품 SET 재고수량 = 20 WHERE 상품코드='AAAAAA';

-- [입고] 테이블에 상품이 삭제 되면 [상품]테이블에 상품의 재고수량이 수정되는 트리거
delimiter // 
CREATE TRIGGER AfterDelete입고
AFTER DELETE ON 입고 FOR EACH ROW 			#데이터가 삽입되면 자동적으로 실행됨
BEGIN 
	UPDATE 상품
    SET 재고수량 = 재고수량 - OLD.입고수량
	WHERE 상품코드 = OLD.상품코드;
END; 
// 
delimiter ;

-- 입고테이블 삭제 테스트
DELETE FROM 입고 WHERE 입고번호 = 2;

-- [판매] 테이블에 자료가 추가되면 [상품]테이블에 상품의 재고수량이 수정되는 트리거
delimiter // 
CREATE TRIGGER BeforeInsert판매
BEFORE INSERT ON 판매 FOR EACH ROW 			#데이터가 삽입되면 자동적으로 실행됨
BEGIN 
	-- STOCK수량 파악
    DECLARE stock INTEGER;
    SELECT 재고수량 INTO stock FROM 상품 where 상품코드 = new.상품코드;
    
    IF stock >= NEW.판매수량 THEN
		UPDATE 상품
		SET 재고수량 = 재고수량 - NEW.판매수량
		WHERE 상품코드 = NEW.상품코드;
	ELSE
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '재고가 부족합니다.';
	END IF;
END; 
// 
delimiter ;

-- 테스트
INSERT INTO 판매 (판매번호, 상품코드, 판매일자, 판매수량, 판매단가) VALUES (3, 'AAAAAA', curdate(), 5,   50000);		#정상실행!
INSERT INTO 판매 (판매번호, 상품코드, 판매일자, 판매수량, 판매단가) VALUES (2, 'BBBBBB', curdate(), 30,   50000);	#실행되지않음!
UPDATE 상품 SET 재고수량 = 5 WHERE 상품코드 = 'BBBBBB';


-- [판매] 테이블에 자료가 추가되면 [상품]테이블에 상품의 재고수량이 수정되는 트리거
delimiter // 
CREATE TRIGGER BeforeUpdate판매
BEFORE UPDATE ON 판매 FOR EACH ROW 			#데이터가 삽입되면 자동적으로 실행됨
BEGIN 
	-- STOCK수량 파악
    DECLARE stock INTEGER;
    SELECT 재고수량 INTO stock FROM 상품 where 상품코드 = new.상품코드;
    
    IF (stock + OLD.판매수량) > NEW.판매수량 THEN
		UPDATE 상품
		SET 재고수량 = 재고수량 - (NEW.판매수량 - OLD.판매수량)
		WHERE 상품코드 = NEW.상품코드;
	ELSE
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '재고가 부족합니다.';
	END IF;
END; 
// 
delimiter ;

-- 테스트
UPDATE 판매 SET 판매수량 = 0 WHERE 판매번호 = 3;		#정상실행!
UPDATE 판매 SET 판매수량 = 30 WHERE 판매번호 = 2;		#실행되지않음!

