/*
=========================================================================================================
Script: Database Exploration – View Tables and Columns
=========================================================================================================
Script Purpose:
      This script provides an overview of the database schema within the 'DataWarehouse' database.
      It performs the following actions:
          - Switches context to the 'DataWarehouse' database.
          - Lists all tables available in the database.
          - Lists all columns for each table in the database.

Usage Example:
      -- Run this script to explore tables and their columns in 'DataWarehouse'
=========================================================================================================
*/
USE DataWarehouse;
GO;

SELECT * 
FROM INFORMATION_SCHEMA.TABLES;
GO;

SELECT * 
FROM INFORMATION_SCHEMA.COLUMNS;
GO;
