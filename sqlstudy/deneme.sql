


--	Bulk-Logged Recovery Model


USE master
GO
ALTER DATABASE AdventureWorks SET RECOVERY FULL;


--	Yedekleme S�k��t�rmas� Planlamak


EXEC sp_configure 'backup compression default','1';
GO
RECONFIGURE WITH OVERRIDE;
GO


--	T-SQL ile Veritaban� Yede�i Olu�turmak


BACKUP DATABASE AdventureWorks
TO DISK='C:\Backups\AWorks1.bak';



BACKUP DATABASE AdventureWorks
TO DISK='C:\Backups\AWorks1.BAK'
WITH INIT;


BACKUP DATABASE AdventureWorks 
TO DISK = 'C:\Backups\AWorks1.BAK' 
WITH DIFFERENTIAL;


BACKUP DATABASE AdventureWorks
TO DISK='C:\Backups\AWorks1.BAK', 
DISK='D:\Backups\AWorks2.BAK', 
DISK='E:\Backups\AWorks3.BAK';


BACKUP DATABASE AdventureWorks 
TO DISK = 'C:\Backups\AWorks1.BAK'
WITH PASSWORD = 'D!�@J#�$B#�$L';


BACKUP DATABASE AdventureWorks
TO DISK = 'C:\Backups\AWorks4.BAK'
WITH STATS;


BACKUP DATABASE AdventureWorks					
TO DISK = 'C:\Backups\AWorks5.BAK'
WITH STATS = 2;


BACKUP DATABASE AdventureWorks 
TO DISK = 'C:\Backups\AWorks6.BAK'
WITH DESCRIPTION = 'AdventureWorks i�in Tam Yedek';


BACKUP DATABASE AdventureWorks 
TO DISK = 'C:\Backups\AWorks7.BAK'
MIRROR TO DISK = 'C:\Backups\AdventureWorks_MIRROR.BAK'
WITH FORMAT, STATS, PASSWORD = 'D!�@J#�$B#�$L';


RESTORE FILELISTONLY
FROM DISK = 'C:\Backups\AWorks1.BAK';


BACKUP DATABASE AdventureWorks 
TO DISK = N'C:\Backups\AWorks10.BAK'
WITH NOFORMAT, NOINIT, 
NAME = N'AdventureWorks - Full Database Backup', 
SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  
STATS = 10, CHECKSUM, CONTINUE_AFTER_ERROR 
GO 
DECLARE @BackupSetID AS INT SELECT @BackupSetID = position 
FROM msdb..backupset 
WHERE database_name = N'AdventureWorks' 
AND 
backup_set_id = (SELECT MAX(backup_set_id) 
		     FROM msdb..backupset 
		     WHERE database_name = N'AdventureWorks') 
IF @BackupSetID IS NULL
BEGIN RAISERROR(N'Do�rulama ba�ar�s�z! ''AdventureWorks2012'' bilgisi bulunamad�.', 16, 1) 
END 
RESTORE VERIFYONLY FROM  DISK = N'C:\Backups\AWorks10.BAK'
WITH  FILE = @BackupSetID,  
NOUNLOAD,  
NOREWIND
GO


--	T-SQL ile Transaction Log Dosyas� Yede�i Olu�turmak


BACKUP LOG AdventureWorks
TO DISK = 'C:\Backups\AWorks1.TRN';


BACKUP LOG AdventureWorks 
TO DISK = 'C:\Backups\AWorks2.TRN' 
WITH PASSWORD = 'D!�@J#�$B#�$L';


BACKUP LOG AdventureWorks 
TO DISK = 'C:\Backups\AWorks3.TRN' 
WITH STATS;


BACKUP LOG AdventureWorks 
TO DISK = 'C:\Backups\AWorks4.TRN' 
WITH STATS = 1;


BACKUP LOG AdventureWorks 
TO DISK = 'C:\Backups\AWorks5.TRN' 
WITH DESCRIPTION = 'AdventureWorks transaction log yede�i';


BACKUP LOG AdventureWorks 
TO DISK = 'D:\Backups\AWorks6.TRN' 
MIRROR TO DISK = 'D:\AdventureWorks_mirror.TRN'
WITH FORMAT;


--	SQL Agent ile Otomatik Yedekleme Plan� Olu�turmak


EXEC sys.sp_configure N'show advanced options',N'1';
RECONFIGURE WITH OVERRIDE;
EXEC sys.sp_configure N'Agent XPs', N'1';
RECONFIGURE WITH OVERRIDE;
EXEC sys.sp_configure N'show advanced options', N'0';
RECONFIGURE WITH OVERRIDE;


--	T-SQL Geri Y�kleme Komutlar�n� Kullanmak


DROP DATABASE AdventureWorks;


RESTORE DATABASE AdventureWorks
FROM DISK = N'C:\Backups\AWorks10.BAK';









































































































