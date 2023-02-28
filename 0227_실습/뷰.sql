-- 뷰 ----------
/* 뷰의 생성 */
create view vw_Book
as select *
from book
where bookname like '%축구%';

create view vw_customer
as select *
from customer;

create view vw_orders (orderid, custid, name, bookid, bookname, saleprice, orderdate)
as select od.orderid, od.custid, cs.name, od.bookid, bk.bookname, od.saleprice, od.orderdate
from orders od, customer cs, book bk
where od.custid = cs.custid and od.bookid = bk.bookid;

/* 뷰의 수정 */
create or replace view vw_customer(custid, name, address)
as select custid, name, address
from customer
where address like '%영국%';