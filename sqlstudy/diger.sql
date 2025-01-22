-- SQL Server'ı düzgün bir şekilde kapat
SHUTDOWN;

-- SQL Server'ı hemen kapat ve işlemleri bekleme
SHUTDOWN WITH NOWAIT;

-- SQL Server'ı kapatıp hemen yeniden başlat
SHUTDOWN WITH RESTART;


SELECT 
    ProductName,
    CASE 
        WHEN Price > 100 THEN 'Expensive'
        WHEN Price BETWEEN 50 AND 100 THEN 'Moderate'
        ELSE 'Cheap'
    END AS PriceCategory
FROM Products;



CREATE DATABASE DIJIBIL 
ON  PRIMARY 
( 
	NAME = N'DIJIBIL_Data', 
	FILENAME = N'C:\Databases\DIJIBIL_Data.mdf',
	SIZE = 21632KB, 
	MAXSIZE = UNLIMITED, 
	FILEGROWTH = 16384KB 
)
LOG ON 
( 
	NAME = N'DIJIBIL_Log', 
	FILENAME = N'C:\Databases\DIJIBIL_Log.ldf',
	SIZE = 2048KB, 
	MAXSIZE = 2048GB, 
	FILEGROWTH = 16384KB 
)
GO




ALTER DATABASE DIJIBIL
MODIFY FILE
(
	NAME = DIJIBIL_Data,
	SIZE = 300MB
);



GRANT CREATE TABLE
TO DIJIUser;


GRANT CREATE TABLE TO AppRole, DIJIUser;


CREATE USER newDijiUser FOR LOGIN DIJILogin;


GRANT CREATE DATABASE, CREATE TABLE TO newDijiUser;


GRANT SELECT, INSERT ON diji_Kullanicilar
TO AppRole
WITH GRANT OPTION;


DENY CREATE TABLE TO DIJIUser;


DENY SELECT ON diji_Kullanicilar TO DIJIUser;


REVOKE ALL TO PUBLIC


REVOKE SELECT ON diji_Kullanicilar TO DIJIUser;



SELECT ROW_NUMBER() OVER(ORDER BY ProductID) AS SatirNO,
	ProductID, Name, ListPrice 
FROM Production.Product;


SELECT * FROM Production.Product TABLESAMPLE(50 PERCENT);


SELECT * FROM Production.Product TABLESAMPLE(300 ROWS);


SELECT * FROM Production.Product TABLESAMPLE(600 ROWS)


SELECT FirstName, LastName 
FROM Person.Person TABLESAMPLE(300 ROWS)
REPEATABLE(300);


DELETE Sales.ShoppingCartItem
OUTPUT DELETED.* 
WHERE ShoppingCartID = 14951;



SELECT BulkColumn 
FROM OPENROWSET(BULK 'C:\video.mp4', SINGLE_BLOB) AS Files;


--	Mevcut Bir Veritaban�nda FILESTREAM Kullanmak


ALTER DATABASE AdventureWorks ADD
FILEGROUP FSGroup1 CONTAINS FILESTREAM;


ALTER DATABASE AdventureWorks ADD FILE(
	NAME = FSGroupFile1,
	FILENAME = 'C:\Databases\AdventureWorks\ADWorksFS')
	TO FILEGROUP FSGroup1;


CREATE TABLE ADVDocuments
(
	DocID		INT IDENTITY(1,1) PRIMARY KEY,
	DocGUID	UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
	DocFile	VARBINARY(MAX) NOT NULL,
	DocDesc	VARCHAR(500)
);




--	SQL Server'da NULL ve Bo�luk Kavram�


SELECT 'Cihan' + NULL + '�zhan';


SET CONCAT_NULL_YIELDS_NULL OFF;


SELECT 'Cihan' + NULL + '�zhan';


SET CONCAT_NULL_YIELDS_NULL ON;


--	SPACE Fonksiyonu


SELECT 'Cihan' + SPACE(1) + '�zhan';


SELECT 1 + SPACE(1) + 4;


SELECT 'DIJIBIL' + SPACE(5) + 2013;		-- Hata


--	IS NULL Operat�r�


SELECT 
	ProductID, Name, Size 
FROM 
	Production.Product
WHERE 
	Size IS NULL;


	
SELECT TOP 5 * FROM Production.Product;


SELECT TOP 1 PERCENT * FROM Production.Product;


SELECT TOP 5 * FROM Production.Product WHERE Name LIKE 'C%';


--	TOP Fonksiyonu


SELECT 
	TOP(5) WITH TIES * 
FROM 
	Production.Product
ORDER BY 
	ProductID;



SELECT 
	TOP(5) PERCENT WITH TIES * 
FROM 
	Production.Product
ORDER BY 
	ProductID;




ALTER TABLE Kullanicilar
ADD CONSTRAINT CHK_Telefon CHECK(
Telefon IS NULL OR(
Telefon LIKE '[0][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') 
AND LEN(Telefon) = 11)



ALTER TABLE Kullanicilar
ADD CONSTRAINT CHK_Telefon CHECK(
Telefon IS NULL OR(
Telefon LIKE '[0][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') 
AND LEN(Telefon) = 14)


--	S�tunlar Aras� Check Constraint


CREATE TABLE Uyeler
(
	UyelerID	INT PRIMARY KEY NOT NULL,
	UyelikAd	VARCHAR(20) NOT NULL,
	Sifre		VARCHAR(10) NOT NULL,
	Email		VARCHAR(30),
	Telefon	VARCHAR(11),
	GirisTarih	DATETIME,
	CikisTarih	DATETIME NULL,
	CONSTRAINT CHK_CalismaTarih CHECK(
	CikisTarih IS NULL OR CikisTarih >= GirisTarih)
);



--	ROLLUP


CREATE TABLE tbPopulation (
	Category VARCHAR(100),
	SubCategory VARCHAR(100),
	BookName VARCHAR(100),
	[Population (in Millions)] INT
);



SELECT Category, SubCategory, BookName,
SUM ([Population]) AS [Population]
FROM tbPopulation
GROUP BY Category,SubCategory,BookName WITH ROLLUP;



--	GROUPING ile �zetleri D�zenlemek


SELECT SalesQuota, SUM(SalesYTD) 'TotalSalesYTD', 
	 GROUPING(SalesQuota) AS 'Grouping'
FROM Sales.SalesPerson
GROUP BY SalesQuota WITH ROLLUP;




--	CUBE



SELECT D.Name, COUNT(*) AS [�al��an Say�s�]
FROM HumanResources.EmployeeDepartmentHistory AS EDH
INNER JOIN HumanResources.Department AS D
ON EDH.DepartmentID = D.DepartmentID
GROUP BY CUBE(D.Name);


SELECT D.Name, COUNT(*) AS [�al��an Say�s�]
FROM HumanResources.EmployeeDepartmentHistory AS EDH
INNER JOIN HumanResources.Department AS D
ON EDH.DepartmentID = D.DepartmentID
GROUP BY CUBE(D.Name)
HAVING COUNT(EDH.DepartmentID) <= 6;



SELECT i.Shelf, SUM(i.Quantity) Total
FROM Production.ProductInventory AS i
WHERE i.Shelf IN('A','B','C')
GROUP BY i.Shelf;


SELECT i.Shelf,	SUM(i.Quantity) Total
FROM Production.ProductInventory AS i
WHERE i.Shelf IN('A','B','C','D')
GROUP BY CUBE(i.Shelf);


CREATE TABLE Person(
	PersonID	UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL UNIQUE,
	FirstName	VARCHAR(30),
	LastName	VARCHAR(30),
	Email		VARCHAR(50),
	PImage	VARBINARY(MAX) FILESTREAM NULL
);


--	Common Table Expressions(CTE)



;WITH CTEProduct(UrunNo, UrunAd, Renk) AS
(
	SELECT ProductID, Name, Color FROM Production.Product
	WHERE ProductID > 400 AND Color IS NOT NULL
)
SELECT * FROM CTEProduct;



WITH CTEProduct(UrunNo, UrunAd, Renk) AS
(
	SELECT ProductID, Name, Color FROM Production.Product
	WHERE ProductID > 400 AND Color IS NOT NULL
)
UPDATE CTEProduct SET UrunAd = 'Advanced SQL Server'
WHERE UrunNo = 461;



SELECT ProductID, Name, Color 
FROM Production.Product WHERE ProductID = 461;



WITH EnPahaliUrunCTE
AS
(
	SELECT TOP 1 ProductID, Name, ListPrice FROM Production.Product
	WHERE ListPrice > 0
	ORDER BY ListPrice ASC
),
EnUcuzUrunCTE
AS
(
	SELECT TOP 1 ProductID, Name, ListPrice FROM Production.Product
	ORDER BY ListPrice DESC
)
SELECT * FROM EnPahaliUrunCTE
 UNION
SELECT * FROM EnUcuzUrunCTE;

--	Time


DECLARE @time time(7) = '12:34:54.1234567';
DECLARE @time1 time(1) = @time;
DECLARE @time2 time(2) = @time;
DECLARE @time3 time(3) = @time;
DECLARE @time4 time(4) = @time;
DECLARE @time5 time(5) = @time;
DECLARE @time6 time(6) = @time;
DECLARE @time7 time(7) = @time;


--	GOTO


DECLARE @Counter int;
SET @Counter = 1;
WHILE @Counter < 10
BEGIN 
    SELECT @Counter
    SET @Counter = @Counter + 1
    IF @Counter = 4 GOTO Etiket_Bir
    IF @Counter = 5 GOTO Etiket_Iki
END
Etiket_Bir:
    SELECT 'Etiket 1'
    GOTO Etiket_Uc;
Etiket_Iki:
    SELECT 'Etiket 2'
Etiket_Uc:
    SELECT 'Etiket 3'



CREATE TABLE #gecici(
	firmaID 	INT NOT NULL IDENTITY(1,1),
	firma_isim 	VARCHAR(20) NULL
);
WHILE (SELECT count(*) FROM #gecici) < 10
BEGIN
	INSERT #gecici VALUES ('dijibil'),('kodlab')
END;
SELECT * FROM #gecici;

DECLARE @DBID INT;
DECLARE @DBNAME NVARCHAR(128);

SET @DBID = DB_ID();
SET @DBNAME = DB_NAME();



CREATE PROCEDURE pr_HataBilgisiGetir
AS
SELECT
     ERROR_NUMBER() AS ErrorNumber,
     ERROR_SEVERITY() AS ErrorSeverity,
     ERROR_STATE() AS ErrorState,
     ERROR_PROCEDURE() AS ErrorProcedure,
     ERROR_LINE() AS ErrorLine,
     ERROR_MESSAGE() AS ErrorMessage;



DECLARE @sayi1 INT = 5
DECLARE @sayi2 INT = 0
DECLARE @sonuc INT

BEGIN TRY
	SET @sonuc = @sayi1 / @sayi2
END TRY
BEGIN CATCH
	EXECUTE pr_HataBilgisiGetir;
END CATCH;



DECLARE @sayi1 INT = 5
DECLARE @sayi2 INT = 0
DECLARE @sonuc INT

BEGIN TRY
	SET @sonuc = @sayi1 / @sayi2
END TRY
BEGIN CATCH
	PRINT CAST(@@ERROR AS VARCHAR) + ' no lu hata olu�tu'
END CATCH;

THROW 50001, '�r�n ekleme s�ras�nda bir hata meydana geldi.', 5;

DECLARE @DBID INT;
DECLARE @DBNAME NVARCHAR(128);

SET @DBID = DB_ID();
SET @DBNAME = DB_NAME();



SELECT * FROM sys.messages;


SELECT * FROM SYS.Messages ORDER BY Message_ID DESC;


sp_addmessage @msgnum = 'mesaj_kod',
	        @severity = 'seviye',
	        @msgtext = 'mesaj',
	        @with_log = 'true'|'false',
	        @lang = 'dil_kod',
		  @replace = ''


sp_addmessage @msgnum = '50006',
		  @severity = 10,
		  @msgtext = 'Ge�erli bir �r�n numaras� giriniz',
		  @with_log = 'true';


SELECT * FROM SYS.Messages WHERE Message_ID = 50006;


DECLARE @xml_veri VARCHAR(MAX);
SET @xml_veri = '
	<kitaplar>
		<kitap>�leri Seviye SQL Server T-SQL</kitap>
		<kitap>�leri Seviye Android Programlama</kitap>
		<kitap>Java SE</kitap>
	</kitaplar>';
SELECT CAST(@xml_veri AS XML);
SELECT CONVERT(XML, @xml_veri);
PRINT @xml_veri;



BEGIN TRANSACTION
	SELECT * FROM Accounts;

	UPDATE Accounts
	SET Balance = 500, Branch = 287
	WHERE AccountID = '0000064219';
		SELECT * FROM Accounts;

	SAVE TRAN save_updateAccount;

	DELETE FROM Accounts WHERE AccountID = '0000064219';
		SELECT * FROM Accounts;

	ROLLBACK TRAN save_updateAccount;
		SELECT * FROM Accounts;
	ROLLBACK TRAN;
		SELECT * FROM Accounts;
COMMIT TRANSACTION;

