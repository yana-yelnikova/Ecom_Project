# Ecom Project: Customer Cohort Analysis

This project showcases a modern marketing analytics solution designed to study customer retention. The primary goal is to analyze e-commerce data to understand how long it takes for new customers to make a second purchase and how this behavior varies across different monthly cohorts.

The project demonstrates an end-to-end data pipeline:
* **Ingestion**: E-commerce sales data was ingested from a **GCP Cloud SQL** database using **Fivetran**.
* **Transformation**: The data was transformed and modeled in **Databricks** leveraging **Delta Lake**.
* **Visualization**: Cohort trends were visualized using a **Databricks Dashboard**.

➡️ **[See Detailed Analysis, Conclusions, and Next Steps](./ANALYSIS.md)** ⬅️

---
## 1. Use Case Background

Customer acquisition is expensive, so companies need to understand if new customers are returning to make repeat purchases. A "cohort" is a group of customers defined by a shared characteristic (such as the date of their first purchase). This project aims to answer the central question:

> **How long does it take for customers to make their second purchase, and how does this vary across different cohorts?**

## 2. Tech Stack

* **Data Ingestion**: **Fivetran**
* **Data Source**: **GCP Cloud SQL**
* **Data Transformation & Warehousing**: **Databricks**, **Delta Lake**, **SQL**
* **Data Visualization**: **Databricks Dashboards**

## 3. Project Objectives

The project was broken down into two main objectives:

#### Data Transformation
* Transform raw transactional data into a model optimized for cohort analysis.
* The final table includes each customer’s first and second purchase dates and the time between them.

#### Visualization and Analysis
* Create a Databricks dashboard with three key visualizations to analyze cohort trends:
    1.  **Retention Rate Plot:** Percentage of customers returning within 1, 2, and 3 months.
    2.  **Repeat Purchase Rate Plot:** Percentage of customers making at least a 2nd, 3rd, and 4th purchase.
    3.  **Cohort Size Plot:** The number of new customers acquired each month.

## 4. Data Overview

The analysis is based on a simulated e-commerce sales table named `ecom_orders` with the following schema:

* `customer_id`: Unique identifier for each customer.
* `order_date`: The date the order was placed.
* `order_id`: Unique identifier for each order.
* `sales`: The monetary value of the order.

## 5. Repository Structure and SQL Scripts

This repository is organized as follows:
* `/raw_data`: Contains the source data file(s) used for the analysis.
* `/sql`: Contains all SQL scripts for the data pipeline.
* `/dashboards`: Contains screenshots of the final dashboards.
* `README.md`: Project overview (this file).
* `ANALYSIS.md`: Detailed interpretation of the results and conclusions.

### SQL Scripts Breakdown

#### Data Transformation Scripts
* `01_first_purchase_date.sql`: Calculates each customer’s first purchase date.
* `02_second_purchase_date.sql`: Calculates each customer’s second purchase date.
* `03_combine_and_calculate_days.sql`: Combines results and calculates days between purchases.
* `04_create_cohort_analysis_table.sql`: Saves the final results to a new table `cohort_analysis`.

#### Visualization and Analysis Scripts
* `05_retention_rate_query.sql`: Query for calculating retention rates.
* `06_repeat_purchase_rate_query.sql`: Query for calculating repeat purchase rates.
* `07_cohort_size_query.sql`: Query for calculating cohort size.

## 6. How to Run the Project

1.  **Prerequisites:** Access to a Databricks workspace.
2.  **Data Loading:** Ensure the `ecom_orders` table is available in your database (`workspace.default.ecom_orders`).
3.  **Execute Transformation Scripts:** In a Databricks SQL notebook, execute the scripts from the `/sql` folder sequentially from `01` to `04` to create the base `cohort_analysis` table.
4.  **Execute Analysis Scripts:** Run scripts `05`, `06`, and `07` to generate the data required for the visualizations.
5.  **Create Dashboards:** Use the results of the analysis queries to build the corresponding visualizations on a Databricks dashboard.
