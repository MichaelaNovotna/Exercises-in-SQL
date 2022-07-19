--1. Zjisti název města a PSČ pro všechny města ze státu Kansas (KS) a seřaď výsledky dle názvu města.
SELECT * FROM country;
SELECT Zip, City/*, State*/ FROM country WHERE State = 'KS' ORDER BY City; 

--2. Kolik průměrně vyděláme za jednotlivé produkty? (podle ProductID)
SELECT * FROM sales;
SELECT ProductID, AVG(Revenue) FROM sales GROUP BY ProductID ORDER BY AVG(Revenue) DESC;

--3. Ve kterém segmentu působí nejvíce výrobců?
SELECT * FROM product;
SELECT Segment, ManufacturerID FROM product;
SELECT DISTINCT Segment, ManufacturerID FROM product ORDER BY Segment;
SELECT DISTINCT Segment, ManufacturerID FROM product ORDER BY Segment;
SELECT Segment, COUNT(*) Manuf_count FROM (SELECT DISTINCT Segment, ManufacturerID FROM product) GROUP BY Segment ORDER BY Manuf_count DESC;
SELECT Segment, COUNT(DISTINCT ManufacturerID) AS ManufacturersCount FROM product GROUP BY Segment ORDER BY ManufacturersCount DESC;

/*4. Jaká je maximální a minimální cena produktu pro každou kategorii? Cena musí být větší než 0 a přejmenujete názvy sloupců na produkt, max_cena, min_cena.
Pokud chceme znázornit, že hodnota číselného sloupce je větší, tak se místo = použije >. 
Např. Revenue > 100*/
SELECT * FROM product;
SELECT Category, MAX(PriceNew) max_cena, MIN(PriceNew) min_cena FROM product WHERE PriceNew > 0 GROUP BY Category;
SELECT Category, MAX(PriceNew) AS max_cena, MIN(PriceNew) AS min_cena FROM product WHERE PriceNew > 0 GROUP BY category;

/*5. Zjisti top 10 ProductId vzhledem k celkovému počtu prodaných kusů, zjisti také celkový příjem a vypočítej průměrný příjem za kus produktu.
        (vypočítej ručně aritmetický průměr – celkový příjem / celkový počet jednotek"*/
SELECT * FROM sales ORDER BY ProductID;
SELECT ProductID, SUM(Revenue) FROM sales GROUP BY ProductID;
SELECT ProductID, SUM(Revenue), SUM(Units) FROM sales GROUP BY ProductID ORDER BY SUM(Revenue) DESC;
--nefunguje SELECT ProductID, SUM(Revenue), SUM(Units), AVG(Revenue) FROM sales GROUP BY ProductID ORDER BY SUM(Revenue) DESC LIMIT 10;
SELECT ProductID, SUM(Revenue), SUM(Units), SUM(Revenue) / SUM(Units) FROM sales GROUP BY ProductID ORDER BY SUM(Revenue) DESC LIMIT 10;
SELECT productID, sum(units) AS sum_unit, sum(revenue) AS sum_rev, sum(revenue) / sum(units) AS rev_per_unit 
    FROM sales GROUP BY productID ORDER BY sum_unit DESC LIMIT 10;


--6. Kolik kusů výrobku Fama UR-40 se prodalo v jednotlivých státech?
SELECT * FROM product WHERE Product = "Fama UR-40";
SELECT * FROM sales WHERE ProductID = 268;
SELECT * FROM country;
SELECT State, COUNT(ProductID) FROM sales JOIN country ON sales.zip = country.zip WHERE ProductID = 268 GROUP BY State ORDER BY COUNT(ProductID) DESC;
SELECT c.State, SUM(s.Units) AS UnitsSold FROM sales s JOIN country c ON s.Zip = c.Zip JOIN product p ON p.ProductID = s.ProductID 
    WHERE p.Product = 'Fama UR-40' GROUP BY c.State ORDER BY SUM(s.Units) DESC;

--7. Jaké jsou v jednotlivých regionech tržby za výrobky společnosti Natura?
SELECT * FROM manufacturer;
SELECT * FROM product;
SELECT * FROM sales;
SELECT * FROM country;
SELECT c.Region, SUM(s.Revenue) sum_rev FROM country c 
    JOIN sales s ON c.Zip = s.Zip 
    JOIN product p ON p.ProductID = s.ProductID 
    JOIN manufacturer m ON m.ManufacturerID = p.ManufacturerID
    WHERE m.Manufacturer = 'Natura'
    GROUP BY c.region
    ORDER BY sum_rev DESC;
    
--8. V jakých městech se prodalo nejvíce různorodých výrobků?"
SELECT * FROM country ORDER BY Zip;
SELECT ProductID, Zip FROM sales ORDER BY Zip;
SELECT c.City, COUNT(DISTINCT s.ProductID) count_products FROM country c JOIN sales s ON s.Zip = c.Zip GROUP BY c.City ORDER BY count_products DESC;




