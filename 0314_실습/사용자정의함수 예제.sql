-- 사용자정의 함수
SET GLOBAL log_bin_trust_function_creators = 1; //ON
delimiter // 
CREATE FUNCTION fnc_Interest(price INTEGER) 
	RETURNS INT 
BEGIN 
	DECLARE myInterest INTEGER;
    -- 가격이 30,000원 이상이면 10%, 30,000원 미만이면 5% 
    IF Price >= 30000 THEN SET myInterest = price * 0.1; 
    ELSE SET myInterest = price * 0.05; 
    END IF; 
    RETURN myInterest; 
END; 
// delimiter ;

/* Orders 테이블에서 각 주문에 대한 이익을 출력 */ 
SELECT custid, orderid, saleprice, fnc_Interest(saleprice) 'interest'
FROM Orders;