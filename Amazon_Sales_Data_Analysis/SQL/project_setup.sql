
DROP TABLE IF EXISTS amazon_s
-- agar table pehle se nahi hai to create:
CREATE TABLE public.amazon_sales (
  order_id text,
  date date,
  status text,
  fulfilment text,
  sales_channel text,
  ship_service_level text,
  style text,
  sku text,
  category text,
  size text,
  asin text,
  courier_status text,
  qty integer,
  currency text,
  amount numeric(14,2),
  ship_city text,
  ship_state text,
  ship_postal_code text,
  ship_country text,
  promotion_ids text,
  b2b boolean,
  fulfilled_by text,
  total_revenue numeric(18,2)
);

-- ab CSV import karo (adjust path):
copy public.amazon_sales FROM 'E:/MAJOR_DATA_ANALYSIS_PROJECT/Amazon Sales Data Analysis/Amazon_Sales_Clean.csv' WITH CSV HEADER DELIMITER ',';
