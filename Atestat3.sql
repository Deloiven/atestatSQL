--Создам таблицу
drop table if exists `logs`;
create table `logs`(
create_at datetime DEFAULT NOW(), 
`table_name` varchar(45) NOT NULL, 
table_id INT UNSIGNED NOT NULL, 
name_value varchar(45)) engine=ARCHIVE;

--таблица users

USE `shop`;

DELIMITER $$

USE `shop`$$
DROP TRIGGER IF EXISTS `shop`.`users_AFTER_INSERT` $$
DELIMITER ;
DROP TRIGGER IF EXISTS `shop`.`creation_record _users`;

DELIMITER $$
USE `shop`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `creation_record _users` AFTER INSERT ON `users` FOR EACH ROW BEGIN
insert into shop.logs (create_at,`table_name`, table_id, name_value)
values (now(), 'shop.users', new.id, new.name);

END$$
DELIMITER ;

--таблица catalogs
DROP TRIGGER IF EXISTS `shop`.`creation_record_catalogs`;

DELIMITER $$
USE `shop`$$
CREATE DEFINER = CURRENT_USER TRIGGER `creation_record_catalogs` AFTER INSERT ON `catalogs` FOR EACH ROW
BEGIN
insert into shop.logs (create_at,`table_name`, table_id, name_value)
values (now(), 'shop.catalogs', new.id, new.name);


END$$
DELIMITER ;

--таблица products

DROP TRIGGER IF EXISTS `shop`.`creation_record_products`;

DELIMITER $$
USE `shop`$$
CREATE DEFINER = CURRENT_USER TRIGGER `creation_record_products` AFTER INSERT ON `products` FOR EACH ROW
BEGIN

insert into shop.logs (create_at,`table_name`, table_id, name_value)
values (now(), 'shop.products', new.id, new.name);
END$$
DELIMITER ;