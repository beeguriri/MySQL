-- (8) 고객의 주문 총액을 계산하여 20,000원 이상이면 '우수', 20,000원 미만이면 '보통'을 반환하는 함수 Grade()를 작성하시오. 
-- Grade()를 호출하여 고객의 이름과 등급을 보이는 SQL 문도 작성하시오.

DROP FUNCTION IF EXISTS grade;
delimiter // 
CREATE FUNCTION grade(in_custid INT) 
	RETURNS CHAR(40) 
BEGIN 
	DECLARE totalPrice INTEGER;
    DECLARE result CHAR(40);
    
    SELECT sum(saleprice) INTO totalPrice 
    FROM orders
    WHERE custid = in_custid;

    -- 주문 총액을 계산하여 20,000원 이상이면 '우수', 20,000원 미만이면 '보통'
    IF totalPrice >= 20000 THEN SET result="우수"; 
    ELSE SET result = "보통"; 
    END IF; 
    RETURN result; 
END; 
// delimiter ;

/* 고객의 이름과 등급 출력 */ 
SELECT name, grade(custid) 'grade'
FROM customer;

/* 셀렉트문에서 결과 같은지 확인 */
SELECT name, sum(saleprice)
FROM orders, customer
WHERE orders.custid = customer.custid
GROUP BY customer.custid;