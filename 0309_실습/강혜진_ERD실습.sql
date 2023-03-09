USE db0309;

-- 견적서
CREATE TABLE 공급자 (
	등록번호 VARCHAR(15) NOT NULL,
	상호 VARCHAR(45) NOT NULL,
	대표성명 VARCHAR(45),
	사업장주소 VARCHAR(45),
	업태 VARCHAR(45),
	종목 VARCHAR(45),
	전화번호 VARCHAR(13),
	PRIMARY KEY (등록번호)
  );
  
  CREATE TABLE 제품 (
	제품번호 INT NOT NULL AUTO_INCREMENT,
	품명 VARCHAR(45)	NOT NULL,
	규격 VARCHAR(45),
	단가 INT,
	PRIMARY KEY (제품번호)
  );
  
  CREATE TABLE IF NOT EXISTS 견적서 (
	견적번호 INT NOT NULL AUTO_INCREMENT,
	견적일 DATE,
	견적접수자 VARCHAR(10),
	담당 VARCHAR(10),
	공급가액 INT,
	비고 VARCHAR(45),
    공급자 VARCHAR(15) NOT NULL,
	PRIMARY KEY (견적번호),
    FOREIGN KEY (공급자) REFERENCES 공급자 (등록번호)
);

CREATE TABLE IF NOT EXISTS 견적세부내용 (
	일련번호 INT NOT NULL AUTO_INCREMENT,
	수량 INT,
	합계 INT,
	제품 INT,
	견적번호 INT,
	PRIMARY KEY (일련번호),
	FOREIGN KEY (제품) REFERENCES 제품 (제품번호),
    FOREIGN KEY (견적번호) REFERENCES 견적서 (견적번호)
);

INSERT INTO 공급자 VALUES('607-123-12345', '국민상사', '김국민', '부산시 강서구', '제조업', '부품제조', '051-123-4567');
INSERT INTO 견적서 (견적일, 견적접수자, 담당, 공급가액, 비고, 공급자) VALUES (curdate(), '김사원', '김사원', 58000, '', '607-123-12345');
INSERT INTO 제품 (품명, 규격, 단가) VALUES ('볼트', 'M12X45L', 800);
INSERT INTO 견적세부내용 (수량, 합계, 제품, 견적번호) VALUES (3, 2400, 1, 3);

-- 학생 수강과목 테이블 작성
CREATE TABLE 과목 (
	과목코드 VARCHAR(45) NOT NULL,
	과목명 VARCHAR(45),
	PRIMARY KEY (과목코드)
);

CREATE TABLE 전공 (
	전공코드 VARCHAR(45) NOT NULL,
	전공명 VARCHAR(45),
	PRIMARY KEY (전공코드)
);

CREATE TABLE 수강정보 (
	학번 VARCHAR(45) NOT NULL,
	이름 VARCHAR(45),
	전공코드 VARCHAR(45),
	PRIMARY KEY (학번),
    FOREIGN KEY (전공코드) REFERENCES 전공 (전공코드)
);

CREATE TABLE 수강과목 (
	일련번호 INT NOT NULL,
	학점 VARCHAR(45),
	과목코드 VARCHAR(45),
	학번 VARCHAR(45),
	PRIMARY KEY (일련번호),
    FOREIGN KEY (과목코드) REFERENCES 과목 (과목코드),
    FOREIGN KEY (학번) REFERENCES 수강정보 (학번)
);

