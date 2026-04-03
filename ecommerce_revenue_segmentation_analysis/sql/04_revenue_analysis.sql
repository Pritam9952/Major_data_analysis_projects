-- ============================================================
-- PROJECT: Ecommerce Revenue Segmentation Analysis
-- FILE: 04_revenue_analysis.sql
-- PURPOSE: Revenue Insights (DA + BI)
-- ============================================================

-- ============================================================
-- 1. Category-wise Revenue
-- ============================================================

SELECT
product_category,
SUM(total_revenue) AS total_revenue,
SUM(profit) AS total_profit
FROM ecommerce_data
GROUP BY product_category
ORDER BY total_revenue DESC;

-- Shows BEAUTY as highest revenue and profit
-- All categories performing almost equally

-- ============================================================
-- 2. Region-wise Revenue
-- ============================================================

SELECT
customer_region,
SUM(total_revenue) AS revenue,
SUM(profit) AS profit
FROM ecommerce_data
GROUP BY customer_region
ORDER BY revenue DESC;

-- Shows MIDDLE EAST as top region
-- EUROPE is lowest but difference is small

-- ============================================================
-- 3. Monthly Revenue Trend
-- ============================================================

SELECT
DATE_TRUNC('month', order_date) AS month,
SUM(total_revenue) AS revenue,
SUM(profit) AS profit
FROM ecommerce_data
GROUP BY month
ORDER BY month;

-- Shows peak months as Jan, Jul, May
-- Indicates seasonal pattern in revenue

-- ============================================================
-- 4. Daily Revenue Trend
-- ============================================================

SELECT
order_date,
SUM(total_revenue) AS daily_revenue
FROM ecommerce_data
GROUP BY order_date
ORDER BY order_date;

-- Shows day-wise revenue fluctuation

-- ============================================================
-- 5. Payment Method Revenue
-- ============================================================

SELECT
payment_method,
SUM(total_revenue) AS revenue
FROM ecommerce_data
GROUP BY payment_method
ORDER BY revenue DESC;

-- Shows WALLET as highest revenue method
-- Digital payments slightly higher

-- ============================================================
-- 6. Discount vs Revenue
-- ============================================================

SELECT
discount_percent,
COUNT(*) AS total_orders,
SUM(total_revenue) AS revenue
FROM ecommerce_data
GROUP BY discount_percent
ORDER BY discount_percent;

-- Shows low discount (0–5%) gives highest revenue
-- High discount reduces revenue

-- ============================================================
-- 7. Rating vs Revenue
-- ============================================================

SELECT
rating,
COUNT(*) AS total_orders,
SUM(total_revenue) AS revenue
FROM ecommerce_data
GROUP BY rating
ORDER BY rating DESC;

-- Shows no strong relation between rating and revenue

-- ============================================================
-- 8. Top Products
-- ============================================================

SELECT
product_id,
SUM(total_revenue) AS revenue
FROM ecommerce_data
GROUP BY product_id
ORDER BY revenue DESC
LIMIT 10;

-- Shows top revenue generating products

-- ============================================================
-- 9. Category Contribution
-- ============================================================

SELECT
product_category,
SUM(total_revenue) AS revenue,
ROUND(
100.0 * SUM(total_revenue) /
(SELECT SUM(total_revenue) FROM ecommerce_data),
2) AS contribution_percent
FROM ecommerce_data
GROUP BY product_category
ORDER BY contribution_percent DESC;

-- Shows each category contributes ~16–17%
-- No dominant category

-- ============================================================
-- 10. Pareto Analysis
-- ============================================================

WITH category_sales AS (
SELECT
product_category,
SUM(total_revenue) AS revenue
FROM ecommerce_data
GROUP BY product_category
),
ranked AS (
SELECT *,
SUM(revenue) OVER (ORDER BY revenue DESC) AS cumulative_revenue,
SUM(revenue) OVER () AS total_revenue
FROM category_sales
)

SELECT *,
ROUND(100.0 * cumulative_revenue / total_revenue, 2) AS cumulative_percent
FROM ranked;

-- Shows top 5 categories contribute ~83% revenue
-- Confirms balanced distribution

-- ============================================================
-- END OF FILE
-- ============================================================
