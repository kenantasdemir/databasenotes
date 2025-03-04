--Commit Transaction komutu begin Transaction ile başlayan bütün işleri onaylar. 
--Zaten bir transaction gerçekleşmişse ardından mutlaka Commit transaction gelmesi gerekir.

     BEGIN TRANSACTION
          --SQL KOMUTLARI...
     COMMIT TRANSACTION
--Save Transaction komutu ise geri dönüşüm noktası belirler.

begin transaction 
update Kitap set KitapSayfa=50
update Kitap set KitapFiyat=1
select * from Kitap rollback select * from Kitap

begin transaction 
update Kitap set KitapSayfa=50
update Kitap set KitapFiyat=1
          
select * from Kitaplar;
rollback;
select * from Kitap

declare @sehir varchar(15)
set @sehir='KahramanMaraş'
select @sehir

declare @sehir varchar(15)
set @sehir='KahramanMaraş'
print @sehir

declare @sehir varchar(15)
declare @ilce varchar(15)
set @sehir='KahramanMaraş'
set @ilce='Gölbaşı'
print @sehir
print @ilce
**********************************************************************************************************************************************
declare @sehir varchar(15)
declare @ilce varchar(15)
set @sehir='KahramanMaraş'
set @ilce='Gölbaşı'
print @sehir + ' ' + @ilce
**********************************************************************************************************************************************
declare @sayi1 int,@sayi2 int,@toplam int
set @sayi1=5
set @sayi2=8
set @toplam=@sayi1+@sayi2
print @toplam

**********************************************************************************************************************************************
declare @sayi1 int,@sayi2 int,@toplam int
set @sayi1=5
set @sayi2=8
set @toplam=@sayi1+@sayi2
print 'Toplam: ' + cast(@toplam as varchar(2))

**********************************************************************************************************************************************
declare @sayi1 int,@sayi2 int,
@toplam int,@fark int,@carpim int,@bolum int
set @sayi1=72
set @sayi2=8
set @toplam=@sayi1+@sayi2
set @fark=@sayi1-@sayi2
set @carpim=@sayi1*@sayi2
set @bolum=@sayi1/@sayi2
print 'Toplam: ' + cast(@toplam as varchar(2))
print 'Fark: ' + cast(@toplam as varchar(2))
print 'Çarpım: ' + cast(@toplam as varchar(3))
print 'Bölüm: ' + cast(@toplam as varchar(2))

**********************************************************************************************************************************************

declare @ogrenciler table(
ogrno varchar(3),
ograd varchar(20),
ogrsoyad varchar(30),
ogrkol varchar(30),
ogrmah varchar(50))

insert into @ogrenciler values('A25','Kenan','Taşdemir','Sağlık','ŞakirPaşa')
insert into @ogrenciler values('B16','Yasin','Taşdemir','Çevre','Yeşilevler')
insert into @ogrenciler values('C28','Nehir','Taşdemir','Trafik','FevziPaşa')

select * from @ogrenciler order by ogrno


**********************************************************************************************************************************************

declare @yeni table(
renk varchar(10),
baski tinyint,
derece varchar (1))

insert into Kitap3
output inserted.KitapRengi,inserted.KitapBaskı,inserted.KitapDerece
into @yeni values('mavi',21,'a')

select * from @yeni


**********************************************************************************************************************************************

declare @silinen table(
renk varchar(10),
baski tinyint,
derece varchar(1))

delete from Kitap3
output deleted.KitapRengi,deleted.KitapBaskı,deleted.KitapDerece
into @silinen
where KitapDerece='d'
select * from @silinen

**********************************************************************************************************************************************

declare @kitapsayi tinyint
select @kitapsayi=count(kitapadi) from Kitap2
select @kitapsayi

**********************************************************************************************************************************************

declare @kitapsayi tinyint
select @kitapsayi=count(kitapadi) from Kitap2
if(@kitapsayi<=5)
begin
print 'Yetersiz Kitap ' + cast(@kitapsayi as varchar(2))
end
else
begin
print 'Yeterli Kitap ' + cast(@kitapsayi as varchar(2))
end

**********************************************************************************************************************************************

select count(KitapTür) from Kitap2 where KitapTür='roman'

**********************************************************************************************************************************************

declare @sayi tinyint
select @sayi=count(KitapTür) from Kitap2 where KitapTür='Roman'
if(@sayi<=3)
begin
print 'Yetersiz Kitap: ' + cast(@sayi as varchar(1))
end
else if(@sayi>3 and @sayi<=6)
begin
print 'Yeterli kitap mevcut: ' + cast(@sayi as varchar(1))
end
else
begin
print 'düşük sayıda kitap: ' + cast(@sayi as varchar(1))
end


**********************************************************************************************************************************************

select KitapRengi,KitapDerece,'Durum'=
case KitapDerece
when 'a' then 'Çok Kaliteli'
when 'b' then 'Kaliteli'
when 'c' then 'orta'
else 'bilnmeyen değer'
end
from Kitap3

**********************************************************************************************************************************************

select KitapRengi,KitapBaskı,'Basım Oranı'=
case
when KitapBaskı<=10 then 'Az Basım'
when KitapBaskı>10 and KitapBaskı<=15 then 'İdare Eder'
when KitapBaskı>15 and KitapBaskı<=20 then 'Orta'
when KitapBaskı>20 then 'Bu Kitap İyi Sattı'
end
from Kitap3

**********************************************************************************************************************************************

declare @sayi int
set @sayi=1
while(@sayi<=10)
begin
print @sayi
set @sayi=@sayi+1
end


**********************************************************************************************************************************************

declare @sayac int
set @sayac=1
while (@sayac<=5)
begin
print cast(@sayac as varchar(1)) + ' - Merhaba Sql'
set @sayac=@sayac+1
end

**********************************************************************************************************************************************

declare @sayi int
set @sayi=1
while(@sayi<=10)
begin
print cast(@sayi as varchar(10)) + ' Karesi: ' + cast(@sayi * @sayi as varchar(3))
set @sayi=@sayi+1
end

**********************************************************************************************************************************************

declare @sayi int
set @sayi=1
while(@sayi<=10)
begin
if(@sayi=7)
begin
set @sayi=@sayi+1
continue
end
print cast(@sayi as varchar(2)) + ' Karesi: ' + cast(@sayi*@sayi as varchar(3))
set @sayi=@sayi+1
end

**********************************************************************************************************************************************

declare @sayac tinyint
set @sayac=1
git:
print 'sayac: ' + cast(@sayac as varchar(1))
set @sayac=@sayac+1
while(@sayac<=5)
goto git

**********************************************************************************************************************************************

waitfor delay '00:00:05'
select * from Kitap

waitfor time '17:02:00'
select * from Kitap2


**********************************************************************************************************************************************
create procedure Deneme as                             //prosedür oluşturulduktan sonra bu 2 satır silinmelidir.
select * from Kitap where KitapSayfa>150

execute Deneme

**********************************************************************************************************************************************
alter procedure Deneme as select * from Kitap where KitapSayfa>400

execute Deneme

**********************************************************************************************************************************************

create procedure kitapgetir as 
select KitapAd,Kitaprenk from Kitap k1 inner join Kitap2 k2
on k1.KitapAd=k2.kitapadi

execute kitapgetir

**********************************************************************************************************************************************

drop procedure Deneme

**********************************************************************************************************************************************

set nocount on
select * from Kitap

set nocount off
select * from Kitap

**********************************************************************************************************************************************

create procedure Toplam(@sayi1 int,@sayi2 int,@sonuc int output) as   //bu iki satırı yazdıktan sonra çalıştırıp sil yoksa aynı isimde 2.prosedürü 
set @sonuc=@sayi1+@sayi2                                              // olusturacağından hata verecektir.

declare @t int
exec Toplam 4,7,@t output
print @t

**********************************************************************************************************************************************

create procedure carpim
(@s1 int,@s2 int,@s3 int, @sonuc int output) as
set @sonuc=@s1*@s2*@s3
print ' Sonuç: ' + cast(@sonuc as varchar(3))

declare @a int 
exec carpim 4,5,6,@a output

**********************************************************************************************************************************************

create procedure ortalama
(@a int,@b int,@c int,@s int output) as 
set @s=(@a+@b+@c)/3
print 'Ortalama: ' + cast(@s as varchar(2))

declare @ort int
exec ortalama 7,14,27,@ort

**********************************************************************************************************************************************

create procedure kitapgetir(@renk varchar(10)) as 
select * from Kitap2 where Kitaprenk=@renk

exec kitapgetir 'mavi'

**********************************************************************************************************************************************

create function buyukharf(@gelendeger varchar(10))
returns varchar(10) as
begin
return upper (@gelendeger)
end

select dbo.buyukharf(Kitaprengi) from Kitap3

**********************************************************************************************************************************************

create function kayitsayi(@gelenrenk varchar(10))
returns int as 
begin
declare @sayi int
select @sayi=count(KitapRengi) from Kitap3 where KitapRengi=@gelenrenk
return @sayi
end

select dbo.kayitsayi('mavi')

**********************************************************************************************************************************************

create function Kitappuan(@gelenpuan int)
returns table as 
return (select * from Kitap2 where KitapPuan>@gelenpuan)

select kitapadi,kitaprenk from dbo.Kitappuan(9)
