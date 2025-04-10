/*
=========================================================================================================
Script: Dimension Exploration – View Unique Values in Key Dimension Columns
=========================================================================================================
Script Purpose:
      This script is used to explore distinct values from key columns in dimension tables within
      the 'gold' schema of the 'DataWarehouse' database.
      It helps in understanding the categorical diversity of customer and product attributes.

      Tables and columns explored:
          - gold.dim_customers: country, marital_status, gender
          - gold.dim_products: product_name, product_line, category, subcategory, maintenance

Usage Example:
      -- Run this script to get a sense of the values stored in dimension fields for analysis or validation
=========================================================================================================
*/
USE DataWarehouse;
GO

-- Explore distinct values in dim_customers
SELECT DISTINCT country
FROM gold.dim_customers;
GO

SELECT DISTINCT marital_status
FROM gold.dim_customers;
GO

SELECT DISTINCT gender
FROM gold.dim_customers;
GO

-- Explore distinct values in dim_products
SELECT DISTINCT product_name
FROM gold.dim_products;
GO

SELECT DISTINCT product_line
FROM gold.dim_products;
GO

SELECT DISTINCT category
FROM gold.dim_products;
GO

SELECT DISTINCT subcategory
FROM gold.dim_products;
GO

SELECT DISTINCT maintenance
FROM gold.dim_products;
GO
