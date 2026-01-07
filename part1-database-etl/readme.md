# Part 1: Relational Database & ETL Pipeline

## Objective
This part focuses on designing a relational database schema, implementing an ETL pipeline, and executing business queries for the FlexiMart retail system.

## Contents
- `etl_pipeline.py`: Python ETL script to load, clean, and transform raw CSV data into MySQL tables.
- `schema_documentation.md`: Entity-Relationship description and normalization (3NF) justification.
- `business_queries.sql`: SQL queries answering key business questions.
- `data_quality_report.txt`: Data quality summary generated during ETL execution.
- Raw data files: `customers_raw.csv`, `products_raw.csv`, `sales_raw.csv`

## Key Features
- Data cleaning and duplicate handling
- Referential integrity enforcement
- Business-focused SQL analytics

## How to Run
```bash
python etl_pipeline.py
mysql -u root -p fleximart < business_queries.sql
