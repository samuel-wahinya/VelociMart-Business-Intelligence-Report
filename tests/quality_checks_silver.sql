/*
====================================================================================
Quality Checks
====================================================================================
Script Purpose:
    This script performs various quality checks for data consistency,
    accuracy & standardization across the 'silver' schemas. It includes checks for:
          - Null or duplicate primary keys.
          - Unwanted spaces in string fields.
          - Data standardization & consistency.
          - Invalid date ranges & orders.
          - Data consistency between related fields.

Usage Notes:
    - Run these checks after loading data in silver layer.
    - Investigate and resolve any discrepancies found during checks.
====================================================================================
*/

--=========================================================================
-- CRM Tables
--=========================================================================

--=========================================================================
-- crm_cust_info table
--=========================================================================

--=========================================================================
-- Quality Check: Check Duplicates, a primary key must not have duplicates
-- Expectation: No Result
--=========================================================================
SELECT *
FROM (
	SELECT
		cst_id,
		COUNT(*) OVER(PARTITION BY cst_id) AS [Check PK]
	FROM silver.crm_cust_info
)t WHERE [Check PK] > 1 OR cst_id IS NULL;

--===============================================================
-- Quality Check: Check NULLS, a primary key must not have nulls
-- Expectation: No Result
--===============================================================
SELECT
	COUNT(cst_id) AS [Customer ID],
	COUNT(*) AS [Total Customers],
	COUNT(*) - CAST(COUNT(cst_id) AS FLOAT) AS NULLS
FROM silver.crm_cust_info;

--=============================================================
-- Quality Check: check for unwanted spaces in string values
-- -- Expectation: No Result
--=============================================================
SELECT 
	cst_key
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

SELECT 
	cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

SELECT 
	cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);

SELECT 
	cst_marital_status
FROM silver.crm_cust_info
WHERE cst_marital_status != TRIM(cst_marital_status);

SELECT 
	cst_gndr
FROM silver.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr);

--===============================================================================
-- Quality Check: check the consistency of values in low cardinality columns
-- -- Expectation: No Result
--===============================================================================
SELECT 
	DISTINCT cst_marital_status
FROM silver.crm_cust_info;

SELECT 
	DISTINCT cst_gndr
FROM silver.crm_cust_info;


--=========================================================================
-- crm_prd_info table
--=========================================================================

--=========================================================================
-- Quality Check: Check Duplicates, a primary key must not have duplicates
-- Expectation: No Result
--=========================================================================
SELECT *
FROM (
	SELECT
		prd_id,
		COUNT(*) OVER(PARTITION BY prd_id) AS [Check PK]
	FROM silver.crm_prd_info
)t WHERE [Check PK] > 1 OR prd_id IS NULL;

--=============================================================
-- Quality Check: check for unwanted spaces in string values
-- -- Expectation: No Result
--=============================================================
SELECT 
	prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

--=============================================================
--	Quality Check: Check for NULLS or negative numbers
--	Expectation: No Results
--=============================================================
SELECT 
	prd_id,
	prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

--============================================================================
-- Quality Check: check the consistency of values in low cardinality columns
-- Expectation: No Result
--============================================================================
SELECT 
	DISTINCT prd_line
FROM silver.crm_prd_info;

--=============================================================
-- Quality Check: Check for invalid date orders
-- End date must not be earlier than start date
--=============================================================
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;


--=========================================================================
-- crm_sales_details table
--=========================================================================

--=====================================================
-- Quality Check: check for spaces
--=====================================================
SELECT
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	sls_order_dt,
	sls_ship_dt,
	sls_due_dt,
	sls_sales,
	sls_quantity,
	sls_price
FROM silver.crm_sales_details
WHERE sls_ord_num != TRIM(sls_ord_num);

--================================================================
-- Quality Check: Column Integrity 
--Check if the keys exist in the connecting table
--================================================================
SELECT 
	sls_prd_key
FROM silver.crm_sales_details
WHERE sls_prd_key IN (SELECT DISTINCT prd_key FROM silver.crm_prd_info);

--================================================================
-- Quality Check: Column Integrity 
--Check if the keys exist in the connecting table
--================================================================
SELECT 
	sls_cust_id
FROM silver.crm_sales_details
WHERE sls_cust_id IN (SELECT DISTINCT cst_id FROM silver.crm_cust_info);

--================================
-- Quality Check: Invalid Dates
--================================
SELECT 
	sls_order_dt
FROM silver.crm_sales_details
WHERE sls_order_dt <= 0
	OR LEN(sls_order_dt) != 8
	OR sls_order_dt < 20010101
	OR sls_order_dt > 20300101;

--================================
-- Quality Check: Invalid Dates
--================================
SELECT 
	sls_ship_dt
FROM silver.crm_sales_details
WHERE sls_ship_dt <= 0
	OR LEN(sls_ship_dt) != 8
	OR sls_ship_dt < 20010101
	OR sls_ship_dt > 20300101;

--================================
-- Quality Check: Invalid Dates
--================================
SELECT 
	sls_due_dt
FROM silver.crm_sales_details
WHERE sls_due_dt <= 0
	OR LEN(sls_due_dt) != 8
	OR sls_due_dt < 20010101
	OR sls_due_dt > 20300101;

--=========================================================
-- Quality Check: Order Date is less Shipping and Due date
--=========================================================
SELECT *
FROM(
	SELECT 
		CASE 
		WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt) != 8 OR sls_ship_dt < 20010101 OR sls_ship_dt > 20300101 THEN NULL
		ELSE CAST(CAST(sls_ship_dt AS varchar) AS DATE)
	END AS sls_ship_dt,
		CASE 
		WHEN sls_due_dt = 0 OR LEN(sls_due_dt) != 8 OR sls_due_dt < 20010101 OR sls_due_dt > 20300101 THEN NULL
		ELSE CAST(CAST(sls_due_dt AS varchar) AS DATE)
	END AS sls_due_dt,
		CASE 
			WHEN sls_order_dt = 0 OR LEN(sls_order_dt) != 8 OR sls_order_dt < 20010101 OR sls_order_dt > 20300101 THEN NULL
			ELSE CAST(CAST(sls_order_dt AS varchar) AS DATE)
		END AS sls_order_dt
	FROM silver.crm_sales_details
)t WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt;

--=========================================================
-- Quality Check: Shipping Date is less than Due date
--=========================================================
SELECT *
FROM(
	SELECT 
		CASE 
		WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt) != 8 OR sls_ship_dt < 20010101 OR sls_ship_dt > 20300101 THEN NULL
		ELSE CAST(CAST(sls_ship_dt AS varchar) AS DATE)
	END AS sls_ship_dt,
		CASE 
		WHEN sls_due_dt = 0 OR LEN(sls_due_dt) != 8 OR sls_due_dt < 20010101 OR sls_due_dt > 20300101 THEN NULL
		ELSE CAST(CAST(sls_due_dt AS varchar) AS DATE)
	END AS sls_due_dt
	FROM silver.crm_sales_details
)t WHERE sls_ship_dt > sls_due_dt;

--==================================================================
-- Quality Check: Data consistency between sales, quantity and price
-- Sales = Quantity * Price
-- Values must not be null, zero or negative
--==================================================================
SELECT 
	sls_sales,
	sls_quantity,
	sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
	OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
	OR sls_sales <= 0 OR sls_quantity <=0 OR sls_price <=0;


--=========================================================================
-- ERP Tables
--=========================================================================

--=========================================================================
-- erp_cust_az12 table
--=========================================================================

--=========================================
-- Quality Check: Check for spaces
--=========================================
SELECT 
	cid
FROM silver.erp_cust_az12
WHERE cid != TRIM(cid);

--=========================================
-- Quality Check: Check duplicates & nulls
--=========================================
SELECT *
FROM(
	SELECT *,
		COUNT(*) OVER(PARTITION BY cid) AS [Check Pk]
	FROM silver.erp_cust_az12
	WHERE cid IS NULL
)t WHERE [Check Pk] != 1;

--====================================
-- Column Integrity: cid column
--====================================
SELECT 
	SUBSTRING(cid, 4, LEN(cid)) AS cst_key
FROM silver.erp_cust_az12
WHERE CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid)) ELSE cid END NOT IN (SELECT DISTINCT cst_key FROM silver.crm_cust_info);

--==================================================
-- Quality Check: Invalid dates
--=================================================
SELECT 
	CASE
		WHEN bdate > GETDATE() THEN NULL
		ELSE bdate
	END AS bdate
FROM silver.erp_cust_az12
WHERE bdate > GETDATE();

--======================================
-- Data standardization & normalization
--======================================
SELECT DISTINCT
	CASE
		WHEN gen IS NULL THEN 'n/a'
		WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
		WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
		WHEN gen = ' ' THEN 'n/a'
	ELSE gen
	END AS gen
FROM silver.erp_cust_az12;

--=========================================================================
-- erp_cust_az12 table
--=========================================================================

--========================
-- Column Integrity
--========================
SELECT 
	REPLACE(cid, '-', '') AS cid
FROM bronze.erp_loc_a101
WHERE REPLACE(cid, '-', '') NOT IN (SELECT DISTINCT cst_key FROM silver.crm_cust_info);

--=======================================
-- Data Standardization & Normalization
--=======================================
SELECT DISTINCT
	CASE
		WHEN UPPER(TRIM(cntry)) IN ('DE', 'GERMANY') THEN 'Germany'
		WHEN UPPER(TRIM(cntry)) IN ('USA', 'US','UNITED STATES', 'UNITED STATES OF AMERICA') THEN 'United States'
		WHEN UPPER(TRIM(cntry)) IN ('AU', 'AUSTRALIA') THEN 'Australia'
		WHEN UPPER(TRIM(cntry)) IN ('UK', 'UNITED KINGDOM') THEN 'United Kingdom'
		WHEN UPPER(TRIM(cntry)) IN ('CA', 'CANADA') THEN 'Canada'
		WHEN UPPER(TRIM(cntry)) IN ('FR', 'FRANCE') THEN 'France'
		WHEN UPPER(TRIM(cntry)) IS NULL OR  UPPER(TRIM(cntry)) = ' ' THEN 'n/a'
	ELSE TRIM(cntry)
	END AS cntry
FROM bronze.erp_loc_a101; 

--=========================================================================
-- erp_px_cat_g1v2 table
--=========================================================================

--=================================
-- Check if Keys match
--=================================
SELECT
	id
FROM silver.erp_px_cat_g1v2
WHERE id NOT IN (SELECT DISTINCT cat_id FROM silver.crm_prd_info);

--=================================
-- Check for empty spaces
--=================================
SELECT
	cat
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat);

--=================================
-- Check for low cardinality
--=================================
SELECT DISTINCT
	cat
FROM silver.erp_px_cat_g1v2;

--=================================
-- Check for empty spaces
--=================================
SELECT
	subcat
FROM silver.erp_px_cat_g1v2
WHERE subcat != TRIM(subcat);

--=================================
-- Check for low cardinality
--=================================
SELECT DISTINCT
	subcat
FROM silver.erp_px_cat_g1v2;

--=================================
-- Check for low cardinality
--=================================
SELECT DISTINCT
	maintenance
FROM silver.erp_px_cat_g1v2;
