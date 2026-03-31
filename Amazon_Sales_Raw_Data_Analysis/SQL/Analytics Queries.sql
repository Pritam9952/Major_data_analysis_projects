-- ANALYTICS QUERIES 


SELECT * FROM fact_sales;
SELECT COUNT(*) FROM fact_sales;


-- 📊 1. Total Sales
SELECT SUM(amount) AS total_sales
FROM fact_sales;

-- 📈 2. Monthly Sales Trend
SELECT
	month,
	SUM(amount) AS monthly_sales
FROM fact_sales
GROUP BY month
ORDER BY monthly_sales DESC;


-- 🏙 3. Top States by Revenue
SELECT 
	ship_state,
	SUM(amount) AS revenue
FROM fact_sales
GROUP BY ship_state
ORDER BY revenue DESC LIMIT 10;


-- 🏢 4. Top Cities by Revenue
SELECT
	ship_city,
	SUM(amount) AS revenue
FROM fact_sales
GROUP BY ship_city
ORDER BY revenue DESC
LIMIT 10;


-- 🛍 5. Category Performance
SELECT category,
SUM(amount) AS category_sales
FROM fact_sales f
JOIN dim_product p
ON f.sku = p.sku
GROUP BY category
ORDER BY category_sales DESC;


-- 🚚 6. Courier Performance
SELECT 
	 courier_status,
	 COUNT(order_id) AS total_orders
FROM amazon_sales_clean
GROUP BY courier_status;


-- 📦 7. Fulfilment Revenue
SELECT
	fulfilment,
	SUM(amount) AS revenue
FROM fact_sales
GROUP BY fulfilment;


-- 👕 8. Revenue by Size
SELECT  
	size,
	SUM(amount) AS revenue
FROM fact_sales f
JOIN dim_product p
ON f.sku = p.sku
GROUP BY size
ORDER BY revenue DESC;


-- 💰 9. Total Profit
SELECT SUM(profit) AS total_profit
FROM fact_sales;

-- 📊 10. Profit by Category
SELECT  
	category,
	ROUND(SUM(profit),2) AS category_profit
FROM fact_sales f
JOIN dim_product p
ON f.sku = p.sku
GROUP BY category
ORDER BY category_profit DESC;