-- DIMENSION TABLES

-- Location
DROP TABLE dim_location;

CREATE TABLE dim_location AS
SELECT DISTINCT
    CONCAT(
        UPPER(TRIM(ship_city)),
        '_',
        UPPER(TRIM(ship_state))
    ) AS location_key,
    UPPER(TRIM(ship_city)) AS ship_city,
    UPPER(TRIM(ship_state)) AS ship_state,
    UPPER(TRIM(ship_country)) AS ship_country
FROM amazon_sales_clean;



-- Product
DROP TABLE dim_product;

CREATE TABLE dim_product AS
SELECT DISTINCT
    UPPER(TRIM(sku)) AS sku,
    UPPER(TRIM(style)) AS style,
    UPPER(TRIM(category)) AS category,
    UPPER(TRIM(size)) AS size
FROM amazon_sales_clean;


UPDATE fact_sales
SET sku = UPPER(TRIM(sku));

SELECT sku, COUNT(*)
FROM dim_product
GROUP BY sku
HAVING COUNT(*) > 1;


-- Fulfilment 
DROP TABLE dim_fulfilment;

CREATE TABLE dim_fulfilment AS
SELECT DISTINCT
    UPPER(TRIM(fulfilled_by)) AS fulfilled_by,
    UPPER(TRIM(fulfilment)) AS fulfilment,
    UPPER(TRIM(courier_status)) AS courier_status
FROM amazon_sales_clean;


UPDATE fact_sales
SET fulfilled_by = UPPER(TRIM(fulfilled_by)),
    fulfilment = UPPER(TRIM(fulfilment));
	

-- FACT TABLE
DROP TABLE fact_sales

CREATE TABLE fact_sales AS
SELECT
    order_id,
    order_date,
    sku,
    ship_city,
	ship_state,
    fulfilment,
	fulfilled_by,
    qty,
	courier_status,
    amount,
    profit,
    month,
    year
FROM amazon_sales_clean;

SELECT * FROM fact_sales


ALTER TABLE fact_sales
ADD COLUMN location_key TEXT;

UPDATE fact_sales
SET location_key =
CONCAT(
    UPPER(TRIM(ship_city)),
    '_',
    UPPER(TRIM(ship_state))
);


-- SOME changes for better powerbi visual 

DROP TABLE IF EXISTS dim_fulfilment_clean;

CREATE TABLE dim_fulfilment_clean AS
SELECT DISTINCT
    UPPER(TRIM(COALESCE(fulfilled_by,'UNKNOWN'))) || '_' ||
    UPPER(TRIM(COALESCE(fulfilment,'UNKNOWN'))) || '_' ||
    UPPER(TRIM(COALESCE(courier_status,'UNKNOWN')))
    AS fulfilment_combo,
    
    UPPER(TRIM(COALESCE(fulfilled_by,'UNKNOWN'))) AS fulfilled_by,
    UPPER(TRIM(COALESCE(fulfilment,'UNKNOWN'))) AS fulfilment,
    UPPER(TRIM(COALESCE(courier_status,'UNKNOWN'))) AS courier_status

FROM fact_sales;


ALTER TABLE dim_fulfilment_clean
ADD PRIMARY KEY (fulfilment_combo);

SELECT COUNT(*) FROM dim_fulfilment_clean;
SELECT COUNT(DISTINCT fulfilment_combo) FROM dim_fulfilment_clean;



ALTER TABLE fact_sales
ADD COLUMN fulfilment_key INT;


UPDATE fact_sales
SET fulfilment = UPPER(TRIM(fulfilment));

UPDATE dim_fulfilment_clean
SET fulfilment = UPPER(TRIM(fulfilment));


UPDATE fact_sales f
SET fulfilment_key = d.fulfilment_key
FROM dim_fulfilment_clean d
WHERE f.fulfilment = d.fulfilment;


SELECT fulfilment, fulfilment_key
FROM fact_sales
LIMIT 20;

SELECT COUNT(*)
FROM fact_sales
WHERE fulfilment_key IS NULL;

SELECT DISTINCT fulfilment FROM fact_sales;
SELECT DISTINCT fulfilment FROM dim_fulfilment_clean;



-- more fixing 

	
ALTER TABLE fact_sales
ADD COLUMN fulfilment_combo TEXT;


UPDATE fact_sales
SET fulfilment_combo =
    UPPER(TRIM(fulfilled_by)) || '_' ||
    UPPER(TRIM(fulfilment)) || '_' ||
    UPPER(TRIM(courier_status));

UPDATE fact_sales
SET fulfilled_by = COALESCE(fulfilled_by,'UNKNOWN'),
    fulfilment = COALESCE(fulfilment,'UNKNOWN'),
    courier_status = COALESCE(courier_status,'UNKNOWN');


SELECT fulfilment_combo
FROM fact_sales
LIMIT 20;