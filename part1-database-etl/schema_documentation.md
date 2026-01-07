# FlexiMart Database Schema Documentation

---

## 1. Entity-Relationship Description

### ENTITY: customers
**Purpose:**  
Stores detailed information about customers who shop at FlexiMart.

**Attributes:**  
- `customer_id`: Unique identifier for each customer (Primary Key)  
- `first_name`: Customer’s first name  
- `last_name`: Customer’s last name 
- `email`: Unique email address of the customer  
- `phone`: Customer phone number (standardized format)  
- `city`: City of residence  
- `registration_date`: Date when the customer registered  

**Relationships:**  
- One customer can place **many orders** (1:M relationship with `orders` table)

---

### ENTITY: products
**Purpose:**  
Stores information about products available for sale.

**Attributes:**  
- `product_id`: Unique identifier for each product (Primary Key)  
- `product_name`: Name of the product  
- `category`: Category to which the product belongs  
- `price`: Selling price of the product  
- `stock_quantity`: Available quantity in inventory  

**Relationships:**  
- One product can be associated with **many order items** (1:M relationship with `order_items` table)

---

### ENTITY: orders
**Purpose:**  
Stores order-level information for purchases made by customers.

**Attributes:**  
- `order_id`: Unique identifier for each order (Primary Key)  
- `customer_id`: Identifier of the customer placing the order (Foreign Key)  
- `order_date`: Date on which the order was placed  
- `total_amount`: Total monetary value of the order  
- `status`: Current status of the order  

**Relationships:**  
- One order belongs to **one customer**  
- One order can contain **many order items** (1:M relationship with `order_items` table)

---
### ENTITY: order_items
**Purpose:**  
Stores detailed line-item information for each product included in an order.

**Attributes:**  
- `order_item_id`: Unique identifier for each order item (Primary Key)  
- `order_id`: Identifier of the associated order (Foreign Key)  
- `product_id`: Identifier of the product ordered (Foreign Key)  
- `quantity`: Number of units ordered  
- `unit_price`: Price per unit at the time of order  
- `subtotal`: Total price for the item (quantity × unit_price)

**Relationships:**  
- Each order item belongs to **one order** and **one product**

---
## 2. Normalization Explanation (Third Normal Form)

The FlexiMart database schema is designed according to **Third Normal Form (3NF)** principles to ensure data consistency, reduce redundancy, and prevent anomalies.

Each table has a clearly defined primary key that uniquely identifies each record. All non-key attributes in every table are functionally dependent only on their respective primary keys. For example, in the `customers` table, attributes such as first name, last name, email, and city depend solely on `customer_id`. Similarly, in the `products` table, product name, category, price, and stock quantity depend only on `product_id`.

There are no partial dependencies, as no table contains composite primary keys. Transitive dependencies are also avoided by separating related data into distinct tables. For instance, product details are stored in the `products` table rather than being repeated in orders, and customer information is stored independently from order data.

This design prevents **update anomalies** by ensuring that changes to customer or product information are made in only one place. **Insert anomalies** are avoided because customers and products can be added without requiring associated orders. **Delete anomalies** are prevented because removing an order does not result in the loss of customer or product data.

Overall, the schema satisfies all conditions of 3NF and supports efficient, scalable database operations.

---
## 3. Sample Data Representation

### customers

| customer_id| first_name| last_name  | email                  | phone           | city    | registration_date |
|------------|------------|-----------|------------------------|-----------------|---------|-------------------|
|C001        |Rahul	      |Sharma     |	rahul.sharma@gmail.com |+91-9876543210   |Bangalore|	15-01-2023     |
|C002	     |Priya       |	Patel	  |priya.patel@yahoo.com   |+91-9988776564	 |Mumbai   |    20-02-2023     |

### products

| product_id| product_name      | category     | price  | stock_quantity |
|-----------|-------------------|--------------|--------|----------------|
|P001       |Samsung GalaxyS21  |Electronics   |45999   |	150          |
|P002	    |Nike Running Shoes	| fashion      | 3499	|   80           |

### orders

| order_id | customer_id | order_date | total_amount | status    |
|----------|-------------|------------|--------------|-----------|
|   1      |     1	     | 2024-01-15 | 45999.00     |Completed  |
|   2	   |     1	     | 2024-01-16 |	5998.00	     |Completed  |

### order_items

| order_item_id | order_id | product_id | quantity | unit_price | subtotal |
|---------------|----------|------------|----------|------------|----------|
|      1	    |    1	   |     1	    |    1	   |  45999.00	| 45999.00 |
|      2	    |    2	   |     1	    |    2	   |  2999.00   | 5998.00  |

