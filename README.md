# Rapido_Ride_Analysis_Python_SQL_Power-BI
Data Analysis showcasing Rapido Rides Using Python, SQL, Power BI


# 🚕 Rapido Ride Analytics

An end-to-end **Data Analytics project** analyzing Rapido ride-hailing data using **Python, SQL, and Power BI**. The project uncovers insights related to ride demand, peak hours, pricing patterns, cancellations, driver performance, and customer behavior, and provides business-focused recommendations.

---

## 📌 Project Overview

This project analyzes **10,000+ Rapido ride logs** to understand operational efficiency and customer usage patterns. The analysis follows a complete analytics lifecycle: data cleaning, exploration, KPI extraction, visualization, and insight generation.

---

## 🎯 Objectives

* Analyze ride frequency and peak demand hours
* Identify high-demand pickup and drop zones
* Understand pricing and surge impact
* Analyze ride cancellations and waiting times
* Evaluate driver performance and reliability
* Deliver data-driven business recommendations

---

## 🗂 Dataset Description

The dataset consists of structured ride transaction logs.

### Columns Used:

* `services` – Ride type (Auto, Cab Economy, etc.)
* `date` – Ride date
* `time` – Ride start timestamp
* `ride_status` – Completed / Cancelled
* `source` – Pickup location
* `destination` – Drop location
* `duration` – Ride duration (minutes)
* `ride_id` – Unique ride identifier
* `distance` – Distance traveled (km)
* `ride_charge` – Base fare
* `misc_charge` – Additional charges
* `total_fare` – Final fare
* `payment_method` – Payment type

> Note: Cancelled rides contain missing fare values.

---

## 🛠 Tools & Technologies

* **Python**: Pandas, NumPy, Matplotlib, Seaborn
* **SQL**: MySQL / PostgreSQL
* **Power BI**: DAX, Power Query, Interactive Dashboards
* **Excel**: Initial data validation

---

## 🧹 Data Cleaning & Feature Engineering (Python)

* Removed duplicate records
* Handled missing and null values
* Converted date and time into datetime format
* Extracted hour, day, and month features
* Categorized peak vs non-peak rides
* Treated cancelled rides separately

---

## 📊 Exploratory Data Analysis (EDA)

* Ride distribution by hour and service type
* Peak hour demand analysis
* Fare and distance distributions
* Waiting time vs cancellation trends
* Payment method usage analysis

---

## 🧮 SQL Analysis & KPIs

Key KPIs extracted using SQL queries:

* Daily Active Riders (DAR)
* Daily and Monthly Revenue Trends
* Cancellation Rate and Reasons
* Top Pickup Zones
* Surge Pricing Impact
* Driver Ride Completion Metrics

---

## 📈 Power BI Dashboard

Interactive dashboard built with:

* Geo maps for pickup & drop zones
* KPI cards (Total Rides, Revenue, Avg Fare)
* Time-series revenue and demand trends
* Cancellation analysis visuals
* Driver performance insights
<img width="1308" height="735" alt="Screenshot 2025-12-14 194249" src="https://github.com/user-attachments/assets/8ecb7370-cadf-4127-b37a-95e4211180dc" />

---

## 🔍 Key Insights

* Peak demand observed during office commute hours
* Specific zones consistently generate higher ride requests
* Long waiting times significantly increase cancellations
* Surge pricing boosts revenue but impacts user retention when overused
* High-performing drivers improve completion rates

---

## 💡 Business Recommendations

* Optimize driver allocation in high-demand zones
* Apply surge pricing strategically
* Reduce waiting time via predictive driver positioning
* Incentivize top-performing drivers
* Introduce customer loyalty programs

---

## 🚀 Future Enhancements

* Demand forecasting using machine learning
* Customer churn prediction
* Real-time analytics dashboard
* Dynamic surge pricing optimization
