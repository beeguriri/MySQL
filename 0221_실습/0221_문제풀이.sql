-- 실습문제

-- 1.<학생> 테이블에 저장되어 있는 모든 학생의 이름을 가져오는 SQL문을 작성하시오. 
SELECT 이름
FROM 학생;
 
-- 2.<교수> 테이블에 저장되어 있는 모든 교수의 이름과 전화번호를 가져오는 SQL문을 작성하시오. 
SELECT 이름, 전화번호
FROM 교수;
 
-- 3.<수강신청> 테이블의 모든 내용을 가져오는 SQL문을 작성하시오. 
 SELECT *
 FROM 수강신청;
 
-- 4.<학생> 테이블에 저장되어 있는 학생 중 2018학년 1학기에 수강신청을 하지 않은 학생의 이름을 찾으시오 
/*서브쿼리 사용*/
SELECT 이름
FROM 학생
WHERE 이름 NOT IN (
					SELECT 학생.이름
					FROM 학생
					INNER JOIN 수강신청 ON 학생.학번 = 수강신청.학번
                    WHERE 연도='2018'AND 학기 = '1');
 
-- 5.이름이 ‘김민준’인 학생이 2018학년도 1학기에 수강 신청한 과목명을 검색하시오 
SELECT 과목.과목명
FROM 과목, 수강신청내역, 수강신청, 학생
WHERE 과목.과목번호 = 수강신청내역.과목번호 AND 수강신청내역.수강신청번호 = 수강신청.수강신청번호 AND 수강신청.학번 = 학생.학번 AND 학생.이름 = '김민준' AND 수강신청.연도 = 2018 AND 수강신청.학기 = 1;

-- 6.<학생> 테이블의 ‘이름’ 필드를 오름차순으로 정렬하여 출력하는 SQL문을 작성하시오. 
SELECT 이름
FROM 학생
ORDER BY 이름;
 
-- 7.<학생> 테이블의 ‘시도’ 와 ‘이름’ 필드의 데이터를 가져와서 ‘시도’, ‘이름’ 순서로 오름차순으로 정렬하는 SQL문을 작성하시오 
SELECT 시도, 이름
FROM 학생
ORDER BY 시도, 이름;
 
-- 8.<학생> 테이블의 ‘시도’ 는 내림차순으로 ‘이름’ 은 오름차순으로 정렬하는 SQL문을 작성하시오 
SELECT 시도, 이름
FROM 학생
ORDER BY 시도 DESC, 이름;
 
-- 9.<학생> 테이블의 ‘시도’ 와 ‘이름’ 필드의 데이터를 가져와서 ‘시도’, ‘이름’ 순서로 내림차순으로 정렬하는 SQL문을 작성하시오 
SELECT 시도, 이름
FROM 학생
ORDER BY 시도 DESC, 이름 DESC;
 
-- 10.<수강신청> 테이블에서 '학번' 필드가 '1801001'인 레코드의 '수강신청번호', '학번', '날짜'를 읽어오는 SQL문을 작성하시오.
SELECT 수강신청번호, 학번, 날짜
FROM 수강신청
WHERE 학번 = 1801001;

-- 11.<수강신청> 테이블에서 '날짜'가 '2018-01-01’ 이전에 수강 신청한 레코드의 '수강신청번호', 학번', '날짜'를 읽어오는 SQL문을 작성하시오. 
SELECT 수강신청번호, 학번, 날짜
FROM 수강신청
WHERE 날짜 < '2018-01-01' ;

-- 12. <과목> 테이블에서 '시수'가 1, 2, 3인 레코드의 '과목번호', '과목', '시수'를 읽어오는 SQL문을 작성하시오.
SELECT 과목번호, 과목명, 시수
FROM 과목
WHERE 시수 IN (1,2,3);

-- 13. <교수> 테이블에서 '전화번호' 필드(열)의 값이 없는 레코드의 '이름'과 '학과'을 읽어오는 SQL문을 작성하시오.
SELECT 이름, 학과
FROM 교수
WHERE 전화번호 IS NULL;

-- 14. <수강신청> 테이블에서 날짜가 ‘2018-01-01’와 ‘2018-07-31’ 사이 수강신청한 레코드의 ‘학번’, ‘날짜’를 읽어오는 SQL문을 작성하시오.
SELECT 학번, 날짜
FROM 수강신청
WHERE 날짜 > '2018-01-01' AND 날짜 < '2018-07-31' ; /*사이는 포함이 안됨*/

-- 15. <교수> 테이블에서 '전화번호'가 있는 교수의 '이름'과 ‘전자우편', ‘전화번호’를 읽어오는 SQL문을 작성하시오. 
SELECT 이름, 전자우편, 전화번호
FROM 교수
WHERE 전화번호 IS NOT NULL;

-- 16. <수강신청> 테이블에서 '학번'이 1601001'이고 '연도'가 2016'인 데이터를 가져오는 SQL문을 작성하시오. 
SELECT *
FROM 수강신청
WHERE 학번 = 1601001 AND 연도 = 2016;

-- 17. <수강신청> 테이블에서 '학번'이 1601002'번과 1801002번인 학생의 수강신청 데이터를 가져오는 SQL문을 작성하시오. 
SELECT *
FROM 수강신청
WHERE 학번 = 1601002 OR 학번 = 1801002
ORDER BY 학번;

-- 18. <수강신청 > 테이블에서 '1601001'와 '1601002' 번인 학생의 '2016' 년도 수강신청 데이터를 가져오는 SQL문을 작성하시오. 
SELECT *
FROM 수강신청
WHERE 학번 IN (1601001, 1601002) AND 연도 = 2016;

-- 19. <수강신청> 테이블에서 '1601001'와 '1601002' 번인 학생의 수강신청 데이터를 가져오는 SQL문을 IN 연산자를 이용하여 작성하시오.
SELECT *
FROM 수강신청
WHERE 학번 IN (1601001, 1601002)
ORDER BY 학번;

-- 20. <수강신청> 테이블에서 '1601001' 학생을 제외한 모든 학생의 수강신청 데이터를 가져오는 SQL문을 작성하시오 
SELECT *
FROM 수강신청
WHERE 학번 !=1601001; /* 또는 <> 사용 */

-- 21. <교수> 테이블에서 '김'씨 성을 가진 교수의 자료를 검색하는 SQL문을 작성하시오. 
SELECT *
FROM 교수
WHERE 이름 LIKE '김%';

-- 22 <학과> 테이블에서 학과 이름에 '공학'이 포함되어 있는 학과의 정보를 검색하는 SQL문을 작성하시오. 
SELECT *
FROM 학과
WHERE 학과명 LIKE '%공학%';

-- 23 <과목> 테이블에서 과목의 영문 이름이 'C'로 시작하여 ‘e’입으로 끝나는 과목의 '과목번호', '과목명', '영문명'을 가져오는 SQL문을 작성하시오.
SELECT 과목번호, 과목명, 영문명
FROM 과목
WHERE 영문명 LIKE 'C%e';

-- 24 <학생> 테이블에서 학생 이름이 '○○준'과 같은 이름을 가진 학생의 자료를 가져오는 SQL문을 작성하시오. 
 SELECT *
 FROM 학생
 WHERE 이름 LIKE '%준';
 
 -- 25 <수강신청내역> 테이블에서 '과목번호'가 'K20045'이거나 'K20056'이고 평점'이 3인 레코드의 '수강신청번호', '과목번호', '평점'을 가져오는 SQL문을 작성하시오. 
 SELECT 수강신청번호, 과목번호, 평점
 FROM 수강신청내역
 WHERE (과목번호 = 'K20045' OR 과목번호 = 'K20056') AND 평점 = 3;
 
 -- 26 <수강신청내역> 테이블에서 '과목번호'가 'K20045’, ‘K20056’, ‘Y00132' 인 과목의 '수강신청번호', '과목번호', '평점'을 가져오는 SQL문을 IN 연산자를 이용하여 작성하시오. 
 -- '과목번호' 필드를 기준으로 오름차순으로 정렬하시오. 
 SELECT 수강신청번호, 과목번호, 평점
 FROM 수강신청내역
 WHERE 과목번호 IN ('K20045', 'K20056', 'Y00132')
 ORDER BY 과목번호;
 
 -- 27 <수강신청내역> 테이블에서 '평점'이 -1이 아닌 레코드의 자료를 가져오는 SQL문을 작성하시오.
 SELECT *
 FROM 수강신청내역
 WHERE 평점 != -1;
 
 -- 28 <학생> 테이블에서 18학번 학생들의 '학번', '이름', '시도'을 가져오는 SQL문을 작성하시오. 
 SELECT 학번, 이름, 시도
 FROM 학생
 WHERE 학번 LIKE '18%';
 
 -- 29 <학생> 테이블에서 주소 중에 시군구' 필드가 '구'로 끝나는 학생들의 ‘학번’, '이름', '시도', 시군구'를 가져오는 SQL문을 작성하시오. 
 SELECT 학번, 이름, 시도, 시군구
 FROM 학생
 WHERE 시군구 LIKE '%구';
 
 -- 30 <과목> 테이블에서 '영문명'이 'I'로 시작하여 'n'으로 끝나는 과목의 '과목번호, ’과목명', '영문명'을 가져오는 SQL문을 작성하시오. 
 SELECT 과목번호, 과목명, 영문명
 FROM 과목
 WHERE 영문명 LIKE 'I%n';
 
 -- 31 <과목> 테이블에서 '과목명'이 ‘컴퓨터ㅇㅇ'와 같은 이름을 가진 과목의 '과목번호', '과목', '영문명'을 가져오는 SQL문을 작성하시오. 
 SELECT 과목번호, 과목명, 영문명
 FROM 과목
 WHERE 과목명 LIKE '컴퓨터__';
 
 -- 32 <학생> 테이블에서 학생의 이름에 '서'자가 들어가는 학생의 '학번', '학과'. '이름’, ‘시도'를 가져오는 SQL문을 작성하시오. 
 SELECT 학번, 학과, 이름, 시도
 FROM 학생
 WHERE 이름 LIKE '%서%';
 
 