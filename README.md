# 🎮 Netflix-Style Cloud Data Warehouse Project
<img width="1431" height="546" alt="netflix-snowflake-dbt" src="https://github.com/user-attachments/assets/bbe07c2b-a4e0-46c7-8e0a-1977118e0887" />

> A full-scale ELT pipeline replicating how platforms like Netflix process, transform, and analyze massive user interaction data using **GCP**, **Snowflake**, and **dbt** — designed with production-level standards, automation, and data governance best practices.

---

## 🎬 Introduction

Ever wondered how platforms like Netflix turn billions of user interactions into data-driven content strategies?

This project recreates that analytics engine with a cloud-native data warehouse built with **GCP**, **Snowflake**, and **dbt**, designed to deliver real-time insights into user engagement, content trends, and subscription behavior — all with a production-grade ELT stack.

---

## 🎯 Project Objectives

* Simulate a scalable Netflix-style pipeline using cloud tools
* Load raw data from GCP to Snowflake using external stages
* Design dimensional models to support analytics
* Apply best practices like schema protection, SCD Type 2, and dbt testing
* Enable visualization-ready, governed data layers

---

## ⚙️ Tech Stack

| Layer             | Tool              | Description                                                               |
| ----------------- | ----------------- | ------------------------------------------------------------------------- |
| ☁️ Cloud Storage  | GCP Cloud Storage | Stores raw CSVs in a scalable bucket                                      |
| ❄️ Data Warehouse | Snowflake         | Cloud-native, high-performance warehouse                                  |
| 🔄 ELT Engine     | dbt               | Handles modeling, testing, documentation, and snapshots                   |
| 📋 Logging        | dbt.log           | Tracks pipeline execution and errors for CI/CD compatibility              |
| 🧪 Data Quality   | dbt Tests         | Enforces rules for null values, uniqueness, and referential relationships |
| 📖 Documentation  | dbt Docs          | Auto-generates model lineage and descriptions for full transparency       |

---

## 🧭 Architecture Overview

We adopted a **medallion architecture**, layered as follows:

### 🤹 Bronze Layer ("As-Is" Layer)

* Raw data ingested from GCP Cloud Storage
* Materialized in Snowflake as backup tables for disaster recovery, auditability, and traceability

### 🥈 Silver Layer ("Transformed" Layer)

* Data cleaned and standardized via dbt staging models
* Timestamps unified, columns renamed, types cast
* Nulls and duplicates handled

### 🥇 Gold Layer ("Final BI-ready" Layer)

* Dimensional star schema
* Business logic applied (e.g. calculated fields)
* Fact and dimension tables prepared for analytics tools

---

## 📊 Business Use Cases

This warehouse supports:

* Viewer behavior analysis post-content release
* Genre trends segmented by location or time
* Subscription behavior linked with engagement levels
* Timeline analysis of user interactions

---

## 🧱 Dimensional Modeling

We use a **star schema** with cleanly separated dimensions and facts:

### Dimension Tables:

* `dim_movies`: Cleaned movie metadata
* `dim_users`: Unique users from ratings/tags
* `dim_genome_tags`: Processed genome tag data
* `dim_movies_with_tags`: Ephemeral join of tags + movies

### Fact Tables:

* `fct_ratings`: Tracks user ratings
* `fct_genome_scores`: Relevance of tags to movies

These tables allow performant joins and business-friendly queries.

---

## 🔄 Step-by-step Workflow

This project follows a modular and automated ELT workflow:

1. **Raw Data Ingestion from GCP**

   * CSVs from MovieLens datasets uploaded to a GCP bucket
   * Acts as a centralized, cloud-native data lake

2. **Secure External Stage Integration in Snowflake**

   * Snowflake stage connects to GCP via `STORAGE INTEGRATION`
   * Enables secure, governed ingestion of cloud-stored data

3. **Raw Backup Layer (Bronze)**

   * All CSVs are loaded into Snowflake raw tables without transformations
   * These act as a snapshot layer for disaster recovery, rollback, and data lineage

4. **Data Transformation (Silver Layer)**

   * dbt `stg_` models rename columns, cast types, and standardize data
   * Time formats, null handling, and consistent naming ensure downstream compatibility

5. **Data Enrichment**

   * Seed datasets (like release dates) enhance movie metadata
   * Helps build features like post-release viewer timelines

6. **Snapshotting (SCD Type 2)**

   * Tags applied by users change over time
   * `snap_tags` snapshot model records history with `dbt snapshot` and a `timestamp` check

7. **Fact & Dimension Modeling (Gold Layer)**

   * Final analytical models (`dim_`, `fct_`) built using business logic
   * Used for metrics like viewer engagement, tag evolution, and genre trends

8. **Mart Layer**

   * Example: `mart_movie_releases` with derived KPIs used in reporting

---

## 🧪 Testing & Validation

We applied automated data quality checks with dbt tests:

* **Null Value Checks**: Ensures required fields (user\_id, movie\_id, rating) are populated
* **Uniqueness**: Primary keys like `user_id`, `movie_id` are enforced to be unique
* **Referential Integrity**: Ensures foreign keys match between fact and dimension tables
* **Snapshot Validation**: Verifies new snapshot rows only appear when real tag data changes

These help eliminate silent pipeline failures, improve trust, and support reliable reporting.

---

## 🗂️ Documentation & Logging

### 🗒️ Auto-Generated Documentation

* `dbt docs generate` builds interactive docs
* Includes:

  * Table and column descriptions
  * Data lineage and model dependencies
  * Pass/fail status of tests

### 📋 Centralized Logging

* All operations (run, test, snapshot) are logged in `dbt.log`
* Logs assist in:

  * Troubleshooting unexpected behavior
  * Auditing pipeline runs for compliance
  * Building CI/CD workflows that monitor log outputs

---

## ✅ Best Practices

* ✅ Used GCP–Snowflake external stage for secure, decoupled ingestion
* ✅ Created materialized raw backups for disaster recovery (Bronze Layer)
* ✅ Separated logic into modular layers (staging, intermediate, final)
* ✅ Implemented SCD Type 2 for temporal tag tracking
* ✅ Protected models using `on_schema_change: fail`
* ✅ Ran automated tests: nulls, uniqueness, relationships
* ✅ Documented everything via dbt docs
* ✅ Logged everything via dbt.log for traceability and CI/CD readiness

---

Want to explore the models or try it out? Reach out or fork the project!

🔗 GitHub: [https://github.com/Chiranjit-B/Netflix-DataWarehousing](https://github.com/Chiranjit-B/Netflix-DataWarehousing)
