ALTER TABLE orders DROP PRIMARY KEY;	/* PRIMARY KEY 삭제*/

SHOW INDEX FROM orders;					/* 기본적으로 PRIMARY KEY, FORIEN KEY 확인*/

ALTER TABLE orders ADD PRIMARY KEY(orderid);	/* PRIMARY KEY 지정*/


-- /* SQL 내장 함수 */ ---------------------
/* 숫자 함수 */
select custid as '고객번호', round(sum(saleprice)/count(*), -2) as '평균금액'
from orders
group by custid;

select custid as '고객번호', round(avg(saleprice), -2) as '평균금액'
from orders
group by custid;


/* 문자 함수 */
select bookid, replace(bookname, '야구', '농구') as bookname, publisher, price
from book;

select bookname as '제목', char_length(bookname) as 문자수, length(bookname) as 바이트수
from book
where publisher = '굿스포츠';

select substr(name, 1, 1) as '성', count(*) as '인원'
from customer
group by substr(name, 1, 1);


/* 날짜, 시간 함수 */
select orderid as '주문번호', orderdate as '주문일', adddate(orderdate, interval 10 day) as '확정'
from orders;

-- STR_TO_DATE() : 문자열을 날짜형으로 반환
-- DATE_FORMAT() : 날짜형을 문자열로 반환
select orderid as '주문번호', str_to_date(orderdate, '%Y-%m-%d') as '주문일', custid '고객번호', bookid '도서번호'
from orders
where orderdate = date_format('20140707', '%Y%m%d');


/* NULL값 처리 */
select name '이름', ifnull(phone, '연락처없음') '전화번호'
from customer;

/* 행번호 출력 - 치환문 */
-- 변수이름 앞에 '@', 치환문에는 ':=' 기호 사용
set @seq:=0;
select (@seq:=@seq+1) '순번', custid, name, phone
from customer
where @seq < 2;


-- /* 부속질의 */ ---------------------
/* 스칼라 부속질의 : select절에 사용 */
-- 고객별 판매액을 보이시오
-- 방법1:
SELECT custid, (select name
				from customer cs
                where cs.custid = od.custid) '이름', sum(saleprice) '합계'
from orders od
group by od.custid;

-- 방법2: 
select od.custid, name '이름', sum(saleprice) '합계'
from customer cs, orders od
where cs.custid = od.custid
group by od.custid;


/* 인라인 뷰 : from절에 사용 */
-- 고객번호가 2 이하인 고객의 판매액을 보이시오(고객이름과 고객별 판매액 출력)
-- 방법1
select cs.name, sum(od.saleprice) '판매액'
from orders od, (select custid, name
					from customer
                    where custid<=2) cs
where cs.custid = od.custid
group by cs.name;

-- 방법2
select cs.name, sum(od.saleprice) '판매액'
from customer cs, orders od
where cs.custid = od.custid && cs.custid <=2
group by cs.name;


/* 중첩질의 : where절에 사용 */
-- 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
select orderid, saleprice
from orders
where saleprice <= (select avg(saleprice)
					from orders);
                    
-- 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 보이시오.                   
select orderid, custid, saleprice
from orders od
where saleprice >= (select avg(saleprice)
					from orders so
                    where od.custid = so.custid);
              
-- 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오.     
select sum(saleprice) 'total'
from orders
where custid in (select custid
				from customer
				where address like '%대한민국%');

--  3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번 호와 금액을 보이시오.
select orderid, saleprice
from orders
where saleprice > all(select saleprice
						from orders
						where custid='3');
                        
-- EXISTS 연산자로 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
select sum(saleprice) 'total'
from orders od
where exists(select *
				from customer cs
				where address like '%대한민국%' AND cs.custid=od.custid );