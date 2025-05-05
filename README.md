# Data Modeling for Analytics (Star Schema & OBT) on AWS RDS

## Project Overview

This project demonstrates the implementation of two common analytical data modeling patterns – the Star Schema and the One Big Table (OBT) – using dbt (Data Build Tool) Core. The transformations are executed directly within a cloud-based relational database (PostgreSQL on AWS RDS), leveraging the database engine for processing. The project utilizes the classic `classicmodels` sample dataset and includes data quality tests to ensure the integrity of the final models.

The primary goal is to showcase a practical dbt workflow for transforming source data into structured, reliable, and analytics-ready datasets suitable for downstream consumption (e.g., BI tools, ML models).

## Objectives

* Demonstrate the setup and configuration of a dbt Core project targeting PostgreSQL on AWS RDS.
* Implement a Star Schema model, including fact and dimension tables with surrogate keys.
* Implement a denormalized One Big Table (OBT) model.
* Utilize dbt's SQL and Jinja templating for model development.
* Leverage dbt packages (`dbt_utils`, `dbt_date`) for common functions like surrogate key generation and date dimension creation.
* Define and execute data quality tests using dbt's `schema.yml` functionality.
* Compare the structure and potential use cases of Star Schema vs. OBT models.
* Illustrate the concept of in-database transformation using dbt.

## Architecture & Workflow

1.  **Source Data:** The `classicmodels` sample dataset is assumed to be pre-loaded into a `classicmodels` schema within an AWS RDS PostgreSQL instance.
2.  **dbt Connection:** dbt Core connects to the RDS instance using connection details specified in `profiles.yml`.
3.  **Transformation:** dbt compiles the SQL+Jinja models defined in the `/models` directory into standard SQL queries.
4.  **Execution:** `dbt run` sends the compiled SQL queries to the AWS RDS PostgreSQL instance. The database engine executes these queries, performing joins, aggregations, and other transformations.
5.  **Materialization:** The results are materialized as new tables within dedicated schemas (`classicmodels_star_schema`, `classicmodels_obt`) in the *same* RDS instance.
6.  **Testing:** `dbt test` runs SQL queries (defined in `schema.yml`) against the materialized tables in RDS to validate data quality.

### Source Data Schema (ERD)

The source `classicmodels` database schema is based on the standard MySQL sample database:

![ClassicModels ERD](images/erm.png)
*(Note: Ensure 'erm.png' from the lab notebook is present in an 'images' subdirectory for this link to work)*

## Technologies Used

* **Data Transformation:** dbt Core
* **Database:** PostgreSQL (hosted on AWS RDS)
* **Language:** SQL, Jinja, YAML, Python (for notebook environment)
* **Cloud Platform:** Amazon Web Services (AWS) - specifically RDS
* **dbt Packages:** `dbt-utils`, `dbt-date`

## dbt Project Structure
classicmodels_modeling/
├── dbt_project.yml     # Main dbt project configuration
├── models/             # Contains SQL models
│   ├── obt/            # Models for One Big Table
│   │   ├── orders_obt.sql
│   │   └── schema.yml
│   └── star_schema/    # Models for Star Schema
│       ├── dim_customers.sql
│       ├── dim_dates.sql
│       ├── dim_employees.sql
│       ├── dim_offices.sql
│       ├── dim_products.sql
│       ├── fact_orders.sql
│       ├── dates.sql      # Helper model for date dimension
│       └── schema.yml
├── packages.yml        # Declares dbt package dependencies
└── profiles.yml        # (Typically in ~/.dbt/, contains connection profiles - included in scripts/ for lab)


## Models Implemented

### 1. Star Schema (`classicmodels_star_schema`)

A classic dimensional model optimized for BI and reporting:

* **Fact Table:** `fact_orders` (granularity: order line item)
* **Dimension Tables:**
    * `dim_customers`
    * `dim_employees`
    * `dim_offices`
    * `dim_products` (joins `products` and `productlines`)
    * `dim_dates` (generated using `dbt_date`)
* **Features:** Uses surrogate keys generated via `dbt_utils.generate_surrogate_key`.

### 2. One Big Table (OBT) (`classicmodels_obt`)

A denormalized table joining relevant information for potentially simpler querying:

* **Table:** `orders_obt`
* **Features:** Contains dimension attributes directly within the table, created via multiple joins from the source tables.

## Data Quality & Testing

Data tests were defined in the `schema.yml` files for both the Star Schema and OBT models to ensure data integrity. Tests included:

* `unique`: Ensure primary key uniqueness.
* `not_null`: Ensure key columns are populated.
* `dbt_utils.unique_combination_of_columns`: Ensure composite primary keys are unique (used for `orders_obt`).

Tests are executed using the `dbt test` command.

## Setup & Usage

To run this dbt project:

1.  **Prerequisites:**
    * dbt Core installed (`pip install dbt-postgres`).
    * Access to a PostgreSQL database (e.g., on AWS RDS).
    * The `classicmodels` sample dataset loaded into a schema named `classicmodels` within the target database.
2.  **Configuration:**
    * Clone this repository.
    * Configure your dbt profile (`~/.dbt/profiles.yml` or using environment variables) with the connection details for your PostgreSQL database. A sample `profiles.yml` structure (as used in the source lab) is provided in `scripts/profiles.yml` - **ensure you replace placeholders with your actual credentials and endpoint**.
3.  **Install Dependencies:**
    ```bash
    cd classicmodels_modeling
    dbt deps
    ```
4.  **Run Models:**
    * To run only the Star Schema models:
        ```bash
        dbt run --select star_schema
        # Or use shorthand: dbt run -s star_schema
        ```
    * To run only the OBT models:
        ```bash
        dbt run --select obt
        # Or use shorthand: dbt run -s obt
        ```
    * To run all models:
        ```bash
        dbt run
        ```
5.  **Run Tests:**
    * To run tests on Star Schema models:
        ```bash
        dbt test --select star_schema
        # Or use shorthand: dbt test -s star_schema
        ```
    * To run tests on OBT models:
        ```bash
        dbt test --select obt
        # Or use shorthand: dbt test -s obt
        ```
    * To run all tests:
        ```bash
        dbt test
        ```

## Discussion: Star Schema vs. OBT Trade-offs

This project allowed for a practical comparison of these modeling approaches:

* **Star Schema:** Generally provides a more normalized, maintainable structure, often requiring less storage. It's conceptually clear for BI tools and analysts familiar with dimensional modeling. Queries typically involve joins between fact and dimension tables.
* **One Big Table (OBT):** Denormalization can simplify certain analytical queries by pre-joining data, potentially leading to faster query performance for specific use cases as fewer joins are needed at query time. However, OBTs can become very wide, potentially require more storage space, and updates can be more complex as data is duplicated.

The choice between them depends heavily on specific query patterns, downstream tooling, data volume, update frequency, and team familiarity.

## Conclusion

This project successfully demonstrates the use of dbt Core to implement, test, and manage data trans
