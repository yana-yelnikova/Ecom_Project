# Ecom Project: Customer Cohort Analysis

## Project Overview

This project focuses on cohort analysis of e-commerce data using Databricks SQL. The main goal is to understand customer behavior after their first purchase, specifically how long it takes for a second purchase and how this varies across different customer cohorts.

## Use Case Background

Customer acquisition is expensive, so companies need to understand if new customers are returning to make repeat purchases. A "cohort" is a group of customers defined by a shared characteristic (such as the date of their first purchase). This project aims to answer the central question: How long does it take for customers to make their second purchase, and how does this vary across different cohorts?

## Data (Overview of the Sample Data)

This project simulates an e-commerce sales dataset using a table named `ecom_orders`. This table represents transactional data and includes the following columns:

* `customer_id`: A unique identifier for each customer.
* `order_date`: The date when the order was placed.
* `order_id`: A unique identifier for each order.
* `row_id`: A unique numeric identifier for each row.
* `sales`: The monetary amount of the sale for that order.

## Project Objectives

### 1. Data Transformation

Transform the raw `ecom_orders` data into a new table optimized for cohort analysis, which includes:

* Each customer’s first purchase date.
* Each customer’s second purchase date (if any).
* The number of days between the first and second purchases.

### 2. Visualization and Analysis

Create three key visualizations on a Databricks dashboard for analyzing cohort trends:

* **Retention Rate Plot:** Showing, for each cohort, the percentage of customers who placed a second order within 1, 2, and 3 months after their first purchase.
* **Repeat Purchase Rate Plot:** Showing, for each cohort, the percentage of customers who placed at least a 2nd, 3rd, and 4th order.
* **Cohort Size Plot:** Showing the number of new customers (by their first purchase month) in each cohort.

## Implementation Steps

### 1. Data Transformation (SQL Scripts)

All SQL queries for data transformation are located in the `sql/` folder.

* `01_first_purchase_date.sql`: Calculates each customer’s first purchase date.
* `02_second_purchase_date.sql`: Calculates each customer’s second purchase date.
* `03_combine_and_calculate_days.sql`: Combines results and calculates days between purchases.
* `04_create_cohort_analysis_table.sql`: Saves the final results to a new table `cohort_analysis`.

### 2. Visualization and Analysis (SQL Scripts and Screenshots)

SQL queries for creating visualizations are also located in the `sql/` folder. Dashboard screenshots can be found in the `dashboards/` folder.

* `05_retention_rate_query.sql`: Query for calculating retention rates.
    [Изображение дашборда с коэффициентом удержания]
* `06_repeat_purchase_rate_query.sql`: Query for calculating repeat purchase rates.
    [Изображение дашборда с коэффициентом повторных покупок]
* `07_cohort_size_query.sql`: Query for calculating cohort size.
    [Изображение дашборда с размером когорты]

## How to Run the Project

1.  **Databricks Workspace:** Ensure you have access to a Databricks workspace.
2.  **Data Loading:** Make sure the `ecom_orders` table is available in your database (`workspace.default.ecom_orders`). If not, you will need to load or create simulated data.
3.  **Execute SQL Scripts:**
    * Open a new SQL notebook in Databricks.
    * Execute the scripts from the `sql/` folder sequentially, starting from `01_first_purchase_date.sql` and ending with `04_create_cohort_analysis_table.sql` to create the base `cohort_analysis` table.
    * Then, execute scripts `05_retention_rate_query.sql`, `06_repeat_purchase_rate_query.sql`, and `07_cohort_size_query.sql` to generate data for visualizations.
4.  **Create Dashboards:** Use the results of these queries to create corresponding visualizations on your Databricks dashboard, as described in the "Project Objectives" section.
