SELECT * FROM sys.messages
sp_addmessage 
    @msgnum = '99934',
    @lang = '1055', 
    @severity = 10, 
    @msgtext = "geçerli bir ürün numarası giriniz", 
    @with_log = true;

SELECT * FROM sys.messages WHERE message_id = 99934;
sp_dropmessage 50010;
SELECT @@ERROR;
--oluşan son hatanın kodunu verir

RAISERROR("Mevcut bir ürünü eklemeye çalışıyorsunuz.",10,1)
/*
BEGIN TRY

END TRY
    BEGIN CATCH
            THROW
END CATCH
*/

CREATE PROCEDURE pr_HataBilgisiGoster
AS
SELECT 
ERROR_NUMBER() AS ErrorNumber,
ERROR_SEVERITY() AS ErrorSeverity,
ERROR_STATE() AS ErrorState,
ERROR_PROCEDURE() as ErrorProcedure,
ERROR_LINE() AS ErrorLine,
ERROR_MESSAGE() AS ErrorMessage



