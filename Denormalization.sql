/*YIXIN LUO*/

use AdventureWorksDW2012;
go

IF OBJECT_ID('aTable') IS NOT NULL 
BEGIN  
	PRINT 'Deleting atable';  
	DROP TABLE aTable; 
END 
 
CREATE TABLE aTable (  
ProductSubcategoryKey INT NOT NULL, 
EnglishProductSubcategoryName	nvarchar(255) NULL,	
SpanishProductSubcategoryName	nvarchar(255) NULL,	
FrenchProductSubcategoryName	nvarchar(255) NULL,	
EnglishProductCategoryName	nvarchar(255) NULL,	
SpanishProductCategoryName	nvarchar(255) NULL,	
FrenchProductCategoryName	nvarchar(255) NULL
 ); 

INSERT INTO aTable
(ProductSubcategoryKey,
EnglishProductSubcategoryName,
SpanishProductSubcategoryName,
FrenchProductSubcategoryName,
EnglishProductCategoryName,
SpanishProductCategoryName,
FrenchProductCategoryName)
SELECT        
ProductSubcategoryKey,
EnglishProductSubcategoryName,
SpanishProductSubcategoryName,
FrenchProductSubcategoryName,
EnglishProductCategoryName,
SpanishProductCategoryName,
FrenchProductCategoryName
	FROM          DimProductSubcategory LEFT OUTER JOIN
                         DimProductCategory ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey;


IF OBJECT_ID('bTable') IS NOT NULL 
BEGIN  
	PRINT 'Deleting btable';  
	DROP TABLE bTable; 
END 

CREATE TABLE bTable(
ProductKey	INT	NOT NULL,
ProductAlternateKey	nvarchar(255)	NULL,
EnglishProductName	nvarchar(255)	NOT NULL,
EnglishProductSubcategoryName	nvarchar(255)	NULL,
SpanishProductSubcategoryName	nvarchar(255)	NULL,
FrenchProductSubcategoryName	nvarchar(255)	NULL,
EnglishProductCategoryName	nvarchar(255)	NULL,
SpanishProductCategoryName	nvarchar(255)	NULL,
FrenchProductCategoryName	nvarchar(255)	NULL
);

INSERT INTO bTable(
ProductKey,
ProductAlternateKey,
EnglishProductName,
EnglishProductSubcategoryName,
SpanishProductSubcategoryName,
FrenchProductSubcategoryName,
EnglishProductCategoryName,
SpanishProductCategoryName,
FrenchProductCategoryName)
SELECT
ProductKey,
ProductAlternateKey,
EnglishProductName,
EnglishProductSubcategoryName,
SpanishProductSubcategoryName,
FrenchProductSubcategoryName,
EnglishProductCategoryName,
SpanishProductCategoryName,
FrenchProductCategoryName
FROM DimProduct LEFT OUTER JOIN
                         aTable ON DimProduct.ProductSubcategoryKey = aTable.ProductSubcategoryKey;


IF OBJECT_ID('newDimProduct') IS NOT NULL
DROP TABLE newDimProduct;
GO

CREATE TABLE newDimProduct
(
ProductKey INT NULL,
ProductAlternateKey nvarchar(25) NULL,
WeightUnitMeasureCode nchar(3) NULL,
SizeUnitMeasureCode nchar(3) NULL,
EnglishProductName nvarchar(50) NOT NULL,
SpanishProductName nvarchar(50) NULL,
FrenchProductName nvarchar(50) NULL,
StandardCost MONEY NULL,
FinishedGoodsFlag BIT NULL,
Color nvarchar(15) NULL,
SafetyStockLevel smallint NULL,
ReorderPoint smallint NULL,
ListPrice MONEY NULL,
Size nvarchar(50) NULL,
SizeRange nvarchar(50) NULL,
Weight FLOAT NULL,
DaysToManufacture INT NULL,
ProductLine nchar(2) NULL,
DealerPrice MONEY NULL,
Class nchar(2) NULL,
Style nchar(2) NULL,
ModelName nvarchar(50) NULL,
LargePhoto	varbinary(MAX) NULL,
EnglishDescription	nvarchar(400) NULL,
FrenchDescription	nvarchar(400) NULL,
ChineseDescription	nvarchar(400) NULL,
ArabicDescription	nvarchar(400) NULL,
HebrewDescription	nvarchar(400) NULL,
ThaiDescription	nvarchar(400) NULL,
GermanDescription	nvarchar(400) NULL,
JapaneseDescription	nvarchar(400) NULL,
TurkishDescription	nvarchar(400) NULL,
StartDate	datetime NULL,
EndDate	datetime NULL,
Status	nvarchar(7) NULL,
EnglishProductSubcategoryName	nvarchar(255) NULL,	
SpanishProductSubcategoryName	nvarchar(255) NULL,	
FrenchProductSubcategoryName	nvarchar(255) NULL,	
EnglishProductCategoryName	nvarchar(255) NULL,	
SpanishProductCategoryName	nvarchar(255) NULL,	
FrenchProductCategoryName	nvarchar(255) NULL
);

INSERT INTO newDimProduct
(ProductKey,
ProductAlternateKey,
WeightUnitMeasureCode,
SizeUnitMeasureCode,
EnglishProductName,
SpanishProductName,
FrenchProductName,
StandardCost,
FinishedGoodsFlag,
Color,
SafetyStockLevel,
ReorderPoint,
ListPrice,
Size,
SizeRange,
Weight,
DaysToManufacture,
ProductLine,
DealerPrice,
Class,
Style,
ModelName,
LargePhoto,
EnglishDescription,
FrenchDescription,
ChineseDescription,
ArabicDescription,
HebrewDescription,
ThaiDescription,
GermanDescription,
JapaneseDescription,
TurkishDescription,
StartDate,
EndDate,
Status
)
SELECT DimProduct.ProductKey,
DimProduct.ProductAlternateKey,
DimProduct.WeightUnitMeasureCode,
DimProduct.SizeUnitMeasureCode,
DimProduct.EnglishProductName,
DimProduct.SpanishProductName,
DimProduct.FrenchProductName,
DimProduct.StandardCost,
DimProduct.FinishedGoodsFlag,
DimProduct.Color,
DimProduct.SafetyStockLevel,
DimProduct.ReorderPoint,
DimProduct.ListPrice,
DimProduct.Size,
DimProduct.SizeRange,
DimProduct.Weight,
DimProduct.DaysToManufacture,
DimProduct.ProductLine,
DimProduct.DealerPrice,
DimProduct.Class,
DimProduct.Style,
DimProduct.ModelName,
DimProduct.LargePhoto,
DimProduct.EnglishDescription,
DimProduct.FrenchDescription,
DimProduct.ChineseDescription,
DimProduct.ArabicDescription,
DimProduct.HebrewDescription,
DimProduct.ThaiDescription,
DimProduct.GermanDescription,
DimProduct.JapaneseDescription,
DimProduct.TurkishDescription,
DimProduct.StartDate,
DimProduct.EndDate,
DimProduct.Status FROM DimProduct;

UPDATE newDimProduct
SET newDimProduct.EnglishProductSubcategoryName = bTable.EnglishProductSubcategoryName,
newDimProduct.SpanishProductSubcategoryName = bTable.SpanishProductSubcategoryName,
newDimProduct.FrenchProductSubcategoryName = bTable.FrenchProductSubcategoryName, 
newDimProduct.EnglishProductCategoryName =  bTable.EnglishProductCategoryName, 
newDimProduct.SpanishProductCategoryName = bTable.SpanishProductCategoryName, 
newDimProduct.FrenchProductCategoryName = bTable.FrenchProductCategoryName
FROM bTable, newDimProduct 
WHERE bTable.ProductKey = newDimProduct.ProductKey 
AND bTable.ProductAlternateKey = newDimProduct.ProductAlternateKey;

SELECT * FROM aTable ORDER BY 1;

SELECT * FROM bTable ORDER BY 1;

SELECT * FROM newDimProduct ORDER BY 1;


