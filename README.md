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
* `06_repeat_purchase_rate_query.sql`: Query for calculating repeat purchase rates.
* `07_cohort_size_query.sql`: Query for calculating cohort size.
    

## How to Run the Project

1.  **Databricks Workspace:** Ensure you have access to a Databricks workspace.
2.  **Data Loading:** Make sure the `ecom_orders` table is available in your database (`workspace.default.ecom_orders`). If not, you will need to load or create simulated data.
3.  **Execute SQL Scripts:**
    * Open a new SQL notebook in Databricks.
    * Execute the scripts from the `sql/` folder sequentially, starting from `01_first_purchase_date.sql` and ending with `04_create_cohort_analysis_table.sql` to create the base `cohort_analysis` table.
    * Then, execute scripts `05_retention_rate_query.sql`, `06_repeat_purchase_rate_query.sql`, and `07_cohort_size_query.sql` to generate data for visualizations.
4.  **Create Dashboards:** Use the results of these queries to create corresponding visualizations on your Databricks dashboard, as described in the "Project Objectives" section.

## Conclusions and Next Steps

### Retention Rate by Cohort Conclusions
Based on the "Retention Rate by Cohort" chart and the provided cohort sizes:

* **Highest Retention Rates:**
    * **1 Month:** May 2024 (16 customers) and June 2024 (10 customers) cohorts show 100% retention.
    * **2 Months:** May 2024 (16 customers) and June 2024 (10 customers) cohorts show 100% retention.
    * **3 Months:** March 2024 (33 customers), May 2024 (16 customers), and June 2024 (10 customers) cohorts achieve 100% retention.

* **Notable Differences in Short-Term Retention:**
    * Significant differences are observed. **Earlier cohorts** (January 2024 with 66 customers, February 2024 with 48 customers) demonstrate considerably lower retention rates compared to subsequent months. For instance, 1-month retention in January is around 60%, while in May and June, it reaches 100%.
    * **Later cohorts** (March to June) show a sharp improvement in retention. However, the extremely high (100%) retention rates for the May (16 customers) and June (10 customers) cohorts **might be influenced by their very small size**. This implies that even a small number of repeat purchases can lead to high percentages, or the data for these cohorts might be too recent for the full retention picture to have formed.
 
### Repeat Purchase Rates by Cohort Conclusions

* **Strong Initial Repurchase:** All cohorts show a very high percentage of customers making at least a second purchase (`repeat_rate_2nd_order`), consistently near 95-100%.
* **Natural Decline:** As expected, the percentage of customers making a 3rd and 4th purchase gradually decreases from the initial high, reflecting a natural customer attrition at each subsequent purchase level.
* **Overall Stability:** The repeat purchase rates for the 2nd order remain highly stable across all cohorts. While there are slight variations for 3rd and 4th orders, the overall trend indicates a successful initial re-engagement with customers.

### Cohort Size by Month Conclusions

* **Largest Cohort:** The largest cohort was observed in **January 2024**, with approximately 66 new customers.
* **Decreasing Trend:** There is a **consistent and significant decline** in the number of new customers acquired from January to June 2024.
* **Overall Implication:** The chart clearly indicates a **negative trend in new customer acquisition** during the first half of 2024, leading to progressively smaller subsequent cohorts. This trend is a critical factor impacting overall business growth and should be further investigated.

### Next Steps

Based on the cohort analysis, here are some recommended next steps:

* **Investigate Declining Cohort Size:** Analyze the reasons behind the significant decrease in new customer acquisition from January to June 2024. This could involve examining marketing efforts, seasonality, or external factors.
* **Deep Dive into Early Cohorts' Low Retention:** For cohorts with lower retention rates (e.g., January and February 2024), conduct further analysis to understand why these customers did not return as frequently. This might involve looking at product categories, initial purchase value, or customer source.
* **Validate 100% Retention:** For the latest cohorts (May and June 2024) showing 100% retention, closely monitor their behavior as more time passes to confirm if these high rates are sustainable or an artifact of small cohort sizes/fresh data.
* **Expand Repeat Purchase Analysis:** Explore factors influencing customers to make 3rd and 4th (and beyond) purchases. This could involve segmenting customers by product type, promotional history, or engagement with loyalty programs.
* **Implement A/B Testing:** Based on insights, propose and test different strategies (e.g., onboarding flows, post-purchase communication, personalized offers) to improve both new customer acquisition and long-term retention.
* **Monitor Key Metrics Continuously:** Establish a routine for monitoring these cohort metrics to track the impact of any implemented changes and identify new trends early.
