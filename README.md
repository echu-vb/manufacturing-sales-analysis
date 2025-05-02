# Manufacturing Sales Analysis (SQL/Excel)

Conducted sales analysis on a manufacuring company using sample data found on the following [link](https://www.kaggle.com/datasets/kyanyoga/sample-sales-data/data).

Additional queries can be found on `sales_sample.sql`.

***

## Schema
![image](https://github.com/echu-vb/manufacturing-sales-analysis/blob/1c69a33490eae7fa4175bad8298d674b2cd32da6/schema.png)

***

## What is the company's yearly sales?
```sql
SELECT YEAR_ID AS SALESYEAR, ROUND(SUM(SALES),3) AS TOTALSALES
FROM sample_dataset.sales_data_sample
WHERE STATUS = 'Shipped'
GROUP BY SALESYEAR
ORDER BY SALESYEAR ASC;
```

**Output**

| SALESYEAR | TOTAL_SALES |
| --------- | ----------- |
| 2003      | 24,078,026.21 |
| 2004      | 31,696,330.54 |
| 2005      | 9,266,150.81  |

2004 was the company's best performing year in terms of sales following an increase from 2003 but saw a rapid decrease in sales in 2005.
***

## What is the company's best selling products?
```sql
SELECT PRODUCTLINE, SUM(QUANTITYORDERED) AS TOTAL_SOLD 
FROM sample_dataset.sales_data_sample
GROUP BY PRODUCTLINE
ORDER BY TOTAL_SOLD DESC;
```

**Output**

| PRODUCTLINE | TOTAL_SOLD |
| ----------- | ---------- |
| Classic Cars | 237,944    |
| Vintage Cars	| 147,483   |
| Motorcycles |	81,641      |
| Trucks and Buses |	75,439|
| Planes	| 75,089          |
| Ships |	56,889            |
| Trains	| 18,984          |

The company's best selling products are by far its cars (Vintage and Classic). This could be influenced by factors such as price per unit and a lack of demand in the market.

## Using CTE and Dense Rank

```sql
WITH PRODUCT_SALES AS (
SELECT PRODUCTLINE, SUM(QUANTITYORDERED) AS TOTAL_SOLD
FROM sample_dataset.sales_data_sample
GROUP BY PRODUCTLINE
)
SELECT DENSE_RANK() OVER(ORDER BY TOTAL_SOLD DESC) AS RANKING,
PRODUCTLINE, TOTAL_SOLD
FROM PRODUCT_SALES;
```

**Output**
| RANKING |	PRODUCTLINE |	TOTAL_SOLD |
| ------- | ----------- | ---------- |
| 1	| Classic Cars	| 237,944 | 
| 2 |	Vintage Cars	| 147,483 |
| 3 |	Motorcycles	 | 81,641 |
| 4 |	Trucks and Buses	| 75,439 |
| 5 |	Planes	| 75,089 |
| 6 |	Ships | 56,889 | 
| 7	| Trains	| 18,984 |

***

## How do sales differ by country/territory?
Using  `territory_data` table created from Excel, you can correct mismatched information in the TERRITORY column using a JOIN function.
```sql
SELECT s.ORDERNUMBER, s.QUANTITYORDERED, s.PRICEEACH, s.ORDERLINENUMBER, s.SALES, s.STATUS, s.QTR_ID, s.MONTH_ID, s.YEAR_ID, s.PRODUCTLINE, s.MSRP, s.PRODUCTCODE, s.CUSTOMERNAME, s.CITY, s.DEALSIZE, t.COUNTRY, t.TERRITORY 
FROM sample_dataset.sales_data_sample AS s
INNER JOIN sample_dataset.territory_data AS t
ON s.COUNTRY = t.COUNTRY
```
Now we can find sales by territory.
```sql
SELECT t.TERRITORY, ROUND(SUM(s.SALES),3) AS TOTAL_SALES
FROM sample_dataset.sales_data_sample AS s
INNER JOIN sample_dataset.territory_data AS t
ON s.COUNTRY = t.COUNTRY
WHERE s.STATUS = 'Shipped'
GROUP BY t.TERRITORY
ORDER BY TOTAL_SALES DESC;
```
**Output**
| TERRITORY	| TOTAL_SALES |
| --------- | ----------- |
| EMEA	| 31,865,908.97 |
| NA	| 25,173,979.88 |
| APAC	| 6,683,444.04 |

For further analysis we look at sales per country as well.

```sql
WITH COUNTRY_SALES AS (
SELECT COUNTRY, SUM(SALES) AS TOTAL_SALES
FROM sample_dataset.sales_data_sample
WHERE STATUS = 'Shipped'
GROUP BY COUNTRY
)
SELECT RANK() OVER(ORDER BY TOTAL_SALES DESC) AS RANKING, COUNTRY, ROUND(TOTAL_SALES,3) AS TOTAL_SALES
FROM COUNTRY_SALES;
```

**Output**
| RANKING	| COUNTRY |	TOTAL_SALES |
| ------- | ------- | ----------- |
| 1 | USA	| 23,605,429.96 |
| 2 |	France	| 7,469,922.81 |
| 3	| Spain	| 7,314,337.17 |
| 4 |	Australia	| 4,005,915.06 |
| 5 |	UK	| 2,999,305.47 |
| 6 |	Italy	| 2,622,720.17 |
| 7	| Finland	| 2,307,073.37 |
| 8 |	Norway	| 2,152,245.90 |
| 9 |	Singapore	| 2,019,418.87 |
| 10	| Canada	| 1,568,549.92 |
| 11	| Germany	| 1,543,304.63 |
| 12	| Denmark | 1,368,819.69 |
|13	| Japan	| 1,317,174.67 |
| 14	| Austria	| 1,214,583.58 |
| 15	| Sweden	| 945,301.56 |
| 16	| Switzerland	| 823,994.92 |
| 17	| Belgium	| 700,004.69 |
| 18	| Philippines	| 658,110.11 |
| 19	| Ireland	| 404,295.01 |

When querying for sales by territory, EMEA records the highest amount of sales but when querying for sales of country, we can see that the company actuall gets the most amount of sales from the US.
