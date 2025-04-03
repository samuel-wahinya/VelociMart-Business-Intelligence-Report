# Data Dictionary for Gold Layer

## Overview

The Gold Layer is the business-level data representation, structured to support analytical and reporting use cases. It consists of **dimension tables** and **fact tables** for specific business metrics.

---

## 1. gold.dim_customers

- **Purpose:** stores customer details enriched with demographic and geographic data.
- **Columns:**

| Column Name     | Data Type    | Description                                                                         |
| --------------- | ------------ | ----------------------------------------------------------------------------------- |
| customer_key    | INT          | Surrogate key uniquely identifying each customer record in the dimension table.     |
| customer_id     | INT          | Unique numerical identifier assigned to each customer.                              |
| customer_number | NVARCHAR(50) | Alphanumeric identifier representing the customer, used for tracking and reference. |
| first_name      | NVARCHAR(50) | The customer's first name.                                                          |
| last_name       | NVARCHAR(50) | The customer's last name.                                                           |
| country         | NVARCHAR(50) | The country of residence for the customer (e.g., '*Australia*').                    |
| marital_status  | NVARCHAR(50) | The marital status of the customer (e.g., '*Married*', '*Single*').                 |
| gender          | NVARCHAR(50) | The gender of customer (e.g., '*Male*', '*Female*', '*n/a*').                       |
| birthdate       | DATE         | The date of birth of customer, formatted as YYYY-MM-DD (e.g., _1971-10-06_)         |
| create_date     | DATE         | The date and time when customer record was created in the system.                   |
