-- ============================================================
-- FILE: 02_kpi_calculation.sql
-- PURPOSE: KPI Metrics for Netflix Churn Analysis (DA + BI + BA)
-- ============================================================


-- ============================================================
-- 1. Total Customers
-- ============================================================
-- Total number of users in dataset

SELECT COUNT(*) AS total_customers
FROM netflix_cleaned;


-- ============================================================
-- 2. Churned Customers
-- ============================================================
-- Customers who have left the service

SELECT COUNT(*) AS churned_customers
FROM netflix_cleaned
WHERE Churn = 'Yes';


-- ============================================================
-- 3. Churn Rate (%)
-- ============================================================
-- Percentage of customers who churned

SELECT
    ROUND(
        COUNT(*) FILTER (WHERE Churn = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM netflix_cleaned;


-- ============================================================
-- 4. Retention Rate (%)
-- ============================================================
-- Percentage of customers retained

SELECT
    ROUND(
        COUNT(*) FILTER (WHERE Churn = 'No') * 100.0 / COUNT(*),
        2
    ) AS retention_rate_percentage
FROM netflix_cleaned;


-- ============================================================
-- 5. Total Revenue
-- ============================================================
-- Total revenue generated from all customers

SELECT 
    ROUND(SUM(TotalCharges), 2) AS total_revenue
FROM netflix_cleaned;


-- ============================================================
-- 6. Average Revenue Per User (ARPU)
-- ============================================================
-- Average revenue generated per customer

SELECT 
    ROUND(SUM(TotalCharges) / COUNT(*), 2) AS arpu
FROM netflix_cleaned;


-- ============================================================
-- 7. Average Customer Tenure
-- ============================================================
-- Average number of months customers stay

SELECT
    ROUND(AVG(tenure), 2) AS avg_tenure_months
FROM netflix_cleaned;


-- ============================================================
-- 8. Monthly Recurring Revenue (MRR Approx)
-- ============================================================
-- Approximate monthly revenue from all active users

SELECT
    ROUND(SUM(MonthlyCharges), 2) AS monthly_recurring_revenue
FROM netflix_cleaned;


-- ============================================================
-- 9. Churn by Contract Type
-- ============================================================
-- Identify which contract type has highest churn risk

SELECT
    Contract,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE Churn = 'Yes') AS churned_customers,
    ROUND(
        COUNT(*) FILTER (WHERE Churn = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM netflix_cleaned
GROUP BY Contract
ORDER BY churn_rate DESC;


-- ============================================================
-- 10. Churn by Payment Method
-- ============================================================
-- Analyze churn behavior across payment types

SELECT
    PaymentMethod,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE Churn = 'Yes') AS churned_customers,
    ROUND(
        COUNT(*) FILTER (WHERE Churn = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM netflix_cleaned
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;


-- ============================================================
-- 11. Churn by Internet Service
-- ============================================================
-- Identify churn patterns based on service type

SELECT 
    InternetService,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE Churn = 'Yes') AS churned_customers,
    ROUND(
        COUNT(*) FILTER (WHERE Churn = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM netflix_cleaned
GROUP BY InternetService
ORDER BY churn_rate DESC;

