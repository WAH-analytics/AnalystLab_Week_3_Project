use sample_sales;

CREATE TABLE sales_raw (
    ORDERNUMBER VARCHAR(20),
    QUANTITYORDERED INT,
    PRICEEACH DECIMAL(10,2),
    ORDERLINENUMBER INT,
    SALES DECIMAL(10,2),
    ORDERDATE VARCHAR(30),
    STATUS VARCHAR(50),
    QTR_ID INT,
    MONTH_ID INT,
    YEAR_ID INT,
    PRODUCTLINE VARCHAR(100),
    MSRP DECIMAL(10,2),
    PRODUCTCODE VARCHAR(50),
    CUSTOMERNAME VARCHAR(150),
    PHONE VARCHAR(50),
    ADDRESSLINE1 VARCHAR(255),
    ADDRESSLINE2 VARCHAR(255),
    CITY VARCHAR(100),
    STATE VARCHAR(100),
    POSTALCODE VARCHAR(50),
    COUNTRY VARCHAR(100),
    TERRITORY VARCHAR(50),
    CONTACTLASTNAME VARCHAR(100),
    CONTACTFIRSTNAME VARCHAR(100),
    DEALSIZE VARCHAR(50)
);
SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Users/WAH3/Desktop/Analystlab Africa/sample_sales_data/sales_data_sample.csv'
INTO TABLE sales_raw
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- data preview
select *
from sales_raw;

-- full row counts
select count(*)
from sales_raw;

-- schema columns structure
select count(*) as total_columns
from information_schema.columns
where table_schema = 'sample_sales' 
and table_name = 'sales_raw';

describe sales_raw;

select *
from sales_raw;

-- unexpected line-item duplicates
SELECT ORDERNUMBER, PRODUCTCODE, COUNT(*)
FROM sales_raw
GROUP BY ORDERNUMBER, PRODUCTCODE
HAVING COUNT(*) > 1;

-- standardizing missing structural states
UPDATE sales_raw
SET STATE = 'Unknown'
WHERE STATE IS NULL OR TRIM(STATE) = '' OR STATE = 'NULL';

select STATE
from sales_raw;

select count(STATE) as unknown_state
from sales_raw
where STATE = 'Unknown';

select distinct(COUNTRY)
from sales_raw;

select count(CITY), count(POSTALCODE), count(COUNTRY)
from sales_raw;

select distinct(STATUS)
from sales_raw;

-- checking for inconsistent PRICEEACH records
SELECT 
    ORDERNUMBER,
    QUANTITYORDERED,
    SALES,
    PRICEEACH AS CappedPriceEach,
    ROUND((SALES / QUANTITYORDERED), 2) AS TruePriceEach 
FROM sales_raw;

-- rectifying the $100 price cap logic error using underlying metrics
UPDATE sales_raw
SET PRICEEACH = ROUND((SALES / QUANTITYORDERED), 2)
WHERE PRICEEACH = 100.00;

SELECT 
    ORDERNUMBER,
    QUANTITYORDERED,
    PRICEEACH,
    SALES
FROM sales_raw;

select * 
from sales_raw;

-- Creating a descriptive month name field
ALTER TABLE sales_raw ADD COLUMN MONTH_NAME VARCHAR(15);

UPDATE sales_raw
SET MONTH_NAME = CASE MONTH_ID
    WHEN 1 THEN 'January'
    WHEN 2 THEN 'February'
    WHEN 3 THEN 'March'
    WHEN 4 THEN 'April'
    WHEN 5 THEN 'May'
    WHEN 6 THEN 'June'
    WHEN 7 THEN 'July'
    WHEN 8 THEN 'August'
    WHEN 9 THEN 'September'
    WHEN 10 THEN 'October'
    WHEN 11 THEN 'November'
    WHEN 12 THEN 'December'
END;

select MONTH_NAME, MONTH_ID
from sales_raw;

select distinct(YEAR_ID), sum(SALES) as REVENUE
FROM sales_raw
group by YEAR_ID;

select *
from sales_raw;

SELECT COUNTRY, COUNT(*) AS MissingCount
FROM sales_raw
WHERE POSTALCODE IS NULL OR POSTALCODE = ''
GROUP BY COUNTRY;


-- resolving missing values in address lines and postal records
UPDATE sales_raw
SET POSTALCODE = 'Not Available'
WHERE POSTALCODE = 'N/A'  OR POSTALCODE = '';

SELECT ORDERNUMBER, CUSTOMERNAME, STATE, POSTALCODE 
FROM sales_raw 
WHERE COUNTRY = 'USA' AND POSTALCODE = 'Not Available';

UPDATE sales_raw
SET ADDRESSLINE2 = 'Not Provided'
WHERE ADDRESSLINE2 = '' OR ADDRESSLINE2 = ' ';

select ADDRESSLINE1, ADDRESSLINE2
from sales_raw;

-- Implementing validation column strategy to eliminate data scrambling risk
ALTER TABLE sales_raw 
ADD COLUMN TEST_DATE DATETIME;

UPDATE sales_raw
SET TEST_DATE = STR_TO_DATE(ORDERDATE, '%m/%d/%Y %H:%i');

select TEST_DATE, ORDERDATE
from sales_raw;

-- overwriting text values with verified dates and dropping the staging field
UPDATE sales_raw
SET ORDERDATE = TEST_DATE;

ALTER TABLE sales_raw 
DROP COLUMN TEST_DATE;

-- Permanently changing schema structure to native datetime formatting
ALTER TABLE sales_raw 
MODIFY COLUMN ORDERDATE DATETIME;

select ORDERDATE
from sales_raw;

-- performance metrics and volume distribution by product line
SELECT 
    PRODUCTLINE,
    COUNT(DISTINCT ORDERNUMBER) AS TotalOrders,
    SUM(QUANTITYORDERED) AS TotalUnitsSold,
    ROUND(SUM(SALES), 2) AS TotalRevenue,
    ROUND(AVG(PRICEEACH), 2) AS AverageUnitPrice
FROM sales_raw
GROUP BY PRODUCTLINE
ORDER BY TotalRevenue DESC;

-- high-revenue (> $500k) by country
SELECT 
    COUNTRY,
    ROUND(SUM(SALES), 2) AS TotalRevenue
FROM sales_raw
GROUP BY COUNTRY
HAVING TotalRevenue > 500000
ORDER BY TotalRevenue DESC;

-- Time-series analysis tracking monthly volume and trend seasonality
SELECT 
    YEAR_ID,
    MONTH_ID,
    MONTH_NAME,
    ROUND(SUM(SALES), 2) AS MonthlyRevenue,
    COUNT(DISTINCT ORDERNUMBER) AS OrderVolume
FROM sales_raw
GROUP BY YEAR_ID, MONTH_ID, MONTH_NAME
ORDER BY YEAR_ID ASC, MONTH_ID ASC;

