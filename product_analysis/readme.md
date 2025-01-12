## E-commerce의 제품별 매출, 주문수, 마진 특성을 살펴봤습니다. 데이터 추출은 MySQL을 사용했고, 시각화 툴은 Excel의 차트를 사용하여 인사이트를 도출했습니다.
(Eng) This analysis explored the sales, order volume, and margin characteristics by product in e-commerce. Data was extracted using MySQL, and insights were derived using Microsoft Excel charts.


### 전체 구매량은 1번 제품이 가장 많은 반면, 세션당 평균 구매액은 2번 제품이 가장 큰 것을 알 수 있다.
(Eng) The total purchase volume is highest for Product 1, whereas the average purchase amount per session is largest for Product 2.

<p align="center">
<a href="url"><img src="https://github.com/user-attachments/assets/bd0ec04f-e54c-4705-a8c9-712e92ae4d00" height="350" width="700" ></a> 
</p>

[MySQL code](https://github.com/Jihyesh/mysql_for_ecommerce_da/blob/main/product_analysis/72%20analyzing%20product%20sales%20and%20product%20launches.sql)

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
<br/><br/>


### 2023년 1월 이전의 트렌드를 살펴보면, 플랫폼의 매출과 주문, 그에 따른 이익도 증가하고 있다. 그러나 마진율이 점점 초반 대비 감소한 것을 볼 수 있다. 마진율이 감소한 이유로는 트래픽이 증가함에 따라 플랫폼을 운영하는 비용이 증가하는 반면에 구매로 전환되는 비율이 상대적으로 덜 증가하기 때문이라고 추측할 수 있다.
(Eng) Looking at trends prior to January 2023, the platform's revenue, orders, and resulting profits have been increasing. However, it is noticeable that the profit margin rate has been gradually declining compared to the early stages. The decrease in the profit margin rate can be attributed to the increasing cost of operating the platform as traffic grows, while the conversion rate to purchases has not increased proportionally.

<p align="center">
<a href="url"><img src="https://github.com/user-attachments/assets/f587c2ef-9230-45b1-b7ae-c776d9cefeb9" height="350" width="700" ></a> 
</p>
	
[MySQL code](https://github.com/Jihyesh/mysql_for_ecommerce_da/blob/main/product_analysis/73%20product-level%20sales%20analysis.sql)

```
 SELECT
	YEAR(created_at) AS yr,
    MONTH(created_at) AS mo,
    -- SUM(items_purchased) AS number_of_sales,
    COUNT(DISTINCT order_id) AS number_of_sales,
    SUM(price_usd) AS total_revenue,
	SUM(price_usd - cogs_usd) AS total_margin
    
 FROM orders
 WHERE created_at < '2013-01-04' -- date of request
 GROUP BY YEAR(created_at), MONTH(created_at)
```
<br/><br/>

### 2023년 1월에 제품 2를 새로 출시했고, 트렌드를 살펴보면 구매전환율이 증가한 것을 확인할 수 있다. 구매전환율이 증가하면 마진율 상승을 기대할 수 있다.
(Eng) In January 2023, this e-commerce business launched Product 2, and trends show an increase in the conversion rate. An increase in the conversion rate is expected to lead to higher profit rate.
<p align="center">
<a href="url"><img src="https://github.com/user-attachments/assets/5f7745ab-118f-4c2e-95a9-cda9cb84e6db" height="350" width="700" ></a> 
</p>

[MySQL code](https://github.com/Jihyesh/mysql_for_ecommerce_da/blob/main/product_analysis/75%20analyzing%20product%20launches.sql)

```
SELECT 
	YEAR(website_sessions.created_at) AS yr,
    MONTH(website_sessions.created_at) AS mo,
	COUNT(DISTINCT orders.order_id) AS orders,
    COUNT(DISTINCT orders.order_id)/COUNT(DISTINCT website_sessions.website_session_id)  AS conv_rate,
    SUM(orders.price_usd)/COUNT(DISTINCT website_sessions.website_session_id) AS revenue_per_session,
    COUNT(DISTINCT CASE WHEN orders.primary_product_id = 1 THEN orders.order_id ELSE NULL END) AS product_one_orders,
    COUNT(DISTINCT CASE WHEN orders.primary_product_id = 2 THEN orders.order_id ELSE NULL END) AS product_two_orders

FROM website_sessions
	LEFT JOIN orders ON website_sessions.website_session_id = orders.website_session_id
WHERE website_sessions.created_at < '2013-04-05' 
	AND website_sessions.created_at > '2012-04-01' 
GROUP BY YEAR(created_at), MONTH(created_at)
ORDER BY 1, 2
```
