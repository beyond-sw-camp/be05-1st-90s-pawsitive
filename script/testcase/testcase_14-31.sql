-- test 014
INSERT INTO wish
VALUES ('US000006', 'P0013');

-- test 015
DELETE FROM wish
WHERE member_id = 'US000006';

-- test 016
SELECT *
FROM wish
WHERE member_id = 'US000004';

-- test 017
SELECT COUNT(w.product_id)
		,p.product_name
FROM wish w
JOIN product p ON (p.product_id = w.product_id)
GROUP BY w.product_id
ORDER BY 1 DESC;

-- test 018
WITH RankedWishes AS (
    SELECT
        c.category_id,
        c.category_name,
        p.product_id,
        p.product_name,
        COUNT(*) AS wish_count,
        ROW_NUMBER() OVER (PARTITION BY c.category_id ORDER BY COUNT(*) DESC) AS rank
    FROM
        wish w
        JOIN product p ON w.product_id = p.product_id
        JOIN category c ON p.category_id = c.category_id
    GROUP BY
        c.category_id, p.product_id
		)
		SELECT
		    category_name,
		    product_name,
		    wish_count
		FROM RankedWishes
		WHERE
			rank = 1
			order BY 3 DESC;

-- test 019
INSERT INTO ask
VALUES ('AS00008','US000006', 'P0006', '현금 영수증 발급', '2024-01-08', '현금 영수증 발급 가능할까요?', '가능합니다.', NULL, '배송', 'N');

-- test 020
UPDATE ask
SET ask_content = '현금 영수증 발급 가능 여부 알려주세요~'
WHERE member_id = 'US000006';

-- test 021
DELETE FROM ask
WHERE member_id = 'US000006';

-- test 022
INSERT INTO review
VALUES ('R00015', 'P0008', 'US000008','추천해요~', '2024-01-25','만족스러워요', '이용해주셔서 감사합니다!', '3', 'https://example.com/image15.jpg');

-- test 023
UPDATE review
SET review_title = '만족스러워요~'
WHERE review_id = 'R00015';

-- test 024
DELETE FROM review
WHERE review_id = 'R00015';

-- test 025
SELECT review_comments
FROM review
WHERE member_id = 'US000014';

-- TEST 026
INSERT INTO basket
VALUES ('B00016', 'US000016','P0001', '1');

-- test 027
SELECT *
FROM basket
WHERE member_id = 'US000016';

-- test 028
UPDATE basket
SET product_id = 'P0002'
WHERE member_id = 'US000016';

-- test 029
DELETE FROM basket
WHERE member_id = 'US000016';

-- test 030
SELECT p.product_name
		,p.product_sales_price
		,b.basket_quantity
		,P.product_sales_price*b.basket_quantity
FROM basket b
JOIN product p USING (product_id)
WHERE member_id = 'US000014';

-- test 031
SELECT b.basket_id
		,b.product_id
		,p.product_name
		,b.basket_quantity
FROM basket b
JOIN product p USING (product_id);
