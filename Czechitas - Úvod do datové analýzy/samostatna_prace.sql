-- Vyber sloupce zip, city a country z tabulky country a přejmenuj je.
SELECT zip PSC FROM country;
SELECT city mesto FROM country;
SELECT country stat FROM country;
SELECT zip PSC, city mesto, country stat FROM country;
-- Vyber jedinečné Regiony z tabulky Country (aby tam žádný region nebyl dvakrát) a zobraz pouze první záznam.
SELECT DISTINCT region FROM country;
SELECT DISTINCT region FROM country LIMIT 1;

-- 2
-- Vyber všechny sloupce tabulky Sales pro ProductID se rovná 1 a seřaď výsledky sestupně dle výše Revenue.
SELECT * FROM sales WHERE ProductID = 1 ORDER BY revenue DESC;
--omez výsledek na prvních 5 řádků
SELECT * FROM sales WHERE ProductID = 1 ORDER BY revenue DESC LIMIT 5;

--3
-- Kolik máme produktů (ProductId) v kategorii Rural? Výsledný sloupec přejmenuj na ‚ProductCount‘.
--celá tabulka
SELECT * FROM product;
--z toho kategorie Rural
SELECT * FROM product WHERE category = "Rural";
--spočítat
SELECT count(ProductID) FROM product WHERE category = "Rural";
--přejmenovat
SELECT count(ProductID) ProductCount FROM product WHERE category = "Rural";