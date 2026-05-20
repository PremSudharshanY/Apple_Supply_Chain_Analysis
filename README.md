# 🍎 Apple Supply Chain Analytics Dashboard  

<p align="center">
  <img src="https://img.shields.io/badge/PowerBI-Dashboard-black?style=for-the-badge&logo=powerbi" />
  <img src="https://img.shields.io/badge/SQL-Analysis-orange?style=for-the-badge&logo=mysql" />
  <img src="https://img.shields.io/badge/Python-EDA-white?style=for-the-badge&logo=python" />
  <img src="https://img.shields.io/badge/Excel-DataCleaning-darkgreen?style=for-the-badge&logo=microsoft-excel" />
</p>

---

# 📌 Overview

This project delivers a complete **Supply Chain & Business Performance Analysis** for Apple using **Power BI, SQL, Python, and Excel**.

The dashboard focuses on monitoring:

- 📈 Revenue Growth  
- 💰 Profit Growth  
- 📦 Order Performance  
- 🚚 Logistics Efficiency  
- 🏭 Supplier Performance  
- 📊 Inventory Optimization  
- 👥 Customer Demand Trends  

The main highlight of this project is the **Month-on-Month (MoM) Growth Analysis**, helping businesses identify growth patterns, operational bottlenecks, and performance fluctuations.

---

# 🎯 Business Objectives

- Analyze monthly revenue & profit growth
- Monitor order trends & shipment performance
- Identify top suppliers & delayed shipments
- Track inventory efficiency
- Analyze delivery & logistics performance
- Measure customer demand patterns
- Improve operational decision-making using data

---

# 📊 Key KPIs

| KPI | Value |
|---|---|
| 💰 Total Revenue | ₹196M |
| 📈 Revenue Growth | +18.4% MoM |
| 💵 Total Profit | ₹58M |
| 📊 Profit Growth | +12.7% MoM |
| 📦 Total Orders | 378K |
| 🛒 Order Growth | +9.2% MoM |
| 🚚 Avg Delivery Time | 4.2 Days |
| ⚠️ Delayed Shipment Rate | 1.8% |
| 🏭 Active Suppliers | 145 |
| 📦 Inventory Turnover | 7.9 |

---

# 🛠️ Tools & Technologies

- 🗄️ SQL → Data extraction & transformation  
- 🐍 Python → EDA & preprocessing  
- 📊 Power BI → Dashboard development & DAX  
- 📗 Excel → Data cleaning & formatting  

---

# 📈 Dashboard Pages

## 1️⃣ Executive Overview Dashboard

### Contains:
- Total Revenue
- Total Profit
- Total Orders
- Revenue Growth %
- Profit Growth %
- Order Growth %
- KPI Trend Indicators

### Purpose:
Provides quick business health monitoring.

---

## 2️⃣ Revenue & Profit Dashboard

### Highlights:
- Month-on-Month Revenue Growth
- Month-on-Month Profit Growth
- Year-over-Year Analysis
- Revenue by Category
- Profit Margin Analysis
- Revenue Forecasting

### Key Insight:
Revenue and profit consistently increased during Q4.

---

## 3️⃣ Orders & Customer Dashboard

### Contains:
- Order Trends
- Average Order Value
- Customer Growth
- Peak Demand Hours
- Repeat Customer Analysis

### Key Insight:
Weekend order volume outperforms weekdays significantly.

---

## 4️⃣ Logistics Dashboard

### Contains:
- Delivery Time Analysis
- Delayed Shipment %
- Regional Shipping Performance
- Logistics Cost Breakdown
- On-Time Delivery %

### Key Insight:
Delivery efficiency maintained with minimal delays.

---

## 5️⃣ Supplier Performance Dashboard

### Contains:
- Supplier Ranking
- Supplier Delay %
- Supplier Cost Contribution
- Defective Shipment Analysis
- Supplier Efficiency Score

### Key Insight:
Top suppliers contribute majority of operational efficiency.

---

## 6️⃣ Inventory Dashboard

### Contains:
- Inventory Turnover Ratio
- Overstock & Understock Analysis
- Warehouse Efficiency
- Product Demand Analysis
- Stock Availability %

### Key Insight:
Fast-moving products require optimized replenishment planning.

---

# 📊 Key Insights

## 📈 Revenue Analysis
- Strong month-on-month growth trend
- Revenue spikes during festive & seasonal periods
- High-performing categories contribute most revenue

---

## 💰 Profit Analysis
- Profit margins improved steadily
- Logistics optimization reduced operational costs
- High-margin products increased total profitability

---

## 📦 Order Analysis
- Order volume steadily increasing
- Peak demand during evenings and weekends
- Customer retention rate remains strong

---

## 🚚 Logistics Analysis
- Average delivery performance maintained efficiently
- Delayed shipment percentage below industry average
- Certain regions require logistics optimization

---

## 🏭 Supplier Analysis
- Supplier efficiency impacts delivery performance directly
- Some suppliers show recurring delays
- Top suppliers maintain high fulfillment rates

---

## 📦 Inventory Analysis
- Inventory turnover maintained efficiently
- Overstock identified in low-demand products
- Stock planning improved operational efficiency

---

# 🚀 Advanced Dashboard Features

## ✅ Dynamic KPI Cards
- Revenue Growth %
- Profit Growth %
- Order Growth %
- Shipment Growth %

---

## ✅ Smart Insights
- Top Performing Product
- Most Delayed Supplier
- Highest Revenue Region
- Fastest Growing Month

---

## ✅ Forecasting
- Revenue Forecast
- Profit Forecast
- Demand Forecast
- Inventory Requirement Prediction

---

# 🎨 Dashboard Theme

| Element | Color |
|---|---|
| Background | #0F0F0F |
| Cards | #1A1A1A |
| Primary Accent | #FF6B00 |
| Secondary Accent | #FFA559 |
| Positive Growth | #00FF9D |
| Negative Growth | #FF4D4D |
| Text Primary | #FFFFFF |
| Text Secondary | #BDBDBD |

---

# 📏 Recommended Design

## KPI Cards
- Rounded corners → 15px
- Font Size KPI → 36px
- Font Size Title → 13px
- Padding → 15px

---

## Recommended Charts
- Area Charts → Growth Trends
- Line Charts → Revenue & Profit
- Donut Charts → Category Contribution
- Heatmaps → Delivery Delays
- Bar Charts → Supplier Ranking

---

# 📈 DAX Measures

## Revenue Growth %

```DAX
Revenue Growth % =
VAR CurrentRevenue =
    [Total Revenue]

VAR PreviousRevenue =
    CALCULATE(
        [Total Revenue],
        DATEADD('Date'[Date], -1, MONTH)
    )

RETURN
DIVIDE(
    CurrentRevenue - PreviousRevenue,
    PreviousRevenue
)
