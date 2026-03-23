⛽ UK Macroeconomic Fuel Trends: An End-to-End ETL & Visualization Pipeline

📌 Project Overview
The price of road fuel is one of the most accurate indicators of macroeconomic health and global geopolitical stability. The goal of this project was to build an automated, end-to-end data pipeline to analyze over 20 years of UK government fuel data (2003–Present). 

Instead of relying on raw, highly volatile weekly pump prices, this project utilizes "Advanced SQL Window Functions" to engineer new financial metrics, smoothing out market noise and revealing true economic trends during major global events (e.g., the 2008 Financial Crisis, COVID-19, and the 2022 Global Energy Crisis).

🛠️ Tech Stack
* Data Extraction & Cleaning: Microsoft Excel (CSV formatting, data normalization)
* Database & Transformation (Engine):** MySQL (Aggregations, Window Functions)
* Data Visualization: Power BI (Interactive Dashboards, KPI tracking, DAX)

---

🏗️ The Data Pipeline (Architecture)

 Phase 1: Data Extraction
* Sourced raw weekly road fuel price statistics directly from the official UK Government database.
* Extracted the master dataset from a complex, multi-sheet workbook, normalized date formats (`yyyy-mm-dd`), and stripped redundant government tax/duty columns to isolate the core consumer variables: Date, Petrol Price (ULSP), and Diesel Price (ULSD).

#Phase 2: Data Transformation (The SQL Engine)
Raw weekly prices zigzag constantly, making trend analysis difficult. To solve this, I built a SQL engine to calculate two vital metrics on the fly:
1. Week-over-Week (WoW) Volatility:** Using the `LAG()` function to track sudden price shocks.
2. 4-Week Moving Average:** Using the `AVG() OVER()` rolling window to smooth out weekly noise and expose the true trajectory of the market.

Featured SQL Code:
```sql
SELECT 
    price_date,
    petrol_price,
    diesel_price,
    
    -- Calculating Week-over-Week Price Shocks
    ROUND(petrol_price - LAG(petrol_price, 1) OVER (ORDER BY price_date), 2) AS wow_petrol_change,
    ROUND(diesel_price - LAG(diesel_price, 1) OVER (ORDER BY price_date), 2) AS wow_diesel_change,
    
    -- Calculating 4-Week Moving Averages for Trend Smoothing
    ROUND(AVG(petrol_price) OVER (ORDER BY price_date ROWS BETWEEN 3 PRECEDING AND CURRENT ROW), 2) AS petrol_4wk_avg,
    ROUND(AVG(diesel_price) OVER (ORDER BY price_date ROWS BETWEEN 3 PRECEDING AND CURRENT ROW), 2) AS diesel_4wk_avg

FROM fuel_prices;
```
Phase 3: Visual Storytelling
The transformed dataset was imported into Power BI to build an interactive dashboard for stakeholders.

Designed a dual-axis continuous timeline tracking both fuel types.

Implemented KPI cards for instant all-time high referencing.

Added a dynamic timeline slicer allowing users to zoom in on specific historical eras.

📊 The Final Dashboard

<img width="1877" height="1028" alt="Screenshot 2026-03-22 213746" src="https://github.com/user-attachments/assets/4ef0c1e0-864f-42f8-a225-a4abac891a49" />

 
💡 Key Economic Insights
By interacting with the dashboard, several distinct historical events become immediately visible:

The 2008 Financial Crash: A sharp, sudden plunge in prices as global markets contracted.

The 2020 COVID-19 Lockdowns: A massive drop in demand led to some of the lowest pump prices in the modern era.

The 2022 Global Energy Crisis: Following geopolitical conflicts, prices shattered previous records, with Diesel hitting an all-time peak of 199.07 pence per litre and Petrol reaching 191.43 pence per litre.

👨‍💻 How to Run This Project
Clone this repository.

Run the UK_Fuel_Analysis.sql script in MySQL to build the database and execute the window functions.

Open the Power BI .pbix file to interact with the dashboard.
