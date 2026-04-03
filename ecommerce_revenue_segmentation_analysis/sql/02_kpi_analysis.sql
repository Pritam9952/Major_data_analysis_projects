-- ============================================================
-- PROJECT: Ecommerce Revenue Segmentation Analysis
-- FILE: 02_kpi_analysis.sql
-- PURPOSE: KPI Analysis & Business Metrics Extraction (DA + BI)
-- ============================================================

-- ============================================================
-- STEP 1: Overall Business KPIs
-- ============================================================
-- Goal:
-- Extract key business metrics for overall performance tracking

SELECT
COUNT(DISTINCT order_id) AS total_orders,
SUM(total_revenue) AS total_revenue,
SUM(profit) AS total_profit,
ROUND(SUM(total_revenue) / COUNT(DISTINCT order_id), 2) AS avg_order_value,
ROUND(AVG(rating), 2) AS avg_rating
FROM ecommerce_data;

-- OUTPUT:
-- total_orders: 50000
-- total_revenue: 32866573.74
-- total_profit: 1643351.46
-- avg_order_value: 657.33
-- avg_rating: 3.00

-- Insight:
-- Business generating strong revenue with moderate average order value

-- ============================================================
-- STEP 2: Revenue per Order
-- ============================================================
-- Goal:
-- Identify high-value orders

SELECT
order_id,
SUM(total_revenue) AS order_revenue
FROM ecommerce_data
GROUP BY order_id
ORDER BY order_revenue DESC;

-- Insight:
-- Helps identify top revenue-generating transactions

-- ============================================================
-- STEP 3: Total Quantity Sold
-- ============================================================
-- Goal:
-- Measure total product demand

SELECT
SUM(quantity_sold) AS total_units_sold
FROM ecommerce_data;

-- OUTPUT:
-- total_units_sold: 149970

-- Insight:
-- High sales volume indicates strong product demand

-- ============================================================
-- STEP 4: Category-wise KPIs
-- ============================================================
-- Goal:
-- Compare performance across product categories

SELECT
product_category,
COUNT(DISTINCT order_id) AS total_orders,
SUM(total_revenue) AS revenue,
SUM(profit) AS profit,
ROUND(AVG(rating), 2) AS avg_rating
FROM ecommerce_data
GROUP BY product_category
ORDER BY revenue DESC;

-- OUTPUT:
-- BEAUTY           → 5550624.97 revenue
-- BOOKS            → 5484863.03 revenue
-- FASHION          → 5480123.34 revenue
-- HOME & KITCHEN   → 5473132.55 revenue
-- ELECTRONICS      → 5470594.03 revenue
-- SPORTS           → 5407235.82 revenue

-- Insight:
-- All categories contribute almost equally (~16–17% each)

-- ============================================================
-- STEP 5: Region-wise Revenue
-- ============================================================
-- Goal:
-- Analyze geographic performance

SELECT
customer_region,
SUM(total_revenue) AS revenue,
SUM(profit) AS profit
FROM ecommerce_data
GROUP BY customer_region
ORDER BY revenue DESC;

-- OUTPUT:
-- MIDDLE EAST     → 8301844.50
-- NORTH AMERICA   → 8277217.84
-- ASIA            → 8175199.83
-- EUROPE          → 8112311.57

-- Insight:
-- Revenue is evenly distributed across regions

-- ============================================================
-- STEP 6: Payment Method Analysis
-- ============================================================
-- Goal:
-- Understand customer payment preferences

SELECT
payment_method,
COUNT(DISTINCT order_id) AS total_orders,
SUM(total_revenue) AS revenue
FROM ecommerce_data
GROUP BY payment_method
ORDER BY revenue DESC;

-- OUTPUT:
-- WALLET            → 6678638.47
-- UPI               → 6579441.44
-- CASH ON DELIVERY  → 6546386.94
-- CREDIT CARD       → 6540087.16
-- DEBIT CARD        → 6522019.73

-- Insight:
-- Digital payments slightly outperform traditional methods

-- ============================================================
-- STEP 7: Rating Impact on Revenue
-- ============================================================
-- Goal:
-- Analyze relationship between ratings and revenue

SELECT
rating,
COUNT(*) AS total_orders,
SUM(total_revenue) AS revenue
FROM ecommerce_data
GROUP BY rating
ORDER BY rating DESC;

-- Insight:
-- Used to validate if higher ratings lead to higher revenue

-- ============================================================
-- STEP 8: Discount Impact Analysis
-- ============================================================
-- Goal:
-- Understand how discounts affect sales

SELECT
discount_percent,
COUNT(*) AS total_orders,
SUM(total_revenue) AS revenue
FROM ecommerce_data
GROUP BY discount_percent
ORDER BY discount_percent;

-- Insight:
-- Helps identify optimal discount levels

-- ============================================================
-- STEP 9: Monthly Revenue Trend
-- ============================================================
-- Goal:
-- Track revenue & profit trends over time

SELECT
TO_CHAR(DATE_TRUNC('month', order_date), 'Mon-YY') AS month,
SUM(total_revenue) AS monthly_revenue,
SUM(profit) AS monthly_profit
FROM ecommerce_data
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY DATE_TRUNC('month', order_date);

-- Insight:
-- Identifies growth trends and seasonal patterns

-- ============================================================
-- STEP 10: Top 10 Orders by Revenue
-- ============================================================
-- Goal:
-- Identify highest revenue-generating orders

SELECT
order_id,
SUM(total_revenue) AS revenue
FROM ecommerce_data
GROUP BY order_id
ORDER BY revenue DESC
LIMIT 10;

-- Insight:
-- Helps target high-value customers

-- ============================================================
-- STEP 11: Revenue Contribution by Category
-- ============================================================
-- Goal:
-- Measure contribution of each category

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

-- OUTPUT:
-- BEAUTY → 16.89%
-- BOOKS → 16.69%
-- FASHION → 16.67%
-- HOME & KITCHEN → 16.65%
-- ELECTRONICS → 16.64%
-- SPORTS → 16.45%

-- Insight:
-- Revenue is evenly distributed → no single dominant category

-- ============================================================
-- FINAL BUSINESS INSIGHTS
-- ============================================================

-- 1. Revenue distribution is balanced across categories
-- 2. No single region dominates revenue
-- 3. Digital payments slightly lead in usage
-- 4. Discounts & ratings need deeper analysis for optimization


-- ============================================================
-- END OF FILE
-- ============================================================
