#0401 수업시간 실습

#질의4-1
SELECT ABS(-78), ABS(+78);

#질의 4-2
SELECT ROUND(4.875, 1);
SELECT ROUND(4.875, 2);

SET @VALUE := 1.789;

SELECT ROUND(@VALUE, 0); -- -2가 됨 
SELECT ROUND(@VALUE, 1);
SELECT ROUND(@VALUE, 2), ROUND(@VALUE, 3), ROUND(@VALUE, 4), ROUND(@VALUE, 5);

SELECT custid '고객번호', ROUND(SUM(saleprice)/COUNT(*), -2) '평균금액'
FROM orders
GROUP BY custid;

SET @VALUE := 123456;
SELECT ROUND(@VALUE, -1), ROUND(@VALUE, -2), ROUND(@VALUE, -3);

-- 이름 가리기 실습
SELECT
	CONCAT(
		LEFT(NAME, 1), '*', RIGHT(NAME, 1)
	) AS masked_name
FROM customer
WHERE CHAR_LENGTH(name) = 3;

-- 중간 글자 수 만큼 '*'붙이기
SET @NAME := "다니엘헤니";
SELECT CONCAT(LEFT(@NAME, 1), REPEAT('*', CHAR_LENGTH(@NAME) -2), RIGHT(@NAME, 1)) AS masked_name;

SELECT
	CASE
		WHEN CHAR_LENGTH(NAME) = 2
			THEN


-- NOW()의 결과값은 같고 SYSMSDATE()는 결과값 다름
SELECT NOW(), SLEEP(5), NOW(), 
			SYSDATE(), SLEEP(5), SYSDATE();


SELECT ADDDATE('2024-07-01', INTERVAL -5 DAY);

SELECT DATE_FORMAT(NOW(),'%j') '오늘은 몇번 째 날이게';

SELECT orderid '주문번호', DATE_FORMAT(orderdate, '%Y-%m-%d') '주문일', custid '고객번호', bookid '도서번호'
FROM orders
WHERE orderdate = STR_TO_DATE('20240707', '%Y%m%d');

SELECT price + 100
FROM book
WHERE bookid=15;

SELECT bookname,
	CASE
		WHEN price > 20000 THEN '고가'
		WHEN price BETWEEN 10000 AND 20000 THEN '중간'
		ELSE '저가'
	END AS price_category
FROM book;

SELECT
	SUM(CASE WHEN YEAR(orderdate) = 2024 THEN saleprice ELSE 0 END) AS '2024년 매출',
	SUM(CASE WHEN YEAR(orderdate) = 2026 THEN saleprice ELSE 0 END) AS '2026년 매출'
FROM orders;

SELECT
	MONTH(orderdate) AS MONTH,
	SUM(CASE WHEN saleprice >= 20000 THEN saleprice ELSE 0 END) AS high_sales,
	SUM(CASE WHEN saleprice BETWEEN 10000 AND 19999 THEN saleprice ELSE 0 END) AS mid_sales,
	SUM(CASE WHEN saleprice < 10000 THEN saleprice ELSE 0 END) AS low_sales
FROM orders
GROUP BY MONTH(orderdate)
ORDER BY MONTH;

SELECT custid, (SELECT NAME
					 FROM customer cs
					 WHERE cs.custid = od.custid), SUM(saleprice)
FROM orders od
GROUP BY custid;

#join 방식
SELECT od.custid, cs.name, SUM(od.saleprice) AS total_sales
FROM orders od JOIN customer cs ON od.custid = cs.custid
GROUP BY od.custid, cs.name
ORDER BY total_sales DESC;

#질의 4-17 마당서점의 고객별 판매액을 나타내시오 (고객이름과 고객별 판매액 출력)
SELECT (SELECT NAME FROM customer cs WHERE cs.custid=od.custid) 'name', SUM(saleprice) 'total'
FROM orders od
GROUP BY od.custid;

#5 (1) 주문한 적 있는 고객의 고객 아이디, 주소, 고객의 총 주문액 
SELECT custid, (SELECT address FROM customer cs WHERE cs.custid = od.custid) 'address', SUM(saleprice) 'total'
FROM orders od
GROUP BY od.custid;

#5 (2) 주문한 적 있는 고객의 이름과  평균 주문 금액
SELECT cs.name, s
FROM (SELECT custid, AVG(saleprice) s FROM orders GROUP BY custid) od, customer cs
WHERE cs.custid = od.custid;

#5 (3) 고객번호가 3이하인 주문한 적 있는 고객들의 총 주문액
SELECT SUM(saleprice) 'total'
FROM orders od
WHERE EXISTS (SELECT * FROM customer cs WHERE custid <= 3 AND cs.custid = od.custid);

#질의 4-17 마당서점의 고객별 판매액을 나타내시오 (고객이름과 고객별 판매액 출력)
SELECT (SELECT NAME FROM customer cs WHERE cs.custid=od.custid) 'name', SUM(saleprice) 'total'
FROM orders od
GROUP BY od.custid;