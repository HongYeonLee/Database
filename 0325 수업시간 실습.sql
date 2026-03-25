-- 0325 수업 시간 실습
#32번 상관질의 type all scan
EXPLAIN
SELECT b1.bookname
FROM book b1
WHERE b1.price > (
	SELECT AVG(b2.price)
	FROM book b2
	WHERE b2.publisher = b1.publisher
);

#JOIN으로 변형 type ref 스캔도 있음
EXPLAIN
SELECT b1.bookname
FROM book b1
JOIN (
	SELECT publisher, AVG(price) AS avg_price
	FROM book GROUP BY publisher) b2
ON b1.publisher = b2.publisher
WHERE b1.price > b2.avg_price;
;

CREATE TABLE NewCustomer(
	custid INTEGER PRIMARY KEY,
	name VARCHAR(40),
	address VARCHAR(40),
	phone VARCHAR(40)
);

CREATE TABLE NewOrder (
	orderid	INTEGER,
	custid	INTEGER	NOT NULL,
	bookid	INTEGER	NOT NULL,
	saleprice	INTEGER,
	orderdate	DATE,
	PRIMARY KEY(orderid),
-- 	외래키가 참조할 다른 테이블의 키는 기본키여야한다
	FOREIGN KEY(custid) REFERENCES NewCustomer(custid) ON DELETE CASCADE);
	

CREATE TABLE NewBook(
	bookid INTEGER PRIMARY KEY,
	bookname VARCHAR(20),
	publisher VARCHAR(20),
	price INTEGER
	);

ALTER TABLE NewBook ADD isbn VARCHAR(13)


INSERT INTO newbook(bookid, bookname, publisher, price, isbn)
		VALUES (1, 'SQL 첫걸음', '이화출판사', 15000, 123456789);
	
SELECT bookname
FROM book
WHERE price = MAX(price);

SELECT bookname FROM book WHERE price > AVG(price) GROUP BY publisher	