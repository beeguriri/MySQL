-- 입출고 수량에 따라 상품테이블의 "재고수량" 변동

-- 입고 트리거 만들기
delimiter // 
CREATE TRIGGER StockIn
AFTER INSERT ON 입고 FOR EACH ROW 			#데이터가 삽입되면 자동적으로 실행됨
BEGIN 
	UPDATE 상품
    SET 재고수량 = 재고수량 + NEW.입고수량
	WHERE 상품코드 = NEW.상품코드;
END; 
// 
delimiter ;

-- 테스트
INSERT INTO 입고 VALUES (1, 'AAAAAA', curdate(), 3, 50000 );
SELECT * FROM 입고;
SELECT * FROM 상품;

-- 출고 트리거 만들기
delimiter // 
CREATE TRIGGER StockOut
AFTER INSERT ON 판매 FOR EACH ROW 			#데이터가 삽입되면 자동적으로 실행됨
BEGIN 
	UPDATE 상품
    SET 재고수량 = 재고수량 - NEW.판매수량
	WHERE 상품코드 = NEW.상품코드;
END; 
// 
delimiter ;

-- 테스트
INSERT INTO 판매 VALUES (1, 'AAAAAA', curdate(), 1, 50000 );
DELETE FROM 판매 WHERE 판매번호 = 2;
SELECT * FROM 판매;
SELECT * FROM 상품;