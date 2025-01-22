EXEC('SELECT * FROM Musteriler')

DECLARE @TabloAd SYSNAME = "SALES.SalesOrderHeader"
EXEC('SELECT * FROM ' + @TabloAd)

EXECUTE sp_lock;

--CONVERT(VARCHAR(5),@variableName)