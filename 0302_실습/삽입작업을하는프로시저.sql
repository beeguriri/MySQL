USE db0220;
delimiter //						/* 관례적으로 넣음 */
CREATE PROCEDURE InsertBook(
	IN myBOOKID INTEGER,			/*매개변수 선언부*/
    IN myBOOKName VARCHAR(40),		/* IN 키워드는 생략가능함 */
    IN myPublisher VARCHAR(40),
    IN myPrice INTEGER)
BEGIN
	INSERT INTO Book(bookid, bookname, publisher, price)
		VALUES(myBookID, myBookName, myPublisher, myPrice);
END;
//
delimiter ;

-- 프로시저 테스트
-- 프로시저 만들어두면 스크립트에 CALL 만 주고 입력 혹은 StoredProcedure 번개모양에서 바로 데이터 입력 가능함
CALL InsertBook(13,'스포츠과학','마당과학서적',25000);
SELECT * FROM Book;