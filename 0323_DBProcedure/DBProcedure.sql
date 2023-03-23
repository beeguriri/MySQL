create database pnusw36;
use pnusw36;

CREATE TABLE user( 
	uid varchar(30) primary key,
    uname varchar(45),
    email varchar(45),
    rdate datetime default current_timestamp()
);
    
-- user추가 프로시저
delimiter //			
CREATE PROCEDURE InsertUser(
	IN in_uid VARCHAR(30),			
    IN in_uname VARCHAR(45),
    IN in_email VARCHAR(45)
)
BEGIN
	INSERT INTO user(uid, uname, email)
		VALUES(in_uid, in_uname, in_email);
END;
//
delimiter ;

-- 프로시저 테스트
/* 프로시저  InsertUser() 테스트하는 부분 */
CALL InsertUser(1, '김가나', 'abc@abc.com');
SELECT * FROM user;

-- user검색 프로시저
delimiter //			
CREATE PROCEDURE SearchUser(
	IN in_uid VARCHAR(30)		
)
BEGIN
	SELECT *
    FROM user
    WHERE in_uid = uid;
END;
//
delimiter ;

-- 프로시저 테스트
/* 프로시저  SearchUser() 테스트하는 부분 */
CALL SearchUser(1);

-- user수정 프로시저
delimiter //			
CREATE PROCEDURE UpdateUserEmail(
	IN in_uid VARCHAR(30),			
    IN in_email VARCHAR(45)
)
BEGIN
	SET SQL_SAFE_UPDATES=0; /* DELETE, UPDATE 연산에 필요한 설정 문 */ 
	UPDATE user 
    SET email = in_email 
	WHERE in_uid = uid;
END;
//
delimiter ;

-- 프로시저 테스트
/* 프로시저  UpdateUserEmail() 테스트하는 부분 */
CALL UpdateUserEmail(1, 'zzz@abc.com');


-- user삭제 프로시저
-- 삭제 데이터 저장용 테이블 생성
CREATE TABLE delUser( 
	uid varchar(30) primary key,
    uname varchar(45),
    email varchar(45),
    rdate datetime,
    ddate datetime default current_timestamp());
    
-- 삭제 트리거 만들기
delimiter // 
CREATE TRIGGER delUser
AFTER DELETE ON user FOR EACH ROW
BEGIN 
	INSERT INTO delUser (uid, uname, email, rdate) VALUES(old.uid, old.uname, old.email, old.rdate);
END; 
// 
delimiter ;

-- 삭제 프로시저 만들기
delimiter //			
CREATE PROCEDURE DeleteUser(
	IN in_uid VARCHAR(30)
)
BEGIN
	SET SQL_SAFE_UPDATES=0; /* DELETE, UPDATE 연산에 필요한 설정 문 */ 
	DELETE FROM user 
	WHERE in_uid = uid;
END;
//
delimiter ;

-- 프로시저 테스트
/* 프로시저  UpdateUserEmail() 테스트하는 부분 */
CALL DeleteUser(1);
delete from deluser where uid=2;


-- 더미 데이터 입력
INSERT INTO user (uid, uname, email) VALUES ('2', '가가가', 'abc@abc.com');
INSERT INTO user (uid, uname, email) VALUES ('3', '가가가', 'abc@abc.com');
INSERT INTO user (uid, uname, email) VALUES ('4', '가가가', 'abc@abc.com');
INSERT INTO user (uid, uname, email) VALUES ('5', '가가가', 'abc@abc.com');
INSERT INTO user (uid, uname, email) VALUES ('6', '가가가', 'abc@abc.com');
