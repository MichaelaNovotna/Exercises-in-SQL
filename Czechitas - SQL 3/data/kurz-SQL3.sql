/*SAMOSTATNÁ PRÁCE 1: OPAKOVÁNÍ*/
USE sales;

-- Vytvořte novou tabulku topsales založenou na tabulce sales, která bude obsahovat: ProductID, ZIP a Revenue (datové typy budou stejné jako v tabulce sales)
	SHOW COLUMNS FROM sales; -- zjistím si datové typy
	CREATE TABLE topsales (ProductID int, ZIP int, Revenue double); -- vytvořím
	SELECT * FROM topsales LIMIT 5; -- je prázdná

-- Vložte do ní takové prodeje, kdy Revenue daného prodeje bylo > 15 000.
	INSERT INTO topsales SELECT ProductID, ZIP, Revenue FROM sales WHERE Revenue > 15000;
	-- nebo?
	INSERT INTO topsales (ProductID, ZIP, Revenue) (SELECT ProductID, ZIP, Revenue FROM sales WHERE Revenue > 15000); 

-- V řádcích pro Los Angeles (zip = 90013) vynásobte navíc 2.
	UPDATE topsales SET Revenue = Revenue * 2 WHERE ZIP = 90013;

-- Vše z tabulky smažte.
	DELETE FROM topsales;
	-- nebo
	TRUNCATE topsales;

-- Smažte tabulku topsales.
	DROP TABLE topsales;


-- TRANSAKCE
START TRANSACTION;
	INSERT INTO topsales SELECT productID, zip, revenue FROM sales WHERE revenue > 15000 ORDER BY revenue DESC;
	SELECT * FROM topsales LIMIT 10;
ROLLBACK;

-- WINDOW FUNKCE	
SELECT 
	productID, 
    date, 
    ROW_NUMBER(/*nepotřebujeme zde vstup*/) OVER (PARTITION BY productID ORDER BY date) 
FROM sales
ORDER BY productID, date;

SELECT 
	productID, 
    date, 
    ROW_NUMBER() OVER (PARTITION BY productID, date /*kombinace productID v daném datu*/
    ORDER BY date) 
FROM sales
ORDER BY productID, date;

SELECT productID, COUNT(*) FROM sales GROUP BY productID;

SELECT productID, date, 
	ROW_NUMBER() OVER (PARTITION BY productID ORDER BY date),
	COUNT(*) OVER (),
	COUNT(*) OVER (PARTITION BY productID),
	COUNT(*) OVER (PARTITION BY productID, date)
FROM sales
ORDER BY  productID, date;


/*SAMOSTATNÁ PRÁCE 2*/
-- vytvořte pořadí prodeje produktu v daném roce (jak se daný produkt v daném roce postupně prodával)
SELECT s.ProductID, s.Date, d.Year, ROW_NUMBER() OVER (PARTITION BY s.productID, d.Year ORDER BY s.date)
	FROM sales s JOIN date d on d.Date = s.Date;
SELECT sales.productID , sales.date, date.year, ROW_NUMBER() over (partition by sales.productID, date.year order by date)
	FROM sales INNER JOIN date ON sales.date = date.date ORDER BY sales.productID, sales.date;


-- Další window funkce
SELECT
    productID, date, zip, 
    ROW_NUMBER()  OVER (PARTITION BY productID ORDER BY date) as sale_no,
    LAG(date)  OVER (PARTITION BY productID ORDER BY date) as prev_sale,
    LEAD(date)  OVER (PARTITION BY productID ORDER BY date) as next_sale,
    FIRST_VALUE(date) OVER (PARTITION BY productID ORDER BY date) as first_sale,
    LAST_VALUE(date)  OVER (PARTITION BY productID ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_sale
FROM sales
ORDER BY  productID, date, zip;

-- průměrné tržby za 4 týdny zpětně
SELECT 
    calc.year, calc.week, calc.revenue, 
    avg(revenue) over (order by week rows 4 preceding) as avg_4w
	FROM ( SELECT YEAR(date) as year, WEEK(date) as week,
    SUM(revenue) as revenue
        FROM sales GROUP BY YEAR(date), WEEK(date) ) as calc
ORDER BY year, week;


-- PROMĚNNÉ
/*vytvoření*/ SET @nazev_promenne = 1;
/*použití*/ SELECT @nazev_promenne;

	-- aktuální datum
	SET @aktualni_datum = CURRENT_DATE();
	SELECT @aktualni_datum;

	-- filtr produktů
	SET @v_productID = 2;
	SELECT * FROM product WHERE productID = @v_productID;

	-- Proměnná = select
	SET @v_mesic = (SELECT month(date) FROM sales GROUP BY month(date) ORDER BY SUM(revenue) DESC LIMIT 1);
	SELECT @v_mesic;


SET @datum1 = cast('2013-06-01' as date);
SET @datum2 = date_add(@datum1, INTERVAL 12 MONTH); -- definice proměnné na základě jiné proměnné
SET @productID = 1;
SET @zip = '90013';

SELECT * FROM sales
WHERE 
    date BETWEEN @datum1 and @datum2
    and productID = @productID
    and zip <> @zip;

/*Samostatná práce 3*/
-- Vyberte náhodně jeden produkt a pomocí proměnných vypište všechny prodeje, které nastaly během 3 měsíců od jeho prvního prodeje.
SET @random_product = 183;
SELECT * FROM sales WHERE productID = 183;
SET @datum3 = (SELECT MIN(date) FROM sales WHERE productID = @random_product);
SET @datum4 = date_add(@datum3, INTERVAL 3 MONTH);
SELECT * FROM sales 
	WHERE
    date BETWEEN @datum3 and @datum4
    and productID = @random_product
    ORDER BY date;
    
    
-- VLASTNÍ FUNKCE
DELIMITER //
CREATE FUNCTION to_pounds (kilos NUMERIC(16,8))
RETURNS NUMERIC(16,8)
DETERMINISTIC
BEGIN 
	DECLARE pounds NUMERIC(16,8);
	SET pounds = kilos*2.20462;
    RETURN pounds;
END //
DELIMITER ;

SELECT to_pounds(18);

-- Převody měn
DELIMITER //
CREATE FUNCTION to_czk (currency varchar(3), value NUMERIC(16,8))
RETURNS NUMERIC(16,8)
DETERMINISTIC
BEGIN 
	DECLARE amount NUMERIC(16,8);
    SET amount = NULL;
    IF (currency = "USD") THEN SET amount = value * 23.18; -- zjednodušeně
    ELSEIF (currency = "EUR") THEN SET amount = value * 24.6;
    ELSE SET amount = NULL;
    END IF;
    RETURN amount;
    
END //
DELIMITER ;

SELECT to_czk("USD", 1);
SELECT to_czk("EUR", 1);

-- funkce, která napíše datum prvního a poslendího dne v týdnu
DELIMITER //
CREATE FUNCTION EOWEEK (YEAR int, WEEK int)
RETURNS datetime
DETERMINISTIC
BEGIN
	DECLARE EOWEEK datetime;
    
    SET EOWEEK = DATE_ADD(SOWEEK(YEAR,WEEK), INTERVAL 6 DAY);
    
    RETURN EOWEEK;

END //
DELIMITER ;

-- poslední
DELIMITER //
CREATE FUNCTION EOWEEK (YEAR int, WEEK int)
RETURNS datetime
DETERMINISTIC
BEGIN
	DECLARE EOWEEK datetime;
    
    SET EOWEEK = DATE_ADD(SOWEEK(YEAR,WEEK), INTERVAL 6 DAY);
    
    RETURN EOWEEK;

END //
DELIMITER ;


/*Samostatná práce*/
-- Kolik roků uběhlo od prodeje? Vytvořte funkci, která vrátí rozdíl mezi dnešním dnem a dnem prodeje (sales.date) v letech.
SELECT CURRENT_DATE();

DROP FUNCTION spocitej;

DELIMITER //
CREATE FUNCTION spocitej (datum_prodeje date)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE pocet_let INT;
    DECLARE aktualni_datum date;
    SET aktualni_datum = CURRENT_DATE();
    SET pocet_let = YEAR(aktualni_datum) - YEAR(datum_prodeje);
    RETURN pocet_let;
END //
DELIMITER ;

SELECT spocitej('2013-05-06');


-- PROCEDURY
DELIMITER //
CREATE PROCEDURE all_products()
BEGIN
	SELECT * FROM product;
END //
DELIMITER ;

CALL all_products;

-- se vstupní proměnnou
DELIMITER //
CREATE PROCEDURE one_product(v_product_id int)
BEGIN
	SELECT * FROM product WHERE product.productID = v_product_ID;
END //
DELIMITER ;

CALL one_product(3);


-- CYKLY
DELIMITER //
CREATE PROCEDURE fcl(cycles INT)
BEGIN
	DECLARE counter int;
    SET counter  = 0;
cyklus: WHILE counter < cycles 
			DO
				SELECT 'Tohle je cyklus číslo ', counter ;
				SET counter = counter +1 ;
END WHILE cyklus;
END //
DELIMITER ;

CALL fcl(5);

