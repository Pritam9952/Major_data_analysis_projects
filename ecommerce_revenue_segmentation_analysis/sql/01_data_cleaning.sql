-- ============================================================
-- PROJECT: Ecommerce Revenue Analysis
-- FILE: 01_data_cleaning.sql
-- PURPOSE: Basic Data Cleaning & Validation (DA + BI)
-- ============================================================

-- ============================================================
-- STEP 1: Create Table (Schema Definition)
-- ============================================================
-- This table stores ecommerce transaction data

CREATE TABLE ecommerce_data (
order_id VARCHAR(50),
order_date DATE,
product_id VARCHAR(50),
product_category VARCHAR(50),
price DECIMAL(10,2),
discount_percent DECIMAL(5,2),
quantity_sold INT,
customer_region VARCHAR(50),
payment_method VARCHAR(50),
rating DECIMAL(2,1),
review_count INT,
discounted_price DECIMAL(10,2),
total_revenue DECIMAL(10,2),
profit DECIMAL(10,2)
);

-- Quick preview of data
SELECT *
FROM ecommerce_data
LIMIT 10;

-- ============================================================
-- STEP 2: Data Quality Check (NULL Values)
-- ============================================================
-- Checking missing values in key columns

SELECT
COUNT(*) AS total_rows,
SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS order_id_nulls,
SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS order_date_nulls,
SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS product_id_nulls,
SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS price_nulls
FROM ecommerce_data;

-- ============================================================
-- STEP 3: Duplicate Check
-- ============================================================
-- Identifying duplicate order records

SELECT
order_id,
COUNT(*) AS duplicate_count
FROM ecommerce_data
GROUP BY order_id
HAVING COUNT(*) > 1;

-- ============================================================
-- STEP 4: Calculate Discounted Price
-- ============================================================
-- Business Logic:
-- discounted_price = price * (1 - discount_percent / 100)

UPDATE ecommerce_data
SET discounted_price = price * (1 - discount_percent / 100);

-- ============================================================
-- STEP 5: Standardize Categorical Columns
-- ============================================================
-- Converting text fields to uppercase for consistency

UPDATE ecommerce_data
SET
customer_region = UPPER(TRIM(customer_region)),
payment_method = UPPER(TRIM(payment_method)),
product_category = UPPER(TRIM(product_category));

-- ============================================================
-- STEP 6: Final Validation
-- ============================================================
-- Preview cleaned data

SELECT *
FROM ecommerce_data
LIMIT 10;

-- ============================================================
-- END OF FILE
-- ============================================================
