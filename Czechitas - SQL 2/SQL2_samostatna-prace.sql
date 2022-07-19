--Zobraz všechny jedinečné názvy produktů a seřaď je dle abecedy.
SELECT * FROM product LIMIT 5;

SELECT DISTINCT Product FROM product ORDER BY Product;

--Zobraz celkovou tržbu za produkty, kterých se prodalo v rámci jednoho prodeje více než 10.
SELECT * FROM sales ORDER BY Units DESC LIMIT 100;
SELECT * FROM product LIMIT 100;
SELECT ProductID, SUM(Revenue) FROM sales WHERE Units > 10 GROUP BY ProductID;

SELECT SUM(Revenue) FROM sales WHERE Units > 10;

--K úkolu 2 přidej informaci o kategoriích, ve kterých byla tato celková tržba
SELECT p.Category, SUM(Revenue) FROM sales s JOIN product p ON s.ProductID = p.ProductID WHERE s.Units > 10 GROUP BY p.category;
SELECT SUM(s.Revenue), p.category FROM sales s INNER JOIN product p ON s.ProductId = p.ProductID WHERE s.units > 10 GROUP BY p.category;


--V úkolu 3 použijte všechny numerické funkce: SUM, COUNT, MIN, MAX, AVG, ROUND, ABS
SELECT p.category, SUM(s.Revenue), ROUND(SUM(s.Revenue), 3), COUNT(s.Revenue), AVG(s.Revenue), MIN(s.Revenue), MAX(s.Revenue), ABS(SUM(s.Revenue))
	FROM sales s INNER JOIN product p ON s.ProductId = p.ProductID 
    WHERE s.units > 10 GROUP BY p.category;


----ŘETĚZOVÉ FUNKCE----
--V rámci jednoho SELECT příkazu:
 --zobrazte první dva sloupce z tabulky Manufacturer v jednom sloupci a přejmenujte tento sloupec na sloupec1,
 --zobrazte sloupec manufacturer a výrobce Abbas přejmenujte na czechitas, celý sloupec pak pojmenujte jako sloupec3.
 --Bonusová část - pokud budete mít čas:
 --zjistěte délku ManufacturerID, sloupec pojmenujte jako sloupec4,
 --vypište sloupec manufacturer až od druhého písmene, sloupec pojmenujte jako sloupec5.
SELECT * FROM manufacturer LIMIT 5;

SELECT 
ManufacturerID, 
Manufacturer,
ManufacturerID || Manufacturer sloupec1,
REPLACE(Manufacturer, "Abbas", "czechitas") sloupec3,
LENGTH(ManufacturerID) sloupec4,
SUBSTR(Manufacturer, 2) sloupec5
FROM manufacturer;

---DATUMOVÉ FUNKCE
--V rámci jednoho SELECT příkazu:
 --Zjistěte první pátek letošního června
 --Vypište aktuální datum a čas
SELECT date('now','start of year','+5 months','weekday 5');
SELECT date('2022-01-01','+5 months','weekday 5');
--Vypište zítřejší datum
SELECT date('now','+1 day');
--Vypište včerejší datum
SELECT date('now','-1 day');

--Využijte dříve vytvořený příkaz:
SELECT * FROM sales LIMIT 5;
SELECT SUM (s.Revenue), p.category FROM sales s LEFT JOIN product p ON s.ProductId = p.ProductID WHERE s.units > 10  GROUP BY p.category;
 --Nyní chceme  sloupec s celkovou tržbou rozdělit na 2 sloupce a to tak, že v jednom sloupci bude celková tržba za produkty, 
 --kterých se v rámci jednoho prodeje prodalo méně jak 20 kusů a ve druhém sloupci bude celková tržba za zbytek těchto prodejů. 
 --Použijeme k tomu funkci Case.
SELECT SUM(s.Revenue), p.category,
SUM(CASE WHEN s.units < 20 THEN s.Revenue END) "Less20",
SUM(CASE WHEN s.units >= 20 THEN s.Revenue END) "More20"
FROM sales s Left JOIN product p ON s.ProductId = p.ProductID 
WHERE s.units > 10 GROUP BY p.category;

--6
--Vytvoř tabulku gift a poté gift2, která má stejnou strukturu jako tabulka gift (využij SELECT).
CREATE TABLE gift (
  GiftID NUMERIC PRIMARY KEY,
  Gift STRING(20),
  Date DATETIME,
  ManufacturerID NUMERIC);
CREATE TABLE gift2 AS SELECT * FROM gift;

--Přejmenuj tabulku gift2 na gift_new
ALTER TABLE gift2
	RENAME TO gift_new;

--Přidej nový sloupec Price datového typu Numeric do tabulky gift_new.
ALTER TABLE gift_new
	ADD COLUMN Prince NUMERIC;

--Smaž tabulku gift_new
DROP TABLE gift_new;

--7
--Vlož do tabulky gift hodnoty: giftID=1, gift=gift basket, date=2020-11-19, manufacturerID=1 (nebo si můžete vymyslet své hodnoty).
SELECT * FROM gift;
INSERT INTO gift (GiftID, Gift, Date, ManufacturerID) VALUES (1, "gift basket", "2020-11-19", 1);
UPDATE gift SET Date = "2020-11-19";
--Změň hodnotu ManufacturerID na 2 pro GiftID = 1.	
UPDATE gift SET ManufacturerID = 2 WHERE GiftID;
--Smaž řádek z tabulky gift, kde GiftID = 1.
DELETE FROM gift WHERE GiftID = 1;
