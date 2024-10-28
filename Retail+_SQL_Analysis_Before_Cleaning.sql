SELECT top 50 * FROM dbo.retail_I

SELECT TOP 50 * FROM dbo.abnblist

SELECT TOP 50 * FROM retailplusdb.dbo.classtable
SELECT TOP 50 * FROM retailplusdb.dbo.maintable

--NA ve Unspecified incelemesi
SELECT * FROM retailplusdb.dbo.maintable
WHERE [Description] = 'NA'

SELECT *  FROM retailplusdb.dbo.maintable
WHERE [Categories]= 'NA'

SELECT * FROM retailplusdb.dbo.maintable
WHERE Country = 'Unspecified'

--Tarih Saat Ayrımı + Monetary Sonra Ana tabloya ekle.
SELECT *
INTO Retail_Plus_Yagiz
FROM retailplusdb.dbo.maintable


--Feauture Engineering
ALTER TABLE Retail_Plus_Yagiz ADD Tarih date
ALTER TABLE Retail_Plus_Yagiz ADD Zaman time
ALTER TABLE Retail_Plus_Yagiz ADD Monetary float
ALTER TABLE Retail_Plus_Yagiz ADD Yil int
ALTER TABLE Retail_Plus_Yagiz ADD Ay int
ALTER TABLE Retail_Plus_Yagiz ADD Gun int
ALTER TABLE Retail_Plus_Yagiz ADD Season char(20)

UPDATE Retail_Plus_Yagiz SET Tarih = CONVERT(date, Dates)
UPDATE Retail_Plus_Yagiz SET Zaman = CONVERT(time, Dates)
UPDATE Retail_Plus_Yagiz SET Monetary = ROUND((Quantity*Price),2)
UPDATE Retail_Plus_Yagiz SET Yil = YEAR(Dates)
UPDATE Retail_Plus_Yagiz SET Ay = Month(Dates)
UPDATE Retail_Plus_Yagiz SET Gun = Day(Dates)

--Rename Columns
EXEC sp_rename 'Retail_Plus_Yagiz.Tarih', 'LitDate', 'COLUMN';
EXEC sp_rename 'Retail_Plus_Yagiz.Zaman', 'Time', 'COLUMN';
EXEC sp_rename 'Retail_Plus_Yagiz.Yil', 'Year', 'COLUMN';
EXEC sp_rename 'Retail_Plus_Yagiz.Ay', 'LitMonth', 'COLUMN';
EXEC sp_rename 'Retail_Plus_Yagiz.Gun', 'Day', 'COLUMN';


UPDATE Retail_Plus_Yagiz SET Season = CASE 
                                       WHEN LitMonth IN (12,1,2) Then 'Winter'
                                       WHEN LitMonth IN (3,4,5) Then 'Spring'
                                       WHEN LitMonth IN (6,7,8) Then 'Summer'
                                       WHEN LitMonth IN (9,10,11) Then 'Autumn' 
                                      END
WHERE LitMonth IN (1,2,3,4,5,6,7,8,9,10,11,12) 


--Deneme
SELECT TOP 50 * FROM Retail_Plus_Yagiz


--Group By
--CustomerID
SELECT Customer_ID, 
SUM(Quantity) Total_Quantity, AVG(Quantity) Average_Quantity, MAX(Quantity) Max_Quantity, MIN(Quantity) Min_Quantity,
ROUND(SUM(Price),2 )Total_Price, ROUND(AVG(Price),2) Average_Price, MAX(Price) Max_Price, MIN(Price) Min_Price,
ROUND(SUM(Monetary),2) Total_Monetary, ROUND(AVG(Monetary),2) Average_Monetary, MAX(Monetary) Max_Monetary, MIN(Monetary) Min_Monetary
FROM  Retail_Plus_Yagiz
GROUP BY Customer_ID

--Categories
SELECT Categories, 
SUM(Quantity) Total_Quantity, AVG(Quantity) Average_Quantity, MAX(Quantity) Max_Quantity, MIN(Quantity) Min_Quantity,
ROUND(SUM(Price),2 )Total_Price, ROUND(AVG(Price),2) Average_Price, MAX(Price) Max_Price, MIN(Price) Min_Price,
ROUND(SUM(Monetary),2) Total_Monetary, ROUND(AVG(Monetary),2) Average_Monetary, MAX(Monetary) Max_Monetary, MIN(Monetary) Min_Monetary
FROM  Retail_Plus_Yagiz
GROUP BY Categories

--Season
SELECT Season, 
SUM(Quantity) Total_Quantity, AVG(Quantity) Average_Quantity, MAX(Quantity) Max_Quantity, MIN(Quantity) Min_Quantity,
ROUND(SUM(Price),2 )Total_Price, ROUND(AVG(Price),2) Average_Price, MAX(Price) Max_Price, MIN(Price) Min_Price,
ROUND(SUM(Monetary),2) Total_Monetary, ROUND(AVG(Monetary),2) Average_Monetary, MAX(Monetary) Max_Monetary, MIN(Monetary) Min_Monetary
FROM  Retail_Plus_Yagiz
GROUP BY Season

--Country
SELECT Country, 
SUM(Quantity) Total_Quantity, AVG(Quantity) Average_Quantity, MAX(Quantity) Max_Quantity, MIN(Quantity) Min_Quantity,
ROUND(SUM(Price),2 )Total_Price, ROUND(AVG(Price),2) Average_Price, MAX(Price) Max_Price, MIN(Price) Min_Price,
ROUND(SUM(Monetary),2) Total_Monetary, ROUND(AVG(Monetary),2) Average_Monetary, MAX(Monetary) Max_Monetary, MIN(Monetary) Min_Monetary
FROM  Retail_Plus_Yagiz
GROUP BY Country

--Description
SELECT [Description], 
SUM(Quantity) Total_Quantity, AVG(Quantity) Average_Quantity, MAX(Quantity) Max_Quantity, MIN(Quantity) Min_Quantity,
ROUND(SUM(Price),2 )Total_Price, ROUND(AVG(Price),2) Average_Price, MAX(Price) Max_Price, MIN(Price) Min_Price,
ROUND(SUM(Monetary),2) Total_Monetary, ROUND(AVG(Monetary),2) Average_Monetary, MAX(Monetary) Max_Monetary, MIN(Monetary) Min_Monetary
FROM  Retail_Plus_Yagiz
GROUP BY [Description]

--StockCode
SELECT [StockCode], 
SUM(Quantity) Total_Quantity, AVG(Quantity) Average_Quantity, MAX(Quantity) Max_Quantity, MIN(Quantity) Min_Quantity,
ROUND(SUM(Price),2 )Total_Price, ROUND(AVG(Price),2) Average_Price, MAX(Price) Max_Price, MIN(Price) Min_Price,
ROUND(SUM(Monetary),2) Total_Monetary, ROUND(AVG(Monetary),2) Average_Monetary, MAX(Monetary) Max_Monetary, MIN(Monetary) Min_Monetary
FROM  Retail_Plus_Yagiz
GROUP BY [StockCode]

--Invoice
SELECT [Invoice], 
SUM(Quantity) Total_Quantity, AVG(Quantity) Average_Quantity, MAX(Quantity) Max_Quantity, MIN(Quantity) Min_Quantity,
ROUND(SUM(Price),2 )Total_Price, ROUND(AVG(Price),2) Average_Price, MAX(Price) Max_Price, MIN(Price) Min_Price,
ROUND(SUM(Monetary),2) Total_Monetary, ROUND(AVG(Monetary),2) Average_Monetary, MAX(Monetary) Max_Monetary, MIN(Monetary) Min_Monetary
FROM  Retail_Plus_Yagiz
GROUP BY [Invoice]

--Dates
SELECT [Dates], 
SUM(Quantity) Total_Quantity, AVG(Quantity) Average_Quantity, MAX(Quantity) Max_Quantity, MIN(Quantity) Min_Quantity,
ROUND(SUM(Price),2 )Total_Price, ROUND(AVG(Price),2) Average_Price, MAX(Price) Max_Price, MIN(Price) Min_Price,
ROUND(SUM(Monetary),2) Total_Monetary, ROUND(AVG(Monetary),2) Average_Monetary, MAX(Monetary) Max_Monetary, MIN(Monetary) Min_Monetary
FROM  Retail_Plus_Yagiz
GROUP BY [Dates]

--LitDate
SELECT LitDate, 
SUM(Quantity) Total_Quantity, AVG(Quantity) Average_Quantity, MAX(Quantity) Max_Quantity, MIN(Quantity) Min_Quantity,
ROUND(SUM(Price),2 )Total_Price, ROUND(AVG(Price),2) Average_Price, MAX(Price) Max_Price, MIN(Price) Min_Price,
ROUND(SUM(Monetary),2) Total_Monetary, ROUND(AVG(Monetary),2) Average_Monetary, MAX(Monetary) Max_Monetary, MIN(Monetary) Min_Monetary
FROM  Retail_Plus_Yagiz
GROUP BY LitDate

--Time
SELECT Time, 
SUM(Quantity) Total_Quantity, AVG(Quantity) Average_Quantity, MAX(Quantity) Max_Quantity, MIN(Quantity) Min_Quantity,
ROUND(SUM(Price),2 )Total_Price, ROUND(AVG(Price),2) Average_Price, MAX(Price) Max_Price, MIN(Price) Min_Price,
ROUND(SUM(Monetary),2) Total_Monetary, ROUND(AVG(Monetary),2) Average_Monetary, MAX(Monetary) Max_Monetary, MIN(Monetary) Min_Monetary
FROM  Retail_Plus_Yagiz
GROUP BY Time

--Year
SELECT Year, 
SUM(Quantity) Total_Quantity, AVG(Quantity) Average_Quantity, MAX(Quantity) Max_Quantity, MIN(Quantity) Min_Quantity,
ROUND(SUM(Price),2 )Total_Price, ROUND(AVG(Price),2) Average_Price, MAX(Price) Max_Price, MIN(Price) Min_Price,
ROUND(SUM(Monetary),2) Total_Monetary, ROUND(AVG(Monetary),2) Average_Monetary, MAX(Monetary) Max_Monetary, MIN(Monetary) Min_Monetary
FROM  Retail_Plus_Yagiz
GROUP BY Year

--LitMonth
SELECT LitMonth, 
SUM(Quantity) Total_Quantity, AVG(Quantity) Average_Quantity, MAX(Quantity) Max_Quantity, MIN(Quantity) Min_Quantity,
ROUND(SUM(Price),2 )Total_Price, ROUND(AVG(Price),2) Average_Price, MAX(Price) Max_Price, MIN(Price) Min_Price,
ROUND(SUM(Monetary),2) Total_Monetary, ROUND(AVG(Monetary),2) Average_Monetary, MAX(Monetary) Max_Monetary, MIN(Monetary) Min_Monetary
FROM  Retail_Plus_Yagiz
GROUP BY LitMonth

--Day
SELECT Day, 
SUM(Quantity) Total_Quantity, AVG(Quantity) Average_Quantity, MAX(Quantity) Max_Quantity, MIN(Quantity) Min_Quantity,
ROUND(SUM(Price),2 )Total_Price, ROUND(AVG(Price),2) Average_Price, MAX(Price) Max_Price, MIN(Price) Min_Price,
ROUND(SUM(Monetary),2) Total_Monetary, ROUND(AVG(Monetary),2) Average_Monetary, MAX(Monetary) Max_Monetary, MIN(Monetary) Min_Monetary
FROM  Retail_Plus_Yagiz
GROUP BY Day 

-- Year + LitMonth
SELECT Year, LitMonth,
SUM(Quantity) Total_Quantity, AVG(Quantity) Average_Quantity, MAX(Quantity) Max_Quantity, MIN(Quantity) Min_Quantity,
ROUND(SUM(Price),2 )Total_Price, ROUND(AVG(Price),2) Average_Price, MAX(Price) Max_Price, MIN(Price) Min_Price,
ROUND(SUM(Monetary),2) Total_Monetary, ROUND(AVG(Monetary),2) Average_Monetary, MAX(Monetary) Max_Monetary, MIN(Monetary) Min_Monetary
FROM  Retail_Plus_Yagiz
GROUP BY Year, LitMonth

SELECT TOP 50 * FROM Retail_Plus_Yagiz

--NA / Unspecified İncelenmesi
SELECT * FROM Retail_Plus_Yagiz
WHERE Categories = 'NA'

-- Categoriesde NA varsa Descriptionda da var. Descriptionda NA varsa Categoriesde de var. 
SELECT COUNT(*) NA_Record_Values FROM Retail_Plus_Yagiz
WHERE Categories = 'NA'

SELECT * FROM Retail_Plus_Yagiz
WHERE Country = 'Unspecified'

SELECT COUNT(*) Unspecified_Record_Values FROM Retail_Plus_Yagiz
WHERE Country = 'Unspecified'


--Outlier İncelemesi
--Quantity 27 / -13
--Price 7,5 / 2,5
--Monetary 41,325 / -16,875 

SELECT * FROM Retail_Plus_Yagiz
WHERE Quantity > 27

SELECT COUNT(*) Quantity_Record_Number FROM Retail_Plus_Yagiz
WHERE Quantity > 27

SELECT * FROM Retail_Plus_Yagiz
WHERE Price > 7.5

SELECT COUNT(*) Price_Record_Number FROM Retail_Plus_Yagiz
WHERE Price > 7.5

SELECT * FROM Retail_Plus_Yagiz
WHERE Monetary > 41.325

SELECT COUNT(*) Monetary_Record_Number FROM Retail_Plus_Yagiz
WHERE Monetary > 41.325

--Outlier Ortak Kayıt Sayısı - 507 tane var. 
--Değer değiştir,silme. 

SELECT COUNT(*) Intersected_Record_Number FROM (SELECT * FROM Retail_Plus_Yagiz
WHERE Quantity > 27 

INTERSECT

SELECT * FROM Retail_Plus_Yagiz
WHERE Price > 7.5

INTERSECT

SELECT * FROM Retail_Plus_Yagiz
WHERE Monetary > 41.325) T1


SELECT TOP 50 * FROM Retail_Plus_Yagiz


--Unspecified
--Veri toplama ve giriş sürecindeki hatalar veya boşluklardan dolayı ülke bilgisi eksik kalmış olabilir. /İnsan kaynaklı
--Sistem algılayamamış olabilir. /Sistem hatası 
-----Online alışverişlerde müşteri bilgisi takip edilmez ve kaydedilmez ise unspecified kullanılabilir. ** Bazı alışverişler Online mı değil mi? İhtimal var
-----Bazı müşteriler ülkesini paylaşmamış olabilirler veya gizlilik sebebiyle ve yerel düzenlemelerden dolayı kasıtlı olarak toplanmamış olabilir. **/Müşteriye özel boşluk var mı? **Bazı müşterilerin tüm alışverişlerinde ülke bilgisi eksik.


--NA 
--İnsan Kaynaklı veri girişi hatası
--Ürünler yeni tipte gelen ürünlerdir. Sistem o yüzden yeni ürünü ve kategorisini ayarlayamamış olabilir. *Gelen ürünler yeni tip olabilir.
--Farklı kaynaklardan veriler toplanıp bu tablo oluştuysa ve bazı değerler eksik ise NA yazmış olabilir yani gerçekten değeri yok. *Gerçekten değeri olmayabilir.
--Ürün kataloğu ve envanter yönetim sistemindeki güncelleme eksikliğinden kaynaklı olarak NA kalmış olabilir. *Ürün yeni bir ürünse 2. maddeyi destekler ama aynı tarihte farklı saatlerde yine ürün alımı var. Yeni üründen olabilir ama güncelleme tarhinden olamaz.

--SELECT Categories, Dates FROM Retail_Plus_Yagiz


--Outliers
-- İnsan Hatası, Sensör hatası, Eksik-Yanlış birim dönüşümü
-- Doğal Farklılık ve Aşırı Durumlar
-- Cihaz ölçüm hatası
-- Veriler asimetrik dağılmıştır, skewness vardır.
-- Veri seti örneklemesinde veya veri toplama yöntemindeki yanlışlıklar / dengesizlikler.
-- Ani olaylar, şoklar, sistemsel değişiklikler, dışsal faktörler (salgın hastalık, doğal afet, ekonomik kriz,hava koşuları,politika değişiklikleri) outlier yaratabilir
-- Veri seti kümelere/segmentlere ayrılmış olabilir ve bu segmentteki değerler genel veriseti için outlier olabilir. 
-- Sonuçlar için Deney ve anket yapıldığında deney koşullarının yanlış uygulanması, katılıcının soruları anlamayıp aşır uç değerlerde cevap verişi.  

--Quantity'de anormal artış var , haftasonları ve haftaiçi bazı günlerde.   
SELECT LitDate, AVG(Quantity) Avg_Quantity FROM Retail_Plus_Yagiz
WHERE Quantity > 27 
GROUP BY LitDate
ORDER BY LitDate

SELECT LitDate, ROUND(AVG(Price),2) Avg_Price FROM Retail_Plus_Yagiz
WHERE Price > 7.5 
GROUP BY LitDate
ORDER BY LitDate

SELECT LitDate, ROUND(AVG(Monetary),2) Avg_Price FROM Retail_Plus_Yagiz
WHERE Monetary > 41.325 
GROUP BY LitDate
ORDER BY LitDate


SELECT Quantity,Price,Monetary,Dates,LitDate,Time,Season FROM Retail_Plus_Yagiz
WHERE Quantity > 27 

SELECT Price,Quantity,Monetary,Dates,LitDate,Time,Season FROM Retail_Plus_Yagiz
WHERE Price > 7.5

SELECT * FROM Retail_Plus_Yagiz
WHERE Monetary > 41.325  

SELECT TOP 50 * FROM Retail_Plus_Yagiz 
SELECT COUNT(*) RecordAmount FROM Retail_Plus_Yagiz  
 

 