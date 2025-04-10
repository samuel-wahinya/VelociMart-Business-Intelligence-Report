/*
=========================================================================================================
Script: Date Exploration – Identify Key Date Records
=========================================================================================================
Script Purpose:
      This script explores key date-related insights from dimension and fact tables in the 
      'DataWarehouse' database. It highlights earliest and latest values for:
          - Customer birthdates
          - Product start dates
          - Sales order dates

      This is useful for identifying historical range, detecting data issues, or performing timeline analysis.

Usage Example:
      -- Run this script to see the oldest and youngest customers, first and latest product sales,
         and the earliest and most recent orders placed
=========================================================================================================
*/
USE DataWarehouse;
GO

-- Get the oldest and youngest customers
SELECT 
    first_name,
    last_name,
    birthdate
FROM (
    SELECT
        first_name,
        last_name,
        birthdate,
        MIN(birthdate) OVER() AS oldest_employee,
        MAX(birthdate) OVER() AS youngest_employee
    FROM gold.dim_customers
) t
WHERE birthdate IN (oldest_employee, youngest_employee)
ORDER BY birthdate;
GO

-- Get the first and latest product start dates
SELECT 
    product_name,
    startdate
FROM (
    SELECT 
        product_name,
        start_date AS startdate,
        MIN(start_date) OVER() AS first_product_on_sale,
        MAX(start_date) OVER() AS latest_product_on_sale
    FROM gold.dim_products
) t
WHERE startdate IN (first_product_on_sale, latest_product_on_sale)
ORDER BY startdate;
GO

-- Get the first and latest sales orders with customer and product info
SELECT 
    first_name,
    last_name,
    product_name,
    order_date
FROM (
    SELECT 
        c.first_name,
        c.last_name,
        p.product_name,
        f.order_date,
        MIN(f.order_date) OVER() AS first_order,
        MAX(f.order_date) OVER() AS latest_order
    FROM gold.fact_sales AS f
    INNER JOIN gold.dim_customers AS c ON f.customer_key = c.customer_key
    INNER JOIN gold.dim_products AS p ON f.product_key = p.product_key
) t
WHERE order_date IN (first_order, latest_order)
ORDER BY order_date;
GO
