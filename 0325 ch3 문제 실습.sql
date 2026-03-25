-- 질의28 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오
SELECT c.name, o.saleprice
FROM customer c LEFT JOIN orders o ON c.custid = o.custid;

-- 문제: 도서를 기준으로 구매한 고객을 나타낸다면?
SELECT c.name, o.saleprice
FROM customer c RIGHT JOIN orders o ON c.custid = o.custid;

-- 질의29 가장 비싼 도서의 이름을 나타내시오
SELECT bookname FROM book WHERE price = (SELECT MAX(price) FROM book);

-- 도서를 구매한 적이 있는 고객의 이름을 구하세요
SELECT NAME FROM customer WHERE custid IN (SELECT custid FROM orders WHERE orders.custid = customer.custid);

-- 질의 31 대한미디어에서 출판한 도서를 구매한 고객의 이름을 구하세요
SELECT NAME FROM customer WHERE custid IN 
		(SELECT custid FROM orders WHERE bookid IN 
		(SELECT bookid FROM book WHERE publisher = '대한미디어'));
		
-- 질의32 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오
SELECT bookname FROM book b1 WHERE price > (SELECT AVG(price) FROM book b2 WHERE b1.publisher = b2.publisher);

-- 질의33 대한민국에 거주하는 고객의 이름과 도서를 주문한 고객의 이름을 구하시오
SELECT NAME FROM customer WHERE address LIKE '대한민국%'
UNION
SELECT NAME FROM customer WHERE custid IN (SELECT custid FROM orders );

SELECT NAME FROM customer WHERE address LIKE '대한민국%'
UNION ALL
SELECT NAME FROM customer WHERE custid IN (SELECT custid FROM orders );

-- 대한민국에 거주하는 고객의 이름에서 도서를 주문한 고객의 이름을 제외하고 나타내세요
SELECT NAME FROM customer WHERE address LIKE '대한민국%' AND 
											NOT EXISTS (SELECT custid FROM orders WHERE customer.custid = orders.custid);
											
SELECT NAME FROM customer WHERE address LIKE '대한민국%' AND
									NAME NOT IN (SELECT NAME FROM customer WHERE custid IN (SELECT custid FROM orders));											

-- 대한민국에 거주하는 고객의 중 도서를 주문한 고객의 이름을 나타내세요
SELECT NAME FROM customer WHERE address LIKE '대한민국%' AND
						custid IN (SELECT custid FROM orders);

SELECT NAME FROM customer WHERE address LIKE '대한민국%' AND
									NAME IN (SELECT NAME FROM customer WHERE custid IN (SELECT custid FROM orders));	
									
-- 주문이 있는 고객의 이름과 주소를 나타내세요
SELECT NAME, address FROM customer WHERE custid IN (SELECT custid FROM orders);

SELECT NAME, address FROM customer WHERE EXISTS (SELECT * FROM orders WHERE customer.custid = orders.custid);

#질의 32 join으로 풀기
EXPLAIN
SELECT b1.bookname FROM book b1 JOIN 
		(SELECT publisher, AVG(price) AS avg_price FROM book b2 GROUP BY publisher) b2
		ON b1.publisher = b2.publisher
		WHERE b1.price > b2.avg_price;

-- 질의35 다음과 같은 속성을 가진 NewBook 테이블을 생성하고 기본키를 bookid로 지정하세요
CREATE TABLE newbook (
	bookid INTEGER	PRIMARY KEY,
	bookname VARCHAR(20),
	publisher VARCHAR(20),
	price INTEGER
);

-- 질의 36 다음과 같은 속성을 가진 NewOrder, NewCustomer 테이블을 생성하세요
CREATE TABLE NewCustomer(
	custid INTEGER PRIMARY KEY,
	NAME VARCHAR(20),
	address VARCHAR(20),
	phone VARCHAR(20)
);

CREATE TABLE NewOrder(
	orderid INTEGER,
	custid INTEGER NOT NULL,
	bookid INTEGER NOT NULL,
	saleprice INTEGER,
	orderdate DATE,
	PRIMARY KEY(orderid),
	FOREIGN KEY(custid) REFERENCES NewCustomer(custid) ON DELETE CASCADE)	
);


-- 질의37 앞에서 생성한 NewBook 테이블에 VARCHAR(31)의 자료형으로 isbn 속성을 추가하세요
ALTER TABLE newbook ADD isbn VARCHAR(13);

-- 질의38 NewBook 테이블에서 isbn자료형을 INTEGER로 변경하세요
ALTER TABLE newbook MODIFY isbn INTEGER;

-- 질의39 NewBook 테이블의 isbn 속성을 삭제하세요
ALTER TABLE newbook DROP COLUMN isbn;

-- 질의40 NewBook 테이블의 bookname 속성에 NOT NULL 제약 조건을 적용하세요
ALTER TABLE newbook MODIFY bookname VARCHAR(20) NOT NULL;

-- 질의41 NewBook 테이블의 bookid 속성을 기본키로 변경하세요
ALTER TABLE newbook ADD PRIMARY KEY(bookid);

-- 질의42 NewBook 테이블을 삭제하세요
DROP TABLE newbook;

-- 질의43 NewCustomer 테이블을 삭제하세요. 만약 삭제가 거절된다면 원이르 파악하고 관련 테이블을 함께 삭제하세요
-- DROP TALBE newcustomer;
-- DROP TABLE neworder;
-- DROP TABLE newcustomer;

-- 질의44 book 테이블에 새로운 도서 '스포츠 의학'을 삽입하세요
INSERT INTO book(bookid, bookname, publisher, price)
		VALUES (11, '스포츠 의학', '한솔의학서적', 90000);
	
INSERT INTO book(bookid, bookname, publisher, price)
		VALUES (12, '스포츠 의학', '한솔의학서적', 90000);

INSERT INTO book(bookid, bookname, publisher, price)
		VALUES (13, '스포츠 의학', '한솔의학서적', 90000);

-- 질의45 book 테이블에 새로운 도서 '스포츠 의학'을 삽입하세요 단, 가격은 미정입니다
INSERT INTO book (bookid, bookname, publisher)
			VALUES(14, '스포츠 의학', '한솔의학서적');

-- 질의46 수입도서테이블에 있는 모든 목록을 book테이블에 모두 삽입하세요
INSERT INTO book(bookid, bookname, price, publisher)
		SELECT bookid, bookname, price, publisher
		FROM imported_book;
		
-- 질의47 customer 테이블에서 고객번호가 5인 고객의 주소를 '대한민국 부산'으로 변경하세요
UPDATE customer
SET address = '대한민국 부산'
WHERE custid = 5;

-- 질의48 book테이블에서 14번 '스포츠 의학'의 출판사를 imported_book 테이블에 있는 21번 책의 출판사와 동일하게 변경하세요
UPDATE book
SET publisher = (SELECT publisher FROM imported_book WHERE bookid = 21)
WHERE bookid = 14;

-- 질의49 book 테이블에서 도서번호가 11인 도서를 삭제하세요
DELETE FROM book
WHERE bookid = 11;
*/

-- 외래키 확인 조건 실습 부모 - newcustomer, 자식 -neworder
-- DELETE FROM neworder
-- WHERE custid = 1;

-- 자식  테이블(neworder)의 고객 아이디가 1인 튜플도 함께 사라짐 
DELETE FROM newcustomer
WHERE custid = 1;