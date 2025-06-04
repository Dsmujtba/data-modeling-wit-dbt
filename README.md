# Advanced Data Modeling for Analytics with dbt & PostgreSQL on AWS RDS

This project showcases my ability to design, implement, and rigorously test sophisticated analytical data models using dbt (Data Build Tool) Core. I engineered a solution to transform the `classicmodels` relational dataset, hosted on PostgreSQL in AWS RDS, into two distinct, analytics-ready structures: a best-practice Star Schema and a denormalized One Big Table (OBT). My goal was to master dbt's powerful transformation capabilities and apply data modeling principles in a cloud environment.

## Key Achievements & Skills Demonstrated:

* **dbt Core Mastery & End-to-End Workflow:**
    * Successfully configured and managed a dbt Core project from initial setup and source connection (AWS RDS PostgreSQL) through to model development, materialization, and comprehensive testing.
    * Demonstrated a full dbt lifecycle including `dbt run` for model execution, `dbt test` for data validation, and `dbt deps` for package management.
* **Advanced Data Modeling Implementation:**
    * **Star Schema Design:** Architected and built a robust Star Schema, including:
        * `fact_orders` table at the order line item granularity.
        * Dimension tables (`dim_customers`, `dim_employees`, `dim_offices`, `dim_products`, `dim_dates`).
        * Systematically generated **surrogate keys** using the `dbt_utils.generate_surrogate_key` macro, ensuring stable dimensional relationships.
        * Created a comprehensive `dim_dates` table using the `dbt-date` package for flexible time-based analysis.
    * **One Big Table (OBT) Construction:** Developed a denormalized `orders_obt` by strategically pre-joining multiple source tables, optimized for specific analytical use cases.
* **Sophisticated Transformation Logic with SQL & Jinja:**
    * Authored modular and maintainable dbt models using advanced SQL combined with **Jinja templating** for dynamic queries, reusable logic (e.g., macros, `ref`, `source` functions), and efficient development.
* **Rigorous Data Quality Assurance:**
    * Implemented a comprehensive testing strategy by defining **data quality tests** in `schema.yml` files.
    * Leveraged built-in dbt tests (`unique`, `not_null`, `accepted_values`, `relationships`) and dbt-utils macros (e.g., `dbt_utils.unique_combination_of_columns`) to validate primary keys, foreign key relationships, column constraints, and business rules.
* **In-Database Transformation Orchestration:**
    * Effectively utilized dbt to orchestrate all data transformations directly within the AWS RDS PostgreSQL database, leveraging its processing power and ensuring data remained within a secure cloud environment.
* **Cloud Data Warehousing on AWS:**
    * Gained practical experience working with **PostgreSQL on AWS RDS** as a target data warehouse for dbt transformations.
* **Analysis of Modeling Trade-offs:**
    * Developed a practical understanding of the structural differences, benefits, and drawbacks between Star Schema and OBT modeling approaches, enabling informed decisions for future projects.

## Implemented Data Models:

### 1. Star Schema (`classicmodels_star_schema`)

I designed this dimensional model for optimal business intelligence and reporting performance. It features:
* **Central Fact Table:** `fact_orders` (capturing order line item details).
* **Conforming Dimensions:** `dim_customers`, `dim_employees`, `dim_offices`, `dim_products`, and `dim_dates`.
* **Key Techniques:** Employed dbt's `ref` function for inter-model dependencies, `dbt_utils.generate_surrogate_key` for robust primary keys in dimensions, and `dbt-date.get_date_dimension` for a comprehensive date dimension.

### 2. One Big Table (OBT) (`classicmodels_obt`)

To cater to specific analytical queries that benefit from pre-joined data, I constructed the `orders_obt`.
* **Denormalized Structure:** This table combines data from `orders`, `orderdetails`, `products`, `productlines`, `customers`, and `employees`.
* **Purpose:** Designed to simplify query writing for certain use cases and potentially improve performance by reducing complex joins at query time.

## Data Quality & Testing: A Core Focus

Ensuring data reliability was paramount. I leveraged dbt's testing framework extensively:
* **Schema Tests (`schema.yml`):** Defined tests directly alongside model schema definitions.
    * **Uniqueness:** Validated primary keys in all dimension and fact tables (e.g., `customer_sk` in `dim_customers`).
    * **Non-Null Constraints:** Ensured critical attributes (e.g., foreign keys in fact tables, key business identifiers) were always populated.
    * **Referential Integrity:** Used `relationships` tests to confirm that foreign keys in fact tables correctly referenced primary keys in dimension tables.
    * **Custom Logic (via `dbt_utils`):** Employed `dbt_utils.unique_combination_of_columns` for composite key validation in the OBT.
* **Execution:** All tests were executed via `dbt test`, providing immediate feedback on data integrity after model runs.

## Technologies Leveraged:

* **Data Transformation & Modeling:** dbt Core
* **Programming Languages & Templating:** SQL, Jinja, YAML (for dbt configurations)
* **Database:** PostgreSQL (hosted on AWS RDS)
* **Cloud Platform:** Amazon Web Services (AWS)
* **dbt Packages:** `dbt-utils`, `dbt-date`
* **Version Control:** Git & GitHub
* **Development Environment:** Standard Command Line (for dbt execution), (Optionally mention: VS Code with dbt extensions, Jupyter Notebook for exploration/lab guidance)

---
