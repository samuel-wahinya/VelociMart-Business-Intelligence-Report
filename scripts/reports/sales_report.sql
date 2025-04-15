/*
======================================================================================================
Sales Performance Report
======================================================================================================
Purpose:
    - This report provides a comprehensive overview of sales, profits, and quantity sold.

Sections:
1. KPI Overview:
    - Displays total sales, profits, and quantity sold for the current and previous year.

2. Sales Trends:
    - Shows monthly KPI trends for both current and previous years.
    - Highlights highest and lowest sales months for quick visual insights.

3. Product Subcategory Comparison:
    - Compares sales and profit performance across subcategories for the current and previous year.

4. Weekly Trends:
    - Presents weekly sales and profit data for the current year.
    - Calculates weekly averages.
    - Highlights weeks with above/below-average performance.
======================================================================================================
*/
CREATE VIEW report_sales AS
WITH base_query AS (
    SELECT 
        f.order_number,
        f.sales_amount,
        f.quantity,
        p.subcategory,
        p.cost,
        f.order_date
    FROM gold.fact_sales AS f
    LEFT JOIN gold.dim_products AS p
        ON f.product_key = p.product_key
)
SELECT 
    order_number,
    sales_amount,
    quantity,
    subcategory,
    cost,
    order_date,
    SUM(sales_amount) AS total_sales,
    SUM(quantity) AS total_quantity,
    cost * quantity AS total_cost,
    SUM(sales_amount) - SUM(cost * quantity) AS total_profit
FROM base_query
GROUP BY 
    order_number, 
    sales_amount, 
    quantity, 
    subcategory, 
    cost, 
    order_date;
