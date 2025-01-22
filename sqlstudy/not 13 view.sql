CREATE VIEW TEST1
AS
SELECT * FROM TBLKATEGORI


ALTER VIEW TEST1
AS
SELECT * FROM TBLKATEGORI WHERE KATEGORIID<4 



--**********************************************************************************************************************************

USE AdventureWorks
GO
CREATE VIEW vw_Urunler
AS
SELECT ProductID, Name, ProductNumber, ListPrice FROM Production.Product;

SELECT ProductID, Name, ProductNumber, ListPrice FROM vw_Urunler;
/*
view kullanımında bu sorgulama sürecini
uzatacak ek katman oluşturulur. Öncelikle view yapısı metadata bilgileriyle
ayrıştırılır, daha sonra elde edilen SQL sorgusu veritabanına iletilerek sorgu
sonucu alınır. View sorgularında kullandığınız SELECT sorgusu, view’ın
kendisinden daha hızlı ve performanslı çalışacaktır.

View oluşturmak için kullanılacak sorgularda en fazla 1024 sütun (kolon)
seçilebilir.
• View’ler geçici tabloları base tablo olarak kullanamazlar.

View içerisindeki SELECT ifadesi, ORDER BY, COMPUTE, INTO, OPTION ya da COMPUTE
BY yan cümleciklerini alamaz.
*/

/*
information_schema.tables

information_schema.view_table_usage

information_schema.views;

SELECT * FROM sys.views;

SELECT OBJECT_DEFINITION(OBJECT_ID('vw_MusteriSiparisler'))

EXEC sp_helptext 'vw_MusteriSiparisler';

EXEC sp_refreshview 'vw_MusteriSiparisler';

EXEC sp_refreshsqlmodule @name = 'vw_MusteriSiparisler';
*/ 

CREATE VIEW [schema_ismi].view_ismi [sutun_isim_listesi]
WITH ENCRYPTION
AS
'Sorgu_ifadeleri'

ALTER VIEW vw_MusteriSiparisler
WITH ENCRYPTION
AS
/*
• Kümeleme fonksiyonları, GROUP BY, DISTINCT ve HAVING kullanılamaz.

Insert gerçekleştirilecek view’de hesaplanmış sütunlara veri eklenemez.
• Birden fazla tablodan veri çeken view’da gerçekleştirilecek ise Instead Of
Trigger kullanılmalıdır.
• Bir view’in base tablosu üstünde değişiklik yapabilmesi için Constraint, Unique
Indeks’lere takılmaması gerekir. Base tabloda NULL olamayan sütunlar varsa ve
bu sütunlar view’de yer almıyorsa Insert işlemi sırasında bu NULL geçilemeyen
alanlar NULL geçilmiş olacağı için hata meydana gelecektir.
• Kullanıcının view üzerinden erişimi olduğu ancak view sorgusu sonucunda
eklediği kaydı göremeyeceği durumlarda kullanıcının veri eklemesi doğru bir
yaklaşım olmayacaktır. Bu gibi durumları önlemek için CHECK OPTION operatörü
kullanılmalıdır.

View, birden fazla tablonun birleşimini içeriyorsa, birçok durumda Instead
Of Trigger kullanmadan veri ekleme (Insert) ya da silme (Delete) işlemini
gerçekleştiremezsiniz. Veri güncelleme işleminde ise, tek tabloyu base
tablo olarak kullanmak şartıyla Instead Of Trigger kullanmadan güncelleme
gerçekleştirilebilir.

Eğer view sadece bir tabloya bağlı ise ve view veri eklenecek tüm sütunları
içeriyorsa ya da sütunlar DEFAULT değere sahipse, veri ekleme işlemini, view
üzerinden Instead Of Trigger kullanmadan gerçekleştirebiliriz.
• View tek bir tabloya bağlı olsa da veri eklenecek sütun view’de gösterilmemişse
ve DEFAULT değere de sahip değilse, bu durumda, view üzerinden veri eklemek
için Instead Of Trigger kullanmak zorundasınız.

JOIN sorguları içeren view’lerde veri düzenleme işlemi gerçekleştirmek için
Instead Of Trigger’lar kullanılmak zorundadır.

İndekslenmiş Vıew’ler
İndekslenmiş view, clustered indeksler biçiminde maddeleştirilmiş, unique
(benzersiz) değerler setine sahip view’dir. Bunun avantajı, view ile birlikte
view’in temsil ettiği bilgiyi de elde ederek, çok hızlı arama sağlamasıdır.
Clustered olmak zorunda olan ilk indeksten sonra, SQL Server ilk indeksin
işaret ettiği clustered key değerini referans alarak, view üzerinde ek indeksler
oluşturabilir.


View üzerinde indeks kullanabilmek için bazı kısıtlamalar
• View SCHEMABINDING özelliğini kullanmak zorundadır.
• View tarafından referans gösterilen her fonksiyon belirleyici (deterministic)
olmak zorundadır.
• View, referans gösterilen tüm nesnelerle aynı veritabanında olmak zorundadır.
• Sadece tablolar ve UDF (kullanıcı-tanımlı fonksiyonlar)’lere referans olabilir.
View başka bir view’e referans olamaz.
• View herhangi bir kullanıcı-tanımlı fonksiyona referans gösteriliyorsa, view’ler
de schema bağlantılı olmalıdır.
• View’de referans gösterilen tüm tablolar ve UDF’ler iki parçalı (dbo.Production
gibi) isimlendirme kuralına uymak zorundadır. Ayrıca view ile sahibinin de aynı
olması gerekir.
• View ve view’i oluşturan tüm tablolar oluşturulurken, ANSI_NULLS ve QUOTED_
IDENTIFIER özellikleri aktif olmalıdır. Eğer aktif değil ise SET komutu ile bunu
yapabilirsiniz.

İlk oluşturacağımız indeks hem unique hem de clustered olmak zorundadır.
CREATE UNIQUE CLUSTERED INDEX indexedvMusteriSiparisler
ON vw_MusteriSiparisler(SalesOrderID, ProductID, UrunAd);

CREATE VIEW view_ismi
WITH seçenekler
AS
Sorgu_ifadeleri
UNION ALL
SELECT ifadesi2

Parçalı Vıew Kullanılırken Dikkat Edilmesi Gerekenler
• Parçalı view’de kullanılan tablolarda IDENTITY sütun bulunmamalıdır.
• UNION ALL ifadesi parçalı view için önemlidir. Bu nedenle parçalı view’lerde
UNION ALL ifadesinin şartlarının sağlanması gerekir. Yani birleştirilecek
sonuçların alındığı tablolardaki alanlar tür ve sıralama uyumlu döndürülmelidir.
• Parçalı view’de kullanılacak tablo için Ayırıcı Sütun (partitioning column)
bulunmalıdır. 
Ayırıcı sütun hesaplanan bir sütun olamaz. Kayıt işlemlerinin
kontrolü için ayırıcı sütun bir CHECK CONSTRAINT tanımı ile denetlenmelidir. 


DROP VIEW view_ismi

*/