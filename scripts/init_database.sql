/*
=========================================================================
Create Database and Schemas
=========================================================================

Script Purpose: 
      This script creates a new database named 'DataWarehouse' after checking if it already exists. 
      If the database exists, it is dropped and recreated. Additionally the script sets up 3 schemas
      within the database: 'bronze', 'silver', 'gold'.

WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists.
    All the data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

--Switch to master database
USE master;
GO

--Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
  ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DataWarehouse;
END;
GO
  
--Create database 'DataWarehouse'
CREATE DATABASE DataWarehouse;
GO

--Switch to DataWarehouse
USE DataWarehouse;
GO

--Create bronze schema
CREATE SCHEMA bronze;
GO

--Create silver schema
CREATE SCHEMA silver;
GO

--Create gold schema
CREATE SCHEMA gold;
GO
