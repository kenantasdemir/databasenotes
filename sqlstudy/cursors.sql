
-- tablo üzerinde satır satır işlem yapabilmeye imkan sağlayan yapılardır.

--En hızlı Cursor, sadece ileri doğru okuma işlemi yapan Cursor’dür.

--Cursor, kendi içerisinde açık ve kapalı olma durumuna sahiptir. Siz kapatana kadar Cursor açık kalır.



DECLARE @ProductID INT
DECLARE @ProductName VARCHAR(255)

/*
DECLARE ProductCursor CURSOR FOR
SELECT ProductID, ProductName FROM Production.Product;
*/

DECLARE ProductCursor CURSOR  STATIC GLOBAL SCROLL
--FAST_FORWARD
--FORWARD_ONLY
--KEYSET
FOR
SELECT ProductID, ProductName FROM ProductsTable

--static cursor tempdb içinde tutulur.
--static cursor içindeki kayıtlarda güncelleme yapılamaz.

OPEN ProductCursor


FETCH NEXT FROM ProductCursor INTO @ProductID, @ProductName
WHILE @@FETCH_STATUS = 0
BEGIN
PRINT CAST(@ProductID AS VARCHAR) + ' - ' + @ProductName
FETCH NEXT FROM ProductCursor INTO @ProductID, @ProductName
END

CLOSE ProductCursor
DEALLOCATE ProductCursor

OPEN ProductCursor

FETCH NEXT FROM ProductCursor INTO @ProductID, @ProductName;

FETCH FIRST FROM ProductCursor INTO @ProductID, @Name




OPEN ProductCursor

FETCH NEXT FROM cursor_name INTO @id, @ad;

CLOSE ProductCursor;
DEALLOCATE ProductCursor;

--LIFECYCLE
--Bildirim -> Açılış -> Kullanım, Yönlendirme -> Kapanış -> Hafızada ayrılan belleği boşaltma

DECLARE UrunCursor SCROLL CURSOR FOR
SELECT ProductID, ProductName FROM Products WHERE ProductID < 5;

OPEN UrunCursor

FETCH NEXT FROM UrunCursor;
FETCH PRIOR FROM UrunCursor;
FETCH FIRST FROM UrunCursor;
FETCH LAST FROM UrunCursor;
FETCH RELATIVE 3 FROM UrunCursor;

FETCH ABSOLUTE 2 FROM UrunCursor;
--baştan 2.kayda konumlanır.

-->TYPE_WARNING --> DÖNÜŞTÜRME MESAJINI VERECEK OLAN ÖZELLİK

/*

Scope
Scope, Cursor’lerin görünebilirlik ayarını belirtir. LOCAL ve GLOBAL olarak ikiye
ayrılır. En kısa tanım ile şu şekilde özetlenebilir. Bir sproc içerisinde oluşturulan
Cursor GLOBAL scope’u içerisinde ise, bir başka sproc içerisinden bu Cursor’e
erişilebilir. Ancak bu Cursor LOCAL scope içerisinde ise bir başka sproc
içerisinden erişilemez. GLOBAL olarak tanımlanan bir Cursor ismi ile başka bir
sproc içerisinde dahi olsa yeni bir Cursor tanımlanamaz.

*/

DECLARE ProductCursor SCROLL CURSOR FOR
SELECT ProductID, Name FROM Production.Product WHERE ProductID < 5

OPEN productCursor

-- Bir kayır ileri hareket ettirir.
FETCH NEXT FROM ProductCursor
FETCH PRIOR FROM ProductCursor
FETCH FIRST FROM ProductCursor
FETCH LAST FROM ProductCursor

-- Bulunulan yerden 3 kayıt ileri konumlanır.
FETCH RELATIVE 3 FROM ProductCursor
-- Bulunulan kayıttan 2 kayıt geriye konumlanır.
FETCH RELATIVE -2 FROM ProductCursor

-- Baştan 2. kayda konumlanır
FETCH ABSOLUTE 2 FROM ProductCursor

/*

Cursor Tipleri
Cursor’ler çeşitli özelliklerine göre 4 farklı tipe ayrılır.
 -- Statik: Statik Cursor, tempdb üzerinde tutulur ve bir geçici tablo görevi görür. 
 --Statik Cursor içerisindeki kayıtlarda güncelleme yapılamaz.


--DİNAMİK CURSOR

--TÜM DEĞİŞİKLİKLERE KARŞI DUYARLIDIR!!!
--dinamik cursor her fetch komutu çalıştırıldığında cursorı yeniden oluşturur.
--ayrıca içerdiği SELECT ifadesini WHERE ile tekrar çalıştırır.
--genellikle cache yani RAM kullanır


*/
/*
• Keyset ile Çalıştırılan (Keyset-Driven)
Anahtar Takımı Cursor’ler (Keyset-Driven Cursor), veritabanındaki tüm satırları
unique olarak tanımlayan veri kümesi sağlayan Cursor’lerdir.
Anahtar Takımı ile Çalıştırılan Cursor’lerin Özellikleri:
• Cursor’ün kullandığı tablo üzerinde unique indeks olması gerekir.
• tempdb veritabanında veri kümesi değil, sadece anahtar takımı saklanır.
• Satırlarda meydana gelen tüm değişikliklere duyarlıdırlar. Ancak Cursor
oluşturulduktan sonra eklenen yeni satırlara karşı duyarlı değillerdir.
Anahtar takımı ile çalışan Cursor’ler kullanıldığında, tüm anahtarlar tempdb
içerisinde saklanır. Bu anahtarlar gerçek veriye ulaşmak için, veri bulma
yöntemi olarak kullanılır. Bir işaretleyici olarak da düşünülebilir. FETCH işlemi
sırasında ulaşılacak gerçek veriye bu anahtarlar ile ulaşılır.
*/
/*
• Dinamik
• Sadece İleri (Forward-Only)

DECLARE ProductCursor CURSOR
GLOBAL -- Cursor batch dışında da kullanılabilir.
SCROLL -- Geriye doğru kaydırma yapılabilir.
STATIC
FOR
SELECT ProductID, Name FROM ProductCursorTable

FETCH NEXT FROM ProductCursor INTO @ProductID, @Name

--Identity sütunlarda boş olan sütunları değiştirebilmek için;
SET IDENTITY_INSERT ProductCursorTable ON;
*/
/*

DECLARE ProductCursor CURSOR
GLOBAL
SCROLL
KEYSET
FOR
SELECT ProductID, Name FROM Production.Product
WHERE ProductID > 0 AND ProductID < 300
Cursor’de kullanılacak değişkenleri tanımlayalım.
DECLARE @ProductID INT
DECLARE @Name VARCHAR(30)
Cursor’ü açalım.
OPEN ProductCursor

İlk kaydı bulalım.
DECLARE @ProductID INT;
DECLARE @Name VARCHAR(30);
FETCH FIRST FROM ProductCursor INTO @ProductID, @Name

Dynamic Cursor
Diğer Cursor tiplerinde Cursor oluşturulduktan sonra veri hafızaya alınır ve
üzerinde okuma işlemi gerçekleştirilirdi. Bu nedenle, bir veri kümesi Cursor’e
alındıktan sonra tablodaki yeni kayıt ve güncellenen kayıtlardan haberi
olmazdı. Ancak dinamik Cursor’ler tablo temelinde veri duyarlılığına sahiptir.
Bunun sebebi, dinamik Cursor’lerin her FETCH komutu çalıştırıldığında
Cursor’ü yeniden oluşturması ve içerdiği SELECT ifadesini WHERE ile birlikte
tekrar çalıştırmasıdır.


DECLARE cursor_ad CURSOR
DYNAMIC -- Cursor’e dinamik özelliği kazandırır.
SCROLL -- Cursor’e ileri ve geri hareket özelliği kazandırır.
GLOBAL -- Cursor’e batch dışında kullanılabilme özelliği kazandırır.
FOR
select_ifadesi
*/