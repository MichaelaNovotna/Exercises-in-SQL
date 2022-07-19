DROP DATABASE IF EXISTS sales;

CREATE DATABASE sales;

USE sales;

CREATE TABLE date (
    Date      nvarchar (60) NOT NULL,
    MonthNo   int,
    MonthName nvarchar (50),
    MonthID   nvarchar (50),
    Month     nvarchar (50),
    Quarter   nvarchar (50),
    Year      int, 
	CONSTRAINT PK_date PRIMARY KEY  CLUSTERED 
	(
		Date
	));



CREATE TABLE country (
    Zip      int NOT NULL,
    City     nvarchar (50),
    State    nvarchar (50),
    Region   nvarchar (50),
    District nvarchar (50),
    Country  nvarchar (50)  ,
	CONSTRAINT PK_country PRIMARY KEY  CLUSTERED 
	(
		Zip
	)
)
;


CREATE TABLE manufacturer (
    ManufacturerID int NOT NULL,
    Manufacturer   nvarchar (50),
    Logo           nvarchar (250),
	CONSTRAINT PK_manufacturer PRIMARY KEY  CLUSTERED 
	(
		ManufacturerID
	)
)


;

CREATE TABLE product (
    ProductID      int NOT NULL,
    Product        nvarchar (50),
    Category       nvarchar (50),
    Segment        nvarchar (50),
    ManufacturerID int,
    Price          nvarchar (50),
    Currency       nvarchar (50),
    PriceNew       double,
	CONSTRAINT PK_Shippers PRIMARY KEY  CLUSTERED 
	(
		ProductID
	)
)
;

CREATE TABLE sales (
    ProductID int,
    Date      nvarchar (60),
    Zip       int,
    Units     double,
    Revenue   double
)
;
