#ETL Pipeline for FlexiMart
#Extracts raw CSV data, cleans and standardizes records,and 
# loads data into a MySQL database with data quality reporting.


import pandas as pd
import mysql.connector
import os

# ===============================
# DATABASE CONFIG
# ===============================
DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "KITTEN1113",
    "database": "fleximart"
}

BASE_PATH = r"T:\fleximart_etl"

# ===============================
# CONNECT TO DATABASE
# ===============================
conn = mysql.connector.connect(**DB_CONFIG)
cursor = conn.cursor()

report = []

# ===============================
# HELPER FUNCTIONS
# ===============================
def standardize_phone(phone):
    if pd.isna(phone):
        return "Unknown"
    digits = ''.join(filter(str.isdigit, str(phone)))
    if len(digits) >= 10:
        return "+91-" + digits[-10:]
    return "Unknown"

def standardize_category(cat):
    if pd.isna(cat):
        return "Unknown"
    return cat.strip().title()

def parse_date(val):
    try:
        return pd.to_datetime(val, dayfirst=True).date()
    except:
        return None

# ===============================
# EXTRACT
# ===============================
customers = pd.read_csv(os.path.join(BASE_PATH, "customers_raw.csv"))
products = pd.read_csv(os.path.join(BASE_PATH, "products_raw.csv"))
sales = pd.read_csv(os.path.join(BASE_PATH, "sales_raw.csv"))

# ===============================
# TRANSFORM — CUSTOMERS
# ===============================
c_before = len(customers)
customers.drop_duplicates(inplace=True)

customers.fillna({
    "email": "unknown@email.com",
    "phone": "Unknown",
    "city": "Unknown"
}, inplace=True)

customers["phone"] = customers["phone"].apply(standardize_phone)
customers["registration_date"] = customers["registration_date"].apply(parse_date)

report.append(f"Customers processed: {c_before}, duplicates removed: {c_before - len(customers)}")

# ===============================
# TRANSFORM — PRODUCTS
# ===============================
p_before = len(products)
products.drop_duplicates(inplace=True)

products.fillna({
    "price": 0,
    "stock_quantity": 0,
    "category": "Unknown"
}, inplace=True)

products["category"] = products["category"].apply(standardize_category)

report.append(f"Products processed: {p_before}, duplicates removed: {p_before - len(products)}")

# ===============================
# TRANSFORM — SALES (IMPORTANT)
# ===============================
s_before = len(sales)
sales.drop_duplicates(inplace=True)

# Convert IDs safely
sales["customer_id"] = pd.to_numeric(sales["customer_id"], errors="coerce")
sales["product_id"] = pd.to_numeric(sales["product_id"], errors="coerce")

# Replace invalid/missing IDs with Unknown (1)
sales["customer_id"].fillna(1, inplace=True)
sales["product_id"].fillna(1, inplace=True)

sales.loc[sales["customer_id"] <= 0, "customer_id"] = 1
sales.loc[sales["product_id"] <= 0, "product_id"] = 1

sales.fillna({
    "quantity": 0,
    "unit_price": 0,
    "status": "Pending"
}, inplace=True)

sales["order_date"] = sales["order_date"].apply(parse_date)

report.append(f"Sales processed: {s_before}, duplicates removed: {s_before - len(sales)}")

# ===============================
# LOAD — CUSTOMERS
# ===============================
for _, row in customers.iterrows():
    try:
        cursor.execute("""
            INSERT INTO customers (first_name, last_name, email, phone, city, registration_date)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (
            row["first_name"],
            row["last_name"],
            row["email"],
            row["phone"],
            row["city"],
            row["registration_date"]
        ))
    except:
        pass

conn.commit()

# ===============================
# LOAD — PRODUCTS
# ===============================
for _, row in products.iterrows():
    try:
        cursor.execute("""
            INSERT INTO products (product_name, category, price, stock_quantity)
            VALUES (%s, %s, %s, %s)
        """, (
            row["product_name"],
            row["category"],
            row["price"],
            row["stock_quantity"]
        ))
    except:
        pass

conn.commit()

# ===============================
# LOAD — ORDERS & ORDER_ITEMS
# ===============================
for _, row in sales.iterrows():
    try:
        cursor.execute("""
            INSERT INTO orders (customer_id, order_date, total_amount, status)
            VALUES (%s, %s, %s, %s)
        """, (
            int(row["customer_id"]),
            row["order_date"],
            row["quantity"] * row["unit_price"],
            row["status"]
        ))

        order_id = cursor.lastrowid

        cursor.execute("""
            INSERT INTO order_items (order_id, product_id, quantity, unit_price, subtotal)
            VALUES (%s, %s, %s, %s, %s)
        """, (
            order_id,
            int(row["product_id"]),
            row["quantity"],
            row["unit_price"],
            row["quantity"] * row["unit_price"]
        ))
    except:
        pass

conn.commit()

# ===============================
# DATA QUALITY REPORT
# ===============================
with open(os.path.join(BASE_PATH, "data_quality_report.txt"), "w") as f:
    for line in report:
        f.write(line + "\n")

cursor.close()
conn.close()

print("ETL Pipeline Completed Successfully.")
