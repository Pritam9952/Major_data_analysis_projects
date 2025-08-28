CREATE TABLE blinkit_data (
    item_fat_content VARCHAR(20),
    item_identifier VARCHAR(50),
    item_type VARCHAR(50),
    outlet_establishment_year INT,
    outlet_identifier VARCHAR(50),
    outlet_location_type VARCHAR(50),
    outlet_size VARCHAR(20),
    outlet_type VARCHAR(50),
    item_visibility DECIMAL(10,4),
    item_weight DECIMAL(10,2),
    sales DECIMAL(12,2),
    rating DECIMAL(3,1)
);


COPY blinkit_data(Item_Fat_Content, Item_Identifier, 
Item_Type, Outlet_Establishment_Year, 
Outlet_Identifier, Outlet_Location_Type, Outlet_Size,
Outlet_Type	, Item_Visibility, Item_Weight , Sales, 	Rating
)
FROM 'E:\MAJOR_DATA_ANALYSIS_PROJECT\Blinkit\BlinkIT Grocery Data.csv'
CSV HEADER;


SELECT * FROM blinkit_data;

UPDATE blinkit_data 
SET item_fat_content = CASE
WHEN item_fat_content IN('LF' ,'low fat') THEN 'Low Fat'
WHEN item_fat_content = 'reg' THEN 'Regular'
ELSE item_fat_content END;

SELECT DISTINCT(item_fat_content) FROM blinkit_data;

-- TOTAL SALES
SELECT SUM(sales) AS total_sales from blinkit_data;

-- TOTAL SALES IN MILLIONS
SELECT CAST(SUM(sales)/1000000 AS DECIMAL(10,2)) AS total_sales_in_millions
FROM blinkit_data;


-- AVG SALES
SELECT ROUND(AVG(sales),2) AS avg_sales FROM blinkit_data;

SELECT CAST(AVG(sales) AS DECIMAL(10,2)) AS avg_sales FROM blinkit_data;

-- AVG SALES PER YEAR 
SELECT outlet_establishment_year,
CAST(AVG(sales) AS DECIMAL(10,2)) AS avg_sales FROM blinkit_data
GROUP BY outlet_establishment_year
ORDER BY outlet_establishment_year DESC;


-- NUMBER OF ITEM'S
SELECT DISTINCT item_type FROM blinkit_data ;

SELECT item_type ,COUNT(item_type) FROM blinkit_data
GROUP BY item_type;

SELECT COUNT(*) AS total_items FROM blinkit_data;

-- TOTAL SALES BASED ON 'item_fat_content'

SELECT item_fat_content, CAST(SUM(sales) AS DECIMAL(10,2))AS total_sales
FROM blinkit_data
GROUP BY item_fat_content;

-- TOTAL SALES PER YEAR
SELECT outlet_establishment_year , SUM(sales)
FROM blinkit_data
GROUP BY outlet_establishment_year 
ORDER BY outlet_establishment_year DESC;

SELECT item_fat_content ,outlet_establishment_year , SUM(sales)
FROM blinkit_data
GROUP BY outlet_establishment_year,item_fat_content 
ORDER BY outlet_establishment_year DESC;

-- AVG RATING 
SELECT CAST(AVG(rating) AS DECIMAL(10,1)) AS avg_rating FROM blinkit_data

SELECT item_type , CAST(AVG(rating) AS DECIMAL(10,1)) AS avg_rating
FROM blinkit_data
GROUP BY item_type ORDER BY avg_rating DESC;


-- TOTAL AVG SALES AND AVG RATING
SELECT item_fat_content ,
CAST(SUM(sales) AS DECIMAL(10,2)) AS total_sales ,
CAST(AVG(sales) AS DECIMAL(10,2)) AS avg_sales,
CAST(AVG(rating) AS DECIMAL(10,1)) AS avg_rating,
COUNT(*) AS total_items
FROM blinkit_data GROUP BY item_fat_content;

SELECT item_fat_content ,outlet_establishment_year,
CAST(SUM(sales) AS DECIMAL(10,2)) AS total_sales ,
CAST(AVG(sales) AS DECIMAL(10,2)) AS avg_sales,
CAST(AVG(rating) AS DECIMAL(10,1)) AS avg_rating,
COUNT(*) AS total_items
FROM blinkit_data 
GROUP BY item_fat_content,outlet_establishment_year;

--TOTAL SALES BY ITEM TYPE

SELECT item_type , CAST(SUM(sales) AS DECIMAL(10,2)) AS total_sales
FROM blinkit_data GROUP BY item_type

SELECT item_type ,
CAST(SUM(sales) AS DECIMAL(10,2)) AS total_sales ,
CAST(AVG(sales) AS DECIMAL(10,2)) AS avg_sales,
CAST(AVG(rating) AS DECIMAL(10,1)) AS avg_rating,
COUNT(*) AS total_items
FROM blinkit_data 
GROUP BY item_type 
ORDER BY total_sales DESC LIMIT 5;


-- FAT CONTENT BY OUTLET FOR TOTAL SALES

SELECT outlet_location_type ,item_fat_content ,
CAST(SUM(sales) AS DECIMAL(10,2)) AS total_sales ,
CAST(AVG(sales) AS DECIMAL(10,2)) AS avg_sales,
COUNT(*) AS No_of_items,
CAST(AVG(rating) AS DECIMAL(10,1)) AS avg_rating
FROM blinkit_data 
GROUP BY outlet_location_type , item_fat_content
ORDER BY total_sales;

SELECT 
    outlet_location_type,
    COALESCE(SUM(CASE WHEN item_fat_content = 'Low Fat' THEN sales END), 0)
	AS low_fat,
    COALESCE(SUM(CASE WHEN item_fat_content = 'Regular' THEN sales END), 0)
	AS regular
FROM 
    blinkit_data
GROUP BY 
    outlet_location_type
ORDER BY 
    outlet_location_type;
	
-- TOTAL SALES BY OUTLRT ESTABLISHMENT

SELECT outlet_establishment_year,
	CAST(SUM(sales) AS DECIMAL(10,2)) AS total_sales,
	CAST(AVG(sales) AS DECIMAL(10,2)) AS total_avg_sales,
	COUNT(*) AS No_of_items,
	CAST(AVG(rating) AS DECIMAL(10,1)) AS avg_rating
FROM blinkit_data
GROUP BY outlet_establishment_year
ORDER BY total_sales DESC

-- PERCENTAGE OF SALES BY OUTLET SIZE
SELECT * FROM blinkit_data

SELECT outlet_size ,
CAST(SUM(sales) AS DECIMAL(10,2)) AS total_sales,
CAST((SUM(sales) * 100.0 / SUM(SUM(sales)) OVER()) AS DECIMAL(10,2))
AS sales_percentage
FROM blinkit_data
GROUP BY outlet_size
ORDER BY total_sales DESC

-- SALES BY OUTLET LOCATION

SELECT outlet_location_type,
	CAST(SUM(sales) AS DECIMAL(10,2)) AS total_sales,
	CAST(AVG(sales) AS DECIMAL(10,2)) AS total_avg_sales,
	COALESCE(SUM(CASE WHEN outlet_size = 'Small' THEN sales END), 0) AS Small,
	COALESCE(SUM(CASE WHEN outlet_size = 'Medium' THEN sales END), 0) AS Medium,
	COALESCE(SUM(CASE WHEN outlet_size = 'High' THEN sales END), 0) AS High
FROM blinkit_data
GROUP BY outlet_location_type
ORDER BY outlet_location_type 


SELECT outlet_location_type,
	CAST(SUM(sales) AS DECIMAL(10,2)) AS total_sales,
	CAST(AVG(sales) AS DECIMAL(10,2)) AS total_avg_sales,
	COUNT(*) AS No_of_items,
	CAST(AVG(rating) AS DECIMAL(10,1)) AS avg_rating,
	CAST((SUM(sales) * 100.0 / SUM(SUM(sales)) OVER())
	AS DECIMAL(10,2)) AS sales_percentage
FROM blinkit_data
GROUP BY outlet_location_type
ORDER BY outlet_location_type DESC

-- ALL METRICS BY OUTLET TYPE

SELECT outlet_type,
	CAST(SUM(sales) AS DECIMAL(10,2)) AS total_sales,
	CAST(AVG(sales) AS DECIMAL(10,2)) AS total_avg_sales,
	COUNT(*) AS No_of_items,
	CAST(AVG(rating) AS DECIMAL(10,1)) AS avg_rating,
	CAST((SUM(sales) * 100.0 / SUM(SUM(sales)) OVER())
	AS DECIMAL(10,2)) AS sales_percentage
FROM blinkit_data
GROUP BY outlet_type
ORDER BY total_sales DESC



