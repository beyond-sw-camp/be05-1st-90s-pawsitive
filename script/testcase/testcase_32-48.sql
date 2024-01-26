-- TEST 032 --
-- 회원 수 조회
SELECT COUNT(member_id) AS '회원 수'
FROM member

-- TEST 033 --
-- 회원 정보 조회
SELECT *
FROM member
WHERE member_id = 'US000007'

-- TEST 034 --
-- 회원 정보 수정 & 확인
UPDATE member
SET member_address = '남양주시 화도읍', member_grade = '가족'
WHERE member_id = 'US000031'

SELECT *
FROM member
WHERE member_id = 'US000031'


-- TEST 035 --
-- 회원 계정 삭제
DELETE FROM member
WHERE member_id = 'US000031'

-- TEST 036 --
-- 상품 조회 _ 상품ID, 카테고리ID, 상품명, 상품이미지, 판매가
SELECT product_id AS `상품 ID`,
		 category_id AS `카테고리 ID`,
		 product_name AS `상품이름`,
		 product_image AS `상품 이미지`,
		 product_sales_price AS `판매가`
FROM	 product

-- TEST 037 --
-- 상품 등록
INSERT INTO product
VALUES ('P0014', 'CA005', 'PE002', 
		  '왕자님 옷', 'https://dog-prince/image.jpg', 
		  '강아지 옷입니다. 왕자님 옷 사이즈 크고 중소형견에게 적합합니다.', 
		   19830, 19300, 'N', SYSDATE());
		   
SELECT *
FROM product

-- TEST 038 --
-- 상품 설명 수정
UPDATE product
SET product_detail = '엄청 잘 떨어지는 핏,왕 이쁜 왕자님 옷입니다. 사이즈 크고 중대형견에게 적합합니다.'
WHERE product_id = 'P0014'

SELECT *
FROM product
WHERE product_id = 'P0014'

-- TEST 039 --
-- 상품 이미지 수정
UPDATE product
SET product_image = 'https://starstar_dog-prince/image.jpg'
WHERE product_id = 'P0014'

SELECT *
FROM product
WHERE product_id = 'P0014'

-- TEST 040 --
-- 상품 가격 수정
UPDATE product
SET product_Sales_price =  15000
WHERE product_id = 'P0014'

-- TEST 041 --
-- 상품 정보삭제 N >> Y
UPDATE product
SET product_delete_yn =  'Y'
WHERE product_id = 'P0014'

-- TEST 042 --
-- 일별 주문 수량 조회
SELECT order_date AS `주문 날짜`,
       COUNT(order_id) AS `일별 주문 수량`
FROM `order`
GROUP BY order_date

-- TEST 043 --
-- 재구매 횟수가 많은 상품 순위 조회 >> 현재 데이터에 주문 일자마다 1개의 주문만 존재
SELECT COUNT(o.order_id),
		 o.order_date
FROM `order` o
GROUP BY order_date
order BY 2 ASC

-- TEST 044 --
-- 유기 동물 등록
INSERT INTO AbandonedAnimal
VALUES ('AB00032', 'PE002', SYSDATE(), 
        (SYSDATE() + INTERVAL 1 MONTH), 
		  '치이카와', '눈물이 많음', 'N', 7);
		  
SELECT *
FROM AbandonedAnimal


-- TEST 045 --
-- 등록 유기동물 삭제
DELETE FROM abandonedanimal
WHERE abandonedanimal_actual_name = '치이카와'

-- TEST 046 --
-- 당일 등록(신규 입소) 유기 동물 조회
SELECT abandonedanimal_actual_name,
		 abandonedanimal_entrance_date,
		 abandoned_id
FROM abandonedanimal
WHERE abandonedanimal_entrance_date = DATE(NOW())

-- TEST 047 --
-- 해당일 기준 입양 공고 기한이 얼마 남지 않은 순으로 조회
SELECT abandonedanimal_actual_name,
		 abandoned_id,
		 abandonedanimal_last_date
FROM abandonedanimal
order BY 3 ASC
-- 해당일 기준으로 하든, 제일 빠른날로 하든 같음.

-- TEST 048 --
-- 유기동물 상태 변경 
UPDATE abandonedanimal
SET abandonedanimal_actual_name = '하치와레',
    abandonedanimal_animal_age = 10,
	 abandonedanimal_disease = '너무 용감해서 질병이 없음',
	 abandonedanimal_neutering_yn = 'Y'
WHERE abandoned_id = 'AB00031'