
## 📁 part3-datawarehouse/README.md

```md
# Part 3: Data Warehouse & OLAP Analytics

## Objective
This part implements a star schema data warehouse and performs OLAP-style analytical queries to analyze historical sales data.

## Contents
- `star_schema_design.md`: Star schema design explanation and modeling decisions.
- `warehouse_schema.sql`: SQL script to create dimension and fact tables.
- `warehouse_data.sql`: Insert statements with realistic sample data.
- `analytics_queries.sql`: OLAP queries for drill-down, product performance, and customer segmentation.

## Key Features
- Star schema dimensional modeling
- Surrogate keys and conformed dimensions
- Drill-down and aggregation analytics

## How to Run
```bash
mysql -u root -p fleximart_dw < warehouse_schema.sql
mysql -u root -p fleximart_dw < warehouse_data.sql
mysql -u root -p fleximart_dw < analytics_queries.sql
