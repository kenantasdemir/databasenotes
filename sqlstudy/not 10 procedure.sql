SELECT HAREKETID, URUNAD
FROM TBLHAREKET INNER JOIN TBLURUNLER
    ON TBLHAREKET.URUN = TBLURUNLER.URUNID


SELECT HAREKETID, URUNAD, MUSTERIAD
FROM TBLHAREKET INNER JOIN TBLURUNLER
    ON TBLHAREKET.URUN = TBLURUNLER.URUNID
    INNER JOIN TBLMUSTERI ON TBLHAREKET.MUSTERI=TBLMUSTERI.MUSTERIID

SELECT HAREKETID, URUNAD, MUSTERIAD + ' ' + MUSTERISOYAD AS 'AD SOYAD'
FROM TBLHAREKET INNER JOIN TBLURUNLER
    ON TBLHAREKET.URUN = TBLURUNLER.URUNID
    INNER JOIN TBLMUSTERI ON TBLHAREKET.MUSTERI=TBLMUSTERI.MUSTERIID

SELECT HAREKETID, URUNAD, MUSTERIAD + ' ' + MUSTERISOYAD AS 'AD SOYAD',
    PERSONELADSOYAD
FROM TBLHAREKET INNER JOIN TBLURUNLER
    ON TBLHAREKET.URUN = TBLURUNLER.URUNID
    INNER JOIN TBLMUSTERI ON TBLHAREKET.MUSTERI=TBLMUSTERI.MUSTERIID
    INNER JOIN TBLPERSONEL ON TBLHAREKET.PERSONEL=TBLPERSONEL.PERSONELID

SELECT HAREKETID, URUNAD, MUSTERIAD + ' ' + MUSTERISOYAD AS 'AD SOYAD',
    PERSONELADSOYAD, ADET, TUTAR, TARIH
FROM TBLHAREKET INNER JOIN TBLURUNLER
    ON TBLHAREKET.URUN = TBLURUNLER.URUNID
    INNER JOIN TBLMUSTERI ON TBLHAREKET.MUSTERI=TBLMUSTERI.MUSTERIID
    INNER JOIN TBLPERSONEL ON TBLHAREKET.PERSONEL=TBLPERSONEL.PERSONELID


--*******************************************************************************************************
/*
CREATE PROCEDURE HAREKETLER
AS
SELECT HAREKETID, URUNAD, MUSTERIAD + ' ' + MUSTERISOYAD AS 'AD SOYAD',
    PERSONELADSOYAD, ADET, TUTAR, TARIH
FROM TBLHAREKET INNER JOIN TBLURUNLER
    ON TBLHAREKET.URUN = TBLURUNLER.URUNID
    INNER JOIN TBLMUSTERI ON TBLHAREKET.MUSTERI=TBLMUSTERI.MUSTERIID
    INNER JOIN TBLPERSONEL ON TBLHAREKET.PERSONEL=TBLPERSONEL.PERSONELID;

EXECUTE HAREKETLER;

*/
--*******************************************************************************************************

/*
CREATE PROCEDURE DENEME
AS
SELECT * FROM TBLURUNLER WHERE URUNSTOK>10

EXEC DENEME

DROP PROCEDURE DENEME
--PROCEDURE SİLME

*/
--*******************************************************************************************************

/*
ALTER PROCEDURE [dbo].[HAREKETLER]
AS 
SELECT HAREKETID, URUNAD, LEFT(MUSTERIAD,1) + '.' + MUSTERISOYAD AS 'AD SOYAD',
    PERSONELADSOYAD, ADET, TUTAR, TARIH
FROM TBLHAREKET INNER JOIN TBLURUNLER
    ON TBLHAREKET.URUN = TBLURUNLER.URUNID
    INNER JOIN TBLMUSTERI ON TBLHAREKET.MUSTERI=TBLMUSTERI.MUSTERIID
    INNER JOIN TBLPERSONEL ON TBLHAREKET.PERSONEL=TBLPERSONEL.PERSONELID

EXEC HAREKETLER
*/

--*******************************************************************************************************
/*

CREATE PROCEDURE URUNGETIR
AS
SELECT URUNAD, URUNSTOK, URUNMARKA FROM TBLURUNLER

EXECUTE URUNGETIR

*/

--*******************************************************************************************************
/*
ALTER PROCEDURE URUNGETIR
    @Deger varchar(50)='BUZDOLABI'
AS
SELECT URUNAD, URUNSTOK, URUNMARKA FROM TBLURUNLER where URUNAD=@Deger

EXECUTE URUNGETIR

*/
--*******************************************************************************************************
/*
ALTER PROCEDURE URUNGETIR
    @Deger varchar(50)='BUZDOLABI'
AS
SELECT URUNAD, URUNSTOK, URUNMARKA FROM TBLURUNLER where URUNAD=@Deger

EXECUTE URUNGETIR @Deger='ÇAMAŞIR MAKİNESİ'
*/

/* QPOCER
Query
Parse SYNTAX HATASI VAR MI YOK MU
Optimize maliyet hesaplama kısmı denebilir. EN PERFORMANSLI SORGU ELDE EDILMEYE ÇALIŞILIR.
Compile KODLARIN DERLENDIGI ASAMADIR. BU ASAMADAN SONRA SORGU ÇALIŞTIRILMAYA HAZIR
EXECUTE  sorgu planı hazır olan kodların çalıştırılacağı kısımdır.
Results veritabanından alınacak veri varsa, bunların kullanıcıya görüntülendiği kısımdır.

*/

/*
Parse işlemi sırasında prosedürün, ismi sysobjects tablosuna, kaynak kodları
syscomments tablosuna kaydedilir.

Sorgu Ağacı (Query Tree) ya da Sıra Ağacı (Sequence Tree) denilen yapı ortaya
çıkarılır.

Parse işleminde oluşturulan sorgu ağacı kullanılarak çalıştırma planı (execution
plan) çıkartılır. Çalıştırma planında sorgu için gerekli tüm hak, denetim ve ilgili
nesne denetimleri yapılır.

İstekler, prosedür içerisindeki sorgu yapılarına göre
ilgili yöneticilere iletilir. (SELECT sorgusu DML yöneticisine iletilir)

*/

EXEC sp_configure 'show advanced options',1
GO
RECONFIGURE
GO
EXEC sp_configure
'xp_cmdshell',1
GO
RECONFIGURE
GO
/*
sp_help
sp_helpdb
sp_helptext
*/

CREATE PROCEDURE pr_Urunler
AS
BEGIN
    SELECT ProductID, Name,
        ProductNumber, ListPrice
    FROM Production.Product;
END;

--sp_helptext ‘pr_UrunleriGetir’;

--SP oluşturabilmek için sysadmin db_owner ddl_admin

/*
Bir sproc şu ifadeleri içeremez
• CREATE PROCEDURE
• CREATE DEFAULT
• CREATE RULE
• CREATE TRIGGER
• CREATE VIEW
*/

/*
SQL Server’da her işlemden sonra etkilenen kayıt sayısı hesaplanır ve mesaj
olarak geri döndürülür. Bu hesaplama sırasında fazladan kaynak tüketimi
gerçekleşir ve bu durum performansı olumsuz yönde etkiler.
*/

--NOCOUNT ON

/*
Veritabanı geliştirmeleri sırasında tablo yapıları ve indekslerin değiştirilmesi
söz konusu olabilir. Bu gibi durumlarda sproc’ların çalıştırma planı
(execution plan), tablo ve indeks yapısı farklı iken, derlendiği için performans olarak
olumsuz durumlar oluşabilir.
Sproc’ların bu gibi sorunlarla karşılaşmamaları için yeniden derlenmesi gerekir.

*/

EXECUTE prosedur_ismi WITH RECOMPILE
--bu daha performanslı


--DENY ON prosedur_ismi TO public

--GRANT ON prosedure_ismi TO kullanici_ismi

CREATE PROCEDURE pr_UrunAra(@ProductNumber NVARCHAR(25))
AS
WITH ENCRYPTION
SET NOCOUNT ON
IF @ProductNumber IS NOT NULL
SELECT
    ProductID, ProductNumber,
    Name, ListPrice
FROM
    Production.Product
WHERE
ProductNumber = @ProductNumber;
SET NOCOUNT OFF

EXEC prosedur_ismi @parametre_ismi = deger
--ya da
EXEC prosedur_ismi parametre_degeri

EXECUTE AS CALLER
--DEFAULT


EXECUTE AS 'kullanıcı'
Prosedürü çağıran kişi dışında, başka bir kullanıcı hesabı ile çalışmasını sağlar.
CREATE PROC pr_UrunGetir
    (
    @ProductID INT
)
WITH
    EXECUTE AS kullanici_ismi
AS
SELECT
    ProductID, Name, ProductNumber
FROM
    Production.Product
WHERE
ProductID = @ProductID;
/*
Bir başka deyişle, Stored
Procedure için bir yönlendirmeli yetkilendirme yapılmaktadır.
*/ 

EXECUTE AS SELF
EXECUTE AS
’i tanımlayan ya da değiştiren kullanıcıyı vermek gerektiğinde
kullanılır. Sahiplik zinciri değişse bile bu durum değişmez.

EXECUTE AS OWNER
Prosedürün içerdiği kodlar prosedür sahibi adına çalıştırılır. Eğer bir sahibi yok
ise, prosedürün içinde bulunduğu şemanın sahibi adına çalışır.


SELECT
    Name, Type, Type_Desc,
    Create_Date, Modify_Date
FROM
    Sys.Procedures;

SELECT *
FROM Sys.Sql_Modules;

/*
Stored Procedure’lerin bazen, tablolardan aldıkları verileri farklı isim ya da veri
tipinde getirmelerini isteyebiliriz. Bu gibi durumlarda
WITH RESULT
SET yan
cümlesini
kullanarak Stored Procedure çağırabiliriz.
*/
CREATE PROC pr_UrunGetir
    (
    @ProductID INT
)
AS
SELECT ProductID, Name, ProductNumber
FROM Production.Product
WHERE ProductID = @ProductID;


EXEC pr_UrunGetir 4
WITH RESULT SETS(
(
KOD VARCHAR(20),
[Ürün Adı] VARCHAR(20),
[Ürün Numarası] VARCHAR(7)
)
);