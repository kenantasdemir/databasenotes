create table TBLDERSLER(
DERSID tinyint,
DERSAD varchar(20)
)

ALTER TABLE TBLDERSLER ADD KONTENJAN smallint   
--KONTENJAN isimli sütun ekler

ALTER TABLE TBLDERSLER DROP COLUMN KONTENJAN    
--KONTENJAN isimli sütunu siler

SELECT * FROM TBLOGRENCILER
--TBLOGRENCILER tablosundakibütün kayıtları çeker

SELECT OGRAD,OGRSOYAD FROM TBLOGRENCILER
--TBLOGRENCILER tablosundan OGRAD ve OGRSOYAD bilgilerini çeker

SELECT OGRSEHIR FROM TBLOGRENCILER
--TBLOGRENCILER tablosundan OGRSEHIR biglgisini çeker

SELECT OGRAD FROM TBLOGRENCILER WHERE OGRID=5
--TBLOGRENCILER tablosundan OGRID değeri 5 olan kaydın OGRAD bilgisini getirir.

SELECT * FROM TBLOGRENCILER WHERE OGRAD='Ali'
--OGRAD değeri "Ali" olan kayda ait tüm bilgileri getirir.

SELECT * FROM TBLOGRENCILER WHERE OGRSEHIR='Adana' AND OGRKULUP='Kitaplık'
--TBLOGRENCILER tablosundan OGRSEHIR değeri Adana olan aynı zamanda OGRKULUP değeri Kitaplık olan kaydın tüm bilgilerini getirir.

SELECT * FROM TBLOGRENCILER WHERE OGRSEHIR='Adana' OR OGRKULUP='Kitaplik'
--TBLOGRENCILER tablosundan OGRSEHIR bilgisi Adana olan ya da OGRKULUP bilgisi Kitaplik olan kaydın tüm bilgilerini getirir.




--**************************************************************************************************************************************

SELECT * FROM TBLNOTLAR
--TBLNOTLAR tablosundan tümkayıtları getirir.

SELECT (SINAV1+SINAV2+SINAV3) FROM TBLNOTLAR
--TBLNOTLAR tablosunda 3 sınavın toplamını verir.

SELECT (SINAV1+SINAV2+SINAV3)/3 FROM TBLNOTLAR
--TBLNOTLAR tablosunda 3 sınavın ortalamasını verir.


--****************************************************************************************************************************

INSERT INTO TBLOGRENCILER(OGRAD,OGRSOYAD,OGRSEHIR) VALUES ('Kenan','Taşdemir','Kayseri')

INSERT INTO TBLNOTLAR (OGRENCI,DERS,SINAV1,SINAV3) VALUES (6,2,88,67)

INSERT INTO TBLNOTLAR (OGRENCI,DERS,SINAV1,SINAV2) VALUES (2,2,45,99)

INSERT INTO TBLOGRENCILER (OGRAD,OGRKULUP,OGRSEHIR) VALUES ('Berna',4,'Ankara')

--****************************************************************************************************************************


DELETE FROM TBLDERSLER  
--tablodaki bütün verileri siler

DELETE FROM TBLDERSLER WHERE DERSID=3
--TBLDERSLER tablosunda DERSID değeri 3 olan kaydı siler

DELETE FROM TBLDERSLER WHERE DERSAD='Algoritma'
--TBLDERSLER tablosunda DERSAD değeri "Algoritma" olan kaydı siler

--****************************************************************************************************************************

TRUNCATE TABLE TBLDERSLER  --tabloyu sıfırlar(tüm veriler silinir)

--****************************************************************************************************************************



UPDATE TBLOGRENCILER SET OGRYAS=25
--TBLOGRENCILER tablosundaki tüm kayıtların OGRYAS değerini 25 olarak günceller

UPDATE TBLOGRENCILER SET OGRYAS=22 WHERE OGRID=2
--TBLOGRENCILER tablosunda OGRID değeri 2 olan kaydın OGRYAS bilgisini 22 olarak günceller

UPDATE TBLOGRENCILER SET OGRYAS=27 WHERE OGRID=3 OR OGRID=4
--TBLOGRENCILER tablosunda OGRID değeri 3 ya da 4 olan kaydın OGRYAS bilgisini 27 yapar

UPDATE TBLOGRENCILER SET OGRKULUP='Kitaplık' where OGRAD='Kenan'
--TBLOGRENCILER tablosunda OGRAD değeri "Kenan" olan kaydnın OGRKULUP bilgisini "Kitaplik" olarak ayarlar

UPDATE TBLNOTLAR SET DERSID=2
--TBLNOTLAR tablosunda tümkayıtların DERSID değerini 2 yapar


UPDATE TBLNOTLAR SET SINAV2=SINAV2+10 FROM TBLNOTLAR WHERE DERSID=1
--DERSID değeri 1 olan kayıt için o anki SINAV2 değerine 10 eklenir.

UPDATE TBLNOTLAR SET SINAV2=100 WHERE SINAV1=100
--SINAV1 değeri 100 olan kaydın SINAV2 değerini 100 olarak günceller.


SELECT * FROM TBLNOTLAR WHERE DERSID=1
--DERSID değeri 1 olan kayıt hakkında bilgi getirir.s



UPDATE TBLNOTLAR SET ORTALAMA=(SINAV1+SINAV2+SINAV3)/3
--TBLNOTLAR tablosunda her kayıt için 3 sınavın ortalamasını hesaplar ve günceller

UPDATE TBLNOTLAR SET DURUM=1 WHERE ORTALAMA>=50
--TBLNOTLAR tablosunda ORTALAMASI 50'ye eşit ya da yüksek kayıtlar için DURUM değerini 1 olarak günceller

UPDATE TBLNOTLAR SET DURUM=0 WHERE ORTALAMA<50
--TBLNOTLAR tablosunda ORTALAMASI 50'den küçük kayıtlar için DURUM değerini 0 olarak günceller















