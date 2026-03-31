# 📘 Data Dictionary

This document provides a detailed description of each feature used in the Netflix Customer Churn Analysis project.

---

## 🧾 Customer Information

| Column Name   | Description                                                     |
| ------------- | --------------------------------------------------------------- |
| customerID    | Unique identifier for each customer                             |
| gender        | Gender of the customer (Male/Female)                            |
| SeniorCitizen | Indicates if the customer is a senior citizen (1 = Yes, 0 = No) |
| Partner       | Whether the customer has a partner (Yes/No)                     |
| Dependents    | Whether the customer has dependents (Yes/No)                    |

---

## 📅 Account Information

| Column Name      | Description                                               |
| ---------------- | --------------------------------------------------------- |
| tenure           | Number of months the customer has stayed with the service |
| Contract         | Type of subscription (Month-to-month, One year, Two year) |
| PaperlessBilling | Whether the customer uses paperless billing (Yes/No)      |
| PaymentMethod    | Payment method used by the customer                       |

---

## 📞 Services Information

| Column Name      | Description                                       |
| ---------------- | ------------------------------------------------- |
| PhoneService     | Whether the customer has phone service (Yes/No)   |
| MultipleLines    | Whether the customer has multiple lines           |
| InternetService  | Type of internet service (DSL, Fiber optic, None) |
| OnlineSecurity   | Whether the customer has online security          |
| OnlineBackup     | Whether the customer has online backup            |
| DeviceProtection | Whether the customer has device protection        |
| TechSupport      | Whether the customer has tech support             |
| StreamingTV      | Whether the customer uses streaming TV            |
| StreamingMovies  | Whether the customer uses streaming movies        |

---

## 💰 Billing Information

| Column Name    | Description                          |
| -------------- | ------------------------------------ |
| MonthlyCharges | Monthly subscription charges         |
| TotalCharges   | Total amount charged to the customer |

---

## 🎯 Target Variable

| Column Name | Description                                         |
| ----------- | --------------------------------------------------- |
| Churn       | Indicates whether the customer has churned (Yes/No) |

---

## 🧠 Engineered Features (Python)

| Column Name         | Description                                                      |
| ------------------- | ---------------------------------------------------------------- |
| tenure_group        | Categorized tenure (0-1Y, 1-2Y, 2-4Y, 4+Y)                       |
| revenue_bucket      | Customer segmented by monthly charges (Low, Medium, High)        |
| total_services      | Total number of services used by the customer                    |
| high_value_customer | Flag indicating high-value customers based on tenure and charges |

---

## 📌 Notes

* Missing values in `TotalCharges` were handled during data cleaning.
* Categorical variables were encoded for analysis and modeling purposes.
* Feature engineering was performed to enhance analytical insights and segmentation.
