# 🎮 Netflix-Style Cloud Data Warehouse Project
<img width="1431" height="546" alt="netflix-snowflake-dbt" src="https://github.com/user-attachments/assets/04798255-32f6-4a16-b8e7-e043bfe98f20" />

> A full-scale ELT pipeline replicating how platforms like Netflix process, transform, and analyze massive user interaction data using **GCP**, **Snowflake**, and **dbt** — designed with production-level standards, automation, and data governance best practices.

---

## 🎬 Netflix-Style Data Warehouse Project

Ever wondered how platforms like Netflix transform massive user data into strategic content decisions?

I built a **cloud-native analytics pipeline** using **GCP Cloud Storage**, **Snowflake**, and **dbt** that mimics Netflix's core data stack — turning raw interactions into clean, governed, and business-ready insights.

---

## 🎯 Project Objectives

* Simulate a **production-grade ELT pipeline** using cloud-native tools.
* Enable Netflix-style **analytics use cases** (e.g., content popularity, user engagement).
* Apply **dimensional modeling**, **medallion architecture**, and **SCD Type 2** logic.
* Automate data testing, documentation, and CI/CD-friendly logging.
* Showcase **best practices** in modularity, validation, and data governance.

---

## ⚙️ Tech Stack

| Tool              | Purpose                                       |
| ----------------- | --------------------------------------------- |
| GCP Cloud Storage | Raw data storage (CSV ingestion layer)        |
| Snowflake         | Scalable, columnar data warehouse             |
| dbt               | ELT engine for transformation, tests, docs    |
| dbt.log           | Tracks every model run, failure, and error    |
| dbt docs          | Auto-generates data lineage and documentation |

---

## 🧭 Architecture Overview (Medallion Design)

This project adopts a **medallion architecture** with clearly separated layers:

### 🟤 Bronze – Raw Layer

* Data is ingested *as-is* from GCP Storage into Snowflake.
* Materialized into raw backup tables (`MOVIELENS.RAW`) for traceability and rollback.
* Good Practice: Ensures reproducibility and disaster recovery readiness.

### ⚪ Silver – Transformed Layer

* Raw data is cleaned in dbt staging models:

  * Renamed columns (e.g., `userId → user_id`)
  * Casted datatypes (e.g., timestamps converted)
  * Handled NULLs and duplicates
* Follows **standardization** and **normalization** protocols.

### 🟡 Gold – Analytics Layer

* Final fact and dimension models, joined in **star schema** format:

  * Fact Tables: `fct_ratings`, `fct_genome_scores`
  * Dimension Tables: `dim_movies`, `dim_users`, `dim_genome_tags`, `dim_movies_with_tags`
* Good Practice: Modular modeling supports scalable, fast querying.

---

## 📊 Business Use Cases Enabled

* 🎯 Top-performing genres by location
* 📅 Viewer behavior over time and post-release trends
* 🔖 Tag relevance scoring for content profiling
* 👤 User-level interaction and behavioral segmentation
* 📈 Popularity trends using movie ratings and genome tag scores

---

## 🔄 ELT Workflow Breakdown

### 1️⃣ Ingestion from GCP → Snowflake

* GCP CSVs are ingested securely using a **Snowflake External Stage**.
* dbt materializes raw models like `src_ratings`, `src_tags`, etc.

### 2️⃣ Cleaning in Staging Layer

* Each `src_` model (e.g., `src_movies`) is transformed in `stg_` models:

  * Columns renamed
  * Timestamp formats unified
  * Invalid/missing values filtered
* Good Practice: dbt staging keeps transformations modular and testable.

### 3️⃣ Dimensional Modeling (Star Schema)

* Fact models:

  * `fct_ratings`: Stores user→movie→rating interactions (incremental model).
  * `fct_genome_scores`: Relevance scores between tags and movies.
* Dimension models:

  * `dim_movies`: Explodes genres and formats movie titles.
  * `dim_users`: Union of distinct users from `ratings` and `tags`.
  * `dim_genome_tags`: Cleaned list of tags from `src_genome_tags`.
  * `dim_movies_with_tags`: Ephemeral join model for exploration.

### 4️⃣ Historical Change Tracking – SCD Type 2

* Snapshot model (`snap_tags.sql`) tracks changes in user-tag behavior over time.
* Good Practice: Enables temporal comparisons and longitudinal analysis.

### 5️⃣ Enrichment with Seed Data

* Added release dates from a `seed_movie_release_dates` file to enhance insights around timing and engagement.

---

## 🧪 Testing & Validation

dbt **data tests** were implemented to enforce data integrity:

✅ No nulls in required fields
✅ Unique primary keys
✅ Column-level relationships (e.g., `movie_id` exists across related tables)

---

## 📚 Documentation & Logging

### 🗂️ Documentation

* Used `dbt docs generate` to create **interactive lineage docs**.
* Covers source → staging → models → tests.

### 🪵 Logging

* All transformation runs and test outputs are recorded in `dbt.log`.
* Useful for debugging, governance audits, and CI/CD pipelines.

---

## ✅ Best Practices Implemented

| Practice                         | Why It Matters                                              |
| -------------------------------- | ----------------------------------------------------------- |
| External Stage Integration       | Secure, scalable GCP-to-Snowflake pipeline                  |
| Raw Backup Materialization       | Ensures rollback in case of transformation errors           |
| Standardization in Staging Layer | Simplifies joins, enhances data consistency                 |
| SCD Type 2 Snapshots             | Tracks user behavior change history                         |
| Schema Change Protection         | `on_schema_change: fail` to catch accidental column updates |
| Modular Star Schema              | Optimizes BI performance, simplifies query logic            |
| dbt Testing                      | Data quality assurance                                      |
| dbt Logging                      | Enables observability and operational tracking              |
| Seed Enrichment                  | Enhances data completeness using external curated values    |
| Auto-Documentation               | Reduces onboarding time, improves stakeholder understanding |

---

## 🤮 Source-to-Model Mapping (Facts and Dimensions)

### Raw Sources (Bronze Layer)

* `src_movies`, `src_ratings`, `src_genome_scores`, `src_genome_tags`, `src_tags`, `src_links`

### Transformations (Silver Layer)

* Each `src_` table was converted to a `stg_` model:

  * Clean column names
  * Convert timestamps
  * Cast data types
  * Remove NULLs, duplicates

### Dimension and Fact Models (Gold Layer)

| Final Model            | Source Tables Used               | Description                                                  |
| ---------------------- | -------------------------------- | ------------------------------------------------------------ |
| `dim_movies`           | `stg_movies`                     | Cleans movie names, extracts genres, prepares for fact joins |
| `dim_genome_tags`      | `stg_genome_tags`                | Formats tag names                                            |
| `dim_users`            | `stg_ratings` + `stg_tags`       | Unique users from all interaction sources                    |
| `fct_ratings`          | `stg_ratings`                    | User ratings fact table (incremental load)                   |
| `fct_genome_scores`    | `stg_genome_scores`              | Tag relevance scores for movies                              |
| `dim_movies_with_tags` | `stg_movies` + `stg_genome_tags` | Ephemeral join layer for exploration                         |
