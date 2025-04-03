/*
==================================================================================
Quality Checks
==================================================================================
Script Purpose:
    This script performs quality checks to validate the integrity
    and accuracy of gold layer. These checks ensure:
        - Uniqueness of surrogate keys in dimension tables.
        - Referential integrity between fact and dimension tables.
        - Validation of relationships in the data model for analytical purposes.

Usage Notes:
    - Run these checks after loading data in silver layer.
    - Investigate and resolve any discrepancies found during the checks.
==================================================================================
*/


--==================================================================
-- Check: 'gold.dim_customers'
-- Check for uniqueness of customers in gold.dim_customer
-- Expectation: No Result
--=================================================================
SELECT 
	cst_id,
	COUNT(*) AS [Check Duplicates]
FROM (
	SELECT 
		ci.cst_id,
		ci.cst_key,
		ci.cst_firstname,
		ci.cst_lastname,
		ci.cst_marital_status,
		ci.cst_gndr,
		ci.cst_create_date,
		ca.bdate,
		ca.gen,
		cl.cntry
	FROM silver.crm_cust_info AS ci
	LEFT JOIN silver.erp_cust_az12 AS ca
	ON ci.cst_key = ca.cid
	LEFT JOIN silver.erp_loc_a101 AS cl
	ON ci.cst_key = cl.cid
)t GROUP BY cst_id
HAVING COUNT(*) > 1;

--=================================================================
-- Check: 'gold.dim_products'
-- Check for uniqueness of products in gold.dim_products
-- Expectation: No Result
--=================================================================
SELECT 
	prd_id,
	COUNT(*) AS [Check Duplicates]
FROM(
SELECT 
	pn.prd_id,
	pn.prd_key,
	pn.cat_id,
	pn.prd_nm,
	pn.prd_line,
	pc.cat,
	pc.subcat,
	pc.maintenance,
	pn.prd_start_dt,
	pn.prd_end_dt,
	pn.prd_cost
FROM silver.crm_prd_info AS pn
LEFT JOIN silver.erp_px_cat_g1v2 AS pc
ON pn.cat_id = pc.id
WHERE pn.prd_end_dt IS NULL
)t
GROUP BY prd_id
HAVING COUNT(*) > 1;


--=================================================================
-- Check: 'gold.fact_sales'
-- Check the data model connectivity between facts and dimension
--=================================================================
SELECT *
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c
ON f.customer_key = c.customer_key
LEFT JOIN gold.dim_products AS p
ON f.product_key = p.product_key
WHERE f.customer_key != c.customer_key
	OR f.product_key != p.product_key;
