use db0220;

-- 트랜잭션 실습 (SQL의 작업단위)
-- ex : 은행에서 인출 -> 송금 하는 두 작업을 하나의 트랜잭션으로 묶어 commit
-- commit; 		commit이 실행되면 rollback 불가
-- rollback;

select @@autocommit;	#결과 1 : 활성상태(Insert, update, delete 즉시반영)
set autocommit=0;		#결과 0 : 비활성상태(Insert, update, delete 수동반영)

-- 기존의 book table과 동일한 실습용 table 만들기
create table book1 (select * from book);
create table book2 (select * from book);

-- autocommit=1인 상태
delete from book1;
rollback;				# autocommit=1인 상태에서는 rollback 안됨

-- autocommit=0인 상태
set autocommit=0;
delete from book2;
rollback;				# 삭제된 데이터 복구 됨
delete from book2;
commit;
rollback;				# commit 수행후에는 삭제된 데이터 복구 안됨

-- 트랜잭션 만들기 (COMMIT=1인상태 확인)
START TRANSACTION;
delete from book1;
delete from book2;		# 기존에는 COMMIT=1인상태에서 삭제하면 ROLLBACK 안되지만, TRANSACTION 내에서는 ROLLBACK 됨!!
ROLLBACK;				# TRANSACTION 마치는 줄에는 ROLLBACK 또는 COMMIT 사용

-- 트랜잭션 만들기 실습 (ROLLBACK 구역나누기)
START TRANSACTION;
SAVEPOINT A;
DELETE FROM book1;
SAVEPOINT B;
DELETE FROM book2;
ROLLBACK TO SAVEPOINT B;	#BOOK2만 롤백
COMMIT;						#BOOK2 데이터는 살아있음 (BOOK1은 삭제)













