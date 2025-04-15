/*
======================================================================================================
Script Name:       Sales Report View - `report_sales`
======================================================================================================
Purpose:
    - This report provides a comprehensive view of sales, quantity, and profit.
    - Designed for KPI tracking, trend analysis, and product performance monitoring.

Features:
    1. Calculates total sales, profit, and quantity.
    2. Computes cost using cost × quantity logic.
    3. Groups data by order-level granularity for deeper granularity.
    4. Joins fact and dimension tables to enrich the data.
    5. Enables downstream visualizations: Monthly & Weekly Trends, Subcategory Comparison.

Usage:
    - Used as a base table for KPI Dashboards and Trend Analysis Reports.
======================================================================================================
*/

USE DataWarehouse;
GO

-- Drop the view if it already exists to avoid conflict
IF OBJECT_ID('gold.report_sales', 'V') IS NOT NULL
    DROP VIEW gold.report_sales;
GO

-- Create the sales report view
CREATE VIEW gold.report_sales AS

-- ===================================================
-- Base Query: Join fact_sales with dim_products
-- ===================================================
WITH base_query AS (
    SELECT 
        f.order_number,           -- Unique order identifier
        f.sales_amount,           -- Sales amount per line
        f.quantity,               -- Number of units sold
        p.subcategory,            -- Product subcategory
        p.cost,                   -- Unit cost from product table
        f.order_date              -- Date of the order
    FROM gold.fact_sales AS f
    LEFT JOIN gold.dim_products AS p
        ON f.product_key = p.product_key
)

-- ===================================================
-- Final Select: Calculate KPIs and group by order
-- ===================================================
SELECT 
    order_number,
    sales_amount,
    quantity,
    subcategory,
    cost,
    order_date,

    -- Total sales across all records in the order
    SUM(sales_amount) AS total_sales,

    -- Total quantity sold in the order
    SUM(quantity) AS total_quantity,

    -- Total cost (cost × quantity)
    cost * quantity AS total_cost,

    -- Profit = Total sales - Total cost
    SUM(sales_amount) - SUM(cost * quantity) AS total_profit

FROM base_query
GROUP BY 
    order_number, 
    sales_amount, 
    quantity, 
    subcategory, 
    cost, 
    order_date;
GO
