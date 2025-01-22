DECLARE @Sayi int
SET @Sayi=24
SELECT @Sayi as 'Sonuç'

DECLARE @Kisi1 varchar(20)
SET @Kisi1='Kenan'
SELECT @Kisi1

DECLARE @sayi1 int, @sayi2 int, @toplam int
set @sayi1=20
set @sayi2=30
set @toplam=@sayi1+sayi2
SELECT @toplam

**********************************************************************************************************************************************************************************************************************************************


DECLARE @sayi int,@birler int,@onlar int, yuzler @int, @toplam int
set @sayi=456
set @birler=@sayi % 10
set @onlar=(@sayi/10)%10
set @yuzler=@sayi/100
set @toplam = @birler+ @onlar + @yuzler
select @birler, @onlar, @yuzler, @toplam

**********************************************************************************************************************************************************************************************************************************************

DECLARE @Bakiye int
set @Bakiye = Select Max(MUSTERIBAKIYE) FROM TBLMUSTERI
select @Bakiye

DECLARE @stok int
Select @stok=max(urunstok) FROM TBLURUNLER
Select @stok
Selectt * from TBLURUNLER WHERE URUNSTOK=@stok


**************************************************************************************************************************

SELECT @@SERVERNAME, @@ERROR, @@DEFAULT_LANGID, @@LANGUAGE, @@MAX_CONNECTIONS,
@@MICROSOFTVERSION, @@IDENTITY, @@TEXTSIZE, @@VERSION

****************************************************************************************************************************************************************************************************************************************************

Print 'Merhaba'
DECLARE @s1 int, @s2 int, @sonuc int
set @s1=4
set @s2=8
set @sonuc = @s1*@s2
print '4 ile 8 sayilarinin çarpımı: '
print @sonuc


****************************************************************************************************************************************************************************************************************************************************

DECLARE @Kisiler table
(
KisiID int identity(1,1),
KisiAd varchar(10),
KisiSehir varchar(15)
)

INSERT INTO @Kisiler (KisiAd,KisiSehir) VALUES('Ali','Malatya')
INSERT INTO @Kisiler (KisiAd,KisiSehir) VALUES('Ayşe','Kayseri')

SELECT * FROM @Kisiler
SELECT * FROM @Kisiler WHERE KisiSehir like '%r%'

****************************************************************************************************************************************************************************************************************************************************

if(10<5)
print 'merhaba'
else
print 'selam'


if(select sum(urunstok) FROM TBLURUNLER) > 100
print 'toplam ürün sayısı: ' + '123. '+  '100 den büyük'
else
print 'toplam ürün sayısı 100 den küçük'



if(select count(*) FROM TBLURUNLER) > 20
print '20 den daha fazla çeşit  ürün var'
else
print '20 den az çeşit ürün var'


****************************************************************************************************************************************************************************************************************************************************

SELECT URUNAD,URUNMARKA,URUNDURUM=
CASE URUNDURUM
WHEN '1' THEN 'ÜRÜN VAR'
WHEN '0' THEN 'ÜRÜN YOK'
END
FROM TBLURUNLER

SELECT URUNAD,URUNMARKA,KATEGORI=
CASE KATEGORI
WHEN '1' THEN 'LAPTOP'
WHEN '2' THEN 'BEYAZ EŞYA'
WHEN '3' THEN 'KÜÇÜK EV ALETİ'
END
FROM TBLURUNLER


SELECT * FROM TBLURUNLER

****************************************************************************************************************************************************************************************************************************************************

CREATE PROCEDURE STOKKONTROL
AS
SELECT URUNAD,URUNMARKA,URUNSTOK,URUNSTOK=
CASE
WHEN URUNSTOK>=1 AND URUNSTOK<=5 THEN 'KRİTİK SEVİYE'
WHEN URUNSTOK>=6 AND URUNSTOK <=10 THEN 'TAKVİYE YAPILMALI'
WHEN URUNSTOK>10 THEN 'ÜRÜN STOK YETERLİ'
END
FROM TBLURUNLER


****************************************************************************************************************************************************************************************************************************************************

DECLARE @sayac int
set @sayac=1
WHILE @sayac<=5
BEGIN
print 'merhaba sql dersleri'
set @sayac=@sayac+1
END

DECLARE @i int
set @i=1
WHILE @i<=10
BEGIN
set @i+=1
print @i
END

DECLARE @toplam int,@sayac int
set @sayac=1
set @toplam=0
WHILE(@sayac<=10)
BEGIN
set @toplam=@toplam+@sayac
set @sayac+=1
END
print '1 ile 10 arasındaki sayilarin toplami'
print '------------------'
print @toplam


SELECT AVG(URUNSATISFIYAT-URUNALISFIYAT) FROM TBLURUNLER

SELECT AVG(URUNSATISFIYAT-URUNALISFIYAT) FROM TBLURUNLER WHERE KATEGORI=2

WHILE(SELECT AVG(URUNSATISFIYAT-URUNALISFIYAT) FROM TBLURUNLER WHERE KATEGORI=2)
BEGIN
UPDATE TBLURUNLER SET URUNSATISFIYAT+=URUNSATISFIYAT*10/100
END
SELECT * FROM TBLURUNLER



****************************************************************************************************************************************************************************************************************************************************

WAITFOR DELAY '00:00:07'
INSERT INTO TBLKATEGORI(KATEGORIAD) VALUES('DİĞER')
SELECT * FROM TBLURUNLER





























