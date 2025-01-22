SELECT * FROM TBLHAREKET WHERE DATEPART(DAY,TARIH) BETWEEN 1 AND 3
--TARIH adlı sütundan gün bilgisi 1, 2 , 3 arasındaki kayıtları getirir.

SELECT * FROM TBLHAREKET WHERE DATEPART(DAY,TARIH) BETWEEN 1 AND 3 AND MUSTERI=1

SELECT * FROM TBLHAREKET WHERE DATEPART(DAY,TARIH) BETWEEN 1 AND 3 AND
MUSTERI=(SELECT MUSTERIID FROM TBLMUSTERI WHERE MUSTERISEHIR='ANKARA')


--****************************************************************************************************************************************************************************

SELECT DATENAME(MONTH,GETDATE())
--tarih bilgisi içinden ay bilgisini döndürür.

SELECT DATENAME(MONTH,GETDATE())

SELECT DATENAME(WEEKDAY,GETDATE())
SELECT DATENAME(WEEKDAY,'2019.06.10')
--****************************************************************************************************************************************************************************

SELECT DATEDIFF(YEAR,'2010.10.25',GETDATE())

SELECT DATEDIFF(MONTH,'2010.06.14','2015.08.06')

SELECT DATEDIFF(DAY,TARIH,GETDATE()) FROM TBLHAREKET WHERE HAREKETID=1


--****************************************************************************************************************************************************************************

SELECT DATEADD(YEAR,3,'2009-10-25')
SELECT DATEADD(DAY,45,GETDATE())
SELECT DATEADD(MONTH,350,GETDATE())



SELECT FORMAT(GETDATE(), 'yyyy.MM.d HH:MM:ss');	


DECLARE @tarih DATETIME = GETDATE()
SELECT FORMAT ( @tarih, 'd', 'tr-TR' ) AS 'T�rk�e'
      ,FORMAT ( @tarih, 'd', 'en-US' ) AS 'Amerikan �ngilizcesi'
      ,FORMAT ( @tarih, 'd', 'en-gb' ) AS '�ngiltere �ngilizcesi'
      ,FORMAT ( @tarih, 'd', 'de-de' ) AS 'Almanca'
      ,FORMAT ( @tarih, 'd', 'zh-cn' ) AS '�ince'; 


DECLARE @tarih DATETIME = GETDATE()
SELECT FORMAT ( @tarih, 'D', 'tr-TR' ) AS 'T�rk�e'
      ,FORMAT ( @tarih, 'D', 'en-US' ) AS 'Amerikan �ngilizcesi'
      ,FORMAT ( @tarih, 'D', 'en-gb' ) AS '�ngiltere �ngilizcesi'
      ,FORMAT ( @tarih, 'D', 'de-de' ) AS 'Almanca'
      ,FORMAT ( @tarih, 'D', 'zh-cn' ) AS '�ince'; 



SELECT FORMAT ( GETDATE(), 'd', 'tr-TR' ) AS Turkiye;
SELECT FORMAT ( GETDATE(), 'dd', 'tr-TR' ) AS Turkiye;
SELECT FORMAT ( GETDATE(), 'ddd', 'tr-TR' ) AS Turkiye;
SELECT FORMAT ( GETDATE(), 'dddd', 'tr-TR' ) AS Turkiye;


SELECT FORMAT ( GETDATE(), 'm', 'tr-TR' ) AS Turkiye;
SELECT FORMAT ( GETDATE(), 'mm', 'tr-TR' ) AS Turkiye;
SELECT FORMAT ( GETDATE(), 'mmm', 'tr-TR' ) AS Turkiye;
SELECT FORMAT ( GETDATE(), 'mmmm', 'tr-TR' ) AS Turkiye;


SELECT FORMAT ( GETDATE(), 'y', 'tr-TR' ) AS Turkiye;
SELECT FORMAT ( GETDATE(), 'yy', 'tr-TR' ) AS Turkiye;
SELECT FORMAT ( GETDATE(), 'yyy', 'tr-TR' ) AS Turkiye;



SET LANGUAGE us_english	





