/*
=========================================================================================================
Script: Ranking Analysis – Product Performance Insights
=========================================================================================================
Script Purpose:
      This script ranks product performance based on revenue and sales volume in the 
      'DataWarehouse' database.

      It provides insights such as:
          - Top 5 revenue-generating products
          - Bottom 5 products with the lowest sales performance

Usage Example:
      -- Use this script to identify high-performing and underperforming products 
         for strategic business decisions like promotions or discontinuation.
=========================================================================================================
*/
USE DataWarehouse;
GO

-- Top 5 products by total revenue
SELECT 
    product_key,
    product_name,
    revenue
FROM (
    SELECT
        f.product_key,
        p.product_name,
        SUM(f.price) AS revenue,
        RANK() OVER (ORDER BY SUM(f.price) DESC) AS rank
    FROM gold.fact_sales AS f
    LEFT JOIN gold.dim_products AS p
        ON f.product_key = p.product_key
    GROUP BY f.product_key, p.product_name
) t
WHERE rank <= 5;
GO

-- Bottom 5 products by total sales amount
SELECT 
    product_key,
    product_name,
    sales
FROM (
    SELECT 
        f.product_key,
        p.product_name,
        SUM(f.sales_amount) AS sales,
        RANK() OVER (ORDER BY SUM(f.sales_amount) ASC) AS rank
    FROM gold.fact_sales AS f
    LEFT JOIN gold.dim_products AS p
        ON f.product_key = p.product_key
    GROUP BY f.product_key, p.product_name
) t
WHERE rank <= 5;
GO
