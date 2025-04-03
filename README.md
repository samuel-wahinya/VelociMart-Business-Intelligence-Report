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

📜 SQL Script: [`scripts/init_database.sql`](scripts/init_database.sql)

This script:
- Creates the **DataWarehouse** database.
- Defines **three schemas**: `bronze`, `silver`, and `gold` for data segregation.

### Bronze Layer - Raw Data Tables  

The **Bronze Layer** stores raw data ingested from **CRM** and **ERP** sources. No transformations are performed at this stage.  

📜 SQL Script: [`scripts/bronze/ddl_bronze.sql`](scripts/bronze/ddl_bronze.sql)  

This script:  
- Creates **3 CRM** and **3 ERP** tables in the **bronze schema**.  
- Ensures existing tables are dropped before re-creation.

### Bronze Layer - Data Loading  

The **Bronze Layer** is loaded using a stored procedure that:  
- **Truncates** existing data to avoid duplicates.  
- Uses **BULK INSERT** to load data from **CSV files** into Bronze tables.  
- Logs the start and end times for performance tracking.  
- Implements **error handling** to capture issues during data loading.  

📜 SQL Script: [`scripts/bronze/proc_load_bronze.sql`](scripts/bronze/proc_load_bronze.sql)  

---

### Data Analytics: BI Analytics & Reporting

#### Objective
Develop SQL based analytics to deliver detailed insights into:
- **Customer Behaviour**
- **Product Performance**
- **Sales Trends**

These insights empower stakeholders with key business metrics, enabling strategic decision making.
