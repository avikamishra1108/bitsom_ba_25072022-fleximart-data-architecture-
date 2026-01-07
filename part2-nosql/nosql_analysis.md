# NoSQL Database Analysis for FlexiMart

## Section A: Limitations of RDBMS (Relational Databases)

Relational databases like MySQL work best when data is highly structured and consistent across records. However, in a dynamic product catalog such as FlexiMart’s, this rigid structure becomes a limitation. Different product types often have different attributes—for example, laptops require specifications like RAM, processor, and storage, while shoes need size, color, and material. In an RDBMS, accommodating such variation would require creating multiple tables or adding many nullable columns, leading to complexity and poor design.

Frequent schema changes are another challenge. Every time a new product type or attribute is introduced, the database schema must be altered using `ALTER TABLE`, which is time-consuming and risky in production environments. Additionally, storing customer reviews as nested or hierarchical data is unnatural in relational systems. Reviews would need separate tables and joins, increasing query complexity and impacting performance. Overall, RDBMS systems struggle with flexibility, rapid evolution, and hierarchical data representation.

---

## Section B: Benefits of Using MongoDB (NoSQL)

MongoDB addresses these challenges through its flexible, document-based data model. Each product can be stored as a JSON-like document, allowing different products to have different attributes without enforcing a fixed schema. For example, a laptop document can include technical specifications, while a shoe document can include size and color, all within the same collection.

MongoDB also supports embedded documents, making it ideal for storing customer reviews directly inside product documents. This improves data locality and reduces the need for complex joins, resulting in faster read operations. Furthermore, MongoDB is designed for horizontal scalability, allowing data to be distributed across multiple servers using sharding. This makes it suitable for handling large and rapidly growing product catalogs. Overall, MongoDB provides flexibility, scalability, and simplicity for managing diverse and evolving product data.

---

## Section C: Trade-offs of Using MongoDB

Despite its advantages, MongoDB has some drawbacks compared to MySQL. First, it provides weaker support for complex transactions and strict ACID guarantees, which can be critical for financial or order-processing systems. Second, the lack of a fixed schema can lead to inconsistent data if proper validation rules are not enforced at the application level. This may increase the risk of data quality issues. Therefore, MongoDB is better suited for flexible catalogs rather than transactional core systems.
