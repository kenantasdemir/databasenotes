BACKUP DATABASE [YourDatabase] 
TO DISK = 'C:\Backups\YourDatabase_Partial.bak'
WITH PARTIAL;


BACKUP DATABASE DBNAME
TO DISK = 'YOURPATH'


BACKUP DATABASE DBNAME TO DISK='path' WITH INIT;
--YENİ DB YEDEĞİNİN ESKİ YEDEK ÜZERİNE YAZILMASI

BACKUP DATABASE DBNAME TO DISK='path' WITH DIFFERENTIAL;

BACKUP DATABASE DBNAME TO DISK='path' WITH STATS;
--YEDEKLEME İŞLEMİNİN GERÇEKLEŞME YÜZDESİ

BACKUP DATABASE DBNAME TO DISK='path' WITH STATS = 1;

BACKUP DATABASE DBNAME TO DISK='path' WITH DESCRIPTION = "AÇIKLAMA";


RESTORE FILELISTONLY FROM DISK = 'path';
--Bu komut, yedekleme dosyasındaki dosya listelerini döndürür, 
--ancak yedeği geri yüklemez. Bu, yedeğin hangi veritabanı 
--dosyalarına sahip olduğunu anlamak için kullanılır.

BACKUP LOG DBDENEME TO DISK = 'path' WITH STATS;
--veritabanının log dosyasının yedeğini alır. 
--Veritabanı log dosyası, SQL Server'ın veritabanında 
--yapılan her türlü değişikliği 
--(INSERT, UPDATE, DELETE gibi işlemler) kaydeder.

BACKUP LOG DBDENEME TO DISK = 'path' WITH DESCRIPTION = 'DENEME';

DROP DATABASE DBDENEME;

RESTORE DATABASE DBDENEME FROM DISK = 'deneme';
