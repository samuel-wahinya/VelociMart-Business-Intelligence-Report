/*
=========================================================================================================
Script: Measures Exploration – Key Business Metrics Overview
=========================================================================================================
Script Purpose:
      This script generates a summarized report of essential business metrics from the 
      'DataWarehouse' database. It retrieves high-level KPIs from sales, customers, and products 
      across the 'gold' schema.

      Measures included:
          - Total Sales
          - Total Quantity Sold
          - Average Price
          - Total Orders
          - Total Products
          - Total Customers
          - Total Customers With Orders

Usage Example:
      -- Run this script to get a snapshot of the business performance across various dimensions
=========================================================================================================
*/
USE DataWarehouse;
GO

-- Generate a report that shows all key metrics of the business
SELECT 
    'Total Sales' AS measure_name,
    SUM(sales_amount) AS measure_value
FROM gold.fact_sales

UNION ALL

SELECT 
    'Total Quantity' AS measure_name,
    SUM(quantity) AS measure_value
FROM gold.fact_sales

UNION ALL

SELECT 
    'Average Price' AS measure_name,
    AVG(price) AS measure_value
FROM gold.fact_sales

UNION ALL

SELECT 
    'Total Orders' AS measure_name,
    COUNT(DISTINCT order_number) AS measure_value
FROM gold.fact_sales

UNION ALL

SELECT 
    'Total Products' AS measure_name,
    COUNT(DISTINCT product_id) AS measure_value
FROM gold.dim_products

UNION ALL

SELECT 
    'Total Customers' AS measure_name,
    COUNT(customer_id) AS measure_value
FROM gold.dim_customers

UNION ALL

SELECT 
    'Total Customers With Orders' AS measure_name,
    COUNT(*) AS measure_value
FROM gold.dim_customers
WHERE customer_id IN (
    SELECT customer_id FROM gold.fact_sales
);
GO
