# 📊 COVID-19 State-wise Analysis Dashboard
**End-to-End Analytics Project | Public Health Data | India**

---

## 📌 Business Problem

During the COVID-19 pandemic, large volumes of covid data were generated daily. However, raw data alone does not provide actionable insights.

Key challenges:
- Difficulty in identifying **high-risk states**
- Lack of clarity on **peak periods and trends**
- No structured way to compare **state performance**
  Spread of covid in different states over different timeline

This project aims to transform raw COVID data into **meaningful insights and patterns** for better understanding.

---

## 🚀 Project Objective

This project builds an end-to-end analytics system that:

- Tracks **state-wise COVID trends over time**
- Identifies **peak periods for confirmed, recovery, and death cases**
- Compares **state performance using recovery and death rates**
- Classifies states into **stable, unstable, strong, and weak categories**
- Extracts **pattern-based insights instead of raw observations**

---

## 🛠️ Tech Stack

| Layer | Tools |
|------|------|
| Data Cleaning   | Python (Pandas) |
| Data Processing | SQL |
| Analysis | SQL, DAX |
| Visualization | Power BI |
| Concepts Used | Aggregations, Time Series, Pattern Analysis |
| Version Control | Git, GitHub |


## 📂 Dataset

 COVID dataset with processed daily metrics:

| Column | Description |
|--------|------------|
| Date | Daily record date |
| State | State name |
| Confirmed | Cumulative confirmed cases |
| Recovered | Cumulative recovered cases |
| Deceased | Cumulative death cases |
| Tested | Total tests conducted |
| positivity_rate | (Confirmed / Tested) * 100 |

### Derived Metrics

- Daily Confirmed Cases  
- Daily Recovered Cases  
- Daily Deceased Cases  
- Recovery Rate = Recovered / Confirmed  
- Death Rate = Deceased / Confirmed  


## 📊 Key Features

- Peak detection (monthly max values)  
- Trend analysis (confirmed, recovery, death)  
- State-wise comparison  
- Recovery & death rate evaluation  
- Pattern-based classification:
  - Continuous behavior  
  - Peak behavior  
  - Mixed behavior  
  - Neutral states  

---

## 📈 Key Business Insights

- Maharashtra dominates in **confirmed, recovered, and death counts** due to scale  
- April–June represents the **critical peak period**  
- Recovery rates show **high fluctuation across states**  
- Death rates are relatively **more stable**  
- States exhibit:
  - **Continuous behavior** → stable systems  
  - **Peak behavior** → temporary spikes  
  - **Mixed behavior** → instability  
  - **Neutral behavior** → no strong pattern  

---

## 📊 Power BI Dashboard

### Key Visuals

- Monthly trend analysis  
- State-wise comparison charts  
- Peak detection visuals  
- KPI cards (total confirmed, recovered, deaths)  
- Recovery & death rate trends  

---

## 🧠 SQL Analysis

Key analysis performed:

- Data cleaning (cumulative → daily conversion)  
- Aggregations (state & monthly level)  
- Peak identification (MAX values)  
- Rate calculations (recovery & death)  
- Comparative analysis across states  

---

## 📂 Project Structure
covid-state-analysis/
│
├── Data/
│ └── dataset.csv
│
├── Data Analysis/
| └── dataset.csv
|
├── SQL/
│ ├── queries.sql
│
├── Dashboard/
│ └── covid_dashboard.pbip
│
└── README.md


---

## 🎯 Analytical Approach

This project focuses on **pattern-based analysis**:

- Pattern → Identify trends  
- Comparison → State vs State  
- Trend → Time-based behavior  
- Interpretation → Insight generation  

---

## 🚀 What This Project Demonstrates

- Data transformation using SQL  
- Dashboard building using Power BI  
- Strong analytical thinking  
- Ability to extract insights from raw data  
- Understanding of time-series and pattern analysis  

---

## 🎯 Key Learning

- Peaks do not indicate performance → consistency matters  
- Rates must be analyzed with context  
- Data patterns provide deeper insights than raw values  

---

## 🙌 Author

**Aron Varghese John**  
Aspiring Data Analyst  

---

⭐ If you found this useful, consider giving a star!
