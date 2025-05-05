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
