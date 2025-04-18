/*
=========================================================================================================
Script: Magnitude Analysis – Distribution & Contribution Analysis
=========================================================================================================
Script Purpose:
      This script analyzes the distribution and magnitude of key metrics across customer 
      and product dimensions in the 'DataWarehouse' database.

      It answers questions like:
          - Where are most customers located?
          - What gender dominates the customer base?
          - Which product categories generate the most revenue?
          - Who are the top contributing customers?

Usage Example:
      -- Use this script to explore patterns in volume and value across countries, genders,
         product categories, and customer segments
=========================================================================================================
*/

USE DataWarehouse;
GO
  
-- Find the total customers by country
SELECT 
    country,
    COUNT(*) AS total_customers
FROM gold.dim_customers
GROUP BY country
ORDER BY total_customers DESC;
GO
  
-- Find the total customers by gender
SELECT
    gender,
    COUNT(*) AS total_customers
FROM gold.dim_customers
GROUP BY gender
ORDER BY total_customers DESC;
GO
  
-- Find total products by category
SELECT 
    category,
    COUNT(*) AS total_products
FROM gold.dim_products
GROUP BY category
ORDER BY total_products DESC;
GO
  
-- Average cost in each product category
SELECT
    category,
    AVG(cost) AS average_cost
FROM gold.dim_products
GROUP BY category
ORDER BY average_cost DESC;
GO
  
-- Total revenue generated by each category
SELECT
    p.category,
    SUM(f.price) AS total_revenue
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products AS p
    ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY total_revenue DESC;
GO
  
-- Total revenue generated by each customer
SELECT 
    c.customer_key,
    c.first_name,
    c.last_name,
    SUM(f.price) AS total_revenue
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c
    ON f.customer_key = c.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY total_revenue DESC;
GO
  
-- Distribution of sold items across countries
SELECT 
    c.country,
    SUM(f.quantity) AS quantity
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c
    ON f.customer_key = c.customer_key
GROUP BY c.country
ORDER BY quantity DESC;
GO
