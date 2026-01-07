# Star Schema Design for FlexiMart Data Warehouse

---

## Section 1: Schema Overview

This data warehouse follows a **Star Schema** design to support analytical reporting and historical sales analysis for FlexiMart. The schema is optimized for query performance, simplicity, and business intelligence use cases.

### FACT TABLE: `fact_sales`

**Business Process:** Sales Transactions
**Grain:** One row per product per order line item

Each record in `fact_sales` represents a single product sold within a specific customer order on a given date. If one order contains multiple products, each product generates a separate row in the fact table.

**Measures (Numeric Facts):**

* `quantity_sold`: Number of units sold
* `unit_price`: Price per unit at the time of sale
* `discount_amount`: Discount applied on the line item
* `total_amount`: Final transaction amount (quantity × unit_price − discount)

These measures are additive and support aggregation across time, product, and customer dimensions.

**Foreign Keys:**

* `date_key` → `dim_date`
* `product_key` → `dim_product`
* `customer_key` → `dim_customer`

---

### DIMENSION TABLE: `dim_date`

**Purpose:** Enables time-based analysis such as daily, monthly, quarterly, and yearly sales trends.
**Type:** Conformed Dimension

**Attributes:**

* `date_key` (PK): Surrogate key in YYYYMMDD format
* `full_date`: Actual calendar date
* `day_of_week`: Monday, Tuesday, etc.
* `month`: Numeric month (1–12)
* `month_name`: January, February, etc.
* `quarter`: Q1, Q2, Q3, Q4
* `year`: Calendar year (e.g., 2023, 2024)
* `is_weekend`: Boolean flag indicating weekend

This dimension supports flexible time-based roll-up and drill-down analysis.

---

### DIMENSION TABLE: `dim_product`

**Purpose:** Supports analysis of sales performance across different product attributes.

**Attributes:**

* `product_key` (PK): Surrogate key
* `product_name`
* `category`
* `subcategory`
* `brand`
* `price_band`

This dimension allows slicing sales by category, brand, and product hierarchy, enabling detailed product-level insights.

---

### DIMENSION TABLE: `dim_customer`

**Purpose:** Enables customer-centric sales analysis and segmentation.

**Attributes:**

* `customer_key` (PK): Surrogate key
* `customer_name`
* `city`
* `state`
* `customer_segment`

This dimension supports geographic analysis and customer behavior studies.

---

## Section 2: Design Decisions

The star schema uses a **transaction line-item level grain** to preserve maximum detail from source data. This granularity enables flexible analysis, allowing sales to be aggregated at daily, monthly, or yearly levels without loss of information. It also supports product-level and customer-level drill-downs.

**Surrogate keys** are used instead of natural keys to ensure stability and performance. Natural keys such as product codes or customer emails may change over time, whereas surrogate keys remain constant and improve join efficiency in large fact tables.

This design supports **roll-up and drill-down operations** by storing hierarchies within dimensions. Analysts can roll up sales from products to categories or from days to months, and drill down to individual transactions as needed. The structure follows industry-standard dimensional modeling practices, ensuring scalability and ease of reporting.

---

## Section 3: Sample Data Flow

### Source Transaction

Order #101
Customer: John Doe
Product: Laptop
Quantity: 2
Unit Price: ₹50,000

---

### Data Warehouse Representation

**fact_sales record:**

```
{
  date_key: 20240115,
  product_key: 5,
  customer_key: 12,
  quantity_sold: 2,
  unit_price: 50000,
  discount_amount: 0,
  total_amount: 100000
}
```

**dim_date record:**

```
{ date_key: 20240115, full_date: '2024-01-15', month: 1, quarter: 'Q1', year: 2024 }
```

**dim_product record:**

```
{ product_key: 5, product_name: 'Laptop', category: 'Electronics', brand: 'Dell' }
```

**dim_customer record:**

```
{ customer_key: 12, customer_name: 'John Doe', city: 'Mumbai', customer_segment: 'Retail' }
```

This example illustrates how transactional data is transformed through ETL processes into a structured star schema optimized for analytical reporting.

