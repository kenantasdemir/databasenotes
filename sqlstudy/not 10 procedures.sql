
--*******************************************************************************************************


CREATE PROCEDURE StokBuyukMuOndan
AS
SELECT * FROM TBLURUNLER WHERE URUNSTOK>10
--her çalıştırıldığında URUNSTOK değeri 10 dan büyük olan ürünleri listeleyecek

EXEC StokBuyukMuOndan 
EXECUTE StokBuyukMuOndan

DROP PROCEDURE StokBuyukMuOndan
--PROCEDURE SİLME

--*******************************************************************************************************




CREATE PROCEDURE URUNGETIR
AS
SELECT URUNAD,URUNSTOK,URUNMARKA FROM TBLURUNLER

EXECUTE URUNGETIR

--*******************************************************************************************************

--Parametre ile prosedür kullanma

ALTER PROCEDURE URUNGETIR
@Deger varchar(50)='BUZDOLABI'
AS
SELECT URUNAD,URUNSTOK,URUNMARKA FROM TBLURUNLER
where URUNAD=@Deger

EXECUTE URUNGETIR

--*******************************************************************************************************

ALTER PROCEDURE URUNGETIR
@Deger varchar(50)
AS
SELECT URUNAD,URUNSTOK,URUNMARKA FROM TBLURUNLER
where URUNAD=@Deger

EXECUTE URUNGETIR @Deger='ÇAMAŞIR MAKİNESİ'

--*******************************************************************************************************

CREATE PROCEDURE UpdateCustomer
    @CustomerID INT,
    @CustomerName NVARCHAR(50),
    @City NVARCHAR(50)
AS
BEGIN
    UPDATE Customers
    SET CustomerName = @CustomerName, City = @City
    WHERE CustomerID = @CustomerID
END



--*******************************************************************************************************













