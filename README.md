# Netflix-DataWarehousing
# 🎬 Netflix-Style Cloud Data Warehouse Project
<img width="1431" height="546" alt="netflix-snowflake-dbt" src="https://github.com/user-attachments/assets/04798255-32f6-4a16-b8e7-e043bfe98f20" />

> A full-scale ELT pipeline replicating how platforms like Netflix process, transform, and analyze massive user interaction data using **GCP**, **Snowflake**, and **dbt** — designed with production-level standards and automation.

---

## 🌟 Project Overview

This project simulates a real-world streaming platform's data architecture, focusing on:

* 🚀 Scalable ingestion
* 🧹 Robust cleaning & transformation
* 📊 BI-ready dimensional modeling
* 🕵️‍♂️ Change tracking with SCD logic
* 📋 Automated testing & documentation
* 📁 Centralized logging for governance

The result? A modular, secure, and analytics-ready cloud data warehouse that supports advanced content and subscription insights.

---

## 🎯 Project Objectives

* Load raw MovieLens data from **GCP Cloud Storage** into Snowflake
* Clean, standardize, and enrich datasets for analytical readiness
* Implement a dimensional model to support Netflix-style analysis
* Track historical changes in user behavior
* Automate testing, logging, and documentation for reliability

---

## ⚙️ Tech Stack

| Layer             | Tool              | Purpose                                      |
| ----------------- | ----------------- | -------------------------------------------- |
| ☁️ Cloud Storage  | GCP Cloud Storage | Stores raw CSVs                              |
| ❄️ Data Warehouse | Snowflake         | Scalable, cloud-native warehousing           |
| 📦 Modeling       | dbt               | ELT, testing, snapshots, docs                |
| 📋 Logging        | dbt.log           | Audit trails, debugging, CI/CD compatibility |
| 🔍 Docs           | dbt docs          | Auto-generated model & lineage documentation |
| 🧪 Validation     | dbt tests         | Data quality enforcement                     |

---

## 🧭 Architecture Overview

1. **GCP Cloud Storage** hosts raw movie, user, and rating datasets
2. **Snowflake External Stage** ingests data into staging tables
3. **Staging Models (dbt)** clean column names, types, timestamps
4. **Dimensional Models**:

   * Users
   * Movies
   * Tags
5. **Fact Tables**:

   * Ratings
   * Genome Scores
6. **Snapshots** track changes in user tagging over time (SCD Type 2)
7. **Seed Data** fills in missing release dates
8. **Mart Layer** produces business-facing models (e.g. timeline metrics)
9. **Tests & Docs** ensure reliability and transparency

---

## 📊 Key Use Cases Enabled

* Analyze genre performance by geography
* Track user engagement by subscription tier
* Study user tagging behavior over time
* Identify high-rated or heavily watched content
* Assess trends post-release using enriched release data

---

## 🛠️ Detailed Workflow Breakdown

### 1️⃣ Ingestion from GCP to Snowflake

* Raw CSV files are uploaded to a GCP Cloud Storage bucket.
* A Snowflake **external stage** is used to securely ingest this raw data.
* dbt staging models are created to define the schema and perform basic normalization.

### 2️⃣ Raw Backup Layer

* Instead of transient staging, raw data is loaded into materialized tables in Snowflake.
* This layer serves as a **backup for disaster recovery**, audit trails, and traceability.

### 3️⃣ Staging and Standardization

* dbt models in `models/staging/` clean the column names and formats.
* UNIX timestamps are converted into human-readable Snowflake timestamps.
* All columns are standardized for naming consistency and datatype compatibility.

### 4️⃣ Dimensional Modeling

* Designed star schema with `dim_movies`, `dim_users`, `dim_genome_tags`, etc.
* Modular, scalable structure to support BI queries.
* Joins and transformations are optimized for performance.

### 5️⃣ Fact Tables

* `fct_ratings` and `fct_genome_scores` contain core metrics.
* Incremental loads and filters are applied (e.g., removing scores <= 0).
* `on_schema_change: fail` ensures that breaking changes are caught early.

### 6️⃣ Snapshotting for Change Tracking (SCD Type 2)

* dbt snapshots are used to record evolving user tagging behavior over time.
* This allows historical tracking for advanced behavior trend analysis.

### 7️⃣ Enrichment Using Seed Data

* A curated CSV seed (`seed_movie_release_dates.csv`) is used to enrich missing fields like release dates.
* Allows analysis like **user engagement timelines post-release**.

### 8️⃣ Mart Layer

* A final business-facing model `mart_movie_releases` is created.
* This model combines facts and dimensions to power analytics-ready queries.

---

## 🧪 Data Testing Strategy

* Used dbt **tests** to ensure reliability and trust in data:

  * ✅ **Null value checks**: No critical fields are missing
  * ✅ **Uniqueness tests**: IDs and keys must be unique
  * ✅ **Column-level relationships**: Foreign keys match across tables (e.g., ratings → movies)

---

## 📋 Documentation and Logging

* 📄 **Auto-Generated Docs**:

  * `dbt docs generate` produces model-level and column-level documentation.
  * Lineage graphs help new users understand the data flow.

* 📑 **Logging with dbt.log**:

  * Captures all transformation steps, test results, and errors.
  * Useful for:

    * ✅ Debugging
    * ✅ Audits
    * ✅ CI/CD integration

---

## 💼 Business Value Delivered

* 🎯 Enabled exploratory analysis around **content strategy** and **viewer behavior**
* 📈 Delivered BI-ready datasets that can plug into Power BI, Looker, etc.
* 🛡️ Built a secure, modular, and scalable data warehouse
* 📚 Improved team collaboration with auto-generated documentation and testing

---

## 🧭 How to Run This Project

### ✅ Prerequisites

* Python & dbt installed locally or via virtual environment
* Snowflake account with access credentials
* GCP bucket with MovieLens CSV files

### 🚀 Setup Steps

```bash
# Clone the repo
$ git clone https://github.com/Chiranjit-B/Netflix-DataWarehousing.git
$ cd Netflix-DataWarehousing

# Install dependencies
$ pip install dbt-core dbt-snowflake

# Set up dbt profile (~/.dbt/profiles.yml)
# Run the models
$ dbt run

# Test the models
$ dbt test

# Generate documentation
$ dbt docs generate
$ dbt docs serve
---

## 🙌 Final Thoughts

This project reflects a production-grade analytics engineering stack that supports traceable, automated, and analytics-ready pipelines — modeled after how companies like **Netflix** turn raw data into strategy.

Feel free to ⭐ the repo or connect with me for data engineering discussions!
