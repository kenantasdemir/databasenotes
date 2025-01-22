CREATE TABLE users(
    user_id int not null PRIMARY KEY UNIQUE,
    user_name VARCHAR(20) not NULL,
    user_age int CHECK(user_age > 18),
    user_email VARCHAR(20) NOT NULL 
    --UNIQUEIDENTIFIER
)

USE TBLNOTLAR
GO
DELETE FROM TABLNOTLAR WHERE DERSAD="Matematik";

--INSERT UsersTable SELECT "Kenan","Taşdemir" GO 2;

PRINT "KENAN TAŞDEMİR"

--ALTER DATABASE DENEME
--ALTER TABLE TBLUSERS
--CREATE TABLE TBLUSERS;

USE DIJIBIL
GO
IF OBJECT_ID("Users","U") IS NOT NULL
DROP TABLE Users

INSERT Users VALUES 
(1,NEWID(),"KENAN","TAŞDEMİR"),
(1,NEWID(),"YASIN","TAŞDEMİR"),
(1,NEWID(),"NEHIR","TAŞDEMİR")

GRANT
DENY
REVOKE

--CREATE LOGIN firstLogin WITH PASSWORD "deneme123"
--CREATE USER firstUser FOR LOGIN firstLogin


--CREATE APPLICATION ROLE AppRole WITH PASSWORD = "PAROLA123", DEFAULT SCHEMA = AppRole;

SELECT ProductName
INTO DigerTablo
FROM Products

Select * from TBLDERSLER
UNION 
SELECT * FROM DERSLER
PRINT "UNION ISLEMINDE KESİŞİMLER ALINIR"

PRINT "UNION ALL ile bütün kayıtlar getirilir."

SELECT TOP 2 * FROM TBLUSERS
SELECT TOP 65 PERCENT * FROM TBLDERSLER


SELECT
 TOP(5) WITH TIES *
 FROM Products

SELECT TOP(65) PERCENT WITH TIES *
FROM TBLDERSLER

SELECT CAST(ProductID AS VARCHAR) Products

--CONVERT

--BETWEEN 10 AND 20
--NOT BETWEEN 10 AND 20

SELECT ProductID,ProductName FROM PRODUCTS WHERE ProductID IN(10,20);
SELECT ProductID,ProductName FROM PRODUCTS WHERE ProductID NOT IN(10,20);

SELECT "KENAN" + SPACE(1) + "Taşdemir";

SELECT "KENAN" + NULL + "TAŞDEMİR"; --NULL
SET CONCAT_NULL_YİELDS_NULL ON;


--WHERE dataSize IS NULL

SELECT ProductName,ProductColor, ISNULL(ProductColor,"Renk Yok") AS Renk FROM Products
--COALESCE --NULL OLMAYAN İLK DEĞERİ GETİRİR.

--NULLIF(x,y) AS "DEĞERLER EŞİTSE NULL EŞİT DEĞİLSE İLK PARAMETREYİ DÖNDÜRÜR."

CREATE TABLE Kategoriler(
    KategoriID INT PRIMARY KEY,
    KategoriAD VARCHAR(20)
)

CREATE TABLE Makaleler(
    MakaleID VARCHAR(20) PRIMARY KEY IDENTITY,
    Baslik VARCHAR(20) NOT NULL,
    KategoriID VARCHAR(20) FOREIGN KEY REFERENCES Kategoriler(KategoriID)
)

ALTER TABLE Makaleler ADD CONSTRAINT FK_MakaleKategoriler FOREIGN KEY(KategoriID) REFERENCES Kategoriler(KategoriID)

--sp_helpconstraint "Makaleler"


CREATE TABLE Urunler(
    UrunID INT NOT NULL,
    CONSTRAINT PK_URUNID PRIMARY KEY(UrunID)
)

ALTER TABLE Users ADD CONSTRAINT PK_URUNLER PRIMARY KEY(UserID)

ALTER TABLE Users ADD CONSTRAINT CHK_Users CHECK(LEN(SIFRE) >= 8 AND LEN(SIFRE) <= 16)

ALTER TABLE Personeller ADD CONSTRAINT DFLT_VALUES DEFAULT GETDATE() FOR IseGiris


--@@IDENTITY --en son identity değerini döndürür.
-- SCOPE_IDENTITY()

SELECT IDENT_CURRENT("Products")

--SELECT @@ROWCOUNT
--SELECT SERVERNAME --UPPER --LOWER
--@@CONNECTIONS --login teşebbüsleri sayısı

--@@CPU_BUSY --işlemcinin ne kadar aktif olduğunu ms cinsinden döndürür.

SELECT @@DBTS --geçerli db için son kllanılan timestampi döndürür.

SELECT VARP(Bonus) FROM TBLSATISLAR
SELECT VAR(Bonus) FROM TBLSATISLAR
--VARYANSI DÖNDÜDÜR. NULL DEĞERLERİ İHMAL EDER.

/*
WITH CTEProducts(ProductID,ProductName,ProductColor) AS
(
    SELECT ProductID,ProductName, ProductColor FROM Products
)
*/

SELECT ROW_NUMBER() OVER(ORDER BY ProductID) AS SatirNo,
ProductID, ProductName, ListPrice FROM Products;

SELECT RANK() OVER(PARTITION BY LocationID ORDER BY ProductQuantity DESC) AS "Rank";

SELECT DENSE_RANK() OVER(PARTITION BY LocationID ORDER BY ProductQuantity DESC) AS "Rank";

-- ORDER BY NEWID();

SELECT * FROM Products TABLESAMPLE(50 PERCENT);
SELECT * FROM Products TABLESAMPLE(300 ROWS);

SELECT * FROM Persons TABLESAMPLE(300 ROWS) REPEATABLE(300);

--SORGU1
--INTERSECT
--SORGU2

--SORGU1
--EXCEPT
--SORGU2

INSERT INTO Users(Ad,Soyad,Yas,Okul) EXEC storedProcedure;

INSERT INTO Users(Ad,Soyad,Yas,Okul) SELECT Ad,Soyad,Yas,Okul FROM Kullanicilar;

DELETE TOP(2.2) PERCENT FROM Products;
DELETE TOP(2) FROM Users;

DELETE Sales OUTPUT DELETED.* WHERE ShoppingCartID = 14564;
SELECT * FROM Sales WHERE ShoppingCartID = 14564;

--GROUP BY ALL --gruplama işlemini tüm kayıtlar üstünde yapar.
--HAVING, GROUP BY ile kullanılır.

SELECT GETDATE();
SELECT OrderDate,DATEADD(day,2,OrderDate) AS PromisedShipDate FROM Sales;

SELECT DATEDIFF("2022-07-07","2014-08-09");

SELECT DATENAME(DAY,"2017-06-03")

SELECT DAY("2016-06-07")

SELECT GETUTCDATE()
SELECT DAY(GETUTCDATE())

SELECT MONTH("2012-05-22")
SELECT MONTH(GETDATE()) AS BU_AY

SELECT YEAR("2023-04-02")

CREATE UNIQUE NONCLUSTERED INDEX UI_Email
on dbo.diji_Users(user_email)
ON [PRIMARY]

EXEC sp_helpindex "diji_Users"
SELECT * FROM sys.indexes;

CREATE COLUMNSTORE INDEX idx_columnstore ON TabloAdi;

CREATE CLUSTERED COLUMNSTORE INDEX idx_clustered_columnstore ON TabloAdi;

--ALTER INDEX ALL ON Products REBUILD WITH(FILLFACTOR = 90, SORT_IN_TEMPDB);

CREATE NONCLUSTERED COLUMNSTORE INDEX idx_nonclustered_columnstore ON TabloAdi (Sutun1, Sutun2, Sutun3);

--ALTER INDEX UI_Email ON Personeller REORGANIZE WITH (LOB_COMPACTION = ON);
--BOŞALAN INDEX SAYFALARININ ATILMASINI SAĞLAR

ALTER INDEX CL_PersonelID ON Personeller DISABLE;
ALTER INDEX CL_PersonelID ON Products REBUILD;

ALTER INDEX FI_Product ON Products SET(ALLOW_ROW_LOCKS = ON);

CREATE TABLE #gecici(
   -- ...
   user_id int not null PRIMARY KEY
)

SELECT * FROM #gecici;

BEGIN
    WAITFOR DELAY '00:03';
    EXECUTE sp_helpdb;
END;

/* --
DECLARE @Sayi INT = 0;

-- Başlangıç etiketi
START:

-- Kullanıcıdan sayıyı al
PRINT 'Bir sayi girin (0 girerseniz program sonlanır):';
-- (Burada sayıyı manuel olarak alıyoruz. Gerçek uygulamada INPUT alabilirsiniz)
SET @Sayi = 0;

-- Eğer sayı 0 ise, GOTO ile bitiş etiketine atla
IF @Sayi = 0
BEGIN
    GOTO Bitis;
END

-- Sayı sıfır değilse, sayıyı yazdır
PRINT 'Girdiğiniz sayi: ' + CAST(@Sayi AS VARCHAR);

-- Bitiş etiketi
Bitis:
PRINT 'Program sonlanıyor.'; */

/*
CREATE VIEW vw_Siparisler
AS
SELECT * FROM Siparisler;
*/

--viewler geçici tabloları base tablo olarak kullanamaz.
--view içerisindeki SELECT ifadesi ORDER BY, COMPUTE, COMPUTE BY, INTO, OPTION cümleciklerini alamaz.

SELECT * FROM information_schema.tables

SELECT * FROM information_schema.view_table_usage;

SELECT * FROM information_schema.views;

SELECT * FROM sys.views;

SELECT sys.schemas;
/*
ALTER VIEW vw_Siparisler
WITH ENCRYPTION
AS
    SELECT SiparisSira from Siparisler
WITH CHECK OPTION;
*/

EXECUTE sp_refreshview "vw_Siparisler";
EXECUTE sp_refreshsqlmodule;
EXECUTE sp_helptext "vw_Siparisler";
DROP VIEW vw_Siparisler;

/*
NORMAL SORGULAR
Query -> Parse -> Optimize -> Compile -> Execute -> Result

Stored Procedurec Calisma
Parse -> Compile -> Executec 
*/

/*
EXTENDED STORE PROCEDURE
CLR STORED PROCEDURE
SISTEM STORED PROCEDURE
USER DEFINED STORED PROCEDURE

BİR PROCEDURE ŞUNLARI İÇEREMEZ
CREATE PROCEDURE
CREATE DEFAULT
CREATE RULE
CREATE TRIGGER
CREATE VIEW
*/


CREATE TABLE Makaleler(
    makId int PRIMARY KEY identity(1,1),
    mak_name VARCHAR(20) DEFAULT "NO NAME"
);
/*
CREATE PROCEDURE pr_UrunlerGetir
AS
SELECT * FROM Products;
BEGIN
    SELECT * FROM Products;
END;

*/

DROP PROCEDURE pr_UrunlerGetir;
/*
CREATE PROC pr_SaveUser(
    @UserName VARCHAR(20) NOT NULL,
    @UserAge INT NOT NULL
)
AS
BEGIN
INSERT INTO Users(UserName,UserAge) VALUES(@UserName,@UserAge)
END;


CREATE PROC sp_FetchUsers
AS
SELECT * from Users;

--procedure oluşturmak için sysadmin, db_owner, ddl_admin izin ya da rollerine ihtiyaç vardır.

ALTER PROC pr_UrunlerGetir
AS
SELECT MAX(10,20,30,40,50);

ALTER PROC pr_UrunlerGetir
WITH RECOMPILE
--HER ÇALIŞTIĞINDA YENİDEN DERLENİR
AS
SELECT * FROM Urunler;
GO;

DENY ON pr_UrunlerGetir TO kenant42
GRANT ON pr_UrunlerGetir TO kenant42
*/

EXEC pr_UrunAra @ProductNumber = "PC-22";
EXEC pr_UrunAra "pc-22";

CREATE TYPE ProductType AS TABLE(
    ProductCategoryID int not null,
    ProductName VARCHAR(20) NOT NULL
)
/*
CREATE PROC pr_AllCategories(
    @productCategory AS ProductType READONLY
)
AS
SELECT * FROM Categories;
*/

sp_helptext pr_UrunlerGetir;
ALTER PROC pr_UrunlerGetir(
    @ProductID int not null
)
WITH ENCRYPTION
AS
SELECT * FROM Products;


SELECT sys.procedures;
SELECT sys.sql_modules;