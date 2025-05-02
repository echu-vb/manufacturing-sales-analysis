Conducted sales analysis on on manufacuring company using sample data found on the following [link](https://www.kaggle.com/datasets/kyanyoga/sample-sales-data/data)


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

## Output

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

## Output

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

