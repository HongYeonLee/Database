#ch4 연습문제

-- 질의 4-4 도서 제목에 야구가 포함된 도서를 농구로 변경한 후 도서 목록을 나타내시오.
SELECT bookid, REPLACE(bookname, "야구", "농구"), publisher, price
FROM book;

-- 질의 4-5 굿스포츠에서 출판한 도서의 제목과 제목의 문자 수, 바이트 수를 나타내시오.
SELECT bookname, CHAR_LENGTH(bookname) AS '문자 수', LENGTH(bookname) AS '바이트 수'
FROM book
WHERE publisher = '굿스포츠';

-- 문자함수를 이용해서 이름 가리기
-- 1. 이름이 3글자 인경우
SELECT
	CONCAT(
		LEFT(NAME, 1), '*', RIGHT(NAME,1)
	) AS masked_name
FROM customer
WHERE CHAR_LENGTH(NAME) = 3;

-- 2. 이름이 3글자 이상인 경우
SELECT
	CONCAT(
		LEFT("다니엘헤니", 1),
		REPEAT('*', CHAR_LENGTH("다니엘헤니") - 2),
		RIGHT("다니엘헤니", 1)
	) AS masked_name;

-- 3. 이름이 1글자 이상인 경우
SELECT 
	CASE
		WHEN CHAR_LENGTH(NAME) = 2 #이름이 2글자 인경우 '이산' -> '이*'
			THEN CONCAT(LEFT(NAME, 1), '*')
		WHEN CHAR_LENGTH(NAME) > 2
			THEN CONCAT(LEFT(NAME, 1), REPEAT('*', CHAR_LENGTH(NAME) - 2), RIGHT(NAME, 1))
		ELSE NAME
	END AS masked_name
FROM customer;

-- 질의 4-7 마당서점은 주문일로부터 10일 후에 매출을 확정한다. 각 주문의 확정일자를 구하시오.
SELECT orderid '주문번호', orderdate '주문일', ADDDATE(orderdate, INTERVAL 10 DAY) '확정'
FROM orders;

-- 질의 4-8 마당서점이 2024년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 나타내시오.
-- 단 주문일은 %Y-%m-%d 형태로 표시한다
SELECT orderid '주문번호', DATE_FORMAT(orderdate, "%Y-%m-%d") '주문일', custid '고객번호', bookid '도서번호'
FROM orders
WHERE orderdate = STR_TO_DATE('20240707', '%Y%m%d');

SELECT ADDDATE('2026-04-01', INTERVAL 5 DAY);

SELECT ADDDATE('2026-04-01', INTERVAL -1 MONTH);

SELECT ADDDATE('2026-04-01', INTERVAL 2 YEAR);

SELECT DATE_FORMAT(orderdate, "%Y-%m-%d"),
		 DATE_FORMAT(orderdate, "%y-%M-%D-%b-%w-%W-%a-%j")
FROM orders;

SELECT NOW();
SELECT DATE_FORMAT(SYSDATE(), '%Y');
SELECT STR_TO_DATE('12 05 2024', '%d-%m-%Y');
SELECT CAST('12.3' AS DECIMAL(3,1));
SELECT IF(1=1, 'aa', 'bb');
SELECT IFNULL(123, 345);
SELECT IFNULL(NULL, 123);


-- 질의4-10 이름, 전화번호가 포함된 고객 목록을 나타내시오. 
-- 단, 전화번호가 없는 고객은 '연락처 없음'으로 표기하시오.
SELECT NAME '이름', IFNULL(phone, '연락처 없음')
FROM customer;

SELECT bookname,
	CASE
		WHEN price > 20000 THEN '고가'
		WHEN price BETWEEN 10000 AND 20000 THEN '중간'
		ELSE '저가'
	END AS price_category
FROM book;

#orders table에 2026년 주문 건 하나 추가하고 년도별 매출구해보기
SELECT
	SUM(CASE WHEN YEAR(orderdate) = 2024 THEN saleprice ELSE 0 END) AS '2024년 매출',
	SUM(CASE WHEN YEAR(orderdate) = 2026 THEN saleprice ELSE 0 END) AS '2026년 매출'
FROM orders;

#월별 매출 합게를 high-mid-low로 분류하여 나타내기
SELECT
	MONTH(orderdate) AS MONTH,
	SUM(CASE WHEN saleprice >= 20000 THEN saleprice ELSE 0 END) AS high_sales,
	SUM(CASE WHEN saleprice BETWEEN 10000 AND 20000 THEN saleprice ELSE 0 END) AS mid_sales,
	SUM(CASE WHEN saleprice < 10000 THEN saleprice ELSE 0 END) AS low_sales
FROM orders
GROUP BY MONTH(orderdate)
ORDER BY MONTH;

CREATE TABLE mybook (
	bookid INTEGER PRIMARY KEY,
	price INTEGER
);

INSERT INTO mybook(bookid, price)
		VALUES(1, 10000);
		
INSERT INTO mybook(bookid, price)
		VALUES(2, 20000);

INSERT INTO mybook(bookid, price)
			VALUES(3, NULL);

-- 1
SELECT *
FROM mybook;

-- 2
SELECT bookid, IFNULL(price, 0)
FROM mybook;

-- 3
SELECT *
FROM mybook
WHERE price IS NULL;

-- 4
SELECT *
FROM mybook
WHERE price = '';

-- 5
SELECT bookid, price + 100
FROM mybook;

-- 6
SELECT SUM(price), AVG(price), COUNT(*)
FROM mybook
WHERE bookid >= 4;

-- 7
SELECT COUNT(*), COUNT(price)
FROM mybook;

-- 8
SELECT SUM(price), AVG(price)
FROM mybook;

-- 1
SELECT bookid, bookname, price
FROM book;

-- 2
SELECT bookid, bookname, price
FROM book
LIMIT 5;

-- 3
SELECT bookid, bookname, price
FROM book
ORDER BY price
LIMIT 5;

-- 4
SET @RNUM := 0;
SELECT bookid, bookname, price, @RNUM := @RNUM + 1 AS ROWNUM
FROM book
WHERE @RNUM < 5; #임의로 5개만 행번호와 함께 보기

-- 5
SELECT bookid, bookname, price, @RNUM := @RNUM + 1 AS ROWNUM
FROM book, (SELECT @RNUM := 0) R
WHERE @RNUM < 5; #임의로 5개만 행번호와 함께 보기

-- 6
SELECT bookid, bookname, price, @RNUM := @RNUM + 1 AS ROWNUM
FROM (SELECT * FROM book ORDER BY price) b, (SELECT @RNUM := 0) R
WHERE @RNUM <5; #행번호와 함께 price순으로 5개만 보기

-- 7
SELECT bookid, bookname, price, @RNUM := @RNUM + 1 AS ROWNUM
FROM (SELECT * FROM book ORDER BY price) b, (SELECT @RNUM := 0) R
WHERE @RNUM <3; #행번호와 함께 price순으로 5개만 보기

SELECT * FROM book ORDER BY price

-- 0403 실습
SET @SEQ := 0; #SEQ라는 변수에 0 할당

SELECT (@SEQ := @SEQ +1) '순번', custid, NAME, phone
FROM customer
WHERE @SEQ < 2;

-- 질의 4-16 EXISTS 연산자를 사용하여 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오
SELECT SUM(saleprice) AS '총 판매액'
FROM orders
WHERE EXISTS (SELECT * FROM customer WHERE address LIKE '%대한민국%' AND orders.custid = customer.custid);

-- 질의 4-17 마다서점의 고객별 판매액을 나타내시오(고객이름과 고객별 판매액 출력)
SELECT (SELECT NAME FROM customer cs WHERE cs.custid = od.custid) 'name', SUM(saleprice) 'total'
FROM orders od
GROUP BY od.custid;

-- 질의 4-18 orders 테이블에 각 주문에 맞는 도서이름을 입력하시오
ALTER TABLE orders ADD bname VARCHAR(30);
UPDATE orders SET bname = (SELECT bookname FROM book WHERE orders.bookid = book.bookid);
ALTER TABLE orders DROP COLUMN bname;

-- 질의 4-19 고객 번호가 2 이하인 고객의 판매액을 나타내시오. (고객이름과 고객별 판매액 출력)
SELECT cs.name, SUM(od.saleprice)
FROM customer cs JOIN orders od ON cs.custid = od.custid
WHERE cs.custid <= 2
GROUP BY cs.custid;

SELECT cs.name, SUM(od.saleprice) 'total'
FROM (SELECT custid, NAME FROM customer WHERE custid <= 2) cs, orders od #가상테이블 cs와 orders 조인
WHERE cs.custid = od.custid
GROUP BY cs.name;