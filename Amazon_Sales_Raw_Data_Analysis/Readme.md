# 📊 Amazon Sales Data Warehouse & BI Dashboard

### Using PostgreSQL + Power BI

👨‍💻 **Developed by:** [Pritam Nagar](https://github.com/Pritam9952)

---

## 🚀 Project Overview

This project demonstrates a complete **end-to-end Data Analytics workflow** by building a **Sales Data Warehouse in PostgreSQL** and connecting it to **Power BI** for advanced business intelligence reporting.

The objective was to transform raw Amazon sales data into a structured analytical system that enables insights into:

* Sales Performance
* Profitability
* Fulfilment Efficiency
* Regional Trends
* Product Category Analysis

---

## 🧱 Tech Stack Used

| Layer          | Technology                  |
| -------------- | --------------------------- |
| Data Source    | Kaggle Amazon Sales Dataset |
| Database       | PostgreSQL (pgAdmin 4)      |
| Data Modelling | Star Schema                 |
| ETL            | SQL                         |
| BI Tool        | Power BI                    |
| Visualization  | Interactive Dashboard       |

---

## 🏗️ Data Warehouse Architecture

A **Star Schema** was designed for optimized analytics.

### 🔹 Fact Table

* `fact_sales`

### 🔹 Dimension Tables

* `dim_product`
* `dim_location`
* `dim_fulfilment_clean`

This structure enables:

✔ Fast Aggregations
✔ Clean Business Metrics
✔ Scalable Reporting

---

## ⚙️ ETL Process (SQL)

Performed:

* Data Cleaning
* Null Handling
* Date Formatting
* Standardization
* Key Mapping
* Dimension Creation
* Fact Table Population

Example transformations included:

* Removing inconsistent fulfilment values
* Handling missing courier statuses
* Creating surrogate keys
* Normalizing location data

---

## 📈 KPIs Created

The dashboard includes:

* 💰 Total Sales
* 📊 Total Profit
* 📦 Total Orders
* 🔢 Total Quantity
* 📉 Profit %
* 🧾 Average Order Value (AOV)

---

## 📊 Dashboard Insights

### Business Performance

* Sales by Category
* Sales by Fulfilment Type
* Monthly Trends

### Operations

* Orders by Courier Status
* Fulfilment Performance

### Regional Analysis

* Sales by State
* Sales by City

### Product Intelligence

* Top Categories
* Revenue Contribution

---

## 🔗 Power BI Integration

Power BI was connected **live** to PostgreSQL for real-time analytics using:

PostgreSQL → Star Schema → Power BI Model → Interactive Dashboard

This simulates an industry-level BI pipeline.

---

## 📌 Key Learnings

* Data Warehousing Concepts
* Star Schema Design
* SQL Data Cleaning
* Relationship Modelling
* BI Dashboarding
* Real-world Business KPIs

---

## 📷 Final Dashboard

![Dashboard Preview](./Power%20BI/Amazon%20Sales%20Performance%20Dashboard.png)

![Dashboard Preview](./Power%20BI/Dashboard%20usin%20SQL%20and%20BI.png)

---

## 📁 Project Structure

```
Amazon_Sales_DW/
│
├── SQL/
│   ├── raw_table.sql
│   ├── dim_tables.sql
│   ├── fact_table.sql
│   └── transformations.sql
│
├── PowerBI/
│   └── Amazon_Sales_DW_PowerBI.pbix
│
└── README.md
```

---

## ⭐ Future Enhancements

* Add Time Dimension
* Add Customer Segmentation
* Implement Incremental Loading
* Deploy on Cloud (AWS / Azure)

---

## 🤝 Connect With Me

GitHub: 👉 https://github.com/Pritam9952

---

## 🏁 Project Status

✅ Completed


---
