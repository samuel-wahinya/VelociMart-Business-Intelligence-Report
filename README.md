# Data Warehouse and Analytics Projects

Welcome to the **Data Warehouse and Analytics Project** repository.
This project demonstrates a comprehensive data warehousing and analytics solution, from building a data warehouse to generating actionable insights.

---

## Data Engineering: Building the Data Warehouse

### Project Overview
This project involves building a **modern data warehouse** using **SQL Server** to consolidate sales data from **CRM** and **ERP** sources. The warehouse follows the **Medallion Architecture**, ensuring data quality, transformation, and ease of analytical consumption.

### Data Architecture
![Data Architecture](docs/Data%20Architecture.jpg)

### Database & Schema Creation

Before loading data into the **Data Warehouse**, we first need to create the **database** and **schemas** to support the Medallion Architecture (**Bronze, Silver, Gold Layers**).

### 📜 SQL Script: [`scripts/init_database.sql`](scripts/init_database.sql)
This script:
- Creates the **DataWarehouse** database.
- Defines **three schemas**: `bronze`, `silver`, and `gold` for data segregation.

---

### Data Analytics: BI Analytics & Reporting

#### Objective
Develop SQL based analytics to deliver detailed insights into:
- **Customer Behaviour**
- **Product Performance**
- **Sales Trends**

These insights empower stakeholders with key business metrics, enabling strategic decision making.
