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

## 🧱 Data Structure

This section provides a visual overview of the architecture, integration, and modeling of VelociMart’s analytics ecosystem. Each diagram illustrates a specific part of the data journey—from source systems to the final analytical layer.

---

### 🏗️ Data Architecture

Shows the overall design of the data warehouse, including how data moves across the **Bronze, Silver, and Gold** layers following the **Medallion Architecture**.

![Data Architecture](docs/Data%20Architecture.jpg)

---

### 🔗 Integration Model

Visualizes the raw data as it originally existed in **VelociMart’s CRM and ERP systems**, before any transformation or modeling.

![Integration Model](docs/Integration_Model.jpg)

---

### 🔄 Data Flow Diagram

Demonstrates how data flows from the source systems into the **Bronze**, then **Silver**, and finally the **Gold layer**, where business-ready Data Marts are created.

![Data Flow Diagram](docs/Data%20Flow%20Diagram.jpg)

---

### 📊 Sales Data Mart (Star Schema)

Illustrates the **Star Schema** for the Sales Data Mart. Includes the central **Sales Fact Table**, surrounded by the **Customers** and **Products Dimension Tables** used in analysis.

![Sales Data Mart](docs/Sales%20Data%20Mart.jpg)

