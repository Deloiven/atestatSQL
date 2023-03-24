--Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 
--функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
DROP FUNCTION IF EXISTS get_ver;
delimiter //
CREATE FUNCTION get_ver()
    RETURNS TEXT DETERMINISTIC
BEGIN
    set @time = '12:00:00';
        IF(@time >= '06:00:00' AND @time < '12:00:00') THEN
            return 'Доброе утро';
        ELSEIF(@time >= '12:00:00' AND @time < '18:00:00') THEN
            return 'Добрый день';
        ELSEIF(@time >= '18:00:01' AND @time < '23:59:59') THEN
            return 'Добрый вечер';
        ELSE
            return 'Доброй ночи';
        END IF;
end //
delimiter ;
SELECT get_ver();