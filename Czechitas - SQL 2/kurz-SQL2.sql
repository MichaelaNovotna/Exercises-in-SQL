----ŘETĚZOVÉ FUNKCE----

--spojování řetězců ||
SELECT product, product || "_" || category ProductCat FROM product;

--podřetězec SUBSTR
SELECT product, product || "_" || category ProductCat, SUBSTR(product, 1, 5) FROM product;

--pozice substringu (" ") INSTR
SELECT product, product || "_" || category ProductCat, SUBSTR(product, 1, 5), INSTR(product, " ") FROM product;
SELECT product, product || "_" || category ProductCat, SUBSTR(product, 1, INSTR(product, " ")-1) FROM product;

--UPPER a LOWER
SELECT product, product || "_" || category ProductCat, 
SUBSTR(product, 1, 5),
INSTR(product, " "),
SUBSTR(product, 1, INSTR(product, " ")-1),
LENGTH(product),
UPPER(product),
LOWER(product)
FROM product;


--DATUMOVÉ FUNKCE
SELECT date('now');
SELECT datetime('now');
SELECT time('now');

SELECT DATE(DATE) from Date;

--Chceme-li zjistit druhé úterý v říjnu aktuální roku
SELECT date('now','start of year','+9 months','+7 days','weekday 2');


---CASE
SELECT * FROM DATE;
SELECT DISTINCT monthno, monthname, 
	CASE monthNo 
    	WHEN 1 Then "Zima"
        WHEN 2 Then "Zima"
        WHEN 3 THEN "Jaro"
        WHEN 4 THEN "Jaro"
        WHEN 5 THEN "Jaro"
        WHEN 6 THEN "Léto"
        WHEN 7 THEN "Léto"
        WHEN 8 THEN "Léto"
        WHEN 9 THEN "Podzim"
        WHEN 10 THEN "Podzim"
        WHEN 11 THEN "Podzim"
        WHEN 12 THEN "Zima"
END AS "Roční období"
FROM DATE;
--nebo
SELECT DISTINCT monthNo, monthName, 
CASE 
   	WHEN monthNo IN (12, 1, 2) THEN 'Zima'
	WHEN monthNo IN (3, 4, 5) THEN 'Jaro'
	WHEN monthNo IN (6, 7, 8) THEN 'Léto'
    WHEN monthNo IN (9, 10, 11) THEN 'Podzim'
END AS 'Roční období'
FROM DATE;
