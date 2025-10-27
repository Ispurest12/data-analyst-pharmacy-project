# data-analyst-pharmacy-project
## Project: Analysis of an inventory and sales in a pharmacy
1. Design a relational database schema (sql)
2. Generate and load 10,000+ synthetic data records
3. Analyse sales and stock patterns using sql complex queries 
4. Create an interactive dashboard in Tableau

## Tools
1. **Data base: ** PostgreSql
2. **Analysis: ** SQL
3. **Visualization: ** Tableau Public
4. **Data Generator: ** Mockroo


## Data Processing (ETL)

1.  **Generation:** Synthetic data was generated using Mockaroo.
2.  **Load:** Data was loaded using psql's `\copy` command.
3.  **Cleaning (Data Cleaning):** During the load phase, several data quality issues were identified and resolved:
    * **Long Text Data:** Altered `nombre_producto` and `categoria` columns from `VARCHAR(100)` to `TEXT` to handle unexpectedly long source data.
    * **Date Format (Datestyle):** Encountered non-standard date formats (`MM/DD/YYYY`). This was resolved by loading data into a temporary `TEXT` column and then using the `to_date()` function to transform it.
    * **Dirty Numerical Data:** Cleaned currency symbols (`$`) from price data using `REPLACE()` and `::DECIMAL` type casting during transformation.
    * **"Not Null" Violations:** Handled `NOT NULL` constraints by temporarily dropping them (`DROP NOT NULL`) during the ETL load and re-applying them (`SET NOT NULL`) post-transformation.