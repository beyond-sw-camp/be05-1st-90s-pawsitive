-- testcase 1
INSERT INTO	member (member_id, member_password, member_name, member_phone, member_birth, member_address, member_gender, member_email, member_grade)
VALUES		('US000031', '123456', '김마리', '010-2345-9876', '1992-12-31', '광주광역시 동구', 'F', 'mrkim@naver.com', '일반') ;

-- testcase 2
UPDATE	member
SET		member_password = '3673'
WHERE		member_name = '김마리' ;

UPDATE	member
SET		member_name = '김상철'
WHERE		member_name = '김마리' ;

UPDATE	member
SET		member_phone = '010-2323-9753'
WHERE		member_name = '김상철' ;

UPDATE	member
SET		member_address = '광주광역시 서구'
WHERE		member_name = '김상철' ;

UPDATE	member
SET		member_email = 'sckim@naver.com'
WHERE		member_name = '김상철' ;


-- testcase 3
SELECT	member_name,
			member_phone,
			member_birth,
			member_address,
			member_gender,
			member_email,
			member_grade
FROM		member ;


-- testcase 4
SELECT	order_id,
			order_recieve_name,
			order_recieve_address,
			order_recieve_phone_number,
			order_total_price,
			order_payment_method,
			order_cashreceipt_yn,
			order_date,
			order_zipcode,
			order_delivery_message,
			order_status
FROM		`order`
WHERE		member_id = 'US000007' ;

-- testcase 5
DELETE FROM	orderdetail
WHERE			order_id = (SELECT order_id
								FROM	`order`
								WHERE	member_id = 'US000005');

DELETE FROM `order` 
WHERE			member_id = 'US000005' ;

-- testcase 6
SELECT	product_name,
			product_image,
			product_sales_price
FROM		product ;

-- testcase 7
SELECT	category_name,
			product_name,
			product_image,
			product_detail,
			product_sales_price
FROM		product	p
JOIN		category c	ON (p.category_id = c.category_id)
order BY	p.category_id	;


-- testcase 8
SELECT	product_name,
			product_image,
			product_detail,
			product_sales_price
FROM		product			p
JOIN		orderdetail 	od	ON (p.product_id = od.product_id)
JOIN		`order`			o	ON (od.order_id = o.order_id)
GROUP BY	p.product_id
ORDER BY	order_total_amount DESC ;


-- testcase 9
SELECT	product_name,
			product_image,
			product_detail,
			product_sales_price
FROM		product		
order BY	category_id ;


-- testcase 10
SELECT	abandonedanimal_entrance_date,
			abandonedanimal_last_date,
			abandonedanimal_actual_name,
			abandonedanimal_animal_age,
			abandonedanimal_disease,
			abandonedanimal_neutering_yn
FROM		abandonedanimal ;


-- testcase 11
INSERT INTO adoptapplication (member_id, abandoned_id, adoptapplicaton_experience_yn, adoptapplicaton_another_yn, adoptapplicaton_family_member, adoptapplicaton_apply_date, adoptapplicaton_adopt_date)
VALUES		('US000004','AB00016', 'Y', 'N', 3, '2024-01-25', '2024-01-31') ;


-- testcase 12
UPDATE	adoptapplication
SET		adoptapplicaton_experience_yn = 'N',
			adoptapplicaton_another_yn = 'N',
			adoptapplicaton_family_member = 4,
			adoptapplicaton_apply_date = '2023-12-21',
			adoptapplicaton_adopt_date = '2024-01-24'
WHERE		member_id = 'US000003' ;


-- testcase 13
DELETE FROM	adoptapplication
WHERE			member_id = 'US000003' ;