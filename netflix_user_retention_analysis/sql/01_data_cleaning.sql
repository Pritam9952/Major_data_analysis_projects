-- ============================================================
-- PROJECT: Netflix Customer Churn Analysis
-- FILE: 01_data_cleaning.sql
-- PURPOSE: Data Cleaning & Preparation for Analysis (DA + BI + BA)
-- ============================================================


-- ============================================================
-- STEP 1: Create Raw Table (Schema Definition)
-- ============================================================
-- This table stores raw ingested data without transformations

CREATE TABLE netflix_raw (
    customerID TEXT,
    gender TEXT,
    SeniorCitizen INT,
    Partner TEXT,
    Dependents TEXT,
    tenure INT,
    PhoneService TEXT,
    MultipleLines TEXT,
    InternetService TEXT,
    OnlineSecurity TEXT,
    OnlineBackup TEXT,
    DeviceProtection TEXT,
    TechSupport TEXT,
    StreamingTV TEXT,
    StreamingMovies TEXT,
    Contract TEXT,
    PaperlessBilling TEXT,
    PaymentMethod TEXT,
    MonthlyCharges NUMERIC,
    TotalCharges TEXT,   -- kept TEXT due to dirty values in raw data
    Churn TEXT
);

-- Quick sanity check
SELECT * FROM netflix_raw LIMIT 10;


-- ============================================================
-- STEP 2: Drop Existing Clean Table (Idempotency)
-- ============================================================
DROP TABLE IF EXISTS netflix_cleaned;


-- ============================================================
-- STEP 3: Data Cleaning & Transformation
-- ============================================================
-- Key Transformations:
-- 1. Handle invalid/missing TotalCharges
-- 2. Convert TotalCharges → NUMERIC
-- 3. Keep dataset analysis-ready

CREATE TABLE netflix_cleaned AS
SELECT
    customerID,
    gender,
    SeniorCitizen,
    Partner,
    Dependents,
    tenure,
    PhoneService,
    MultipleLines,
    InternetService,
    OnlineSecurity,
    OnlineBackup,
    DeviceProtection,
    TechSupport,
    StreamingTV,
    StreamingMovies,
    Contract,
    PaperlessBilling,
    PaymentMethod,
    MonthlyCharges,

    -- Data Cleaning Logic:
    -- Some records contain blank or invalid values (e.g., ' ', '')
    -- We validate using regex and safely convert to NUMERIC
    CASE 
        WHEN TRIM(TotalCharges) ~ '^[0-9.]+$' 
        THEN CAST(TRIM(TotalCharges) AS NUMERIC)
        ELSE NULL
    END AS TotalCharges,

    Churn

FROM netflix_raw;


-- Preview cleaned data
SELECT * FROM netflix_cleaned LIMIT 5;


-- ============================================================
-- STEP 4: Handle Missing Values (Data Imputation)
-- ============================================================
-- Business Logic:
-- TotalCharges ≈ MonthlyCharges × tenure
-- Assumption: Customer billed consistently across tenure

UPDATE netflix_cleaned
SET TotalCharges = MonthlyCharges * tenure
WHERE TotalCharges IS NULL;


-- ============================================================
-- STEP 5: Data Quality Checks
-- ============================================================

-- Check for remaining NULL values
SELECT COUNT(*) AS null_totalcharges
FROM netflix_cleaned
WHERE TotalCharges IS NULL;

-- Check for duplicate customer IDs
SELECT customerID, COUNT(*) AS duplicate_count
FROM netflix_cleaned
GROUP BY customerID
HAVING COUNT(*) > 1;


-- ============================================================
-- STEP 6: Final Validation
-- ============================================================
-- Ensure dataset is ready for analysis / dashboarding

SELECT 
    COUNT(*) AS total_records,
    COUNT(DISTINCT customerID) AS unique_customers
FROM netflix_cleaned;

