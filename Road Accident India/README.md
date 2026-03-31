# 🚦 Road Accident Analysis in India

![Dashboard Preview](./Power_BI/dashboard.png)

## 📌 Project Overview
This project focuses on analyzing **road accident data in India** using **PostgreSQL, Python, and Power BI** to identify accident trends, key causes, driver behavior, weather impact, and accident severity. The main objective is to uncover **data-driven insights** that can assist in improving road safety and policy planning.

---

## 📂 Dataset Summary
| **Attribute**            | **Details** |
|------------------------|----------------------|
| **Dataset Name**       | Road_accident_data.csv |
| **Total Records**      | 12,316 |
| **Total Columns**      | 32 |
| **Key Columns**        | time, day_of_week, type_of_vehicle, cause_of_accident, weather_conditions, road_surface_type, accident_severity, number_of_casualties, number_of_vehicles_involved |
| **Tools Used**         | PostgreSQL, Power BI, Python |

---

## 🛠 Tools & Technologies
- **Database:** PostgreSQL
- **Visualization:** Power BI
- **Programming:** Python (Pandas, Matplotlib, Seaborn, Plotly)
- **IDE/Notebook:** Jupyter Notebook
- **Reporting:** MS Word, PDF

---
## Business Insights & Impact
- Identified peak ride demand periods and high-revenue zones
- Analyzed cancellation patterns by payment method and vehicle type
- Helped highlight factors influencing ride completion rates
- Dashboard enables stakeholders to monitor revenue trends and operational KPIs

---

## 📊 Project Workflow

### **1. Data Preparation & Cleaning**
- Loaded CSV data into **PostgreSQL** database
- Handled missing values and cleaned column names

### **2. SQL Analysis**
Performed KPI-driven analysis using advanced **SQL queries**:
- Total accidents, vehicles involved & casualties
- Accidents by day of week, time of day, driver age group
- Top causes of accidents
- Weather & road surface impact
- Accident severity & average casualties

### **3. Python Analysis**
- Performed **Exploratory Data Analysis (EDA)**
- Univariate, bivariate, and correlation analysis
- Visualized accident trends using **Seaborn** & **Matplotlib**
- Built interactive graphs using **Plotly**

### **4. Power BI Dashboard**
- Created an **interactive dashboard** showing:
    - Accident trends by year & state
    - Weather impact on severity
    - Driver demographics
    - Casualties & vehicle types

![Power BI Dashboard](./Power_BI/dashboard.png)

---

## 🔍 Key Insights & Findings
- 🚗 **Two-wheelers** contribute to the highest number of accidents.
- 🌧️ Accidents are more frequent in **rainy weather** and poor road conditions.
- 🕒 Most accidents occur during **evening hours (5 PM – 8 PM)**.
- 👨‍🦱 Drivers aged **18-30 years** are involved in the majority of accidents.
- ⚠️ **Over-speeding** and **negligent driving** are the top causes of accidents.
- 🌆 Urban areas show a higher accident density compared to rural areas.

---

## 🚀 How to Run This Project

### **1. Clone the Repository**
```bash
git clone https://github.com/Pritam9952/Major_data_analysis_projects.git
cd Road Accident India
```

### **2. Setup Database**
- Open **PostgreSQL** and run the SQL scripts:
    ```sql
    \i Load_road_accidents_data.sql;
    \i project_query.sql;
    ```

### **3. Run Python Notebook**
```bash
jupyter notebook Road_accident_data.ipynb
```

### **4. View Dashboard**
- Open **dashboard.pbix** file in **Power BI Desktop**

---

## 📁 Project Structure
```
Road Accident India
│── Load_road_accidents_data.sql     # Database schema & CSV import
│── project_query.sql              # SQL KPI queries
│── Road_accident_data.ipynb       # Python EDA & Visualization
│── dashboard.pbix                 # Power BI Dashboard file
│── dashboard.png                  # Dashboard preview
│── ROAD ACCIDENT IN INDIA  ANALYSIS PROJECT.docx  # Report
│── README.md                     # You are here 😎
```

---

## 👨‍💻 Author
**Pritam Nagar**
- 🌐 [GitHub](https://github.com/Pritam9952)
- 🔗 [LinkedIn](https://www.linkedin.com/in/pritam-nagar)

---

## 🏆 Project Highlights
✅ **3-in-1 Approach:** SQL + Python + Power BI  
✅ **Interactive Dashboard** for better insights  
✅ **Data-driven recommendations** for improving road safety

---

> ⚡ *"Data doesn't lie. Use insights to make roads safer!"*
