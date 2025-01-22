SELECT URUNAD,COUNT(*) AS 'ÜRÜN AD' FROM TBLHAREKET
INNER JOIN TBLURUNLER ON TBLHAREKET.URUN =TBLURUNLER.URUNID GROUP BY URUNAD ORDER BY COUNT(*) ASC


SELECT * FROM TBLHAREKET WHERE URUN IN(SELECT URUNID FROM TBLURUNLER WHERE KATEGORI=1)

***********************************************************************************************************************************************************************

SELECT * FROM TBLHAREKET WHERE MUSTERI IN(SELECT MUSTERIID FROM TBLMUSTERI WHERE MUSTERISEHIR='ADANA')

SELECT * FROM TBLHAREKET WHERE URUN IN(SELECT URUNID FROM TBLURUNLER WHERE KATEGORI=3)

SELECT * FROM TBLHAREKET WHERE URUN IN(SELECT URUNID FROM TBLURUNLER WHERE KATEGORI=(SELECT KATEGORIID FROM TBLKATEGORI WHERE KATEGORIAD='BEYAZ EŞYA'))


***********************************************************************************************************************************************************************

SELECT SUM(TUTAR) FROM TBLHAREKET WHERE MUSTERI IN(SELECT MUSTERIID FROM TBLMUSTERI WHERE MUSTERISEHIR='ADANA' OR MUSTERISEHIR='ANKARA')

SELECT * FROM TBLHAREKET WHERE URUN=1

UPDATE TBLURUNLER SET URUNSTOK=URUNSTOK-(SELECT SUM(ADET) FROM TBLHAREKET WHERE URUN=1) WHERE URUNID=1



***********************************************************************************************************************************************************************

CREATE TABLE KASA
(
TOPLAM decimal(18,2)
)

INSERT INTO TBLKASA VALUES (0)
SELECT * FROM TBLKASA

UPDATE TBLKASA SET TOPLAM=(SELECT SUM(TUTAR) FROM TBLHAREKET)

 



























