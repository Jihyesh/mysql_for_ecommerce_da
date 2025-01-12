

[MySQL code](https://github.com/Jihyesh/mysql_for_ecommerce_da/blob/main/product_analysis/72%20analyzing%20product%20sales%20and%20product%20launches.sql)
<br/>
```
SELECT
primary_product_id, 
COUNT(DISTINCT order_id) AS orders,
SUM(price_usd) AS revenue,
SUM(price_usd - cogs_usd) AS margin,
AVG(price_usd) AS aov

FROM orders
WHERE order_id BETWEEN 10000 AND 11000 -- arbitrary

GROUP BY 1;
```
<a href="url"><img src="https://github.com/user-attachments/assets/bd0ec04f-e54c-4705-a8c9-712e92ae4d00" height="350" width="700" ></a> 




<a href="url"><img src="https://github.com/user-attachments/assets/f587c2ef-9230-45b1-b7ae-c776d9cefeb9" height="350" width="700" ></a> 
<br/>
[MySQL code](https://github.com/Jihyesh/mysql_for_ecommerce_da/blob/main/product_analysis/73%20product-level%20sales%20analysis.sql)




<a href="url"><img src="https://github.com/user-attachments/assets/5f7745ab-118f-4c2e-95a9-cda9cb84e6db" height="350" width="700" ></a> 
<br/>
[MySQL code](https://github.com/Jihyesh/mysql_for_ecommerce_da/blob/main/product_analysis/75%20analyzing%20product%20launches.sql)
