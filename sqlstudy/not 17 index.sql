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

--*****************************************************************************************************************************************************************

SELECT * FROM TABLO1 WHERE ID=210387

SET STATISTICS IO ON
SET STATISTICS TIME ON

SELECT * FROM TABLO1 WHERE ID=210387



--*****************************************************************************************************************************************************************
/*
Log dosyası olmadan veritabanı işlem yapmaz
 Büyük verilere sahip veritabanlarında .ndf gibi dosyalar da
vardır. Bunlar, daha sonradan veritabanına eklenirler. Ancak temel anlamda en
gerekli dosyalar veri ve log dosyalarıdır.

Her iki
dosyanın da bir disk üzerinde tutulması hem performans hem de güvenlik
açısından büyük bir risktir.
Disk aynı anda hem ldf hem de mdf dosyalarında
yazma ve okuma işlemi gerçekleştireceği için diskin yazma ve okuma hızı
otomatik olarak yarı yarıya bölünmüş olacaktır. 

Doğru olan, en azından işletim sistemi, veri dosyası ve
log dosyası için ayrı ayrı, üç farklı disk kullanılması ve ayarların buna göre
gerçekleştirilmesidir.

Extent
Tablolar ve Indeksler için kullanılan temel depolama birimidir. Yani, veritabanı
içinde ayrılan birim alanıdır. Sekiz adet bitişik 64K’lık veri page’lerinden oluşur.
Page kavramını detaylıca inceleyeceğiz.
Extent dolduğunda, bir sonraki kayıt, kayıt boyutu kadar yeni bir extent’te
yer alır. 

Page
Page’ler, extent’ler içerisinde bulunan, extent’lerin birim alanlarıdır. Her extent
içerisinde 8 page bulunur. Her extent’teki page sayısı aynıdır. Yani her extent
sekizlik sistem ile çalışır.

Extent’ler yapısal olarak belirli bir kapsayıcıdır. Extent içerisindeki page’ler veri
satırlarını içeren kapsayıcılardır. Her extent’in içerdiği page sayısı sekiz olsa da,
her page içerisindeki satır sayısı aynı değildir. Page’ler veri satırlarını kapsayan
en alt kapsayıcı olduğu için, veri büyüklüğüne göre değişen satırlara sahiptir.
Bir satır, sadece bir page içerisinde olabilir.
*/


/*

Bir tabloda sadece tek bir clustered Indeks oluşturulabilir. 

Clustered Indeks olarak belirlenen sütunların tekil, yani benzersiz değerlere
sahip olması gerekir.

Clustered Indeks Taraması (Scan)
Sorgularda herhangi bir koşul yoksa kullanılır. Koşul ve sıralama işlemlerinin
olmadığı durumlarda, Indekslere bakılmaksızın tüm tablo içeriği taranarak
sonuç döndürülür. Bu yönteme Table Scan denir. 

Clustered Indeks Araması (Seek)
Sorgularda WHERE gibi bir koşul varsa kullanılır. Amacı, Indeksler üzerinden
koşul ile belirtilen kayıtların bulunması ve sorgu içerisinde kullanılacak şekilde
verilerin getirilmesini sağlamaktır.

Clustered Indeksler gibi fiziksel değil, mantıksal
olarak dizme işlemi gerçekleştirirler. Non-Clustered Indeksler, Clustered
Indekslerin yardımcılarıdır diyebiliriz.

non-clustered Indeksten 999 adet tanımlanabilir. Bir
Non-Clustered Indeks verilere doğrudan erişemez. Ancak, Heap üzerinden ya
da bir Clustered Indeks üzerinden verilere erişebilir.

*/

/*
Unıque Indeks
Verinin tekilliğini garanti etmek için kullanılır.

Columnstore Indeks’ler, her bir sütuna ait verileri aynı sayfaya devam ettirerek
sık kullanılan sorgularda performans artışı sağlar. 

Columnstore Indeks tanımlanmış bir tabloda sadece
okuma yapılabilir. Tablodaki veri üzerinde ekleme, güncelleme ve silme işlemi
gerçekleştirebilmek için Indeks pasifleştirilmelidir (disable).

İndeksleri farklı fiziksel dosya gruplarına dağıtarak sorgu performansını
artırmak için kullanılır. SQL Server 2005 ile gelen bu Indeks türü; Clustered ya
da Non-Clustered olabilir.

Filtreli Indeks
Adından da anlaşılacağı gibi, bir sütundaki tüm kayıtları Indekslemek yerine,
sadece belirlenen kurala uya satırları Indekslemek amacı ile kullanılır.

Full-Text Indeks
Full-Text Search özelliği için tasarlanan bu Indeks türü sadece char, nchar,
varchar, nvarchar, varbinary(max), image ve XML veri tipindeki sütunlar
üzerinde tanımlanabilir.

Kapsam (Coverıng) Indeks
Bir sorgunun WHERE kısmını da dahil ederek, seçilen sütunlar ile birlikte bir
Indeks olarak tanımlanmasına denir. 

INCLUDE,
Kapsam (Covering) Indeksleri desteklemek amacı ile SQL Server 2005’de söz
dizimine eklenmiştir. Bu yöntemde, gerekli veriler zaten Indekste yer aldığı
için gerçek veri page’lerine tekrar erişmeye gerek yoktur. Gerçek veri page’lere
gidilmeye gerek olmaması I/O performansı açısından faydalı bir özelliktir.

PAD_INDEX
İndeks oluşturulduğunda non-leaf seviye page’lerin yüzdesel olarak nasıl dolu
olarak kabul edileceğini belirler.
Söz Dizimi:
PAD_INDEX = { ON | OFF }

FILLFACTOR
Page’lerin yoğunluğunu ayarlamak için kullanılır. Indeks ilk oluşturulurken,
page’ler varsayılan olarak tam doluluk durumundan iki kayıt eksik olarak
doldurulur.


DROP_EXISTING
Oluşturulmak istenen bir Indeks adı ile aynı isimde, yeni bir Indeks oluşturulmak
istendiğinde eski Indeksi silip yeni Indeksi aynı isimle oluşturur.
DROP_EXISTING = { ON | OFF }

STATISTICS_NORECOMPUTE = { ON | OFF}

UPDATE STATISTICS

SORT_IN_TEMPDB
Tempdb ve disk okuma-yazma işlemleriyle ilgili bir özelliktir. Indeksleri
barındıran Tempdb, veritabanının bulunduğu fiziksel sürücüden farklı bir
yerde depolandığı durumlarda bu özellik kullanılır.

ONLINE
ONLINE özelliği, tabloyu erişime açmak olarak özetlenebilir. Kullanıcıların Indeks
ya da tabloya erişimini engelleyen herhangi bir Indeks oluşturulamamasını
sağlar.

ON
Performans ile ilgili ve ileri seviye bir SQL Server konusudur. Indekslerin verinin
bulunduğu diskten farklı bir diskte saklanması için kullanılır.


sp_helpindex ‘tablo_yada_view_ismi’

sys.indexes
*/

--Birden fazla sütundan oluşan bir sorgu olduğuna göre en uygun Indeks tipi 
--Kapsam Indeks (Covering Index) olabilir.


/*
CREATE UNIQUE NONCLUSTERED INDEX UI_Email
ON dbo.Personeller(Email)
ON [PRIMARY];
*/

/*
Kapsam Indeksini tanımlayalım.
CREATE INDEX CV_Product
ON Production.Product(Name, ProductNumber, ListPrice);
*/

/*
EKLENTI SÜTUNLU INDEX
CREATE INDEX CV_SalesDetail
ON Sales.SalesOrderDetail(SalesOrderID)
INCLUDE(OrderQty, ProductID, UnitPrice)
*/

/*
Aşağıdaki sorgu ile alınacak filtreli veri için bir Indeks oluşturacağız.
SELECT ProductID, Name, Color FROM Production.Product
WHERE Color IS NOT NULL
Seçili filtreli veriyi Indekslemek için aşağıdaki gibi bir Indeks oluşturalım.
CREATE INDEX FI_Product
ON Production.Product(ProductID, Name)
WHERE Color IS NOT NULL;
Filtreli Indeksler, sadece nonclustered türünden Indeksler için geçerlidir.
*/

/*
REORGANIZE:
Indeksleri Yeniden Düzenlemek
Boşalan Indeks sayfalarının atılmasını sağlar. Bu işlem Indeks performansı
açısından yararlıdır. REORGANIZE deyimi sadece bu işlem için kullanıldığından,
sadece kendisiyle ilgili olan LOB_COMPACTION seçeneğini kullanabilir.
Unique Indeks olarak oluşturulan UI_Email Indeksini yeniden derleyelim.
ALTER INDEX UI_Email
ON dbo.Personeller
REORGANIZE WITH (LOB_COMPACTION = ON);
*/

/*
Clustered Indeks kapatılırsa, tabloda en basit veri seçme sorgusu
dahi kullanılamaz. Nonclustered bir Indeks kapatılırsa veri seçme açısından
sorun teşkil etmeyecektir.
DIJIBIL veritabanında daha önce oluşturduğumuz Personeller tablosunda
bir Clustered Indeks tanımlamıştık. Bu Indeksi kapatalım.
ALTER INDEX CL_PersonelID
ON Personeller
DISABLE
*/

/*
ALTER INDEX FI_Product
ON Production.Product
DISABLE

İki şekilde Indeks açılabilir. Bunlar;
ALTER INDEX CL_PersonelID
ON dbo.Personeller
REBUILD

ALTER INDEX FI_Product
ON Production.Product
REBUILD
*/

/*
İstatistikler
SQL Server, sorgu performansı için istatistikler tutar. Bu istatistikleri SQL Server
tutmamasını ve el ile takip etmek de sağlanabilir.

Bunun için Indeks özelliklerinden STATISTICS_NORECOMPUTE özelliğini tekrar
inceleyebilirsiniz.

İstatistikler diğer veritabanı nesneleri gibi CREATE ile oluşturulur. İstatistikler
güncellenebilir ve silinebilirler.

İstatistik Oluşturmak
İndekslerde olduğu gibi Indekslerde olmayan bir sütun için bile istatistik oluşturulabilir.

Söz Dizimi:
CREATE STATISTICS istatistik_ismi
ON {tablo_ismi | view_ismi}(sutun_ismi)

Production.Product tablosundaki ProductID sütunu için bir istatistik oluşturalım.

CREATE STATISTICS Statistic_ProductID
ON Production.Product(ProductID);

İstatistikleri Silmek
Kullanıcı tarafından oluşturulan istatistikler silinebilirler.

DROP STATISTICS {tablo_ismi | view_ismi}.(istatistik_ismi)

İstatistik silebilmek için, istatistik nesnesinin bağlı olduğu tablo ya da view adı
ile birlikte belirtilmesi gerekir.

DROP STATISTICS Production.Product.Statistic_ProductID;
*/

CREATE CLUSTERED INDEX TABLOKAYITGETIR
ON TABLO1(ID)

SELECT * FROM TABLO1 WHERE ID=210387

ALTER INDEX ALL ON Production.Product
REBUILD WITH(FILLFACTOR = 90)

REBUILD WITH(FILLFACTOR = 90, SORT_IN_TEMPDB = ON)

ALTER INDEX CL_PersonelID
ON Personeller
DISABLE