# 🚦 Road Accident Data Analysis

## 📌 Project Overview

This project explores a comprehensive dataset of 12,316 road accident records with 32 features, including driver demographics, vehicle details, road conditions, weather, and accident severity. The goal is to identify key factors contributing to accident severity and provide actionable insights for improving road safety.

## 📊 Dataset Information

- **Rows**: 12,316 accident records
- **Columns**: 32 (reduced after cleaning)
- **Target Feature**: `Accident_severity`
- **Numeric Features**: 
  - Number_of_vehicles_involved
  - Number_of_casualties
  - Hour (engineered from Time)
- **Categorical Features**:
  - Driver demographics (age, sex, education, experience)
  - Vehicle details (type, ownership, service year, defects)
  - Road & weather conditions
  - Accident causes

## 🧹 Data Cleaning Steps

1. Replaced "na" strings with NaN values
2. Dropped columns with >40% missing values
3. Imputed missing values:
   - Categorical → "Unknown"
   - Numeric → median
4. Engineered new features:
   - Extracted Hour from Time
5. Converted categorical columns to category dtype for memory optimization

## 📊 Exploratory Data Analysis (EDA)

### 1️⃣ Accident Severity Distribution
- Analysis of accident severity distribution (Slight, Serious, Fatal)
- Visualizations showing proportions of each severity type

### 2️⃣ Time Trends
- Accident patterns by hour of day
- Weekly patterns across days of the week

### 3️⃣ Driver Demographics
- Severity by age group, sex, and driving experience
- Identification of high-risk demographic groups

### 4️⃣ Vehicle & Road Conditions
- Severity by vehicle type
- Effect of weather & road surface conditions
- Severity analysis at different junction types

### 5️⃣ Causes of Accidents
- Top 10 most common accident causes
- Relationship between causes and severity

### 6️⃣ Numeric Analysis
- Correlation heatmap (vehicles involved, casualties, hour)
- Boxplots: casualties & vehicles vs accident severity

## 📂 Project Structure
road-accident-analysis/
├── data/
│ ├── Road_accident_data.csv # Raw dataset
├── notebooks/
│ └── EDA_Analysis.ipynb 
└── README.md # Project documentation


## 🛠️ Tech Stack

- **Python**: pandas, numpy
- **Visualization**: matplotlib, seaborn
- **Notebook Environment**: Jupyter Notebook

## 🚀 How to Run

1. Clone this repository:
```bash
git clone https://github.com/your-username/road-accident-analysis.git
cd road-accident-analysis
```

## 📈 Key Insights
Most accidents occur during daylight hours and on weekdays

Young and middle-aged drivers (18–50 yrs) are involved in the majority of accidents

Slight injuries dominate, but serious and fatal accidents are linked with:

Poor road & weather conditions

High vehicle counts and casualties

Top causes: overtaking, lane changing, speeding

## 🔮 Future Work
Build a predictive model for accident severity classification

Add geospatial analysis if location data becomes available

Develop interactive dashboards with Power BI/Tableau/Streamlit

Implement time series analysis for accident trends

## ## 👨‍💻 Author
Pritam Nagar
B.Tech Mechanical Engineering, NIT Bhopal
GitHub : https://github.com/Pritam9952

📄 License
This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

Inspiration from road safety research papers and articles
