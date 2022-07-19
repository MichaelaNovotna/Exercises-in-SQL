--můj první select
SELECT zip, city FROM country;
SELECT zip/*, city*/ FROM country;
-- * vybrat vše
SELECT * FROM country;
SELECT * FROM manufacturer;
SELECT * FROM sales;
SELECT * FROM product;
-- AS přejmenovat
SELECT zip AS PSC FROM country;
SELECT zip PSC FROM country;
SELECT zip "PSČ" FROM country;
SELECT zip AS "PSČ" FROM country;
SELECT zip PSČ FROM country;
-- AS a více sloupců
SELECT zip AS PSC, country AS stat FROM country;
SELECT zip PSC, country stat FROM country;
-- DISTINCT vybere pouze jedinečné záznamy
SELECT DISTINCT state FROM country;
SELECT DISTINCT region, state FROM country;
--spočítat řádky
SELECT COUNT(*) FROM (SELECT DISTINCT region, state FROM country);
-- LIMIT konkrétní počet záznamů
SELECT * FROM country LIMIT 5;
-- WHERE filtrování dotazů
SELECT * FROM sales WHERE ProductID = 1;
SELECT * FROM country WHERE region = "East"; /*je to řetězec*/
SELECT * FROM country WHERE region = "East" OR region = "east";
SELECT * FROM country WHERE UPPER(region) = "EAST";
-- ORDER BY řazení
SELECT * FROM country ORDER BY city; /*automaticky ASC - vzestupně)*/
SELECT * FROM country ORDER BY city DESC;
SELECT * FROM country ORDER BY city DESC LIMIT 5;
SELECT * FROM country ORDER BY state DESC, city DESC LIMIT 5;
SELECT state, city, country FROM country ORDER BY 1 DESC, 2 DESC;

-- AGREGAČNÍ FUNKCE
SELECT productid, SUM(revenue) FROM sales GROUP BY productid;
/*SELECT * FROM sales WHERE productid = 1;*/
SELECT productid, SUM(revenue), AVG(revenue) average_revenue FROM  sales GROUP BY productid;

--Jaké celkové tržby za zboží prodané do Albany, NY, USA (zip = 12225)?
/*SELECT * FROM sales WHERE zip = 12225;*/
SELECT SUM(revenue) FROM sales WHERE zip = 12225;
SELECT zip, SUM(revenue) FROM sales WHERE zip = 12225 GROUP BY zip;

-- INNER JOIN
SELECT * FROM sales INNER JOIN product ON sales.ProductID = product.ProductID;
SELECT * FROM sales 
    INNER JOIN product ON sales.ProductID = product.productid 
WHERE sales.productid = 2275;
SELECT * FROM sales INNER JOIN product ON sales.ProductID = product.ProductID WHERE date = "2013-01-23";
SELECT product.product, sales.revenue FROM sales INNER JOIN product ON sales.ProductID = product.ProductID;

-- LEFT JOIN
SELECT p.product, sum(s.revenue), s.productid FROM product p LEFT JOIN sales s ON s.ProductID = p.Productid
/*WHERE s.productid = 2275*/
GROUP BY p.product, s.productid;
