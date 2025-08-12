# 🎮 Netflix Cloud Data Warehouse And Analysis Project
![Project Badge](https://img.shields.io/badge/Project-Streaming%20Content%20Analytics-brightgreen)
![Cloud Badge](https://img.shields.io/badge/Cloud-GCP%20Cloud%20Storage-blue)
![Data Warehouse Badge](https://img.shields.io/badge/Data%20Warehouse-Snowflake-lightblue)
![Transformation Badge](https://img.shields.io/badge/Transformation-dbt-orange)
![ETL Badge](https://img.shields.io/badge/ETL%20Automation-Python-yellow)
![SCD Badge](https://img.shields.io/badge/Data%20Modeling-SCD%20Type%202-red)
![SQL Badge](https://img.shields.io/badge/Querying-BigQuery%20SQL%20%7C%20AWS%20Athena-yellowgreen)
![Visualization Badge](https://img.shields.io/badge/Dashboarding-Tableau-ff69b4)
![Dataset Badge](https://img.shields.io/badge/Data-5M%2B%20Records-lightgrey)
![Domain Badge](https://img.shields.io/badge/Domain-Streaming%20Platform%20Analytics-purple)


<img width="1431" height="546" alt="netflix-snowflake-dbt" src="https://github.com/user-attachments/assets/0586c109-1e9f-4fa0-95cf-362abed2d9ff" />


> A full-scale ELT pipeline replicating how platforms like Netflix process, transform, and analyze massive user interaction data using **GCP**, **Snowflake**, and **dbt** — designed with production-level standards, automation, and data governance best practices.

---

## 🎮 Introduction

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
| 📜 Logging        | dbt.log           | Tracks pipeline execution and errors for CI/CD compatibility              |
| 🧪 Data Quality   | dbt Tests         | Enforces rules for null values, uniqueness, and referential relationships |
| 📖 Documentation  | dbt Docs          | Auto-generates model lineage and descriptions for full transparency       |

---

## 🧱 Architecture Overview

We adopted a **medallion architecture**, layered as follows:

### 🧹 Bronze Layer ("As-Is" Layer)

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

   * MovieLens data is first uploaded to a GCP Cloud Storage bucket.
   * These CSVs are not transformed and serve as the source of truth.
   * Organizing data centrally in the cloud enables scalability and portability.

2. **External Stage Integration (Secure)**

   * Snowflake connects to the GCP bucket via a `STORAGE INTEGRATION` object.
   * This enables secure, access-controlled ingestion from external cloud storage.
   * We used `FILE_FORMAT` objects to configure how CSVs are interpreted.

3. **Bronze Layer - Raw Backup**

   * Data is ingested **as-is** into Snowflake using raw models.
   * This layer preserves original structure and values.
   * Useful for auditing, disaster recovery, rollback scenarios, or reprocessing.

4. **Silver Layer - Data Transformation**

   * dbt staging (`stg_`) models perform standardization:

     * Column names are made lowercase and snake\_case.
     * Timestamps and numeric formats are standardized.
     * Nulls and duplicates are handled upfront.
   * This creates clean, consistent, and validated inputs for dimensional models.

5. **Data Enrichment**

   * Missing values like movie release dates are patched using `seed` data.
   * This enhances completeness and enables lifecycle-based analytics.

6. **Snapshotting with SCD Type 2**

   * `snap_tags` model implements snapshot logic using dbt.
   * Tracks historical evolution of user tagging behavior over time.
   * Allows longitudinal analysis by comparing how tags have changed.

7. **Gold Layer - Fact & Dimensional Models**

   * Final models like `fct_ratings`, `fct_genome_scores`, and `dim_movies` are created.
   * Built from staging data + business logic for analytical queries.
   * These are materialized as tables for fast dashboard performance.

8. **Mart Layer**

   * Example: `mart_movie_releases` is built on top of dimensions and facts.
   * Contains derived KPIs like viewer activity post-release.
   * Designed for consumption in BI tools.

9. **Documentation Generation**

   * `dbt docs generate` builds a browsable site with:

     * Column-level metadata
     * Data flow lineage
     * Test summaries
   * Helps onboard team members and track model evolution.

10. **Logging with dbt.log**

    * Every `dbt run`, `test`, `snapshot` is logged.
    * Captures model status, errors, and timings.
    * Crucial for debugging, CI/CD pipeline monitoring, and audits.

11. **Testing & CI Readiness**

    * dbt tests added for each model:

      * **Not null tests**: Essential columns like IDs and timestamps
      * **Unique tests**: Avoids duplication in identifiers
      * **Relationship tests**: Ensures referential integrity
    * Acts as a CI system — broken models fail early with error messages.

---

## 🧪 Testing & Validation

We applied automated data quality checks with dbt tests:

* **Check for Null Values**: Ensures key fields are populated (e.g., `user_id`, `rating`, `movie_id`)
* **Unique Value Checks**: Verifies uniqueness of entity IDs (e.g., `user_id`, `movie_id`)
* **Column-Level Relationships**: Validates proper joins between fact and dimension tables
* **Snapshot Audits**: Confirms changes in tag history only get recorded when actual change occurs

These reduce data quality risks, improve confidence, and enforce integrity.

---

## 📂 Documentation & Logging

### 📒 Auto-Generated Documentation

* Used `dbt docs generate` to create browsable documentation
* Includes:

  * Column-level descriptions
  * Upstream/downstream model flow
  * Test summaries and freshness metadata

### 📜 Logging with `dbt.log`

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
