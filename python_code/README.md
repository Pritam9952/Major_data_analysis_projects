# 📊 Amazon Sales Dashboard – Streamlit App

![Amazon Sales Dashboard Screenshot](../Power%20BI/dashboard_img.png)

## 📝 Overview
This project is a **Python Streamlit dashboard** built on Amazon sales data.
It allows users to interactively explore sales KPIs, revenue trends, top products, and state-wise performance.

## 🚀 Features
- **Interactive Filters**: Filter by state and order status from sidebar.
- **Key KPIs**: Total Orders, Total Revenue, Average Order Value displayed in metric cards.
- **Download Option**: Export the filtered dataset as CSV directly from the app.
- **Visual Tabs**:
  - 📈 **Sales Trend**: Daily sales revenue trend line chart.
  - 🏆 **Top SKUs**: Top 10 products by revenue (horizontal bar).
  - 🗺 **State-wise Revenue**: Revenue by state (bar chart).
  - 🚚 **Fulfilment Channels**: Revenue by fulfilment channel.
  - 🧾 **B2B vs B2C Split**: Pie chart showing B2B vs B2C revenue share.

## 🛠️ Tech Stack
- **Python 3.x**
- **Streamlit** for dashboard
- **Plotly Express** for interactive charts
- **Pandas** for data manipulation

## 📂 Files in this Repository
- `app.py` – Streamlit dashboard code.
- `Amazon Sale Report.csv` – Input dataset.
- `dashboard_img.png` – Screenshot of the dashboard.

## ⚙️ Installation & Run
1. Clone this repository:
   ```bash
   git clone https://github.com/pritam9952/Amazon-Sales-Dashboard.git
   cd Amazon-Sales-Dashboard
   ```
2. Install required libraries:
   ```bash
   pip install -r requirements.txt
   ```
   *(requirements.txt should include `streamlit`, `pandas`, `plotly`, `Pillow`)*

3. Run the app locally:
   ```bash
   streamlit run app.py
   ```
4. Open your browser at the URL shown (usually `http://localhost:8501`).

## 📈 Insights Highlighted
- Daily revenue trends.
- Top performing SKUs and fulfilment channels.
- State-level revenue contribution.
- B2B vs B2C revenue split.

## 📬 Author
**Pritam Nagar**  
[GitHub Profile](https://github.com/pritam9952) | [LinkedIn](https://www.linkedin.com/in/pritamnagar/)

---

> Feel free to fork ⭐ this repo if you find it useful!
