-- 03.19 문제 실습
-- 질의1 모든 도서의 이름과 가격을 검색
SELECT bookname, price FROM book;
SELECT price, bookname FROM book;

-- 질의2 모든 도서의 도서번호, 도서이름, 출판사, 가격 검색 
SELECT bookid, bookname, publisher, price FROM book;
SELECT * FROM book;

-- 질의3 도서 테이블에 있는 모든 출판사 검색
SELECT publisher FROM book;
SELECT DISTINCT publisher FROM book;

-- 질의4 가격이 20000원 미만인 도서를 검색하세요
SELECT * FROM book WHERE price < 20000;

-- 질의5 가격이 10000원 이상 20000원 이하인 도서를 검색하세요
SELECT * FROM book WHERE price BETWEEN 10000 AND 20000;
SELECT * FROM book WHERE price >= 10000 AND price <= 20000;

-- 질의6 출판사가 굿스포츠 혹은 대한미디어인 도서를 검색하세요
SELECT * FROM book WHERE publisher = '굿스포츠' OR publisher = '대한미디어';
SELECT * FROM book WHERE publisher IN ('굿스포츠', '대한미디어');

-- 질의7 출판사가 굿스포츠 혹은 대한미디어가 아닌 도서를 검색하세요
SELECT * FROM book WHERE publisher NOT IN ('굿스포츠', '대한미디어');

-- 질의8 축구의 역사를 출간한 출판사를 검색하세요
SELECT bookname, publisher FROM book WHERE bookname = '축구의 역사';

-- 질의9 도서이름에 '축구'가 포함된 출판사륵 검색하세요
SELECT bookname, publisher FROM book WHERE bookname LIKE '%축구%';

-- 문제 축구, 야구, 배구 처럼 도서이름의 왼쪽 두번째 위치에 구가 들어가는 도서를 검색하려면?
SELECT * FROM book WHERE bookname LIKE '_구%'; 

-- 질의11 축구에 관한 도서 중 가격이 20000원 이상인 도서를 검색하시오
SELECT * FROM book WHERE bookname LIKE '%축구%' AND price >= 20000;

-- 질의12 출판사가 굿스포츠 혹은 대한미디어인 도서를 검색하시오
SELECT * FROM book WHERE publisher IN ('굿스포츠', '대한미디어');

-- 질의13 출판사가 대로 시작하는 5자리이름을 가진 도서 정보 검색하기
SELECT * FROM book WHERE publisher LIKE '대____';

-- 질의14 도서를 이름순으로 검색하세요
SELECT * FROM book ORDER BY bookname;

-- 질의15 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하세요
SELECT * FROM book ORDER BY price, bookname;

-- 질의16 도서를 가격순으로 내림차순으로 검색하되, 가격이 같으면 출판사를 오름차순으로 출력하세요.
SELECT * FROM book ORDER BY price DESC, publisher;

-- 질의16 고객이 주문한 도서의 총판매액을 구하세요.
SELECT SUM(saleprice) AS 총판매액 FROM orders;

-- 질의17 custid가 2번인 고객이 주문한 도서의 총판매액을 구하고 이름을 총매출로 변경하세요
SELECT SUM(saleprice) AS 총매출 FROM orders WHERE custid = 2;

-- 질의18 고객이 주문한 도서의 총판매액, 평균값, 최저가, 최고가를 구하세요
SELECT SUM(saleprice) AS 총판매액,
		AVG(saleprice) AS 평균값,
		MIN(saleprice) AS 최저가,
		MAX(saleprice) AS 최고가
FROM orders;

-- 질의19 마당서점의 도서 판매건수를 구하세요
SELECT COUNT(*)
FROM orders;

-- 질의20 고객 별로 주문한 도서의 총수량과 총판매액을 구하세요. 속성이름은 도서 수량과 총액을 사용하세요.
SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS 총액
FROM orders
GROUP BY custid;

-- 질의21 가격이 8000원 이상인 도서를 구매한 고객에 대해서, 고객별 주문도서의 총수량을 구하세요. 단 2권 이상 구매한 고객에 대해서만 구하세요
SELECT custid, COUNT(*) AS 주문도서
FROM orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING COUNT(*) >= 2;

-- 도서번호가 1인 도서의 이름
SELECT bookname
FROM book
WHERE bookid = 1;

-- 가격이 20000원 이상인 도서의 이름
SELECT bookname
FROM book
WHERE price >= 20000;

-- 박지성의 총 구매액
SELECT SUM(saleprice)
FROM orders
WHERE custid = (SELECT custid FROM customer WHERE NAME = '박지성');

-- 박지성이 구매한 도서의 수
SELECT COUNT(*)
FROM orders
WHERE custid = (SELECT custid FROM customer WHERE NAME = '박지성');

-- 박지성이 구매한 도서의 출판사 수
SELECT COUNT(DISTINCT publisher)
FROM book
WHERE bookid IN (SELECT bookid FROM orders WHERE custid =
					(SELECT custid FROM customer WHERE NAME = '박지성'));
-- 서브쿼리가 여러 행을 리턴할시 IN을 사용해야한다. DISTINCT는 집계함수 앞이 아니라 속성 앞에 사용한다

-- 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
SELECT bookname, price, price-saleprice AS 가격차이
FROM orders JOIN book ON orders.bookid = book.bookid
WHERE custid = (SELECT custid FROM customer WHERE NAME = '박지성');

-- 박지성이 구매하지 않은 도서의 이름
SELECT DISTINCT bookname
FROM book JOIN orders ON book.bookid = orders.bookid
WHERE custid <> (SELECT custid FROM customer WHERE NAME = '박지성');

-- 마당서점 도서의 총 개수
SELECT COUNT(*)
FROM book;

-- 마당서점에 도서를 출고하는 출판사의 총 개수
SELECT COUNT(DISTINCT publisher)
FROM book;

-- 모든 고객의 이름, 주소
SELECT NAME, address
FROM customer;

-- 2024년 7월 4일 ~ 7월 7일 사이에 주문받은 도서의 주문번호
-- Date는 '로 감싸기
SELECT orderid
FROM orders
WHERE orderdate BETWEEN '2024-07-04' AND '2024-07-07';

-- 2024년 7월 4일 ~ 7월 7일 사이에 주문받은 도서를 제외한 도서의 주문번호
SELECT orderid
FROM orders
WHERE orderdate NOT BETWEEN '2024-07-04' AND '2024-07-07';

-- 성이 김씨인 고객의 이름과 주소
SELECT NAME, address
FROM customer
WHERE NAME LIKE '김%';

-- 성이 김씨이고 이름이 아로 끝나는 고객의 이름과 주소
SELECT NAME, address
FROM customer
WHERE NAME LIKE '김%아';

-- 주문하지 않은 고객의 이름
-- NOT IN 을 사용하면 부속질의에서 테이블에 NULL값이 있을 경우 
-- NOT IN NULL도 포함되기에 결과가 나오지 않는다 -> NOT EXISTS 이용, 서브쿼리를 만족하지 않는 행을 선택함

SELECT NAME
FROM customer
WHERE NOT EXISTS (SELECT custid FROM orders WHERE customer.custid = orders.custid);

-- 주문 금액의 총액과 주문의 평균 금액
SELECT SUM(saleprice), AVG(saleprice)
FROM orders;

-- 고객의 이름과 고객별 구매액
SELECT customer.name, SUM(orders.saleprice)
FROM customer JOIN orders ON customer.custid = orders.custid
GROUP BY customer.name;

-- 고객의 이름과 고객이 구매한 도서 목록
SELECT customer.name, book.bookname
FROM book JOIN (customer JOIN orders ON customer.custid = orders.custid) 
			ON book.bookid = orders.bookid;

-- 고객 이름을 모르는 주문 도서도 나옴
SELECT customer.name,
	book.bookname
FROM orders
	LEFT JOIN customer ON orders.custid = customer.custid
	LEFT JOIN book ON orders.bookid = book.bookid;
	
-- 도서의 가격(book 테이블)과 판매가격(orders 테이블)의 차이가 가장 많은 주문
SELECT *
FROM book JOIN orders ON book.bookid = orders.bookid
WHERE price - saleprice = (SELECT MAX(price-saleprice) 
									FROM book JOIN orders ON book.bookid = orders.bookid);


-- 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
SELECT customer.name, AVG(saleprice)
FROM customer JOIN orders ON customer.custid = orders.custid
GROUP BY customer.name
HAVING AVG(saleprice)  > (SELECT AVG(saleprice) FROM orders);

SELECT customer.name, AVG(saleprice)
FROM customer JOIN orders ON customer.custid = orders.custid
GROUP BY customer.custid;

