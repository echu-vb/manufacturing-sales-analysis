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
