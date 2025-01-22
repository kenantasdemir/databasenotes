use DbOgrenci
--bu komut çalıştırıldığında yazılan bütün komutlar bu veritabanı üzerinde çalışır

SELECT COUNT(*) FROM TBLOGRENCILER
--TBLOGRENCILER tablosunda bulunan kayıt sayısı

SELECT COUNT(*) As 'Toplam Kayit' FROM TBLOGRENCILER
--TBLOGRENCILER tablosunda bulunan kayıt sayısını döner. sütun için "Toplam Kayit" takma adını kullanır.

SELECT COUNT(*) As 'Toplam Kişi' FROM TBLOGRENCILER WHERE OGRSEHIR='Adana'
--TBLOGRENCILER tablosunda OGRSEHIR değeri "Adana" olan kayıtların sayısını yazdırır. sütuna "Toplam Kişi" takma adı verildi.

SELECT SUM(SINAV1) FROM TBLNOTLAR
--TBLNOTLAR tablosunda SINAV1 sütunundaki veriler toplandı.

SELECT SUM(SINAV1),SUM(SINAV2),SUM(SINAV3) FROM TBLNOTLAR
--TBLNOTLAR tablosunda her sütundaki veriler toplandı.

SELECT SUM(SINAV1) AS 'Birinci Sinav',SUM(SINAV2) As 'İkinci sinav' ,SUM(SINAV3) As 'Üçüncü Sinav' FROM TBLNOTLAR

SELECT AVG(SINAV1),AVG(SINAV2),AVG(SINAV3) FROM TBLNOTLAR
--SINAV1 SINAV2 SINAV3 sütunlarının ortalaması yazdırıldı.

SELECT MAX(SINAV1) FROM TBLNOTLAR
--SINAV1 sütunundaki en yüksek not yazdırıldı

SELECT MAX(SINAV1),MAX(SINAV2),MAX(SINAV3) FROM TBLNOTLAR
--her sütundaki en yüksek not hesaplandı.

SELECT MIN(SINAV1),MIN(SINAV2),MIN(SINAV3) FROM TBLNOTLAR
--her sütundaki en düşük not hesaplandı.