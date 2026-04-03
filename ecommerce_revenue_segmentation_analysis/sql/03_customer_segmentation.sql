-- ============================================================
-- PROJECT: Ecommerce Revenue Segmentation Analysis
-- FILE: 03_customer_segmentation.sql
-- PURPOSE: Customer Segmentation & Behavioral Analysis (DA + BI)
-- ============================================================

-- ============================================================
-- STEP 1: Customer-Level Aggregation
-- ============================================================
-- Goal:
-- Analyze overall customer behavior by region

SELECT
customer_region,
COUNT(DISTINCT order_id) AS total_orders,
SUM(total_revenue) AS total_spent,
SUM(quantity_sold) AS total_units,
ROUND(AVG(rating), 2) AS avg_rating
FROM ecommerce_data
GROUP BY customer_region;

-- OUTPUT:
-- ASIA            → Orders: 12526 | Revenue: 8.17M | Units: 37440 | Rating: 3.00
-- EUROPE          → Orders: 12452 | Revenue: 8.11M | Units: 37302 | Rating: 2.97
-- MIDDLE EAST     → Orders: 12505 | Revenue: 8.30M | Units: 37694 | Rating: 3.02
-- NORTH AMERICA   → Orders: 12517 | Revenue: 8.27M | Units: 37534 | Rating: 3.00

-- Insight:
-- All regions show nearly equal distribution → balanced customer base

-- ============================================================
-- STEP 2: Revenue-Based Segmentation
-- ============================================================

SELECT
customer_region,
SUM(total_revenue) AS total_spent,
CASE
WHEN SUM(total_revenue) > 50000 THEN 'HIGH VALUE'
WHEN SUM(total_revenue) BETWEEN 20000 AND 50000 THEN 'MEDIUM VALUE'
ELSE 'LOW VALUE'
END AS customer_segment
FROM ecommerce_data
GROUP BY customer_region
ORDER BY total_spent DESC;

-- OUTPUT:
-- All regions classified as HIGH VALUE

-- Insight:
-- Entire dataset consists of high-value segments → no weak region

-- ============================================================
-- STEP 3: Frequency Segmentation
-- ============================================================

SELECT
customer_region,
COUNT(DISTINCT order_id) AS total_orders,
CASE
WHEN COUNT(DISTINCT order_id) > 50 THEN 'FREQUENT'
WHEN COUNT(DISTINCT order_id) BETWEEN 20 AND 50 THEN 'OCCASIONAL'
ELSE 'RARE'
END AS frequency_segment
FROM ecommerce_data
GROUP BY customer_region;

-- OUTPUT:
-- All regions → FREQUENT

-- Insight:
-- Strong repeat purchase behavior across all regions

-- ============================================================
-- STEP 4: Profit-Based Segmentation
-- ============================================================

SELECT
customer_region,
SUM(profit) AS total_profit,
CASE
WHEN SUM(profit) > 20000 THEN 'HIGH PROFIT'
WHEN SUM(profit) BETWEEN 10000 AND 20000 THEN 'MEDIUM PROFIT'
ELSE 'LOW PROFIT'
END AS profit_segment
FROM ecommerce_data
GROUP BY customer_region;

-- OUTPUT:
-- All regions → HIGH PROFIT

-- Insight:
-- Business is consistently profitable across all regions

-- ============================================================
-- STEP 5: Combined Segmentation (Key Business View)
-- ============================================================

SELECT
customer_region,
COUNT(DISTINCT order_id) AS total_orders,
SUM(total_revenue) AS total_spent,
SUM(profit) AS total_profit,

```
CASE 
    WHEN SUM(total_revenue) > 50000 AND COUNT(DISTINCT order_id) > 50 
        THEN 'VIP CUSTOMERS'
    WHEN SUM(total_revenue) > 20000 
        THEN 'LOYAL CUSTOMERS'
    ELSE 'LOW VALUE CUSTOMERS'
END AS customer_segment
```

FROM ecommerce_data
GROUP BY customer_region
ORDER BY total_spent DESC;

-- OUTPUT:
-- All regions → VIP CUSTOMERS

-- Insight:
-- Entire business customer base behaves like VIP → high value + high frequency

-- ============================================================
-- STEP 6: RFM Analysis
-- ============================================================

-- Step 6.1: Base Metrics

SELECT
customer_region,
MAX(order_date) AS last_order_date,
COUNT(DISTINCT order_id) AS frequency,
SUM(total_revenue) AS monetary
FROM ecommerce_data
GROUP BY customer_region;

-- OUTPUT:
-- All regions last order: 2023-12-31

-- Step 6.2: Recency Calculation

SELECT
customer_region,
CURRENT_DATE - MAX(order_date) AS recency_days,
COUNT(DISTINCT order_id) AS frequency,
SUM(total_revenue) AS monetary
FROM ecommerce_data
GROUP BY customer_region;

-- OUTPUT:
-- All regions recency: 823 days

-- Step 6.3: RFM Segmentation

WITH rfm AS (
SELECT
customer_region,
CURRENT_DATE - MAX(order_date) AS recency,
COUNT(DISTINCT order_id) AS frequency,
SUM(total_revenue) AS monetary
FROM ecommerce_data
GROUP BY customer_region
)

SELECT *,
CASE
WHEN recency < 30 AND frequency > 50 AND monetary > 50000
THEN 'CHAMPIONS'
WHEN frequency > 30
THEN 'LOYAL CUSTOMERS'
WHEN recency > 90
THEN 'AT RISK'
ELSE 'REGULAR'
END AS rfm_segment
FROM rfm;

-- OUTPUT:
-- All regions → LOYAL CUSTOMERS

-- Insight:
-- High frequency + high revenue but high recency → not recent activity

-- ============================================================
-- FINAL BUSINESS INSIGHTS
-- ============================================================

-- 1. Revenue, orders, and profit are evenly distributed across regions
-- 2. All regions are high-value, high-frequency customers (VIP behavior)
-- 3. No weak or low-performing segment identified
-- 4. RFM shows all customers as "LOYAL" but with high recency
-- 5. Indicates potential inactivity risk despite strong past performance

-- ============================================================
-- END OF FILE
-- ============================================================
