/* What is the company's yearly sales?
What is the company's best selling products?
How do sales change by year?
How do sales differ by country/territory?
What months show the most sales?
*/

-- Join data from a new dataset to correct territory column
SELECT s.ORDERNUMBER, s.QUANTITYORDERED, s.PRICEEACH, s.ORDERLINENUMBER, s.SALES, s.STATUS, s.QTR_ID, s.MONTH_ID, s.YEAR_ID, s.PRODUCTLINE, s.MSRP, s.PRODUCTCODE, s.CUSTOMERNAME, s.CITY, s.DEALSIZE, t.COUNTRY, t.TERRITORY 
FROM sample_dataset.sales_data_sample AS s
INNER JOIN sample_dataset.territory_data AS t
ON s.COUNTRY = t.COUNTRY

-- Select all data from the year 2005
SELECT * 
FROM sample_dataset.sales_data_sample
WHERE YEAR_ID = 2005;

-- Total sales from 2005 where order status was shipped
SELECT YEAR_ID, ROUND(SUM(SALES),3) AS TOTAL_SALES 
FROM sample_dataset.sales_data_sample
WHERE STATUS = 'Shipped'
AND YEAR_ID = 2005;

-- Best selling products
SELECT PRODUCTLINE, SUM(QUANTITYORDERED) AS TOTAL_SOLD 
FROM sample_dataset.sales_data_sample
GROUP BY PRODUCTLINE
ORDER BY TOTAL_SOLD DESC;

-- Sales trend by year where products were shipped
SELECT YEAR_ID AS SALESYEAR, ROUND(SUM(SALES),3) AS TOTALSALES
FROM sample_dataset.sales_data_sample
WHERE STATUS = 'Shipped'
GROUP BY SALESYEAR
ORDER BY SALESYEAR ASC;

-- Ranking best selling products using CTE and Dense Rank
WITH PRODUCT_SALES AS (
SELECT PRODUCTLINE, SUM(QUANTITYORDERED) AS TOTAL_SOLD
FROM sample_dataset.sales_data_sample
GROUP BY PRODUCTLINE
)
SELECT DENSE_RANK() OVER(ORDER BY TOTAL_SOLD DESC) AS RANKING,
PRODUCTLINE, TOTAL_SOLD
FROM PRODUCT_SALES;

-- Ranking sales by Country
WITH COUNTRY_SALES AS (
SELECT COUNTRY, SUM(SALES) AS TOTAL_SALES
FROM sample_dataset.sales_data_sample
WHERE STATUS = 'Shipped'
GROUP BY COUNTRY
)
SELECT RANK() OVER(ORDER BY TOTAL_SALES DESC) AS RANKING, COUNTRY, ROUND(TOTAL_SALES,3) AS TOTAL_SALES
FROM COUNTRY_SALES;

-- Sales by Territory
SELECT t.TERRITORY, ROUND(SUM(s.SALES),3) AS TOTAL_SALES
FROM sample_dataset.sales_data_sample AS s
INNER JOIN sample_dataset.territory_data AS t
ON s.COUNTRY = t.COUNTRY
WHERE s.STATUS = 'Shipped'
GROUP BY t.TERRITORY
ORDER BY TOTAL_SALES DESC;

-- Sales by Month
SELECT MONTH_ID, ROUND(SUM(SALES),3) AS TOTAL_SALES
FROM sample_dataset.sales_data_sample
WHERE STATUS = 'Shipped'
GROUP BY MONTH_ID
ORDER BY TOTAL_SALES DESC;