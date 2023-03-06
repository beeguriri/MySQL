-- 상품 테이블 작성
CREATE TABLE 상품 (
   상품코드 VARCHAR(6) NOT NULL PRIMARY KEY,
   상품명 VARCHAR(30) NOT NULL,
   제조사 VARCHAR(30) NOT NULL,
   소비자가격 INTEGER,
   재고수량 INTEGER DEFAULT 0
);

-- 입고 테이블 작성
CREATE TABLE 입고 (
	입고번호 INTEGER PRIMARY KEY,
	상품코드 VARCHAR(6) NOT NULL,
	입고일자 DATE,
	입고수량  INTEGER,
	입고단가  INTEGER
);

-- 판매 테이블 작성
CREATE TABLE 판매 (
	판매번호      INTEGER  PRIMARY KEY,
	상품코드      VARCHAR(6) NOT NULL,
	판매일자      DATE,
	판매수량      INTEGER,
	판매단가      INTEGER
);

-- 상품 테이블에 자료 추가
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('AAAAAA', '디카', '삼싱', 100000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('BBBBBB', '컴퓨터', '엘디', 1500000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('CCCCCC', '모니터', '삼싱', 600000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('DDDDDD', '핸드폰', '다우', 500000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
         ('EEEEEE', '프린터', '삼싱', 200000);
COMMIT;
SELECT * FROM 상품;