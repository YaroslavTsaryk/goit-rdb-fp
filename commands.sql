create schema pandemic;

use pandemic;

-- p2

ALTER TABLE `pandemic`.`infectious_cases` 
ADD COLUMN `id` INT NOT NULL AUTO_INCREMENT AFTER `entity_id`,
ADD PRIMARY KEY (`id`);
;

CREATE TABLE `pandemic`.`entities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Entity` VARCHAR(45) NULL,
  `Code` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `Code_IDX` (`Code` ASC) VISIBLE);

insert into entities (Entity,Code) select distinct Entity, Code from infectious_cases;

ALTER TABLE pandemic.infectious_cases ADD entity_id INT NULL;

ALTER TABLE `pandemic`.`infectious_cases` 
ADD CONSTRAINT `entity_id`
  FOREIGN KEY (`id`)
  REFERENCES `pandemic`.`entities` ()
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `pandemic`.`infectious_cases` 
ADD COLUMN `id` INT NOT NULL AUTO_INCREMENT AFTER `entity_id`,
ADD PRIMARY KEY (`id`);

update infectious_cases ic set entity_id = (select id from entities e where e.Entity=ic.Entity) where entity_id is null;

ALTER TABLE `pandemic`.`infectious_cases` 
DROP COLUMN `Code`,
DROP COLUMN `Entity`;

--p3

select id, avg(Number_rabies) n_avg, min(Number_rabies) n_min, 
max(Number_rabies) n_max, sum(Number_rabies) n_sum 
from infectious_cases
where Number_rabies is not null
group by id
order by n_avg
limit 10;

--p4

ALTER TABLE `pandemic`.`infectious_cases` 
ADD COLUMN `orig_year` DATE NULL DEFAULT NULL;


update infectious_cases
set orig_year = cast(concat(cast(year as char(4)),'-01-01') as date);

ALTER TABLE `pandemic`.`infectious_cases` 
ADD COLUMN `current` DATE NULL DEFAULT NULL AFTER `orig_year`;

update infectious_cases
set current = now();

ALTER TABLE `pandemic`.`infectious_cases` 
ADD COLUMN `ddiff` INT NULL DEFAULT NULL AFTER `current`;

update infectious_cases
set ddiff = TIMESTAMPDIFF(year, orig_year, current);

--p5

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

select f_ddiff(1955);

select ddiff, f_ddiff(year) from infectious_cases;
