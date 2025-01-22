SELECT COALESCE(Title,'Title Bilgisi Yok') FROM MOVIES;
//Movies tablosundaki kayıtlarda title bilgisi olmayan kayıtların Title sütununa Title Bilgisi Yok ifadesini atar.

SELECT OGRAD,OGRSINIF,OGRNUMARA,OGRYAS COALESCE(OGRAD,OGRSINIF,OGRNUMARA) AS 'NULL OLMAYAN ILK DEGER' FROM PRODUCTS;
//COALESCE fonksiyonuna verilen alanlardan NULL olmayan ilk değeri verir.

SELECT OGRAD,OGRSOYAD NULLIF(OGRAD,OGRSOYAD) AS 'ograd' FROM TBLOGRENCILER;
--iki ifade birbirine eşitse NULL, eşit değilse ilk parametreyi döndürür.


SELECT ProductCategoryID FROM products
INTERSECT
SELECT ProductCategoryID FROM ProductSubCategory
--iki tablodan kesişen kayıtları getirir.


SELECT ProductID FROM products
EXCEPT
SELECT ProductID FROM WorkOrders;
--ilkinde olup ikinci de olmayan kayıtları getirir.


