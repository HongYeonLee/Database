SELECT *
FROM book;

SELECT bookname, price
FROM book;

SELECT price, bookname
FROM book;

SELECT publisher
FROM book;

SELECT DISTINCT publisher
FROM book;

SELECT *
FROM book
WHERE price < 20000;

SELECT *
FROM book
WHERE price BETWEEN 10000 AND 20000;

SELECT *
FROM book
WHERE price >= 20000
ORDER BY bookname ASC; /* 가나다순 정렬  */

SELECT *
FROM book
WHERE publisher IN ('굿스포츠', '대한미디어');

SELECT *
FROM book
WHERE publisher NOT IN ('굿스포츠', '대한미디어');

SELECT bookname, publisher
FROM book
WHERE bookname LIKE '축구의 역사';

SELECT *
FROM book
WHERE publisher LIKE '대____';

SELECT COUNT(DISTINCT (publisher))
FROM book;

SELECT COUNT(publisher)
FROM book;

SELECT COUNT(*)
FROM orders
WHERE custid=(
	SELECT custid
	FROM customer
	WHERE NAME="박지성"
);

SELECT orderid
FROM orders
WHERE orderdate BETWEEN '2024-07-04' AND '2024-07-07';


SELECT orderid
FROM orders
WHERE orderdate NOT IN ('2024-07-04' AND '2024-07-07'); 


-- 왼쪽 외부 조인
SELECT C.NAME, O.saleprice
FROM customer AS C
	LEFT JOIN orders AS O
	ON C.custid=O.custid
ORDER BY C.name, O.saleprice;
	
-- 내부조인
SELECT *
FROM customer C
JOIN orders O ON C.custid=O.custid
ORDER BY C.name, O.saleprice;	

-- 자연조인
SELECT *
FROM customer C
NATURAL JOIN orders O
ORDER BY C.name, O.saleprice;	
	
SELECT C.name, O.saleprice
FROM customer C
NATURAL JOIN orders O
ORDER BY C.name, O.saleprice;

-- 고객별 주문금액 총합
SELECT C.name, Sum(saleprice)
FROM customer C
NATURAL JOIN orders O
GROUP BY C.name;

-- 완전 외부조인
-- 주문한 적 없는 고객도 정보가 나옴 (왼쪽)
SELECT C.name, O.saleprice
FROM customer C
LEFT OUTER JOIN orders O
ON C.custid = O.custid

UNION

-- 고객 정보가 없는 주문도 나옴 (오른쪽)
SELECT C.name, O.saleprice
FROM customer C
RIGHT OUTER JOIN orders O
ON C.custid = O.custid;


-- 완전 외부조인 GROUP BY 이용
SELECT C.name, ROUND(AVG(O.saleprice)) AS '평균 금액'
FROM Customer C
LEFT OUTER JOIN Orders O
ON C.custid = O.custid
GROUP BY C.name

UNION

SELECT C.name, ROUND(AVG(O.saleprice)) AS '평균 금액'
FROM customer C
RIGHT OUTER JOIN orders O
ON C.custid = O.custid
GROUP BY C.name;