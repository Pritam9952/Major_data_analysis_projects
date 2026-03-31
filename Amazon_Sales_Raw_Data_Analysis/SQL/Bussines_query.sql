DROP TABLE IF EXISTS amazon_sales_raw

CREATE TABLE amazon_sales_raw(
index_no TEXT,
order_id TEXT,
order_date TEXT,
status TEXT,
fulfilment TEXT,
sales_channel TEXT,
ship_service_level TEXT,
style TEXT,
sku TEXT,
category TEXT,
size TEXT,
asin TEXT,
courier_status TEXT,
qty TEXT,
currency TEXT,
amount TEXT,
ship_city TEXT,
ship_state TEXT,
ship_postal_code TEXT,
ship_country TEXT,
promotion_ids TEXT,
b2b TEXT,
fulfilled_by TEXT,
extra_col TEXT
);

COPY amazon_sales_raw 
FROM 'E:\DATA_ANALYSIS_PROJECTS\Amazon_Sales\dataset\Amazon Sale Report.csv'
DELIMITER ','
CSV HEADER
QUOTE '"'
ESCAPE '"';

SELECT * FROM amazon_sales_raw LIMIT 10;

-- Clean table
CREATE TABLE amazon_sales_clean AS
SELECT
	order_id,
	-- Cleaning process
	TO_DATE(order_date , 'MM-DD-YYYY') AS order_date,
	 status,
    fulfilment,
    sales_channel,
    ship_service_level,
    style,
    sku,
    category,
    size,
    asin,
    courier_status,

	-- numberic
	CAST(qty AS INT) AS qty,
	currency,
	CAST(amount AS NUMERIC) AS amount,

	ship_city,
    ship_state,
    ship_postal_code,
    ship_country,
    promotion_ids,
    b2b,
    fulfilled_by

FROM amazon_sales_raw
WHERE order_id IS NOT NULL;

SELECT * FROM amazon_sales_clean LIMIT 5;
SELECT COUNT(*) FROM amazon_sales_clean;


-- NULL CHECK
SELECT
COUNT(*) FILTER (WHERE amount IS NULL) AS missing_amount,
COUNT(*) FILTER (WHERE qty IS NULL) AS missing_qty,
COUNT(*) FILTER (WHERE courier_status IS NULL) AS missing_courier
FROM amazon_sales_clean;

DELETE FROM amazon_sales_clean 
WHERE amount IS NULL;

UPDATE amazon_sales_clean
SET qty = 0
WHERE qty IS NULL;

UPDATE amazon_sales_clean 
SET courier_status = 'Unknown'
WHERE courier_status IS NULL;


SELECT
COUNT(*) FILTER (WHERE amount IS NULL) AS missing_amount,
COUNT(*) FILTER (WHERE qty IS NULL) AS missing_qty,
COUNT(*) FILTER (WHERE courier_status IS NULL) AS missing_courier
FROM amazon_sales_clean;


-- Adding Profit Column
ALTER TABLE amazon_sales_clean
ADD COLUMN profit NUMERIC;

UPDATE amazon_sales_clean
SET profit = amount * 0.15; -- Assuming 15% margin

-- MONTH YEAR 
ALTER TABLE amazon_sales_clean
ADD COLUMN month TEXT,
ADD COLUMN YEAR INT;

UPDATE amazon_sales_clean
SET
month = TO_CHAR(order_date, 'Mon'),
year = EXTRACT(YEAR FROM order_date);

SELECT order_date, month, year, amount, profit
FROM amazon_sales_clean
LIMIT 10;

