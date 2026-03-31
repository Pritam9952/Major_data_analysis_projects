# 📊 Amazon Sales Data Analysis (SQL Project)

## 👤 Author
**Username:** Pritam9952  

---

## 📌 Project Overview
This project focuses on analyzing **Amazon sales data** using **PostgreSQL / SQL**.  
The goal is to uncover insights such as total revenue, orders, top products, sales trends, and more.  

We load the dataset into a PostgreSQL database, perform data cleaning checks, and run SQL queries to generate **KPIs and business insights**.

---

## 🗂 Project Structure
```
.
├── amazon_sales_sql_analysis.docx   # Reference schema, KPIs & example outputs
├── load_dataset.sql                 # Script to create table & load CSV
├── sql_code.sql                     # SQL queries for KPIs & analysis
├── Amazon_Sales_Clean.csv           # (Place cleaned dataset here)
```
---

## 🛠 Setup Instructions

### 1. Create Database
```sql
CREATE DATABASE amazon_sales_db;
```

### 2. Run Schema & Load Data
```sql
\i load_dataset.sql
```

This will:
- Drop any existing table
- Create a new `amazon_sales` table
- Load data from `Amazon_Sales_Clean.csv`

### 3. Verify Data
```sql
SELECT COUNT(*) FROM amazon_sales;
```

---

## 📈 Key KPIs & Example Outputs

Below are some of the **important KPIs** derived from the dataset:

### 1. Total Orders
```sql
SELECT COUNT(*) AS total_orders FROM amazon_sales;
```
**Output:**  
📌 **120,378 Orders**

---

### 2. Total Revenue
```sql
SELECT SUM(total_revenue) AS total_revenue FROM amazon_sales;
```
**Output:**  
💰 **76,034,406.00 INR**  

---

### 3. Average Order Value (AOV)
```sql
SELECT ROUND(SUM(total_revenue) / COUNT(*), 2) AS avg_order_value
FROM amazon_sales;
```
**Output:**  
📌 **631.63 INR**

---

### 4. Revenue by Month
```sql
SELECT DATE_TRUNC('month', order_date) AS month,
       COUNT(*) AS orders,
       SUM(total_revenue) AS revenue
FROM amazon_sales
GROUP BY 1
ORDER BY 1;
```
**Insight:** Shows **monthly revenue growth** & seasonality trends.  

---

### 5. Top 10 Products by Revenue
```sql
SELECT sku, asin, SUM(total_revenue) AS revenue, SUM(qty) AS total_qty
FROM amazon_sales
GROUP BY sku, asin
ORDER BY revenue DESC LIMIT 10;
```
**Insight:** Helps identify **best-selling products**.

---

### 6. Category-wise Revenue
```sql
SELECT category, SUM(total_revenue) AS revenue
FROM amazon_sales
GROUP BY category
ORDER BY revenue DESC;
```
**Insight:** Identifies top-performing **product categories**.

---

### 7. B2B vs B2C Revenue Split
```sql
SELECT b2b, COUNT(*) AS orders, SUM(total_revenue) AS revenue
FROM amazon_sales GROUP BY b2b;
```
**Output Example:**  
- B2C:  📌 Higher order count  
- B2B:  💰 Higher average order size  

---

### 8. Fulfilment Channel Performance
```sql
SELECT fulfilled_by, COUNT(*) AS orders, SUM(total_revenue) AS revenue
FROM amazon_sales GROUP BY fulfilled_by ORDER BY revenue DESC;
```
**Insight:** Compares **FBA vs Seller Fulfilled** sales.

---

### 9. Order Status Distribution
```sql
SELECT status, COUNT(*) AS count_orders, SUM(total_revenue) AS revenue
FROM amazon_sales GROUP BY status ORDER BY count_orders DESC;
```
**Insight:** Tracks **Delivered, Returned, Cancelled** orders.

---

### 10. Average Items per Order
```sql
SELECT ROUND(AVG(qty),2) AS avg_items_per_order FROM amazon_sales;
```
**Output:**  
📌 **0.90 items per order**

---

### 11. Revenue by City (Top 20)
```sql
SELECT ship_city, ship_state, SUM(total_revenue) AS revenue
FROM amazon_sales GROUP BY ship_city, ship_state
ORDER BY revenue DESC LIMIT 20;
```
**Insight:** Highlights **top contributing cities**.

---

## ✅ Recommendations for Improvement
- Use **consistent column names** (e.g., `order_date` instead of `date`).
- Add a **primary key constraint** on `order_id`.
- Use **`COUNT(DISTINCT order_id)`** to avoid duplicate order inflation.
- Add **indexes** on frequently queried columns (`order_date`, `category`, `sku`).

---

## 🚀 Future Enhancements
- Build **interactive dashboards** in **Tableau / Power BI**.
- Automate data refresh with **ETL pipelines (Airflow / Python)**.
- Extend analysis to **multi-year and multi-market data**.

---
