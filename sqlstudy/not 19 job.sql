USE SATISVT
CREATE TABLE JOBTABLOSU
(
ID INT IDENTITY(1,1),
METIN VARCHAR(20)
)

INSERT INTO JOBTABLOSU (METIN) VALUES ('TEST YAPIYORUZ')

SELECT * FROM JOBTABLOSU

//job'ı durdurmak için
//job üzerine sağ tıkla > disable