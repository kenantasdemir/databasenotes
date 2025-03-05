CREATE FUNCTION dbo.fn_GetFirst20Chars (@input VARCHAR(MAX))
RETURNS VARCHAR(20)
--RETURNS NUMERIC(5,2)
AS
BEGIN
    RETURN LEFT(@input, 20)
END

SELECT dbo.fn_GetFirst20Chars('Bu bir test mesajıdır, lütfen dikkate alınız.')


ALTER FUNCTION dbo.fn_GetFirst20Chars (@input VARCHAR(MAX))
RETURNS VARCHAR(30)
AS
BEGIN
    RETURN LEFT(@input, 30)
END



DROP FUNCTION dbo.fn_GetFirst20Chars;


CREATE FUNCTION PInedir()
RETURNS NUMERIC(5,2)
AS
BEGIN
RETURN 3.14;
END;


CREATE FUNCTION dbo.UrunToplamSayi()
RETURNS INT
AS
BEGIN
DECLARE @toplam INT;
SELECT @toplam = COUNT(ProductID) FROM Production.Product;
RETURN @toplam;
END;

CREATE FUNCTION dbo.KullaniciGetir(@KullniciKod INT = NULL)
RETURNS VARCHAR(100)
AS
BEGIN
DECLARE @ad_soyad VARCHAR(100)
SELECT @ad_soyad = FirstName + ‘ ‘ + LastName
FROM Person.Person WHERE BusinessEntityID = @KullniciKod
RETURN @ad_soyad
END;

SELECT
BusinessEntityID, PersonType, Title,
dbo.KullaniciGetir(BusinessEntityID) AS AdSoyad
FROM Person.Person;


CREATE FUNCTION fnc_UrunAra(@ara VARCHAR(10)) RETURNS TABLE
AS
RETURN SELECT * FROM Production.Product
WHERE Name LIKE ‘%’ + @ara + ‘%’;

SELECT * FROM dbo.fnc_UrunAra('Be');



CREATE FUNCTION maleUsers() RETURNS TABLE
AS
RETURN SELECT * FROM Users WHERE gender = 'male';


SELECT * from maleUsers()

ALTER FUNCTION dbo.KullaniciGetir(@KullniciKod INT = NULL)
RETURNS VARCHAR(100)
WITH ENCRYPTION
AS
BEGIN
DECLARE @ad_soyad VARCHAR(100)
SELECT @ad_soyad = FirstName + ‘ ‘ + LastName
FROM Person.Person WHERE BusinessEntityID = @KullniciKod
RETURN @ad_soyad
END;

/*
Aldığı aynı parametreler için aynı sonucu döndüren fonksiyonlar
Deterministic’tir.

Her çalışmasında farklı sonuç üreten fonksiyonlar Nondeterministic’tir. Sistem
saatini döndüren GETDATE() fonksiyonu buna örnek gösterilebilir. 
*/

--INNER JOIN gibi çalışır
SELECT * FROM Departments D
CROSS APPLY
(
SELECT * FROM Employees E WHERE E.DepartmentID = D.DepartmentID
)DIJIBIL;


--OUTER APPLY
--OUTER APPLY operatörü ise LEFT OUTER JOIN gibi çalışır.

SELECT * FROM Departments D
OUTER APPLY
(
SELECT * FROM Employees E WHERE E.DepartmentID = D.DepartmentID
)KODLAB;
