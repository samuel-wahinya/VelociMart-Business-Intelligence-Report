/*
=========================================================================================================
Script: Customer Report View – gold.report_customer
=========================================================================================================

Purpose:
    Consolidates customer-centric data into a unified, analytics-ready view.

Features:
    1. Combines customer demographics and transactional behavior.
    2. Segments customers into:
        - Age groups (e.g., 20–29, 30–39, etc.)
        - Customer segments (VIP, Regular, New) based on spend and history.
    3. Aggregates customer-level performance metrics:
        - Total orders
        - Total sales
        - Total quantity purchased
        - Total unique products purchased
        - Total active months (lifespan)
    4. Calculates key customer KPIs:
        - Recency (months since last order)
        - Average order value
        - Average monthly spend

Usage:
    Ideal for use in dashboards, segmentation reports, retention tracking, and targeted marketing.
=========================================================================================================
*/
USE DataWarehouse;
GO

-- Drop existing view if it exists
IF OBJECT_ID('gold.report_customer', 'V') IS NOT NULL
    DROP VIEW gold.report_customer;
GO

-- Create customer report view
CREATE VIEW gold.report_customer AS
WITH base_query AS (
    --===================================================
    -- 1) Base Query: Retrieve core columns from tables
    --===================================================
    SELECT 
        f.order_number,
        f.product_key,
        f.order_date,
        f.sales_amount,
        f.quantity,
        c.customer_key,
        c.customer_number,
        CONCAT(c.first_name, ' ', c.last_name) AS full_name,
        DATEDIFF(YEAR, c.birthdate, GETDATE()) AS age
    FROM gold.fact_sales AS f
    LEFT JOIN gold.dim_customers AS c
        ON f.customer_key = c.customer_key
    WHERE order_date IS NOT NULL
),
customer_aggregation AS (
    --====================================================================
    -- 2) Customer aggregations: summarizes key metrics at customer level
    --====================================================================
    SELECT 
        customer_key,
        customer_number,
        full_name,
        age,
        COUNT(DISTINCT order_number) AS total_orders,
        SUM(sales_amount) AS total_sales,
        SUM(quantity) AS total_quantity,
        COUNT(DISTINCT product_key) AS total_products,
        COUNT(DISTINCT DATETRUNC(MONTH, order_date)) AS month_history,
        MAX(order_date) AS last_order_date
    FROM base_query
    GROUP BY customer_key, customer_number, full_name, age
)
--===================================================
-- 3) Final Output: Add segments and calculated KPIs
--===================================================
SELECT 
    customer_key,
    customer_number,
    full_name,
    age,
    -- Age Grouping
    CASE
        WHEN age <= 20 THEN 'Below 20'
        WHEN age BETWEEN 21 AND 29 THEN '20 - 29'
        WHEN age BETWEEN 30 AND 39 THEN '30 - 39'
        WHEN age BETWEEN 40 AND 49 THEN '40 - 49'
        WHEN age >= 50 THEN 'Above 50'
    END AS age_group,
  
    -- Customer Segmentation
    CASE
        WHEN month_history >= 12 AND total_sales > 5000 THEN 'VIP'
        WHEN month_history >= 12 AND total_sales <= 5000 THEN 'Regular'
        ELSE 'New'
    END AS cust_segment,
  
    total_orders,
    last_order_date,
    DATEDIFF(MONTH, last_order_date, GETDATE()) AS month_since_last_order,
    total_sales / NULLIF(total_orders, 0) AS avg_order_value,
    total_sales,
    total_sales / NULLIF(month_history, 0) AS avg_monthly_spend,
    total_quantity,
    total_products,
    month_history;
