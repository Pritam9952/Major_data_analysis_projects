# 📊 Data Dictionary – Ecommerce Revenue Dataset

This dataset contains transactional ecommerce sales data used for revenue analysis and customer segmentation.

---

## 🧾 Column Descriptions

| Column Name         | Description |
|--------------------|------------|
| order_id           | Unique identifier for each order |
| order_date         | Date when the order was placed |
| product_id         | Unique identifier for each product |
| product_category   | Category of the product (e.g., Beauty, Fashion, Electronics) |
| price              | Original price per unit of the product |
| discount_percent   | Discount percentage applied on the product |
| quantity_sold      | Number of units sold in the order |
| customer_region    | Region of the customer (e.g., North, South, East, West) |
| payment_method     | Mode of payment (e.g., Credit Card, UPI, COD) |
| rating             | Customer rating for the product (1 to 5 scale) |
| review_count       | Number of reviews received for the product |
| discounted_price   | Final price after discount |
| total_revenue      | Total revenue generated (discounted_price × quantity_sold) |
| profit             | Profit earned from the order |

---

## 📌 Notes
- `discounted_price` is derived from price and discount_percent  
- `total_revenue` depends on quantity_sold  
- `profit` may be calculated using cost assumptions or margin  

---