INSERT INTO Book VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO Book VALUES(2, '축구아는 여자', '나무수', 13000);
INSERT INTO Book VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO Book VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO Book VALUES(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO Book VALUES(6, '역도 단계별기술', '굿스포츠', 6000);
INSERT INTO Book VALUES(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO Book VALUES(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO Book VALUES(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 'Pearson', 13000);

INSERT INTO Customer VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO Customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');  
INSERT INTO Customer VALUES (3, '장미란', '대한민국 강원도', '000-7000-0001');
INSERT INTO Customer VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전',  NULL);

INSERT INTO Orders VALUES (1, 1, 1, 6000, STR_TO_DATE('2014-07-01','%Y-%m-%d')); 
INSERT INTO Orders VALUES (2, 1, 3, 21000, STR_TO_DATE('2014-07-03','%Y-%m-%d'));
INSERT INTO Orders VALUES (3, 2, 5, 8000, STR_TO_DATE('2014-07-03','%Y-%m-%d')); 
INSERT INTO Orders VALUES (4, 3, 6, 6000, STR_TO_DATE('2014-07-04','%Y-%m-%d')); 
INSERT INTO Orders VALUES (5, 4, 7, 20000, STR_TO_DATE('2014-07-05','%Y-%m-%d'));
INSERT INTO Orders VALUES (6, 1, 2, 12000, STR_TO_DATE('2014-07-07','%Y-%m-%d'));
INSERT INTO Orders VALUES (7, 4, 8, 13000, STR_TO_DATE( '2014-07-07','%Y-%m-%d'));
INSERT INTO Orders VALUES (8, 3, 10, 12000, STR_TO_DATE('2014-07-08','%Y-%m-%d')); 
INSERT INTO Orders VALUES (9, 2, 10, 7000, STR_TO_DATE('2014-07-09','%Y-%m-%d')); 
INSERT INTO Orders VALUES (10, 3, 8, 13000, STR_TO_DATE('2014-07-10','%Y-%m-%d'));

select *
FROM BOOK
WHERE not (publisher = '굿스포츠' or publisher = '대한미디어');

select publisher
from book
where bookname like '%축구%' ;

select bookname, publisher
from book
where bookname = '축구의 역사' ;

select *
from book
where bookname like '_구%';

select *
from book
where bookname like '__의%';

select *
from book
where bookname like '%축구%' and price >=20000;

select *
from book
where publisher = '굿스포츠' or publisher = '대한미디어';

select *
from book
order by bookname;

select *
from book
order by price, bookname;

select *
from book
order by price desc, publisher;

select sum(saleprice) as '총매출'
from orders;

select sum(saleprice) 
from orders
where customer_custid = 2;

select sum(saleprice) as 'Total', avg(saleprice) as 'Average', min(saleprice) as 'Minimum', max(saleprice) as 'Maximum'
from orders;

select count(*)
from orders;

select customer_custid, count(*) as 도서수량, sum(saleprice) as 총액
from orders
group by customer_custid with rollup;

select customer_custid, count(*) as 도서수량
from orders
where saleprice >= 8000
group by customer_custid
having count(*) >= 2;


ALTER TABLE orders RENAME COLUMN customer_custid TO custid;
ALTER TABLE orders RENAME COLUMN book_bookid TO bookid;

/* 2개 이상의 테이블 사용 */

select *
from customer, orders
where customer.custid = orders.custid;

select name, sum(saleprice)
from customer, orders
where customer.custid = orders.custid
group by customer.name
order by customer.name;

select customer.name, book.bookname
from customer, book, orders
where customer.custid = orders.custid and book.bookid = orders.bookid;

select customer.name, book.bookname
from customer, book, orders
where customer.custid = orders.custid and book.bookid = orders.bookid /*조인조건*/
       and book.price = 20000;
       
select customer.name, saleprice
from customer LEFT OUTER JOIN orders		/*customer(LEFT) 테이블에 있는 값은 다 뿌리고, orders 테이블에 매칭안되는 값은 null로 출력*/
		ON customer.custid = orders.custid;

select customer.name
from customer LEFT OUTER JOIN orders
		ON customer.custid = orders.custid
where saleprice is null;					/*검색조건은 결과가 나온것에서 처리함...*/

-- 가장 비싼 도서의 이름을 찾으시오
select bookname
from book
where price = (select max(price) from book);

-- 주문을 한 적이 있는 고객 찾기 : 서브쿼리로 표현하기
select name
from customer
where custid in (select custid from orders);

-- 주문을 한 적이 있는 고객 찾기 : 조인으로 표현하기
select distinct name
from customer right outer join orders ON customer.custid = orders.custid;

-- 대한미디어에서 주문한 고객이름 
select name
from customer
where custid in (select custid from orders where bookid in 
							(select bookid from book where publisher = '대한미디어'));
 
 -- 대한미디어에서 주문한 고객이름 : 조인쿼리
select customer.name
from customer, book, orders
where customer.custid = orders.custid and book.bookid = orders.bookid and publisher = '대한미디어';

/* 집합연산 */
-- 대한민국에 거주하고 있는 고객의 이름과 도서를 주문한 고객의 이름
select name
from customer
where address like '대한민국%'
union
select name
from customer
where custid in (select custid from orders);