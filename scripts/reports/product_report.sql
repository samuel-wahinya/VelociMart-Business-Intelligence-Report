/*
=========================================================================================================
Script: Product Report View – gold.report_products
=========================================================================================================

Purpose:
    Consolidates product-related data into a detailed report for analytics and business decisions.

Features:
    1. Combines product metadata (name, category, subcategory, cost) with sales performance data.
    2. Segments products by total revenue:
        - High Performer: > 1,000,000
        - Mid Range: > 100,000
        - Low Performer: <= 100,000
    3. Aggregates product-level metrics:
        - Total orders
        - Total sales
        - Total quantity sold
        - Total unique customers
        - Lifespan (active months)
    4. Calculates KPIs for product performance:
        - Recency (months since last sale)
        - Average revenue per order
        - Average monthly revenue

Usage:
    Suitable for dashboards, performance tracking, and strategic planning.
=========================================================================================================
*/
USE DataWarehouse;
GO

-- Drop view if it already exists
IF OBJECT_ID('gold.report_products', 'V') IS NOT NULL
    DROP VIEW gold.report_products;
GO

-- Create product report view
CREATE VIEW gold.report_products AS
WITH base_query AS (
    --===============================================
    -- 1) Base Query: Join sales and product details
    --===============================================
    SELECT 
        p.product_key,
        p.product_number,
        p.product_name,
        p.product_line,
        p.category,
        p.subcategory,
        p.cost,
        f.order_number,
        f.customer_key,
        f.order_date,
        f.sales_amount,
        f.quantity,
        f.price
    FROM gold.fact_sales AS f
    LEFT JOIN gold.dim_products AS p
        ON f.product_key = p.product_key
    WHERE f.order_date IS NOT NULL
),
product_aggregation AS (
    --=======================================================
    -- 2) Aggregation: Summarize product-level performance
    --=======================================================
    SELECT 
        product_key,
        product_number,
        product_name,
        product_line,
        category,
        subcategory,
        cost,
        COUNT(DISTINCT order_number) AS total_orders,
        SUM(quantity) AS total_quantity,
        SUM(price) AS total_price,
        SUM(sales_amount) AS total_sales,
        COUNT(DISTINCT customer_key) AS total_customers,
        MAX(order_date) AS last_sale_date,
        COUNT(DISTINCT DATETRUNC(MONTH, order_date)) AS month_history
    FROM base_query
    GROUP BY 
        product_key, product_number, product_name, product_line,
        category, subcategory, cost
)
--=======================================================
-- 3) Final Output: Add product segment and KPI metrics
--=======================================================
SELECT 
    product_key,
    product_number,
    product_name,
    product_line,
    category,
    subcategory,
    cost,
    total_orders,
    total_sales,
    
    -- Product Segmentation based on total sales
    CASE
        WHEN total_sales > 1000000 THEN 'High Performer'
        WHEN total_sales > 100000 THEN 'Mid Range'
        ELSE 'Low Performer'
    END AS product_segment,

    total_quantity,
    total_customers,
    total_sales / NULLIF(total_orders, 0) AS avg_order_revenue,
    total_sales / NULLIF(month_history, 0) AS avg_monthly_revenue,
    last_sale_date,
    DATEDIFF(MONTH, last_sale_date, GETDATE()) AS month_since_last_sale,
    month_history;
