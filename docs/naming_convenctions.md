# Table Naming Conventions

1) ## Bronze & Silver layer 

All names must start with source system name and table names must match their original names without renaming.

* **\<sourcesystem\>\_\<entity\>**  
  * **\<sourcesystem\>** \- name of the source system e.g. (crm, erp).  
  * **\<entity\>** \- exact table name from source system.  
* Example *crm\_customer\_info*; customer information from crm system.

2) ## Gold layer 

All names must use meaningful, business-aligned names for tables, starting with category prefix.

* **\<category\>\_\<entity\>**  
  * **\<category\>** \- describes the role of table such as dim (dimension) or fact (fact table) or agg (aggregated table).  
  * **\<entity\>** \- descriptive name of table, aligned with the business domain (e.g. customers, products, sales).  
* Examples:  
  * **dim\_customers** – dimension table for customer data.  
  * **fact\_sales** – fact table containing sales transaction.  
  * **agg\_sales\_monthly** – aggregation table containing monthly sales.

# Column Naming Conventions

## Surrogate Keys 

All primary keys in the dimension table must use the ***suffix \_key***.

* **\<table\_name\>\_key:**  
  * **\<table\_name\>** \- refers to the name of the table or entity the key belongs to.  
  * **\_key** – a suffix indicating that this column is a surrogate key.  
* Example:  
  * **customer\_key** – surrogate key in the dim\_customers table.

## Technical columns 

All technical columns must start with prefix dwh\_ followed by a descriptive name indicating the column’s purpose.

* **dwh\_\<column\_name\>**   
  * **dwh** – prefix exclusively for system generated metadata.  
  * **\<column\_name\>** \- descriptive name indicating the column’s purpose.  
* **Example:**  
  * **dwh\_load\_state** – system generated column used to store the date when record was loaded.

# Stored Procedure

All stored procedure used for loading data must follow the naming pattern:

* **load\_\<layer\>**  
  * **\<layer\>** \- represents the layer being loaded such as bronze, silver or gold.  
* Example:  
  * **load\_bronze** – stored procedure for loading data into bronze layer.  
  * **load\_silve**r \- stored procedure for loading data into silver layer.
