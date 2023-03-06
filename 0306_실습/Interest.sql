use db0220
delimiter // 
CREATE PROCEDURE Interest() 
BEGIN 
	DECLARE myInterest INTEGER DEFAULT 0.0; 
    DECLARE Price INTEGER; 
    DECLARE endOfRow BOOLEAN DEFAULT FALSE; 
    DECLARE InterestCursor CURSOR FOR SELECT saleprice FROM Orders;  #커서 선언
    DECLARE CONTINUE handler FOR NOT FOUND SET endOfRow=TRUE; 		 #커서 예외처리(Handler정의)
    OPEN InterestCursor; 											 #커서 열기
    cursor_loop: LOOP 												 #루프돌면서
		FETCH InterestCursor INTO Price; 							 #데이터 가져와서 Price변수에 저장(Fetch)
        IF endOfRow THEN LEAVE cursor_loop; 						 #커서 예외처리
        END IF; 
        IF Price >= 30000 THEN 
			SET myInterest = myInterest + Price * 0.1; 
		ELSE SET myInterest = myInterest + Price * 0.05; 
        END IF; 
	END LOOP cursor_loop; 
    CLOSE InterestCursor; 											#커서닫기
    SELECT CONCAT(' 전체 이익 금액 = ', myInterest); 
END; 
// 
delimiter ;

/* Interest 프로시저를 실행하여 판매된 도서에 대한 이익금을 계산 */ 
CALL Interest();