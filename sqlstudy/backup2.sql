


--	Bulk-Logged Recovery Model


USE master
GO
ALTER DATABASE AdventureWorks SET RECOVERY FULL;
/*

RECOVERY modunu belirler. Veritabanasının geri dönüşüm (recovery) modunu tanımlar.
FULL recovery modu, veritabanı yedeği alırken tam yedeklemeyi sağlayan ve geri yükleme işlemleri için en sağlam modu ifade eder. 
Bu modda, veritabanının tüm işlem günlükleri (transaction logs) tutulur ve bu sayede 
veritabanı kazalarını, sistem çöküşlerini veya beklenmedik durumları geri alabilmek için 
tam bir kurtarma yapılabilir.

RECOVERY FULL Modunun Özellikleri:
Tam Yedekleme ve Günlük Tutma:

FULL recovery modu, işlem günlüklerinin tam olarak tutulmasını sağlar. 
Bu, veri kaybını minimuma indirir çünkü işlem günlüklerinin tamamı yedeklenir.
Yani, veritabanı her türlü değişiklik, işlem ve veritabanı güncellemesi hakkında bilgi tutar.
Yedekleme Türleri:

Tam Yedekleme: Bu, veritabanının tüm verilerini yedekler.
Artık Yedekleme: Veritabanı işlemleri sırasında yapılan değişikliklerin yalnızca artık kısmını yedekler.
Günlük Yedekleme: Yapılan tüm işlemleri içerir ve veritabanının herhangi bir noktada geri yüklenmesini sağlar.
*/

--	Yedekleme S�k��t�rmas� Planlamak


EXEC sp_configure 'backup compression default','1';
GO
RECONFIGURE WITH OVERRIDE;
GO

--SQL Server'da yedeklemeler sıkıştırılabilir ve bu parametre, 
--yedeklemelerin varsayılan olarak sıkıştırılıp sıkıştırılmayacağını belirler.


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
--Bu, yedeklemenin bir kopyasının (mirror) başka bir dosyaya yapılmasını sağlar.
--FORMAT seçeneği , önceki yedeklerin silinmesini sağlar ve yalnızca yeni yedekleme dosyası üzerinde işlem yapılır. 
--Genellikle boş bir dosya oluşturulup üzerine yedekleme yapılması amacıyla kullanılır.


RESTORE FILELISTONLY
FROM DISK = 'C:\Backups\AWorks1.BAK';
--yedekleme dosyasının içeriklerini görüntülemek için kullanılır.

-- SKIP, yedekleme sırasında herhangi bir uyarıyı görmezden gelmenize olanak tanır.
-- NOREWIND, Tape sürücüsü kullanırken, yedekleme sonrası bandın başa sarılmaması sağlanır.
-- NOUNLOAD, genellikle tape sürücüsü ile kullanılır. Tape sürücüsü kullanılıyorsa, yedekleme tamamlandıktan sonra tape'in çıkartılmamasını sağlar.
-- COMPRESSION, yedekleme dosyasının sıkıştırılmasını sağlar. Bu, özellikle büyük veritabanları için disk alanı tasarrufu sağlar. Yedekleme dosyasının boyutunu küçültmek amacıyla veri sıkıştırılır.
-- CHECKSUM, yedekleme sırasında veri bütünlüğünü kontrol etmek için kullanılır.
-- CONTINUE_AFTER_ERROR, yedekleme işlemi sırasında hatalar meydana gelirse bile işlemin devam etmesini sağlar.

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
-- RESTORE VERIFYONLY: Bu komut, belirtilen yedek dosyasının doğru formatta olup olmadığını ve geri yüklemeye uygun olup olmadığını kontrol eder. 
--Bu işlem sadece doğrulama yapar, ancak veritabanı geri yüklenmez.
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









































































































