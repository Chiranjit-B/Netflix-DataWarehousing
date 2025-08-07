# 🎮 Netflix-Style Cloud Data Warehouse Project

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

* **Check for Null Values**: Ensures key fields are populated (e.g., `user_id`, `rating`, `movie_id`)
* **Unique Value Checks**: Verifies uniqueness of entity IDs (e.g., `user_id`, `movie_id`)
* **Column-Level Relationships**: Validates proper joins between fact and dimension tables
* **Snapshot Audits**: Confirms changes in tag history only get recorded when actual change occurs

These reduce data quality risks, improve confidence, and enforce integrity.

---

## 🗂️ Documentation & Logging
<img width="1431" height="546" alt="netflix-snowflake-dbt" src="https://github.com/user-attachments/assets/1106eaa5-84ac-4d67-969a-7ed6bc086b40" />

### 🗒️ Auto-Generated Documentation

* Used `dbt docs generate` to create browsable documentation
* Includes:

  * Column-level descriptions
  * Upstream/downstream model flow
  * Test summaries and freshness metadata

### 📋 Logging with `dbt.log`

* All `dbt run`, `dbt test`, `dbt snapshot` actions logged
* Used for:

  * Debugging during development
  * Governance and audit trails
  * CI/CD observability and pipeline failure analysis

---

## ✅ Best Practices

This project follows industry-grade engineering principles:

* ✅ **Cloud-native pipeline**: Scalable, serverless ingestion from GCP to Snowflake
* ✅ **Modular dbt models**: Organized by layers (staging → intermediate → marts)
* ✅ **SCD Type 2 for change tracking**: Preserves tag history for temporal analysis
* ✅ **Schema protection**: `on_schema_change: fail` avoids breaking changes
* ✅ **Null, uniqueness, and relationship checks**: Catch upstream issues fast
* ✅ **Version-controlled development**: Git integration for dbt project
* ✅ **Auto-documentation**: Full transparency with model lineage and logic
* ✅ **Logging and observability**: Every transformation is logged for governance
* ✅ **Dimensional modeling**: Enables performant analytics at scale
* ✅ **Medallion architecture**: Logical data layers ensure clarity, reusability, and control
* ✅ **Raw backups retained**: Enables rollback, root-cause analysis, and disaster readiness
