create table members (
memid varchar(10) not null, 					/*varchar : 가변형문자열*/
memname varchar(20) not null,
passwd varchar(128),
passwdmdt datetime, 							/*datetime : 날짜와 시간 저장*/
jumin varchar(64),
addr varchar(100),
birthday date, 									/*date : 날짜만 저장*/
jobcd char(1),  								/*char : 고정형문자열*/
mileage decimal(7,0) unsigned default 0,		/*decimal : 소수정 이하 길이 지정, unsigned : 부호없음*/
stat enum('Y', 'N') default 'Y',				/*enum : 리스트중에서 하나 선택*/
enterdtm datetime default CURRENT_TIMESTAMP(),	/*시스템의 날짜 가져옴*/
leavedtm datetime,
primary key (memid)								/*기본키 설정*/
);

INSERT  INTO members (memid, memname, addr, birthday, jobcd, mileage, enterdtm) VALUES ('hong1', '홍길동', '인천 동구 송림동', '2000-05-08', '2', 500, '2022-03-01 14:10:27');
INSERT  INTO members (memid, memname, addr, birthday, jobcd, mileage, enterdtm) VALUES	('hong2', '홍길동', '서울 강남구 신사동', '1990-01-05', '9', 1000,  '2022-03-01 14:11:50');
INSERT  INTO members (memid, memname, addr, birthday, jobcd, enterdtm) VALUES ('kim1', '김갑수', '인천 연수구 연수동', '2003-07-01', '1', '2022-03-01 14:12:39');
INSERT  INTO members (memid, memname, addr, birthday, jobcd, enterdtm) VALUES ('park', '박기자', '경기 부천시', '2002-09-30', '3', '2022-03-01 14:13:16');
INSERT  INTO members (memid, memname, addr, birthday, jobcd, enterdtm) VALUES ('seo', '서갑돌',  '인천 동구', '1998-03-10', '1', '2022-03-01 14:08:41');
INSERT  INTO members (memid, memname, addr, birthday, jobcd, enterdtm) VALUES	('Taeh', '태현', '경기 수원시', '2002-10-15', '4', '2022-03-01 14:15:10');

create table goodsinfo (
goodscd char(5) not null,
goodsname varchar(20) not null,
unitcd char(2),
unitprice decimal(5, 0),
stat enum('Y', 'N') default 'Y',
insdtm datetime default CURRENT_TIMESTAMP(),
moddtm datetime,
primary key(goodscd)
);

INSERT INTO goodsinfo (goodscd, goodsname, unitcd, unitprice, insdtm) VALUES ('GDS01', '노트', '01', '2000', '2022-03-01 14:42:44');
INSERT INTO goodsinfo (goodscd, goodsname, unitcd, unitprice, insdtm) VALUES ('GDS02', '연필', '02', '100', '2022-03-01 14:43:17');
INSERT INTO goodsinfo (goodscd, goodsname, unitcd, unitprice, insdtm) VALUES ('GDS03', '복사지', '03', '5000', '2022-03-01 14:43:47');
INSERT INTO goodsinfo (goodscd, goodsname, unitcd, unitprice, insdtm) VALUES ('GDS04', '볼펜', '02', '500', '2022-03-01 14:44:13');
INSERT INTO goodsinfo (goodscd, goodsname, unitcd, unitprice, insdtm) VALUES ('GDS05', '네임펜', '02', '1000', '2022-03-01 14:44:30');
INSERT INTO goodsinfo (goodscd, goodsname, unitcd, unitprice, insdtm) VALUES ('GDS06', '크레파스', '02', '1500', '2022-03-01 14:45:30');

create table order_h (
orderno char(9) not null,
orddt date not null,
memid varchar(10) not null,
ordamt decimal(7,0) unsigned default 0,
cancelyn enum('Y', 'N') default 'N',
canceldtm datetime,
insdtm datetime default CURRENT_TIMESTAMP(),
moddtm datetime,
primary key(orderno)
);

INSERT INTO order_h (orderno, orddt, memid, ordamt, insdtm) VALUES  ('202201001', '2022-01-24', 'seo', '10000', '2022-03-01 14:49:07');
INSERT INTO order_h (orderno, orddt, memid, ordamt, insdtm) VALUES ('202201002', '2022-01-24', 'hong2', '15000', '2022-03-01 14:50:35');
INSERT INTO order_h (orderno, orddt, memid, ordamt, insdtm) VALUES ('202201003', '2022-01-25', 'hong1', '20000', '2022-03-01 14:51:19');
INSERT INTO order_h (orderno, orddt, memid, ordamt, insdtm) VALUES ('202201004', '2022-01-25', 'kim1', '10000', '2022-03-01 14:51:58');
INSERT INTO order_h (orderno, orddt, memid, ordamt, cancelyn, canceldtm, insdtm) VALUES ('202201005', '2022-01-25', 'park', '5000', 'Y', '2022-01-25 00:00:00', '2022-03-01 14:53:12');
INSERT INTO order_h (orderno, orddt, memid, ordamt, insdtm) VALUES ('202202001', '2022-02-01', 'hong1', '30000', '2022-03-01 14:54:09');
INSERT INTO order_h (orderno, orddt, memid, ordamt, insdtm) VALUES ('202202002', '2022-02-01', 'hong1', '1000', '2022-03-01 14:54:40');
INSERT INTO order_h (orderno, orddt, memid, ordamt, insdtm) VALUES ('202202003', '2022-02-02', 'park', '10000', '2022-03-01 14:55:28');
INSERT INTO order_h (orderno, orddt, memid, ordamt, insdtm) VALUES ('202202004', '2022-02-02', 'abcd', '500', '2022-03-01 14:56:03');

create table order_d (
orderno char(9) not null,
goodscd char(5) not null,
unitcd char(2),
unitprice decimal(5,0) unsigned not null default 0,
qty decimal(3,0) not null default 0,
amt decimal(7,0) not null default 0,
insdtm datetime default CURRENT_TIMESTAMP(),
moddtm datetime,
primary key(orderno, goodscd)
);

INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202201001', 'GDS01', '01', '2000', '10', '20000', '2022-03-01 15:10:39');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202201001', 'GDS02', '02', '100', '50', '5000', '2022-03-01 15:11:39');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202201001', 'GDS03', '03', '5000', '1', '5000', '2022-03-01 15:12:23');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202201002', 'GDS01', '01', '1000', '5', '5000', '2022-03-01 15:13:28');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202201002', 'GDS03', '03', '5000', '10', '50000', '2022-03-01 15:14:26');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202201003', 'GDS04', '02', '500', '50', '25000', '2022-03-01 15:15:12');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202201004', 'GDS05', '02', '1000', '10', '10000', '2022-03-01 15:15:59');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202201005', 'GDS02', '02', '100', '50', '5000', '2022-03-01 15:16:45');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202201005', 'GDS03', '03', '5000', '4', '20000', '2022-03-01 15:17:30');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202201006', 'GDS01', '01', '2000', '1', '2000', '2022-03-01 15:18:08');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202202001', 'GDS01', '01', '2000', '10', '20000', '2022-03-01 15:18:59');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202202001', 'GDS03', '03', '5000', '1', '5000', '2022-03-01 15:19:10');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202202001', 'GDS05', '02', '1000', '20', '20000', '2022-03-01 15:19:20');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202202003', 'GDS01', '01', '2000', '10', '20000', '2022-03-01 15:19:30');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202202003', 'GDS07', '03', '2000', '20', '40000', '2022-03-01 15:20:30');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202202004', 'GDS01', '01', '2000', '10', '20000', '2022-03-01 15:21:18');

create table Persons (
id int not null,
lastname varchar(255) not null,
firstname varchar(255),
age int,
primary key (id)
);

insert into persons values (1, 'hansen', 'ola', 30);
insert into persons values (2, 'ola', 'hansen', 25);
insert into persons values (3, 'hansen', 'ola', 10);

create table orders (
orderid int not null,
ordernumber int not null,
id int,
primary key (orderid),
foreign key (id) references persons(id)
);

drop table orders;

create table orders (
orderid int not null,
ordernumber int not null,
personid int,
primary key (orderid),
foreign key (personid) references persons(id)
);

insert into orders values (1, 77895, 4); /*부모테이블의 도메인과 같지않으므로 입력불가*/
