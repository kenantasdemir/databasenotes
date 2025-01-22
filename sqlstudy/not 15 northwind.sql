Select * FROM Products

Select * FROM PRODUCTS WHERE CategoryID=(SELECT CATEGORYID FROM Categories WHERE CategoryName='SeaFood')
AND UnitsInStock>50
AND SupplierID=(SELECT SupplierID FROM Suppliers WHERE City='Osaka')

CREATE PROCEDURE TEST10
AS
SELECT * FROM ORDERS WHERE EmployeeID IN(select EmployeeID from Employees WHERE City='London')
AND ShipVia=3 AND ShipCountry='France'

EXEC TEST10

*******************************************************************************************************************************************************************************************************************


CREATE VIEW VIEW1
AS
SELECT ORDERID,CompanyName,FirstName + ' ' + LastName AS 'Employee',ORDERDATE,ShipName,ShipCity,ShipCountry FROM ORDERS
INNER JOIN Customers ON ORDERS.CustomerID=Customers.CustomerID
INNER JOIN Employees
ON ORDERS.EmployeeID=Employees.EmployeeID

SELECT * FROM VIEW1

SELECT * FROM Invoices




