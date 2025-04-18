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
