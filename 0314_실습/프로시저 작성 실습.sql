USE db0220;
-- #1 고객을 새로 등록하는 InsertCustomer() 프로시저
DROP PROCEDURE IF EXISTS InsertCustomer;
delimiter //			
CREATE PROCEDURE InsertCustomer(
	IN iCustid INTEGER,			
    IN iName VARCHAR(40),
    IN iAddress VARCHAR(50),
    IN iPhone VARCHAR(20))
BEGIN
	INSERT INTO customer(custid, name, address, phone)
		VALUES(iCustid, iName, iAddress, iPhone);
END;
//
delimiter ;

-- 프로시저 테스트
/* 프로시저  InsertCustomer() 테스트하는 부분 */
CALL InsertCustomer(6, '김가나', '대한민국 부산', '010-1234-1234');
SELECT * FROM customer;


-- #2 삽입 작업을 수행하는 프로시저
-- 삽입하려는 도서와 동일한 도서가 있으면 삽입하려는 도서의 가격이 높을 때만 새로운 값으로 변경한다. 
DROP PROCEDURE IF EXISTS BookInsert;
delimiter // 
CREATE PROCEDURE BookInsert( 
	myBookID INTEGER, 
	myBookName VARCHAR(40), 
    myPublisher VARCHAR(40), 
    myPrice INT) 
BEGIN 
	/* BEGIN~END 내부에서 사용할 변수 선언 및 값 저장 */
	DECLARE mycount INTEGER; 	
    SELECT count(*) INTO mycount FROM Book 
		WHERE bookname LIKE myBookName; 

	IF mycount!=0 THEN
		SET SQL_SAFE_UPDATES=0; /* DELETE, UPDATE 연산에 필요한 설정 문 */ 
		UPDATE book SET price = myPrice 
		WHERE myPrice > price;
	ELSE 
		INSERT INTO Book(bookid, bookname, publisher, price) 
			VALUES(myBookID, myBookName, myPublisher, myPrice); 
	END IF; 
END; 
// 
delimiter ;

-- BookInsert 프로시저를 실행하여 테스트하는 부분
CALL BookInsert(18, '축구의 역사', '굿스포츠', 10000); -- 높은값 테스트
CALL BookInsert(18, '축구의 역사', '굿스포츠', 5000); -- 낮은값 테스트
CALL BookInsert(18, '스포츠조아', '마당과학', 14000); -- 중복도서 없는 경우 테스트
SELECT * FROM Book; 

-- #3 출판사가 '이상미디어'인 도서의 이름과 가격을 보여주는 프로시저를 작성하시오.
DROP PROCEDURE IF EXISTS showBook;
delimiter //			
CREATE PROCEDURE showBook(
	IN myPublisher VARCHAR(40))
BEGIN
	SELECT bookname, price
    FROM book
    WHERE publisher = myPublisher;
END;
//
delimiter ;

-- 커서를 사용하는 버전
DROP PROCEDURE IF EXISTS cusor_pro3;
delimiter //
CREATE PROCEDURE cusor_pro3()
BEGIN
	DECLARE myName VARCHAR(40);
    DECLARE myPrice INT;
    DECLARE endOfRow BOOLEAN DEFAULT FALSE;
    DECLARE bookCursor CURSOR FOR SELECT bookname, price from book WHERE publisher='이상미디어'; -- 커서 선언
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET endOfRow=TRUE;  -- 반복조건 선언
    OPEN bookCursor;	-- 커서 열기
		cursor_loop: LOOP	-- 커서 반복 
			FETCH bookCursor INTO myName, myPrice;  -- 데이터 가져오기(FETCH)
			IF endOfRow THEN LEAVE cursor_loop; -- 루프 제어문 (탈출조건)
			END IF;
			SELECT myName, myPrice;
		END LOOP cursor_loop;	-- 루프 닫기
    CLOSE bookCursor; -- 커서 닫기
END;
// delimiter ;

-- showBook 프로시저 테스트
CALL showBook('이상미디어');
CALL cusor_pro3();

-- #4 출판사별로 출판사 이름과 도서의 판매 총액을 보이시오(판매 총액은 Orders 테이블에 있다).
DROP PROCEDURE IF EXISTS total_Publisher;
delimiter //			
CREATE PROCEDURE total_Publisher()
BEGIN
	SELECT publisher, SUM(saleprice)
    FROM book, orders
    WHERE book.bookid = orders.bookid
    GROUP BY publisher;
END;
//
delimiter ;

-- total_Publisher 프로시저 테스트
CALL total_Publisher();

-- #5 출판사별로 도서의 평균가보다 비싼 도서의 이름을 보이시오(예를 들어 A 출판사 도서의 평균가가 20,000원이라면 A 출판사 도서 중 20,000원 이상인 도서를 보이면 된다).
DROP PROCEDURE IF EXISTS avg_book;
delimiter //			
CREATE PROCEDURE avg_book()
BEGIN
	SELECT bookname
    FROM book b1
    WHERE b1.price > (SELECT avg(b2.price) FROM book b2 WHERE b2.publisher = b1.publisher);
END;
//
delimiter ;

-- total_Publisher 프로시저 테스트
CALL avg_book();

-- #6 고객별로 도서를 몇 권 구입했는지와 총 구매액을 보이시오
DROP PROCEDURE IF EXISTS buy_book;
delimiter //			
CREATE PROCEDURE buy_book()
BEGIN
	SELECT name, count(*) '구매권수' , sum(saleprice) '총구매액'
    FROM customer, orders
    WHERE customer.custid = orders.custid
    GROUP BY name;
END;
//
delimiter ;

-- total_Publisher 프로시저 테스트
CALL buy_book();

-- #7 주문이 있는 고객의 이름과 주문 총액을 출력하고, 주문이 없는 고객은 이름만 출력하는 프로시저를 작성하시오.
DROP PROCEDURE IF EXISTS buy_customer;
delimiter //
CREATE PROCEDURE buy_customer()
BEGIN
	DECLARE done BOOLEAN DEFAULT FALSE;
	DECLARE v_sum INT;
    DECLARE v_id INT;
    DECLARE v_name VARCHAR(20);
    
    -- cursor 1: 총 합 계산하기
    DECLARE cursor1 CURSOR FOR SELECT custid, name FROM customer;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cursor1;
    my_loop : LOOP
		FETCH cursor1 INTO v_id, v_name;
			SELECT sum(saleprice) INTO v_sum from orders where custid=v_id;
		IF done THEN LEAVE my_loop;
        END IF;
        IF v_sum >0 THEN 
			SELECT v_name, v_sum; -- 출력할 내용
		ELSE 
			SELECT v_name;
        END IF;
	END LOOP my_loop;
    CLOSE cursor1;
END;
//
delimiter ;

-- total_Publisher 프로시저 테스트
CALL buy_customer();
