-- Hourly Sales Table -- 
SELECT * 
FROM dbo.saleshourly

-- Sum of all drug sales on Sunday
SELECT SUM(M01AB + M01AE + N02BA + N02BE + N05B + N05C + R03 + R06) AS All_Drugs_Sold_Sunday
FROM dbo.saleshourly
WHERE Weekday_Name = 'Sunday' AND Year = '2014';

-- Which Hours had the most sales 
SELECT Hour, SUM(M01AB + M01AE + N02BA + N02BE + N05B + N05C + R03 + R06) AS Total_Drug_Sales
FROM dbo.saleshourly
GROUP BY Hour
ORDER BY HOUR ASC;

-- Daily Sales Table --  
SELECT * 
FROM dbo.salesdaily

-- Total Sum of Sales by Day 
SELECT Weekday_Name, SUM(M01AB + M01AE + N02BA + N02BE + N05B + N05C + R03 + R06) AS Total_Drug_Sales
FROM dbo.salesdaily
GROUP BY Weekday_Name;

-- Total Sum of Sales of Anti-Inflammitory and antirheumatic products
SELECT Weekday_Name, SUM(M01AB + M01AE) AS Anti_Inflammitory_Sales
FROM dbo.salesdaily
GROUP BY Weekday_Name;

-- Total Sum of Sales of Psycholeptics drugs
SELECT Weekday_Name, SUM(N05B + N05C) AS Psycholeptic_Drug_Sales
FROM dbo.salesdaily
GROUP BY Weekday_Name;

-- Weekly Sales Table --
SELECT * 
FROM dbo.salesweekly

-- Total Drug Sales by each week' 
SELECT
  DATEPART(week, datum) AS Week,
  SUM(M01AB + M01AE + N02BA + N02BE + N05B + N05C + R03 + R06) AS Total_Drug_Sales
FROM dbo.salesweekly
WHERE '2014-01-05' <= datum
  AND datum < '2019-10-13'
GROUP BY DATEPART(week, datum)
ORDER BY DATEPART(week, datum);

-- Monthly Sales Table -- 
SELECT *
FROM dbo.salesmonthly

-- Total Drug Sales monthly
CREATE VIEW Monthly_Sales 
AS 
SELECT 
    DATEPART(MONTH, datum) AS Month,
    SUM(M01AB + M01AE + N02BA + N02BE + N05B + N05C + R03 + R06) AS Total_Drug_Sales
FROM dbo.salesweekly
    WHERE '2014-01-05' <= datum  AND datum < '2019-10-13'
        GROUP BY DATEPART(MONTH, datum);

SELECT * FROM Monthly_Sales;


    

