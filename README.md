Conducted sales analysis on on manufacuring company using sample data found on the following [link](https://www.kaggle.com/datasets/kyanyoga/sample-sales-data/data)


## Schema
![image](https://github.com/echu-vb/manufacturing-sales-analysis/blob/1c69a33490eae7fa4175bad8298d674b2cd32da6/schema.png)

## What is the company's yearly sales?
```sql
SELECT YEAR_ID AS SALESYEAR, ROUND(SUM(SALES),3) AS TOTALSALES
FROM sample_dataset.sales_data_sample
WHERE STATUS = 'Shipped'
GROUP BY SALESYEAR
ORDER BY SALESYEAR ASC;

| SALESYEAR | TOTAL_SALES |
| --------- | ----------- |
| 2003      | 24078026.21 |
| 2004      | 31696330.54 |
| 2005      | 9266150.81  |

## What is the company's best selling products?
```sql
SELECT PRODUCTLINE, SUM(QUANTITYORDERED) AS TOTAL_SOLD 
FROM sample_dataset.sales_data_sample
GROUP BY PRODUCTLINE
ORDER BY TOTAL_SOLD DESC;

| PRODUCTLINE | TOTAL_SOLD |
| ----------- | ---------- |
| Classic Cars | 237944    |
| Vintage Cars	| 147483   |
| Motorcycles |	81641      |
| Trucks and Buses |	75439|
| Planes	| 75089          |
| Ships |	56889            |
| Trains	| 18984          |


