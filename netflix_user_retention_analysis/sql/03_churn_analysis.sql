-- ============================================================
-- FILE: 03_churn_analysis.sql
-- PURPOSE: Customer Churn Deep Dive Analysis (DA + BI + BA)
-- ============================================================


-- ============================================================
-- 1. Churn by Gender
-- ============================================================
SELECT 
    gender,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE Churn = 'Yes') AS churned_customers,
    ROUND(
        COUNT(*) FILTER (WHERE Churn = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM netflix_cleaned
GROUP BY gender
ORDER BY churn_rate DESC;


-- ============================================================
-- 2. Churn by Senior Citizen
-- ============================================================
SELECT
    SeniorCitizen,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE Churn = 'Yes') AS churned_customers,
    ROUND(
        COUNT(*) FILTER (WHERE Churn = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM netflix_cleaned
GROUP BY SeniorCitizen
ORDER BY churn_rate DESC;


-- Contribution to total churn
SELECT
    SeniorCitizen,
    COUNT(*) FILTER (WHERE Churn = 'Yes') AS churned_customers,
    ROUND(
        COUNT(*) FILTER (WHERE Churn = 'Yes') * 100.0 /
        SUM(COUNT(*) FILTER (WHERE Churn = 'Yes')) OVER(),
        2
    ) AS contribution_to_total_churn
FROM netflix_cleaned
GROUP BY SeniorCitizen;


-- ============================================================
-- 3. Churn by Partner
-- ============================================================
SELECT 
    Partner,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE Churn = 'Yes') AS churned_customers,
    ROUND(
        COUNT(*) FILTER (WHERE Churn = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM netflix_cleaned
GROUP BY Partner
ORDER BY churn_rate DESC;


-- ============================================================
-- 4. Churn by Dependents
-- ============================================================
SELECT 
    Dependents,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE Churn = 'Yes') AS churned_customers,
    ROUND(
        COUNT(*) FILTER (WHERE Churn = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM netflix_cleaned
GROUP BY Dependents
ORDER BY churn_rate DESC;


-- ============================================================
-- 5. Churn by Tenure Group
-- ============================================================
-- Segmentation based on customer lifetime

SELECT
    CASE 
        WHEN tenure <= 12 THEN '0-1 Year'
        WHEN tenure <= 24 THEN '1-2 Years'
        WHEN tenure <= 48 THEN '2-4 Years'
        ELSE '4+ Years'
    END AS tenure_group,

    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE Churn = 'Yes') AS churned_customers,

    ROUND(
        COUNT(*) FILTER (WHERE Churn = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM netflix_cleaned
GROUP BY tenure_group
ORDER BY churn_rate DESC;


-- ============================================================
-- 6. Churn by Contract Type
-- ============================================================
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
-- 7. Churn by Internet Service
-- ============================================================
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


-- ============================================================
-- 8. Churn by Payment Method
-- ============================================================
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
-- 9. Churn by Streaming Behavior
-- ============================================================
-- Combined impact of content engagement on churn

SELECT 
    StreamingTV,
    StreamingMovies,
    COUNT(*) AS total_customers,

    COUNT(*) FILTER (WHERE Churn = 'Yes') AS churned_customers,

    ROUND(
        COUNT(*) FILTER (WHERE Churn = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM netflix_cleaned
GROUP BY StreamingTV, StreamingMovies
ORDER BY churn_rate DESC;