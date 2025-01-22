CREATE TABLE TABLO1
(
ID INT IDENTITY(1,1),
AD VARCHAR(20)
)

DECLARE @SAYAC INT=1
WHILE @SAYAC<250001
BEGIN
INSERT TABLO1
SELECT 'Kitap' + CAST(@SAYAC AS VARCHAR(20))
SET @SAYAC=@SAYAC+1
END

*****************************************************************************************************************************************************************

SELECT * FROM TABLO1 WHERE ID=210387



SET STATISTICS IO ON
SET STATISTICS TIME ON

SELECT * FROM TABLO1 WHERE ID=210387



*****************************************************************************************************************************************************************

CREATE CLUSTERED INDEX TABLOKAYITGETIR
ON TABLO1(ID)

SELECT * FROM TABLO1 WHERE ID=210387