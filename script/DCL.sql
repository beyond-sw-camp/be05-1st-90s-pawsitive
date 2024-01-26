CREATE USER 'ADMIN'@'localhost' IDENTIFIED BY 'admin_pawsitive';

GRANT ALL PRIVILEGES ON *.* TO 'ADMIN'@'localhost';
FLUSH PRIVILEGES;

CREATE USER 'MEMBER'@'%' IDENTIFIED BY 'member_password';

GRANT UPDATE ON 									pawsitive.Member 				TO 'MEMBER'@'%';
GRANT SELECT ON 									pawsitive.benefitmember 	TO 'MEMBER'@'%';
GRANT INSERT, UPDATE, DELETE ON 				pawsitive.Ask 					TO 'MEMBER'@'%';
GRANT INSERT, UPDATE, DELETE ON 				pawsitive.Review 				TO 'MEMBER'@'%';
GRANT SELECT ON 									pawsitive.Wish 				TO 'MEMBER'@'%';
GRANT SELECT ON 									pawsitive.Basket				TO 'MEMBER'@'%';
GRANT SELECT ON 									pawsitive.Product 			TO 'MEMBER'@'%';
GRANT SELECT ON 									pawsitive.Category 			TO 'MEMBER'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON 	pawsitive.Order 				TO 'MEMBER'@'%';
GRANT SELECT ON 									pawsitive.AbandonedAnimal 	TO 'MEMBER'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON 	pawsitive.AdoptApplication TO 'MEMBER'@'%';
FLUSH PRIVILEGES;