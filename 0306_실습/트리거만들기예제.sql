USE db0220;
CREATE TABLE Book_log( 
	bookid_l INTEGER, 
    bookname_l VARCHAR(40), 
    publisher_l VARCHAR(40), 
    price_l INTEGER);

-- 트리거 만들기
delimiter // 
CREATE TRIGGER AfterInsertBook 
AFTER INSERT ON Book FOR EACH ROW 			#데이터가 삽입되면 자동적으로 실행됨
BEGIN 
	DECLARE average INTEGER; 
    INSERT INTO Book_log VALUES(new.bookid, new.bookname, new.publisher, new.price); 
END; 
// 
delimiter ;

/* 삽입한 내용을 기록하는 트리거 확인 */ 
INSERT INTO Book VALUES(16, '스포츠 과학 1', '이상미디어', 25000); 
SELECT * FROM Book WHERE BOOKID=16; 
SELECT * FROM Book_log WHERE BOOKID_L='16' ;
