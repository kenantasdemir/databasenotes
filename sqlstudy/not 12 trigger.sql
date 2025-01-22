/*
Trigger’lar bir transaction olarak çalışırlar. Hata ile karşılaşıldığında ROLLBACK
ile yapılan işlemler geri alınabilir. Trigger yapısının en önemli unsurlarından biri
sözde tablolardır. Sözde tablolar, INSERTED ve DELETED olmak üzere iki adettir.
Bu tablolar RAM üzerinde mantıksal olarak bulunurlar. Gerçek veri tablosuna
veri eklendiğinde, eklenen kayıt INSERTED tablosuna da eklenir. Tablodan
bir kayıt silindiğinde ise silinen kayıt DELETED tablosunda yer alır.

Trigger’lar şu ifadeleri içeremez;
• CREATE DATABASE • LOAD LOG
• ALTER DATABASE • RESTORE LOG
• DROP DATABASE • DISK INIT
• LOAD DATABASE • DISK RESIZE
• RESTORE DATABASE • RECONFIGURE
*/

CREATE TRIGGER locationInsert
ON Production.Location
AFTER INSERT
AS
BEGIN
SET NOCOUNT ON;
SELECT 'Yeni lokasyon bilgisi eklendi.';
SET NOCOUNT OFF;
END;

CREATE TRIGGER trg_PersonelHatirlatici ON Personeller
AFTER INSERT
AS
RAISERROR ('Eklenen Personeli Bildir', 16, 10);

CREATE TRIGGER trg_ProductLog
ON Production.Product
AFTER INSERT
AS
BEGIN
INSERT INTO ProductLog SELECT ProductID, Name,
ProductNumber, ListPrice
FROM inserted;
END;

CREATE TRIGGER trg_KullaniciSil
ON Kullanicilar
AFTER DELETE
AS
BEGIN
SELECT deleted.KullaniciAd + ' kullanıcı adına ve ' + deleted.Email + 
'email adresine sahip kullanıcı silindi.' FROM deleted;
END;

CREATE TRIGGER trg_UrunGuncellemeTarihiniGuncelle
ON Production.Product
AFTER UPDATE
AS
BEGIN
UPDATE Production.Product
SET ModifiedDate = GETDATE()
WHERE ProductID = (SELECT ProductID FROM inserted)
END;

CREATE TRIGGER trigger_ismi
ON tablo_ismi
AFTER INSERT, UPDATE, DELETE;

/*
INSTEAD OF Trigger’lar veri değişimi başlamadan hemen önce çalışırlar.
Tabloda bir değişiklik yapılmadan, hatta constraint’ler bile devreye girmeden
çalışırlar. Sözde tablolar (INSERTED, DELETED) bu trigger türü tarafından da
desteklenir.

INSTEAD OF UPDATE Trıgger
INSTEAD OF Trigger’lar, güncelleme işleminden önce gerçekleştirilmesi
gereken kontroller ve işlemlerdeki değişiklikler için kullanılabilir.

CREATE TRIGGER trigger_name
ON tablo_ismi
INSTEAD OF INSERT || UPDATE || DELETE
AS
    ...



INSTEAD OF DELETE Trıgger
Veri silme işlemlerinden önce de bazı işlem ya da kontroller yapılmak
istenebilir. Örneğin; bir veri silme işlemi gerçekleştirilirken, silme işlemi yerine
güncelleme işlemi yapmak gerekebilir.
*/

/*
UPDATE() Fonksiyonu
UPDATE() fonksiyonu, trigger çalışma alanı içerisinde çalışan bir fonksiyondur.
Belirli bir sütunun güncellenip güncellenmediğini öğrenmek için kullanılabilir.
Güncelleme bilgisini Boolean veri tipiyle True/False olarak bildirir.

CREATE TRIGGER Production.ProductNumberControl
ON Production.Product
AFTER UPDATE
AS
BEGIN
IF UPDATE(ProductNumber)
BEGIN
PRINT ‘ProductNumber değeri değiştirilemez.’;
ROLLBACK
END;
END;

COLUMNS_UPDATED() Fonksiyonu
Trigger ile güncelleme işlemlerinde kullanılır. UPDATE() fonksiyonu ile benzer
amaca sahiptir. UPDATE() fonksiyonu tekil sütun değişikliklerini takip ederken,
COLUMNS_UPDATED() fonksiyonu çoklu sütun değişikliklerini takip etmek için
kullanılır. Bu fonksiyon, binary olarak değişen sütunların listesini metinsel veri
tipi olan VARCHAR olarak döndürür.
Söz Dizimi:
CREATE TRIGGER trigger_ismi
ON tablo_ismi
FOR UPDATE[, INSERT, DELETE]
AS
IF COLUMNS_UPDATED() & maskeleme_degeri > 0
BEGIN
-- Sütun değişikliklerine göre çalışacak sorgu bloğu.
END;

SELECT trigger_nestlevel(object_ID(‘trigger_ismi’));

Aşağıdaki yöntem ile iç içe trigger özelliği kapatılabilir.
sp_configure ‘nested triggers’, 0


ALTER DATABASE veritabani_ismi
SET RECURSIVE_TRIGGERS ON

DDL trigger’lar, sadece AFTER trigger olarak tanımlanabilirler. INSTEAD OF
türden bir DDL trigger oluşturulamaz.

CREATE TRIGGER trigger_ismi
ON {DATABASE | ALL SERVER}
FOR { veritabani_seviyeli_olaylar | sunucu_seviyeli_olaylar }
AS
-- Trigger sorgu gövdesi

Veritabanı Seviyeli DDL Trıgger’lar
Veritabanı seviyeli bir DDL trigger oluşturmak için ON komutundan sonra
DATABASE kullanılmalıdır. DDL trigger’ı oluştururken bir veritabanı ismi
verilmez. Hangi veritabanı için çalıştırılırsa, o veritabanı için geçerli bir trigger
olacaktır.
AdventureWorks veritabanı seçili iken yeni bir DDL trigger oluşturalım. Bu
trigger, veritabanında tablo, prosedür, view oluşturmayı yasaklasın.

CREATE TRIGGER KritikNesnelerGuvenligi
ON DATABASE
FOR CREATE_TABLE, CREATE_PROCEDURE, CREATE_VIEW
AS
PRINT ‘Bu veritabanında tablo, prosedür ve view oluşturmak yasaktır!’
ROLLBACK;

Sunucu Seviyeli DDL Trıgger’lar
Sunucu seviyeli DDL trigger’lar, sunucunun bütününe özgü işlemlere
duyarlıdır. Sunucu seviyeli trigger oluşturmak için ON komutundan sonra ALL
SERVER kullanılmalıdır.
Yeni bir veritabanı oluşturma işlemini yakalayacak trigger oluşturalım.

CREATE TRIGGER SunucuBazliDegisiklikler
ON ALL SERVER
FOR CREATE_DATABASE
AS
PRINT ‘Veritabanı oluşturuldu.’;
SELECT EVENTDATA().value(‘(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]’,
‘NVARCHAR(MAX)’);

ALTER TRIGGER SunucuBazliDegisiklikler
ON ALL SERVER
FOR CREATE_DATABASE, DDL_LOGIN_EVENTS
AS
PRINT ‘Veritabanı ya da Login oluşturma olayı yakalandı.’;
SELECT EVENTDATA().value(‘(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]’,
‘NVARCHAR(MAX)’);

sp_rename sistem prosedürü kullanılarak trigger’ın sadece ismi değiştirilebilir.

ALTER TABLE Production.Product
DISABLE TRIGGER ProductNumberControl;

Bir tablodaki tüm trigger’ları kapatalım.
ALTER TABLE Production.Product
DISABLE TRIGGER ALL;

Kapatılan tek bir trigger’ı tekrar açalım.
ALTER TABLE Production.Product
ENABLE TRIGGER ProductNumberControl;

Bir tablodaki tüm trigger’ları tekrar açalım.
ALTER TABLE Production.Product
ENABLE TRIGGER ALL;

DROP TRIGGER trigger_ismi

DROP TRIGGER trigger_ismi
ON DATABASE

EventLogCreateBackup isimli veritabanı seviyeli DDL trigger’ı silelim.
DROP TRIGGER EventLogCreateBackup
ON DATABASE;

Sunucu Seviyeli DDL Trıgger’ları Silmek
Sunucu seviyeli DDL trigger’ları silmek için söz dizimi ON ALL SERVER ifadesi alır.
DROP TRIGGER trigger_ismi
ON ALL SERVER;

SunucuBazliDegisiklikler isimli sunucu bazlı DDL trigger’ı silelim.
DROP TRIGGER SunucuBazliDegisiklikler
ON ALL SERVER;
*/


/*
INSTEAD OF TRIGGERS
İşlem gerçekleşmeden hemen önce devreye girdiği için, bu trigger’lar genel
olarak view’lere veri ekleme işlemlerini yönetmek için kullanılır. Tablolar
üzerinde de, yapılmak istenen işlemi durdurmak ya da farklı bir işleme
yönlendirerek otomatik olarak belirlenen bu işlemin gerçekleşmesini sağlamak
için kullanılabilir.
*/

CREATE TABLE TBLSAYAC
(
ISLEM int
);

INSERT INTO TBLSAYAC VALUES(0);


UPDATE TBLSAYAC SET ISLEM =(SELECT COUNT(*) FROM TBLHAREKET);

CREATE TRIGGER ISLEMARTIS
ON TBLHAREKET
AFTER INSERT
AS
UPDATE TBLSAYAC SET ISLEM=ISLEM+1

--**************************************************************************************************************************************************************************************

CREATE TABLE TBLTOPLAMKATEGORI
(
ADET tinyint
)

UPDATE TBLTOPLAMKATEGORI SET ADET=(SELECT COUNT(*) FROM TBLKATEGORI)

CREATE TRIGGER KATEGORIARTIS ON TBLKATEGORI
AFTER INSERT AS 
UPDATE TBLTOPLAMKATEGORI SET ADET=ADET+1

CREATE TRIGGER KATEGORIAZALIS
ON TBLKATEGORI AFTER DELETE
AS
UPDATE TBLTOPLAMKATEGORI SET ADET=-1







