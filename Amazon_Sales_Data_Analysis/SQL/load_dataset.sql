DROP TABLE IF EXISTS amazon_sales;

CREATE TABLE amazon_sales (
    order_id TEXT,
    date DATE,
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
    qty INTEGER,
    currency TEXT,
    amount NUMERIC(12,2),
    ship_city TEXT,
    ship_state TEXT,
    ship_postal_code TEXT,
    ship_country TEXT,
    promotion_ids TEXT,
    b2b BOOLEAN,
    fulfilled_by TEXT,
    total_revenue NUMERIC(12,2)
);

SELECT * FROM amazon_sales;

copy amazon_sales
FROM 'E:\MAJOR_DATA_ANALYSIS_PROJECT\Amazon Sales Data Analysis\python_code\Amazon_Sales_Clean.csv'
WITH (FORMAT csv, HEADER true);

SELECT * FROM amazon_sales;