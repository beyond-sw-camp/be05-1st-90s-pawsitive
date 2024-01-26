CREATE DATABASE pawsitive default CHARACTER SET UTF8; 

USE pawsitive;

CREATE TABLE Member (
	member_id			VARCHAR(10)	PRIMARY KEY,
	member_password	VARCHAR(20)	NOT NULL,
	member_name			VARCHAR(10)	NOT NULL,
	member_phone		VARCHAR(13)	NOT NULL,
	member_birth		DATE	NULL,
	member_address		VARCHAR(100)NOT NULL,
	member_gender		CHAR(1)		NOT NULL
			CHECK (member_gender IN ('M', 'F')),
	member_email		VARCHAR(20)	NOT NULL,
	member_grade		VARCHAR(3)	NOT NULL
			CHECK (member_grade IN ('일반', '친구', '가족', 'VIP'))
);

CREATE TABLE Pet (
	pet_id				VARCHAR(10)	PRIMARY KEY,
	pet_type				VARCHAR(10)	NOT NULL
);

CREATE TABLE Category (
	category_id			VARCHAR(10)	PRIMARY KEY,
	category_name		VARCHAR(20)	NOT NULL
);

CREATE TABLE Product (
	product_id					VARCHAR(10)	PRIMARY KEY,
	category_id					VARCHAR(10)	NOT NULL
			REFERENCES category (category_id),
	pet_id						VARCHAR(10)	NOT NULL
			REFERENCES pet (pet_id),
	product_name				VARCHAR(20)	NULL,
	product_image				VARCHAR(100)NULL,
	product_detail				VARCHAR(400)NOT NULL,
	product_price				INT(10)	NOT NULL DEFAULT 1000,
	product_sales_price		INT(10)	NOT NULL DEFAULT 1000,
	product_delete_yn			CHAR(1)	NOT NULL DEFAULT 'N',
	product_received_date	DATE	NOT NULL DEFAULT SYSDATE()
);

CREATE TABLE ProductDetail (
	product_id					VARCHAR(10)
			REFERENCES product (product_id),
	productdetail_stock		INT(7) NOT NULL DEFAULT 0,
	productdetail_expire_date	DATE	NOT NULL DEFAULT (SYSDATE() + INTERVAL 3 MONTH),
	productdetail_register_date	DATE	NOT NULL DEFAULT SYSDATE(),
	CONSTRAINT PRIMARY KEY(product_id)
);

CREATE TABLE `Order` (
	order_id				VARCHAR(10)	PRIMARY KEY,
	member_id			VARCHAR(10)	NOT NULL
			REFERENCES member (member_id),
	order_recieve_name		VARCHAR(10)	NOT NULL,
	order_recieve_address	VARCHAR(50)	NOT NULL,
	order_recieve_phone_number	INT(13)	NOT NULL,
	order_date	DATE	NOT NULL DEFAULT SYSDATE(),
	order_zipcode	INT(5)	NOT NULL,
	order_delivery_message	VARCHAR(100) NULL DEFAULT( "요청사항 없음" ),
	order_status	VARCHAR(10)	NULL
				CHECK (order_status IN ('주문확인', '발송대기', '배송중', '배송완료', '구매확정')),
	order_total_amount	INT(10)	NOT NULL DEFAULT 0,
	order_total_price		INT(7)	NOT NULL DEFAULT 0,
	order_cashreceipt_yn	CHAR(1)	NOT NULL DEFAULT 'N',
	order_payment_method	VARCHAR(20)	NOT NULL
				CHECK (order_payment_method IN('카드결제', '계좌이체', '무통장입금', '소액결제'))
);

CREATE TABLE Orderdetail (
	orderdetail_id	VARCHAR(10)	PRIMARY KEY,
	order_id	VARCHAR(10)	NOT NULL
			REFERENCES `order` (order_id),
	product_id	VARCHAR(10)	NOT NULL
			REFERENCES product (product_id)
);

CREATE TABLE AbandonedAnimal (
	abandoned_id	VARCHAR(10)	PRIMARY KEY,
	pet_id	VARCHAR(10)	NOT NULL
			REFERENCES pet (pet_id),
	abandonedanimal_entrance_date	DATE	NOT NULL DEFAULT SYSDATE(),
	abandonedanimal_last_date	DATE	NOT NULL DEFAULT((SYSDATE() + INTERVAL 1 MONTH)),
	abandonedanimal_actual_name	VARCHAR(10)	NOT NULL DEFAULT('알수없음'),
	abandonedanimal_disease	VARCHAR(100)	NOT NULL DEFAULT('질병없음'),
	abandonedanimal_neutering_yn	CHAR(1)	NOT NULL DEFAULT('N'),
	abandonedanimal_animal_age		INT(5)	NOT NULL DEFAULT 0
);

CREATE TABLE Adopt (
	adopt_id	VARCHAR(10)	PRIMARY KEY,
	abandoned_id	VARCHAR(10)	NOT NULL
			REFERENCES AbandonedAnimal (abandoned_id),
	adopt_date	DATE	NOT NULL	DEFAULT SYSDATE()
);

CREATE TABLE AdoptApplication (
	member_id	VARCHAR(10)
			REFERENCES member (member_id),
	abandoned_id	VARCHAR(10)	NOT NULL
			REFERENCES AbandonedAnimal (abandoned_id),
	adoptapplicaton_experience_yn	CHAR(1) NOT NULL DEFAULT 'N',
	adoptapplicaton_another_yn	CHAR(1) NOT NULL DEFAULT 'N',
	adoptapplicaton_family_member	INT(10) NOT NULL,
	adoptapplicaton_apply_date	DATE NOT NULL DEFAULT SYSDATE(),
	adoptapplicaton_adopt_date	DATE NOT NULL DEFAULT SYSDATE(),
	CONSTRAINT PRIMARY KEY(member_id, abandoned_id)
);


CREATE TABLE Basket (
	basket_id		VARCHAR(10)	PRIMARY KEY,
	member_id	VARCHAR(10)	NOT NULL
			REFERENCES member (member_id),
	product_id	VARCHAR(10)	NOT NULL
			REFERENCES product (product_id),
	basket_quantity	INT(7) NOT NULL DEFAULT 0
);

CREATE TABLE Wish (
	member_id	VARCHAR(10)	NOT NULL
			REFERENCES member (member_id),
	product_id	VARCHAR(10)	NOT NULL
			REFERENCES product (product_id),
	CONSTRAINT PRIMARY KEY (member_id, product_id)
);

CREATE TABLE Ask (
	ask_id		VARCHAR(10)	PRIMARY KEY,
	member_id	VARCHAR(10)	NOT NULL
			REFERENCES member (member_id),
	product_id	VARCHAR(10)	NOT NULL
			REFERENCES product (product_id),
	ask_title		VARCHAR(50)	NOT NULL,
	ask_date		DATE		NOT NULL DEFAULT SYSDATE(),
	ask_content	VARCHAR(500)	NOT NULL,
	ask_comments	VARCHAR(500)	NULL,
	ask_product_image	VARCHAR(100) NULL,
	ask_category	VARCHAR(20)	NOT NULL
			CHECK (ask_category IN('배송', '결제', '상품', '기타')),
	ask_content_hide_yn	CHAR(1)	NOT NULL DEFAULT 'N'
);

CREATE TABLE Review (
	review_id		VARCHAR(10)	PRIMARY KEY,
	product_id	VARCHAR(10)	NOT NULL
			REFERENCES product (product_id),
	member_id	VARCHAR(10)	NOT NULL
			REFERENCES member (member_id),
	review_title	VARCHAR(50)	NOT NULL,
	review_date	DATE	NOT NULL DEFAULT SYSDATE(),
	review_contents	VARCHAR(500) NOT NULL,
	review_comments	VARCHAR(500) NULL,
	review_point	INT(10)	NOT NULL DEFAULT 0,
	review_image	VARCHAR(100)	NULL
);

CREATE TABLE ADMIN (
	admin_id				VARCHAR(10)	PRIMARY KEY,
	admin_password		VARCHAR(20)	NOT NULL,
	admin_name			VARCHAR(10)	NOT NULL
);

CREATE TABLE benefitmember (
	member_id		VARCHAR(10)
			REFERENCES MEMBER (member_id),
	adopt_id		VARCHAR(10)
			REFERENCES Adopt (adopt_id),
	benefitmember_discount_date	DATE	NOT NULL,
	benefitmember_discount_rate	INT(3)	NULL DEFAULT 0,
	CONSTRAINT PRIMARY KEY(member_id, adopt_id)
);

ALTER TABLE member
ADD CONSTRAINT pk_member_id_format
CHECK (member_id REGEXP '^US[0-9]{6}$');

ALTER TABLE pet
ADD CONSTRAINT pk_pet_id_format
CHECK (pet_id REGEXP '^PE[0-9]{3}$');

ALTER TABLE category
ADD CONSTRAINT pk_category_id_format
CHECK (category_id REGEXP '^CA[0-9]{3}$');

ALTER TABLE product
ADD CONSTRAINT pk_product_id_format
CHECK (product_id REGEXP '^P[0-9]{4}$');

ALTER TABLE `order`
ADD CONSTRAINT pk_order_id_format
CHECK (order_id REGEXP '^O[0-9]{6}$');

ALTER TABLE orderdetail
ADD CONSTRAINT pk_orderdetail_id_format
CHECK (orderdetail_id REGEXP '^OD[0-9]{7}$');

ALTER TABLE abandonedanimal
ADD CONSTRAINT pk_abandoned_id_format
CHECK (abandoned_id REGEXP '^AB[0-9]{5}$');

ALTER TABLE adopt
ADD CONSTRAINT pk_adopt_id_format
CHECK (adopt_id REGEXP '^AD[0-9]{5}$');

ALTER TABLE basket
ADD CONSTRAINT pk_basket_id_format
CHECK (basket_id REGEXP '^B[0-9]{5}$');

ALTER TABLE ask
ADD CONSTRAINT pk_ask_id_format
CHECK (ask_id REGEXP '^AS[0-9]{5}$');

ALTER TABLE review
ADD CONSTRAINT pk_review_id_format
CHECK (review_id REGEXP '^R[0-9]{5}$');

ALTER TABLE admin
ADD CONSTRAINT pk_admin_id_format
CHECK (admin_id REGEXP '^ADM[0-9]{3}$');




