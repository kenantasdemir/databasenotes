SELECT UPPER(OGRAD) AS 'AD', UPPER(OGRSOYAD) AS 'SOYAD', LOWER(OGRSEHIR) AS 'ŞEHİR' FROM TBLOGRENCILER

SELECT SUBSTRING(OGRAD,1,2) FROM TBLOGRENCILER

SELECT SUBSTRING(OGRAD,1,1) + '.' + OGRSOYAD AS 'AD SOYAD' FROM TBLOGRENCILER

--**********************************************************************************************

SELECT LEFT('MERHABA DUNYA',4)
--verilen metnin soldan 4 karakterini yazdırır.

SELECT RIGHT('MERHABA ISTANBUL',2)

SELECT LEFT(OGRAD,1) + '.' + OGRSOYAD AS 'Ad Soyad' FROM TBLOGRENCILER

--**********************************************************************************************

SELECT LEN('MERHABA')

SELECT LEN(OGRAD) FROM TBLOGRENCILER WHERE OGRSEHIR='Adana'

SELECT OGRAD,LEN(OGRAD),OGRKULUP FROM TBLOGRENCILER WHERE OGRSEHIR='Adana' 

SELECT OGRAD,LEN(OGRAD),OGRKULUP FROM TBLOGRENCILER WHERE OGRSEHIR='Adana' AND
OGRKULUP=(SELECT KULUPID FROM TBLKULUPLER WHERE KULUPAD='Bilişim')

SELECT * FROM TBLOGRENCILER WHERE LEN(OGRAD)=4 OR LEN(OGRAD)=3

SELECT * FROM TBLOGRENCILER WHERE LEN(OGRAD+OGRSOYAD) BETWEEN 3 AND 8

--**********************************************************************************************

SELECT LTRIM('     Hola Mundo')

SELECT RTRIM('Hola Mundo     ')

SELECT REPLACE('Kenan Taşdemir','Taşdemir','T.Demir')
--Taşdemir ifadesini T.Demir ile değiştirir. çıktı: Kenan T.Demir

--**********************************************************************************************

SELECT CHARINDEX('a','SQL Derslerine Devam Ediyoruz')

SELECT CHARINDEX('x','SQL Derslerine Devam Ediyoruz')

SELECT CHARINDEX('e','SQL Derslerine Devam Ediyoruz',15)
--15.karakterden itibaren "e" harfini arar.

SELECT CHARINDEX('a',OGRAD) FROM TBLOGRENCILER

SELECT REVERSE('Murat')

SELECT REVERSE(DERSAD) FROM TBLDERSLER

--**********************************************************************************************

















