SELECT OGRSEHIR,Count(*) as 'Toplam' FROM TBLOGRENCILER GROUP BY OGRSEHIR
--OGRSEHIR bilgisine göre gruplar
--her şehirden kaç öğrenci kayıtlı olduğu bilgisini verir.

SELECT OGRCINSIYET,COUNT(*) As 'Toplam' FROM TBLOGRENCILER GROUP BY OGRCINSIYET
--OGRCINSIYET değerine göre gruplar
--tabloda kayıtlı erkek/kız öğrenci sayısını döndürür.

UPDATE TBLNOTLAR SET ORTALAMA=(SINAV1+SINAV2+SINAV3)/3
--her kayıt için 3 sınavın ortalamasını hesaplar

SELECT OGRKULUP,COUNT(*) FROM TBLOGRENCILER GROUP BY OGRKULUP
--OGRKULUP değerine göre gruplar. OGRKULUP değerlerini ve sayılarını getirir.
--her kulüpte kaç öğrenci var bilgisini verir.


--********************************************************************************************

SELECT OGRSEHIR,COUNT(*) AS 'SAYI' FROM TBLOGRENCILER GROUP BY OGRSEHIR HAVING COUNT(*)=2
--hangi şehirden 2 öğrenci kayıtlı ise o şehri döner.


SELECT OGRKULUP,COUNT(*) FROM TBLOGRENCILER GROUP BY OGRKULUP HAVING OGRKULUP='Kitaplık'
--OGRKULUP değerine göre gruplar. OGRKULUP değeri Kitaplık olan kayiların OGRKULUP değerini ve sayılarını getirir.

--********************************************************************************************

SELECT * FROM TBLOGRENCILER WHERE OGRAD LIKE '%z%' AND OGRSEHIR LIKE '%i%'
--TBLOGRENCILER tablosunda OGRAD değeri içinde z harfi bulunanlar ve OGRSEHIR değeri içinde i harfi bulunan kayıtlar getirildi.

SELECT * FROM TBLOGRENCILER WHERE OGRAD LIKE 'a%'
--OGRAD değeri "a" ile başlayan kayıtlar getirildi

SELECT * FROM TBLOGRENCILER WHERE OGRAD LIKE '%n'
--OGRAD değeri "n" ile biten kayıtlar getirildi

SELECT * FROM TBLOGRENCILER WHERE OGRSEHIR LIKE '%ar%'
--OGRSEHIR değerinin içinde "ar" ifadesi geçen kayıtlar getirilir.

SELECT * FROM TBLOGRENCILER WHERE OGRKULUP NOT LIKE '%i%'
--OGRKULUP değeri içinde "i" harfi bulunmayan kayıtlar getirilir.

--********************************************************************************************

SELECT OGRSEHIR FROM TBLOGRENCILER
--TBLOGRENCILER tablosunda OGRSEHIR kayıtları getirilir.

SELECT DISTINCT OGRSEHIR FROM TBLOGRENCILER
--TBLOGRENCILER tablosunda OGRSEHIR kayıtları getirilir. fakat kayıtlar eşleşemez.
--Yani OGRSEHIR bilgisi Kayseri olan 2 veya daha fazla kullanıcı olamaz.

SELECT COUNT(DISTINCT(OGRSEHIR)) FROM TBLOGRENCILER
--OGRSEHIR bilgisi eşsiz olan kayıtların sayısını döndürür.

SELECT DISTINCT OGRKULUP FROM TBLOGRENCILER
--OGRKULUP değerleri eşsiz olan kayıtlar getirilir.

SELECT COUNT(DISTINCT(OGRKULUP)) FROM TBLOGRENCILER
--OGRKULUP değeri eşsiz olan kayıtların sayısını döndürür.

--********************************************************************************************


SELECT * FROM TBLOGRENCILER ORDER BY OGRAD
--TBLOGRENCILER tablosundaki kayıtları OGRAD değerine göre sıralar
--default olarak ASC

SELECT * FROM TBLOGRENCILER ORDER BY OGRAD ASC
----TBLOGRENCILER tablosundaki kayıtları OGRAD değerine göre ASC(artan) olarak sıralar

SELECT * FROM TBLOGRENCILER ORDER BY OGRAD DESC
----TBLOGRENCILER tablosundaki kayıtları OGRAD değerine göre DESC(azalan) olarak sıralar


SELECT DISTINCT OGRSEHIR FROM TBLOGRENCILER ORDER BY OGRSEHIR DESC
--TBLOGRENCILER tablosunda OGRSEHIR değeri eşsiz olan kayıtları OGRSEHIR değerine göre DESC olarak sıralar.


--********************************************************************************************

SELECT * FROM TBLOGRENCILER WHERE OGRSEHIR LIKE '%ir%'
--başında ve sonunda olmamak kaydıyla OGRSEHIR değeri içinde "ir" bulunan kayıtlar getirilir.

SELECT * FROM TBLOGRENCILER WHERE OGRSEHIR LIKE '%ir_%'
--ne ile başladığı farketmez fakat "ir" ifadesi birlikte olmalı
--altçizgi için bu ifadeden sonra bir harf gelmeli
--sonunda ne olduğu farketmez.

SELECT * FROM TBLOGRENCILER WHERE OGRSEHIR LIKE '%an_%'
--başında ve sonunda ne olduğu farketmez
--"an" ifadesi birlikte olmalı ve bu ifadeden sonra bir harf gelmeli

SELECT * FROM TBLOGRENCILER WHERE OGRAD LIKE '[A,B]%'
--A ya da B ile başlayan OGRAD değerlerinin lduğu kayıtlar getirilir. 

SELECT * FROM TBLOGRENCILER WHERE OGRAD LIKE '%[A,B]%'
--başında ve sonunda olmamak kaydıyla içinde "A" ya da "B" harfi bulunan OGRAD değerlerine ait kayıtlar getilir.

SELECT * FROM TBLOGRENCILER WHERE OGRAD LIKE '%[A,B]'
--başında ne olduğu farketmez son harfinde A ya da B olan OGRAD değerlerinin ait olduğu kayıtlar getirilir.

SELECT * FROM TBLOGRENCILER WHERE OGRKULUP LIKE '[a-m]%'
--sonunda ne olduğu farketmez. 
--ilk harfinin "a" ile "m" arasındaki harflerle başladığı OGRKULUP değerinin ait olduğu kayıtlar getirilir. 

SELECT * FROM TBLOGRENCILER WHERE OGRKULUP LIKE '%[a-e]'
--ne ile başladığı farketmez. fakat "a" ile "e" arasındaki harfler ile bitmeli

--********************************************************************************************

SELECT * FROM TBLOGRENCILER WHERE OGRID<=3
--TBLOGRENCILER tablosunda OGRID değeri 3 ya da 3'ten küçük olan kayıtlar getirilir.

SELECT TOP 3 * FROM TBLOGRENCILER
--TBLOGRENCILER tablosundan ilk 3 kaydı getirir.

SELECT TOP 4 * FROM TBLOGRENCILER ORDER BY OGRID DESC
--TBLOGRENCILER tablosundan ilk 4 kayıt getirilir.
-- getirilen kayıtlar OGRID değerine göre DESC olarak sıralanır.

SELECT TOP 50 PERCENT * FROM TBLOGRENCILER
--TBLOGRENCILER tablosundan %50 oranında kayıt getirilir.

--********************************************************************************************

SELECT * FROM TBLOGRENCILER WHERE OGRSEHIR in('İzmir','Ankara','Edirne')
--TBLOGRENCILER tablosunda OGRSEHIR bilgisi beliritilen değerler arasında olan kayıtlar getirilir

SELECT * FROM TBLNOTLAR WHERE SINAV1 in(70,75,80,85,90)
--TBLNOTLAR tablosunda SINAV1 değeri belirtilen değerler arasında olan kayıtları listeler

SELECT * FROM TBLNOTLAR WHERE SINAV1 NOT in(70,75,80,85,90)
--TBLNOTLAR tablosunda SINAV1 değeri belirtilen değerler arasında olmayan kayıtları listeler


--********************************************************************************************

SELECT * FROM TBLNOTLAR WHERE ORTALAMA BETWEEN 74 AND 100
--TBLNOTLAR tablosunda ORTALAMA bilgisi 74 ile 100 arasında olan bütün kayıtlar getirilir.

SELECT * FROM TBLOGRENCILER WHERE OGRAD BETWEEN 'A' AND 'K'  
--adı A-K arasındaki harflerden biriyle başlayan kayıtlar getirildi

SELECT * FROM TBLOGRENCILER WHERE OGRAD NOT BETWEEN 'A' AND 'K'
--adı A-K arasındaki harflerden biriyle başlamayan kayıtlar getirildi

--********************************************************************************************

SET CONCAT_NULL_YIELDS_NULL OFF;
--default olarak NULL ile yapılan işlmlerin sonucu NULL olur
--bu deyim ile bu özelliği kapatmış olduk.

SELECT 'Kenan' + SPACE(5) + 'Tasdemir'

SELECT OGRAD FROM TBLOGRENCILER WHERE OGRID IS NULL;

SELECT Adi, ISNULL(Adi,'İsim Yok') FROM Ogrenci;

SELECT 1 + SPACE(1) +4
--çıktı

--********************************************************************************************
SELECT ProductID, Name, Color ISNULL()




















