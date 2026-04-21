
# BrightTV Viewership Analytics 📺

## Problem Statement

* BrightTV aims to **grow its subscription base** within the current financial year.
* The CEO requested **data-driven insights** to support Customer Value Management (CVM) strategies.
* Two datasets were provided:

  * Viewership transactions (user activity)
  * User profiles (demographics)
* The challenge was to **analyze user behavior and identify actionable opportunities** to increase engagement and subscriptions.

---

## Aim of the Project

* To analyze user and viewership data in order to:

  * Identify **usage trends and viewing patterns**
  * Understand **factors influencing content consumption**
  * Recommend **content strategies for low-traffic periods**
  * Propose **initiatives to grow and retain the subscriber base**

---

## Objectives (Steps Taken to Achieve the Aim)

* **Data Ingestion & Preparation**

  * Loaded datasets into Databricks
  * Joined tables using `UserID`
  * Converted timestamps from UTC to **South African Standard Time (SAST)**

* **Data Cleaning & Transformation**

  * Removed ghost sessions (<30 seconds)
  * Replaced "None" values with **"Unknown"**
  * Standardized age into **six demographic bands**

* **Exploratory Data Analysis (EDA)**

  * Analyzed:

    * Daily, weekly, and monthly trends
    * Hour-of-day and day-of-week usage
    * Channel popularity
    * Demographic breakdowns (gender, race, age, province)

* **Data Visualization**

  * Exported results to Excel
  * Built **pivot tables and charts** for storytelling

* **Insight Generation**

  * Identified:

    * Peak viewing periods (Afternoon & Evening)
    * Low engagement days (Mondays)
    * High-performing content (Live sports)
    * Demographic and geographic imbalances

* **Strategic Recommendations**

  * Target inactive users with re-engagement campaigns
  * Increase female audience participation
  * Expand engagement in underperforming provinces
  * Retain high-value subscribers with loyalty strategies

---

## Tools Used

* **Databricks** – Data processing, SQL queries, and transformations
* **Databricks SQL** – Exploratory data analysis
* **Microsoft Excel** – Data visualization (pivot tables & charts)
* **SQL** – Data querying and aggregation
* **Miro** – Process mapping and workflow visualization
* **Powerpoint** - Project Presentation

---
