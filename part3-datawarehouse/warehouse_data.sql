/* =========================================
   DATA WAREHOUSE SEED DATA
   Database: fleximart_dw
   ========================================= */

USE fleximart_dw;

-- ===============================
-- DIMENSION: DATE (30 records)
-- ===============================
INSERT INTO dim_date VALUES
(20240101,'2024-01-01','Monday',1,1,'January','Q1',2024,FALSE),
(20240102,'2024-01-02','Tuesday',2,1,'January','Q1',2024,FALSE),
(20240103,'2024-01-03','Wednesday',3,1,'January','Q1',2024,FALSE),
(20240104,'2024-01-04','Thursday',4,1,'January','Q1',2024,FALSE),
(20240105,'2024-01-05','Friday',5,1,'January','Q1',2024,FALSE),
(20240106,'2024-01-06','Saturday',6,1,'January','Q1',2024,TRUE),
(20240107,'2024-01-07','Sunday',7,1,'January','Q1',2024,TRUE),
(20240110,'2024-01-10','Wednesday',10,1,'January','Q1',2024,FALSE),
(20240113,'2024-01-13','Saturday',13,1,'January','Q1',2024,TRUE),
(20240114,'2024-01-14','Sunday',14,1,'January','Q1',2024,TRUE),
(20240120,'2024-01-20','Saturday',20,1,'January','Q1',2024,TRUE),
(20240121,'2024-01-21','Sunday',21,1,'January','Q1',2024,TRUE),
(20240201,'2024-02-01','Thursday',1,2,'February','Q1',2024,FALSE),
(20240202,'2024-02-02','Friday',2,2,'February','Q1',2024,FALSE),
(20240203,'2024-02-03','Saturday',3,2,'February','Q1',2024,TRUE),
(20240204,'2024-02-04','Sunday',4,2,'February','Q1',2024,TRUE),
(20240207,'2024-02-07','Wednesday',7,2,'February','Q1',2024,FALSE),
(20240210,'2024-02-10','Saturday',10,2,'February','Q1',2024,TRUE),
(20240211,'2024-02-11','Sunday',11,2,'February','Q1',2024,TRUE),
(20240214,'2024-02-14','Wednesday',14,2,'February','Q1',2024,FALSE),
(20240217,'2024-02-17','Saturday',17,2,'February','Q1',2024,TRUE),
(20240218,'2024-02-18','Sunday',18,2,'February','Q1',2024,TRUE),
(20240221,'2024-02-21','Wednesday',21,2,'February','Q1',2024,FALSE),
(20240224,'2024-02-24','Saturday',24,2,'February','Q1',2024,TRUE),
(20240225,'2024-02-25','Sunday',25,2,'February','Q1',2024,TRUE),
(20240226,'2024-02-26','Monday',26,2,'February','Q1',2024,FALSE),
(20240227,'2024-02-27','Tuesday',27,2,'February','Q1',2024,FALSE),
(20240228,'2024-02-28','Wednesday',28,2,'February','Q1',2024,FALSE),
(20240229,'2024-02-29','Thursday',29,2,'February','Q1',2024,FALSE);

-- ===============================
-- DIMENSION: PRODUCT (15 records)
-- ===============================
INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
('P001','Laptop Pro','Electronics','Laptops',75000),
('P002','Smartphone X','Electronics','Mobiles',45000),
('P003','Headphones','Electronics','Audio',3000),
('P004','Smart TV','Electronics','Television',65000),
('P005','Bluetooth Speaker','Electronics','Audio',5000),
('P006','Jeans','Fashion','Clothing',2500),
('P007','Sneakers','Fashion','Footwear',6000),
('P008','T-Shirt','Fashion','Clothing',1200),
('P009','Jacket','Fashion','Outerwear',8500),
('P010','Formal Shoes','Fashion','Footwear',7000),
('P011','Sofa Set','Home','Furniture',45000),
('P012','Dining Table','Home','Furniture',38000),
('P013','Microwave','Home','Appliances',12000),
('P014','Vacuum Cleaner','Home','Appliances',15000),
('P015','Wall Clock','Home','Decor',900);

-- ===============================
-- DIMENSION: CUSTOMER (12 records)
-- ===============================
INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('C001','Amit Sharma','Delhi','Delhi','Retail'),
('C002','Neha Verma','Mumbai','Maharashtra','Corporate'),
('C003','Rahul Singh','Bangalore','Karnataka','Retail'),
('C004','Priya Gupta','Kolkata','West Bengal','Wholesale'),
('C005','Ankit Jain','Delhi','Delhi','Retail'),
('C006','Sneha Iyer','Mumbai','Maharashtra','Corporate'),
('C007','Vikas Mehta','Bangalore','Karnataka','Retail'),
('C008','Ritu Malhotra','Kolkata','West Bengal','Wholesale'),
('C009','Karan Patel','Mumbai','Maharashtra','Retail'),
('C010','Pooja Nair','Bangalore','Karnataka','Corporate'),
('C011','Suresh Das','Kolkata','West Bengal','Retail'),
('C012','Meera Kapoor','Delhi','Delhi','Corporate');

-- ===============================
-- FACT TABLE: SALES (40 records)
-- ===============================
INSERT INTO fact_sales
(date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
(20240106,1,2,2,75000,5000,145000),
(20240107,2,1,1,45000,0,45000),
(20240113,3,3,3,3000,0,9000),
(20240114,4,4,1,65000,3000,62000),
(20240120,5,5,2,5000,0,10000),
(20240121,6,6,3,2500,0,7500),
(20240203,7,7,1,6000,0,6000),
(20240204,8,8,4,1200,0,4800),
(20240210,9,9,1,8500,500,8000),
(20240211,10,10,2,7000,0,14000),

(20240101,11,11,1,45000,2000,43000),
(20240102,12,12,1,38000,0,38000),
(20240103,13,1,2,12000,0,24000),
(20240104,14,2,1,15000,0,15000),
(20240105,15,3,5,900,0,4500),
(20240110,1,4,1,75000,0,75000),
(20240113,2,5,2,45000,5000,85000),
(20240114,3,6,2,3000,0,6000),
(20240120,4,7,1,65000,3000,62000),
(20240121,5,8,3,5000,0,15000),

(20240201,6,9,2,2500,0,5000),
(20240202,7,10,1,6000,0,6000),
(20240203,8,11,3,1200,0,3600),
(20240204,9,12,1,8500,0,8500),
(20240207,10,1,2,7000,0,14000),
(20240210,11,2,1,45000,0,45000),
(20240211,12,3,1,38000,2000,36000),
(20240214,13,4,1,12000,0,12000),
(20240217,14,5,1,15000,0,15000),
(20240218,15,6,4,900,0,3600),

(20240221,1,7,1,75000,5000,70000),
(20240224,2,8,1,45000,0,45000),
(20240225,3,9,2,3000,0,6000),
(20240226,4,10,1,65000,0,65000),
(20240227,5,11,2,5000,0,10000),
(20240228,6,12,3,2500,0,7500),
(20240229,7,1,1,6000,0,6000);
