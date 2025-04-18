# VelociMart

## 📘 Project Background

**VelociMart** is a dynamic e-commerce company founded in 2010, specializing in the sale of high-performance cycling gear and accessories. Their product catalog spans Bikes, Components, Clothing, and Accessories, catering to both casual riders and professional cyclists.

To keep up with business growth and evolving decision-making needs, VelociMart needed to transition from Excel-based reporting to a **scalable, reliable data platform**. This project was initiated to help the company unlock deeper insights from their data using **SQL Server** for warehousing and **Tableau** for visualization.

The project focuses on delivering insights and recommendations for VelociMart’s leadership, especially the Chief Revenue Officer (CRO), in the following key areas:

- Year-over-year growth in sales and profit  
- Monthly and seasonal performance trends  
- Weekly sales monitoring to track progress against targets  
- High and low-performing periods across product categories and timeframes  

---

### ⚙️ Data Engineering

Scripts for building the data warehouse using the **Medallion Architecture**:

- 🟤 [Bronze Layer](scripts/bronze) — Raw data ingestion  
- ⚪ [Silver Layer](scripts/silver) — Cleaned and conformed data  
- 🟡 [Gold Layer](scripts/gold) — Analytical, business-ready data marts  

Data quality checks to ensure accurate and reliable analysis:

- 🧪 [Silver Layer Quality Checks](tests/quality_checks_silver.sql)  
- 🧪 [Gold Layer Quality Checks](tests/quality_checks_gold.sql)

---

### 📊 Data Analysis

SQL logic for preparing the sales data for reporting:

- 📄 [Sales Report SQL Script](scripts/reports/sales_report.sql)

---

### 📈 Data Visualization

CRO dashboard was built in **Tableau Public**, providing rich, visual insights for decision-makers:

- 🌐 [View CRO Dashboard in Tableau Public](https://public.tableau.com/shared/HBWCH3TXQ?:display_count=n&:origin=viz_share_link)
