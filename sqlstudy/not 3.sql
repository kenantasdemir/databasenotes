use DbOgrenci
SELECT COUNT(*) FROM TBLOGRENCILER

SELECT COUNT(*) As 'Toplam Kayit' FROM TBLOGRENCILER
SELECT COUNT(*) As 'Toplam Kişi' FROM TBLOGRENCILER WHERE OGRSEHIR='Adana'

SELECT SUM(SINAV1) FROM TBLNOTLAR

SELECT SUM(SINAV1),SUM(SINAV2),SUM(SINAV3) FROM TBLNOTLAR

SELECT SUM(SINAV1) AS 'Birinci Sinav',SUM(SINAV2) As 'İkinci sinav' ,SUM(SINAV3) As 'Üçüncü Sinav' FROM TBLNOTLAR

SELECT AVG(SINAV1),AVG(SINAV2),AVG(SINAV3) FROM TBLNOTLAR

SELECT MAX(SINAV1) FROM TBLNOTLAR

SELECT MAX(SINAV1),MAX(SINAV2),MAX(SINAV3) FROM TBLNOTLAR

SELECT MIN(SINAV1),MIN(SINAV2),MIN(SINAV3) FROM TBLNOTLAR