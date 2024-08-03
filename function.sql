DROP FUNCTION IF EXISTS f_ddiff;

DELIMITER //

CREATE FUNCTION f_ddiff(date1 int)
RETURNS int
DETERMINISTIC 
NO SQL
BEGIN
    DECLARE result FLOAT;
    set @orig_year = cast(concat(cast(date1 as char(4)),'-01-01') as date);
    set @ddiff = TIMESTAMPDIFF(year, @orig_year, now());
    
    
    RETURN @ddiff;
END //

DELIMITER ;