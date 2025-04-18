# VelociMart Business Insights

## 📚 Table of Contents

1. [Project Background](#1-project-background)  
   - [Data Engineering](#️data-engineering)  
   - [Data Analysis](#data-analysis)  
   - [Data Visualization](#️data-visualization)  
2. [Data Structure](#2-data-structure)  
   - [Data Architecture](#️data-architecture)  
   - [Integration Model](#integration-model)  
   - [Data Flow Diagram](#data-flow-diagram)  
   - [Sales Data Mart (Star Schema)](#sales-data-mart-star-schema)  
   - [Data Catalog](#️data-catalog)  
3. [Executive Summary](#3-executive-summary)  
   - [Key Takeaways](#key-takeaways)  
4. [Recommendations](#4-recommendations)

## 1) Project Background

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

## 2) Data Structure

This section highlights the core structure and modeling approach used in VelociMart’s data warehouse. It covers the architecture, flow, and star schema modeling that enabled effective analysis and reporting.

---

### 🏗️ Data Architecture

An overview of how the data warehouse was designed using the **Medallion Architecture** (Bronze → Silver → Gold).  
📎 [View Diagram](docs/Data%20Architecture.jpg)

---

### 🔗 Integration Model

Illustrates the structure of the raw data from VelociMart’s **CRM and ERP systems** before transformation.  
📎 [View Diagram](docs/Integration_Model.jpg)

---

### 🔄 Data Flow Diagram

Demonstrates the journey of data from the source systems through the **Bronze**, **Silver**, and into the **Gold layer**, ready for analysis.  
📎 [View Diagram](docs/Data%20Flow%20Diagram.jpg)

---

### 📊 Sales Data Mart (Star Schema)

Visual representation of the **Sales Data Mart** modeled as a **Star Schema**, comprising:
- A central **Sales Fact Table**
- Linked **Customers** and **Products** Dimension Tables

![Sales Data Mart](docs/Sales%20Data%20Mart.jpg)

---

### 🗂️ Data Catalog

A comprehensive documentation of the Sales Data Mart tables, including **columns, data types, and descriptions**.  
📎 [View Data Catalog](docs/data_catalog.md)

## 3) Executive Summary

This report provides a high-level overview of VelociMart's sales, profit, and quantity performance trends from 2010 to 2014, highlighting significant growth patterns, seasonal fluctuations, and category performance across the years.

![CRO Dashboard](docs/CRO-Dashboard.jpg)

🔗 [View Interactive Dashboard](https://public.tableau.com/shared/HBWCH3TXQ?:display_count=n&:origin=viz_share_link)

---

### 🧠 Key Takeaways

- **Explosive growth** between 2010 and 2013:
  - Sales grew from **$43.4K (2010)** to **$16.3M (2013)**  
  - Profit increased from **$17.7K (2010)** to **$6.76M (2013)**
  - Units sold rose from **14 (2010)** to **52,226 (2013)**

- **Seasonality played a strong role**, with:
  - **February** consistently being a low-sales month.  
  - **June and December** peaking in both sales and profits.

- **Bikes remained the top-performing category** every year:
  - Leading both in **revenue and profit** outpacing Accessories and Clothing.

## 4) Recommendations

Based on the analysis of historical performance trends, category performance, and seasonal fluctuations, the following actions are recommended to sustain growth and drive better business outcomes:

- **Double down on Bikes category**: With consistently high revenue and profit margins, this category should receive priority in marketing, inventory planning, and supply chain optimization.

- **Capitalize on peak seasons**: Allocate more resources to inventory, campaigns, and customer engagement during high-performing months like **June and December** to maximize sales opportunities.

- **Address February sales slump**: Investigate causes of low performance during February and explore targeted promotions, flash sales, or product bundles to stimulate demand.

- **Leverage Accessories and Clothing**: These categories showed strong secondary performance in 2013. Curated cross-sell strategies (e.g. bundling with bikes) could boost overall order value.
