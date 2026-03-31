SELECT * FROM smartphone_sales_data
-- Data Cleaning Process

UPDATE smartphone_sales_data
SET 
	"Memory" = TRIM(REPLACE(LOWER("Memory"),'gb','GB')),
	"Storage" = TRIM(REPLACE(LOWER("Storage"),'gb','GB'))


ALTER TABLE smartphone_sales_data ADD COLUMN memory_value FLOAT;

UPDATE smartphone_sales_data
SET memory_value =
	CASE
		WHEN "Memory" ~ '[0-9]+' THEN CAST(REGEXP_REPLACE("Memory", '[^0-9\.]','','g') AS FLOAT)
		ELSE NULL
	END;


ALTER TABLE smartphone_sales_data ADD COLUMN storage_value FLOAT;
UPDATE smartphone_sales_data
SET storage_value =
	CASE
		WHEN "Storage" ~ '[0-9]+' THEN CAST(REGEXP_REPLACE("Storage", '[^0-9\.]','','g') AS FLOAT)
		ELSE NULL
	END;
	
SELECT  * FROM smartphone_sales_data


-- REMOVE INCOMPLETE ROWS
DELETE FROM smartphone_sales_data
WHERE "Brands" IS NULL OR "Selling Price" IS NULL;

-- Standradizee brand and color names
UPDATE smartphone_sales_data
SET  "Brands" = INITCAP("Brands"),
	 "Colors" = INITCAP("Colors")


-- Fix negative or null discounts
UPDATE smartphone_sales_data
SET "Discount" = ABS("Discount"),
	"discount percentage" = ABS("discount percentage")

---- Query Process

-- 🟢 1️⃣ Total Smartphones Sold 
SELECT COUNT(*) AS total_smartphones
FROM smartphone_sales_data  -- output (3114)

🔹 Top 5 Brands by Total Sales

SELECT "Brands"  , SUM("Selling Price") AS total_sales
FROM  smartphone_sales_data
GROUP BY "Brands"
ORDER BY total_sales DESC
LIMIT 5;

-- 🟢 2️⃣ Total Revenue (Based on Selling Price)
SELECT ROUND(SUM("Selling Price"),2) AS total_revenue
FROM smartphone_sales_data   -- output (82323652.00)

-- 🟢 3️⃣ Average Discount Percentage
SELECT ROUND(AVG("discount percentage")::numeric, 2) AS avg_discount_percent
FROM smartphone_sales_data;  -- output(6.9)


-- 🔹 Discount Impact on Rating
SELECT
	ROUND("discount percentage") AS discount_range,
	ROUND(AVG("Rating")::numeric, 2) AS avg_rating
FROM smartphone_sales_data
GROUP BY discount_range
ORDER BY discount_range

-- 🟢 4️⃣ Average Rating Across All Models
SELECT ROUND(AVG("Rating")::numeric,2) AS avg_rating
FROM smartphone_sales_data

-- 🔹 Average Rating by Brand
SELECT "Brands" , ROUND(AVG("Rating")::numeric, 2) AS avg_ratings
FROM smartphone_sales_data
GROUP BY "Brands"
ORDER BY avg_ratings DESC;

-- 🔹 Average Selling Price by Storage

SELECT "Storage" , ROUND(AVG("Selling Price"),2) AS avg_price
FROM smartphone_sales_data
GROUP BY "Storage"
ORDER BY "Storage"

-- 🔹 Average Selling Price by Memory


SELECT "Memory" , ROUND(AVG("Selling Price"),2) AS avg_price
FROM smartphone_sales_data
GROUP BY "Memory"
ORDER BY "Memory"

-- 🔹 Brand-Wise Original vs Selling Price

SELECT 
	"Brands",
	ROUND(AVG("Original Price"), 2) AS  avg_original_price,
	ROUND(AVG("Selling Price"), 2) AS  avg_selling_price
FROM smartphone_sales_data
GROUP BY "Brands"
ORDER BY  avg_selling_price DESC

-- 🟢 5️⃣ Total Brands Available
SELECT COUNT(DISTINCT "Brands") AS total_brands
FROM smartphone_sales_data;




-- 🟡 6️⃣ Brand-Wise Total Revenue
SELECT
    "Brands",
	ROUND(SUM("Selling Price"),2) AS total_revenue
FROM smartphone_sales_data
GROUP BY "Brands"
	ORDER BY total_revenue DESC



-- 🟡 7️⃣ Top 5 Best-Selling Models
SELECT "Models" , "Brands", SUM("Selling Price") As total_sales
FROM smartphone_sales_data
GROUP BY "Models","Brands"
ORDER BY total_sales DESC
LIMIT 5



-- 🟡 8️⃣Top 5 Brands by Average Rating
SELECT "Brands", ROUND(AVG("Rating")::numeric,2) as avg_rating
FROM smartphone_sales_data
GROUP BY "Brands"
ORDER BY avg_rating DESC
LIMIT 5

-- 🟠 9️⃣ High-End Phones (Selling Price > ₹60,000)

SELECT "Brands", "Models", "Selling Price"
FROM smartphone_sales_data
WHERE "Selling Price" > 60000
ORDER BY "Selling Price" DESC


-- 🟠 🔟 Average Selling vs Original Price by Brand
SELECT DISTINCT ON ("Brands")
		"Brands",
		"Models",
		"Discount",
		ROUND("discount percentage" ::numeric,2) as percent_discount
FROM smartphone_sales_data
ORDER BY "Brands", percent_discount DESC;


-- 🟠 11️⃣ Rating Performance vs Price Range

SELECT
	CASE
		WHEN "Selling Price" < 10000 THEN 'Budget (<10K)'
        WHEN "Selling Price" BETWEEN 10000 AND 25000 THEN 'Mid-Range (10K–25K)'
        WHEN "Selling Price" BETWEEN 25000 AND 60000 THEN 'Premium (25K–60K)'
        ELSE 'Flagship (>60K)'
	END AS price_category,
	ROUND(AVG("Rating")::numeric, 2) AS avg_rating,
	COUNT(*) AS model_count
FROM smartphone_sales_data
GROUP BY price_category
ORDER BY  avg_rating DESC;


-- 🟠 12️⃣ Identify Brand Loyalty — Avg Rating vs Discount %

SELECT "Brands",
		ROUND(AVG("Rating")::numeric,2) AS avg_rating,
		ROUND(AVG("discount percentage")::numeric,2) AS  avg_discount,
	    COUNT(*) AS model_count
FROM smartphone_sales_data
GROUP BY "Brands"
ORDER BY avg_rating DESC;