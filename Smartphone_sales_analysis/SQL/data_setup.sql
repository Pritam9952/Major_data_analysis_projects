DROP TABLE IF EXISTS smartphone_sales_data


CREATE TABLE smartphone_sales_data (
    "Brands" VARCHAR(50),
    "Models" VARCHAR(100),
    "Colors" VARCHAR(50),
    "Memory" VARCHAR(50),
    "Storage" VARCHAR(50),
    "Camera" VARCHAR(50),
    "Rating" FLOAT,
    "Selling Price" NUMERIC(10,2),
    "Original Price" NUMERIC(10,2),
    "Mobile" VARCHAR(100),
    "Discount" NUMERIC(10,2),
    "discount percentage" FLOAT
);
SELECT * FROM smartphone_sales_data

COPY smartphone_sales_data(
"Brands", "Models", "Colors", "Memory", "Storage", "Camera",
"Rating", "Selling Price", "Original Price",
"Mobile", "Discount", "discount percentage"
)
FROM 'E:/MAJOR_DATA_ANALYSIS_PROJECT/Smartphone_sales_analysis/Sales.csv'
DELIMITER ','
CSV HEADER;