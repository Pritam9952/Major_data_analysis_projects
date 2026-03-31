-- ============================================================
-- FILE: 05_advanced_analysis.sql
-- PURPOSE: Advanced Churn Drivers & Revenue Impact Analysis
-- ============================================================


-- ============================================================
-- 1. Contract + Payment Method (High-Risk Segments)
-- ============================================================
-- Identify risky combinations of contract and payment behavior

SELECT 
    Contract,
    PaymentMethod,

    COUNT(*) AS total_customers,

    COUNT(*) FILTER (WHERE Churn = 'Yes') AS churned_customers,

    ROUND(
        COUNT(*) FILTER (WHERE Churn = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM netflix_cleaned
GROUP BY Contract, PaymentMethod
ORDER BY churn_rate DESC;


-- ============================================================
-- 2. Monthly Charges Bucket vs Churn
-- ============================================================
-- Segment customers by pricing tiers

SELECT
    CASE
        WHEN MonthlyCharges < 30 THEN 'Low'
        WHEN MonthlyCharges < 70 THEN 'Medium'
        ELSE 'High'
    END AS revenue_bucket,

    COUNT(*) AS total_customers,

    COUNT(*) FILTER (WHERE Churn = 'Yes') AS churned_customers,

    ROUND(
        COUNT(*) FILTER (WHERE Churn = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM netflix_cleaned
GROUP BY revenue_bucket
ORDER BY churn_rate DESC;


-- ============================================================
-- 3. Internet Service + Tech Support
-- ============================================================
-- Analyze impact of support availability on churn

SELECT
    InternetService,
    TechSupport,

    COUNT(*) AS total_customers,

    COUNT(*) FILTER (WHERE Churn = 'Yes') AS churned_customers,

    ROUND(
        COUNT(*) FILTER (WHERE Churn = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM netflix_cleaned
GROUP BY InternetService, TechSupport
ORDER BY churn_rate DESC;


-- ============================================================
-- 4. Service Usage Behavior
-- ============================================================
-- Engagement-based churn analysis

SELECT
    OnlineSecurity,
    StreamingTV,
    StreamingMovies,

    COUNT(*) AS total_customers,

    COUNT(*) FILTER (WHERE Churn = 'Yes') AS churned_customers,

    ROUND(
        COUNT(*) FILTER (WHERE Churn = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM netflix_cleaned
GROUP BY OnlineSecurity, StreamingTV, StreamingMovies
ORDER BY churn_rate DESC;


-- ============================================================
-- 5. Revenue Loss Due to Churn 🔥 (IMPORTANT)
-- ============================================================
-- Estimate revenue lost from churned customers

SELECT
    ROUND(SUM(TotalCharges) FILTER (WHERE Churn = 'Yes'), 2) AS revenue_lost,

    ROUND(AVG(TotalCharges) FILTER (WHERE Churn = 'Yes'), 2) AS avg_revenue_per_churned_user,

    COUNT(*) FILTER (WHERE Churn = 'Yes') AS churned_customers

FROM netflix_cleaned;


-- ============================================================
-- 6. High-Risk Customers Identification 🔥
-- ============================================================
-- Identify segments most likely to churn

SELECT
    customerID,
    tenure,
    MonthlyCharges,
    Contract,
    PaymentMethod,
    InternetService

FROM netflix_cleaned
WHERE Churn = 'Yes'
    AND tenure <= 12
    AND MonthlyCharges > 70
    AND Contract = 'Month-to-month';