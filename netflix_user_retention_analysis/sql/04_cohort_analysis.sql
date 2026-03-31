-- ============================================================
-- FILE: 04_cohort_analysis.sql
-- PURPOSE: Cohort & Retention Analysis (Tenure-Based)
-- ============================================================


-- ============================================================
-- STEP 1: Create Cohort Table (Reusable)
-- ============================================================

DROP TABLE IF EXISTS cohort_data;

CREATE TEMP TABLE cohort_data AS
SELECT
    customerID,
    tenure,
    Churn,

    CASE
        WHEN tenure <= 12 THEN '0-1 Year'
        WHEN tenure <= 24 THEN '1-2 Years'
        WHEN tenure <= 48 THEN '2-4 Years'
        ELSE '4+ Years'
    END AS cohort_group

FROM netflix_cleaned;


-- ============================================================
-- 1. Cohort Retention Analysis
-- ============================================================

SELECT
    cohort_group,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE Churn = 'No') AS retained_customers,

    ROUND(
        COUNT(*) FILTER (WHERE Churn = 'No') * 100.0 / COUNT(*),
        2
    ) AS retention_rate

FROM cohort_data
GROUP BY cohort_group
ORDER BY cohort_group;


-- ============================================================
-- 2. Cohort Churn Rate
-- ============================================================

SELECT 
    cohort_group,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE Churn = 'Yes') AS churned_customers,

    ROUND(
        COUNT(*) FILTER (WHERE Churn = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM cohort_data
GROUP BY cohort_group
ORDER BY churn_rate DESC;


-- ============================================================
-- 3. Detailed Tenure vs Churn Trend
-- ============================================================

SELECT
    tenure,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE Churn = 'Yes') AS churned_customers,

    ROUND(
        COUNT(*) FILTER (WHERE Churn = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM netflix_cleaned
GROUP BY tenure
ORDER BY tenure;