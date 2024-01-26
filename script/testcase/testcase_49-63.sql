-- Test-049
SELECT	n.abandonedanimal_actual_name,
			i.abandoned_id
FROM		abandonedanimal		n
JOIN		adopt	i ON (n.abandoned_id = i.abandoned_id) ;


-- Test-050

SELECT	pet_type ,
			COUNT(pet_id) '종별 입양 완료 수'
FROM		pet
GROUP BY	pet_type;


-- Test-051

SELECT	*
FROM		wish ;

SELECT	*
FROM		product ;

SELECT		m.member_name '성함' ,
				c.category_name '카테고리명' ,
				p.product_name '물품명' ,
				COUNT(w.product_id) '찜 개수'
FROM			wish			w
JOIN			product		p	ON (w.product_id = p.product_id)
JOIN			member		m	ON (w.member_id = m.member_id)
JOIN			category		c	ON	(p.category_id = c.category_id)
WHERE			w.member_id = 'US000002'
GROUP BY		c.category_name
order BY		4 ASC;


-- Test-052

UPDATE	ask
SET		ask_content_hide_yn = 'Y'
WHERE		product_id = 'P0003'

UPDATE	ask
SET		ask_comments = '착용 가능합니다.'
WHERE		product_id = 'P0008' ;


SELECT	*
FROM		ask;


-- Test-053

DELETE	FROM	ask
WHERE		member_id = 'US000013' 
AND		ask_id = 'AS00007' ;

SELECT	*
FROM		ask ;


-- Test-054

SELECT	*
FROM		ask ;


-- Test-055
SELECT	*
FROM		ask ;

SELECT	ask_category '카테고리' ,
			COUNT(ask_category) '질문개수'
FROM		ask 
GROUP BY	ask_category;


-- Test-056

SELECT	*
FROM		review ;


-- Test-057

UPDATE	review
SET		review_comments = '이용해주셔서 감사합니다!' ;

UPDATE	review
SET		review_point = '5'
WHERE		review_id = 'R00008' ;

SELECT	*
FROM		review ;


-- Test-058

DELETE	FROM	review
WHERE		review_id = 'R00012';

SELECT	*
FROM		review ;


-- Test-059  

SELECT	*
FROM		review ;

UPDATE	review
SET		review_comments = '다음에 또 방문해 주세요!'
WHERE		review_id = 'R00009' ;


-- Test-060
SELECT	*
FROM		benefitmember;

UPDATE	benefitmember
SET		benefitmember_discount_rate = '10'
WHERE		member_id = 'US000004' ;


-- Test-061

SELECT	*
FROM		benefitmember;

UPDATE	benefitmember
SET		benefitmember_discount_date = benefitmember_discount_date + INTERVAL 6 MONTH
WHERE		member_id = 'US000002' ;


-- Test-062

SELECT	*
FROM		adoptapplication ;


-- Test-063

SELECT	id.abandoned_id,
			an.abandonedanimal_actual_name '동물 이름' ,
			COUNT(adoptapplication_apply_date) '입양신청서 제출 현황'
FROM		adoptapplication	id
JOIN		abandonedanimal	an ON (an.abandoned_id = id.abandoned_id) 
WHERE		adoptapplication_apply_date is NOT NULL 
GROUP BY	an.abandonedanimal_actual_name
order BY	3 asc;



















