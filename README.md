# data-analyst-pharmacy-project
## Project: Analysis of an inventory and sales in a pharmacy
1. Design a relational database schema (sql)
2. Generate and load 10,000+ synthetic data records
3. Analyse sales and stock patterns using sql complex queries 
4. Create an interactive dashboard in Tableau

## Tools
1. **Database: ** PostgreSql
2. **Analysis: ** SQL
3. **Visualization: ** Tableau Public
4. **Data Generator: ** Mockaroo

## Project Structure

    ├── database/
    │   ├── schema.sql       
    │   ├──── analisis.sql
        └── etl_y_limpieza.sql 
    ├── exports/
    │   ├── q1_top_10_selling.csv
        │── q2_revenue_by_category
    │   ├── q3_expiring_soon.csv
    │   ├── q4_monthly_sales_trend.csv
    │   ├── q5_inventory_value_by_supplier.csv
    │   └── q6_least_10_selling.csv
    └── README.md            

## Data Processing (ETL)

1.  **Generation:** Synthetic data was generated using Mockaroo.
2.  **Load:** Data was loaded using psql's `\copy` command.
3.  **Cleaning (Data Cleaning):** During the load phase, several data quality issues were identified and resolved:
    * **Long Text Data:** Altered `nombre_producto` and `categoria` columns from `VARCHAR(100)` to `TEXT` to handle unexpectedly long source data.
    * **Date Format (Datestyle):** Encountered non-standard date formats (`MM/DD/YYYY`). This was resolved by loading data into a temporary `TEXT` column and then using the `to_date()` function to transform it.
    * **Dirty Numerical Data:** Cleaned currency symbols (`$`) from price data using `REPLACE()` and `::DECIMAL` type casting during transformation.
    * **"Not Null" Violations:** Handled `NOT NULL` constraints by temporarily dropping them (`DROP NOT NULL`) during the ETL load and re-applying them (`SET NOT NULL`) post-transformation.




## Analysis & Visualization (SQL & Tableau)

The final analysis was conducted using complex SQL queries (saved in the `database/analisis.sql` file) to generate key insights. The results of these queries were exported as CSVs and visualized in Tableau.

###  dashboards
**You can view the final interactive dashboard here:**
[**View Interactive Dashboard on Tableau Public**](https://public.tableau.com/app/profile/roberto.moreno.mendoza/viz/PharmacySalesInventoryDashboard/InventoryDashboard)


### Key Insights Found
* **Top Performers:** The `q1_top_10_selling.csv` analysis revealed that "Loratadine" is the highest-selling product by quantity.
* **Zero-Sales Products:** The `q6_least_10_selling.csv` analysis (using `LEFT JOIN` and `COALESCE`) identified several products that had zero (0) sales, representing a clear opportunity for inventory reduction.
* **At-Risk Inventory:** The `q3_expiring_soon.csv` report built a watchlist of products expiring within 60 days, allowing for proactive sales or returns.
* **Sales Trend:** The `q4_monthly_sales_trend.csv` line chart shows a clear seasonal peak in sales during [January] and [April].
* **Inventory Value Concentration:** The `q5_inventory_value_by_supplier` pie chart revealed that the majority of inventory value is concentrated with just a few key suppliers, highlighting critical supplier dependencies.
* **Category Omission:** The analysis for `q2_revenue_by_category` was intentionally omitted. Upon inspection, the source data in the `categoria` column was found to be low-quality and unreliable, making any category-level analysis misleading.


## Local Setup & Replication

To replicate this project on your local machine, follow these steps:

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/Ispurest12/data-analyst-pharmacy-project.git](https://github.com/Ispurest12/data-analyst-pharmacy-project.git)
    cd data-analyst-pharmacy-project
    ```

2.  **Database Setup:**
    * Install PostgreSQL on your machine.
    * Open the `psql` shell and create the database:
      ```sql
      CREATE DATABASE farmacia_db;
      ```
    * Connect to your new database:
      ```
      \c farmacia_db
      ```
    * Run the schema script to create the tables:
      ```
      \i 'path/to/your/repo/database/schema.sql'
      ```

3.  **Data Generation (Manual Step):**
    * The raw data for this project was generated using Mockaroo and is not included in this repository.
    * To load your own data, generate CSVs (following the schema) and use the `\copy` command as detailed in the `Data Processing (ETL)` section.

4.  **Run Analysis & Visualization:**
    * The SQL queries used for the final analysis are available in `database/analisis.sql`.
    * The pre-exported CSV results are available in the `/exports` folder.
    * Open the CSV files in Tableau Public to interact with the final visualizations.