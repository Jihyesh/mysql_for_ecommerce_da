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