# FlexiMart Data Architecture Project

**Student Name:** [Avika Mishra]  
**Student ID:** [bitsom_ba_25072022]  
**Email:** [avikamishra11@gmail.com]  
**Date:** 07/January/2026  

---

## Project Overview

This project implements an end-to-end data architecture solution for *FlexiMart*, covering transactional databases, NoSQL systems, and a data warehouse for analytics. The solution includes an ETL pipeline using SQL and Python, a MongoDB-based product catalog for semi-structured data, and a star-schema data warehouse designed for OLAP analysis and business intelligence reporting.

---

## Repository Structure

├── part1-database-etl/
│   ├── etl_pipeline.py
│   ├── schema_documentation.md
│   ├── business_queries.sql
│   └── data_quality_report.txt
├── part2-nosql/
│   ├── nosql_analysis.md
│   ├── mongodb_operations.js
│   └── products_catalog.json
├── part3-datawarehouse/
│   ├── star_schema_design.md
│   ├── warehouse_schema.sql
│   ├── warehouse_data.sql
│   └── analytics_queries.sql
└── README.md

---

## Technologies Used

- **Programming:** Python 3.x, pandas  
- **Relational Databases:** MySQL 8.0  
- **NoSQL Database:** MongoDB 6.0  
- **Data Warehousing:** Star Schema (Dimensional Modeling)  
- **Tools:** VS Code, MongoDB Compass, Git, GitHub  

---

## Setup Instructions

### Database Setup (MySQL)

```bash
# Create databases
mysql -u root -p -e "CREATE DATABASE fleximart;"
mysql -u root -p -e "CREATE DATABASE fleximart_dw;"

# Run Part 1 - ETL Pipeline
python part1-database-etl/etl_pipeline.py

# Execute business queries
mysql -u root -p fleximart < part1-database-etl/business_queries.sql

# Run Data Warehouse Schema and Data
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_schema.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_data.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/analytics_queries.sql

### MongoDB Setup
mongosh < part2-nosql/mongodb_operations.js

### Key Learnings

Designed and implemented a complete ETL pipeline with data validation and quality checks.

Gained hands-on experience with MongoDB for handling semi-structured and nested data.

Learned dimensional modeling concepts and implemented a star schema for analytical workloads.

Developed OLAP queries to support real-world business decision-making.

Challenges Faced

Handling heterogeneous product attributes:
Solved by using MongoDB’s flexible document schema instead of rigid relational tables.

Maintaining data consistency across fact and dimension tables:
Addressed by carefully managing surrogate keys and foreign key relationships in the data warehouse.