/* =========================================
   MongoDB Operations for FlexiMart
   Database: fleximart_nosql
   Collection: products
   ========================================= */

/* -----------------------------------------
   Operation 1: Load Data
   -----------------------------------------
   Product catalog data was imported into
   MongoDB using MongoDB Compass via JSON
   file import into the 'products' collection.
------------------------------------------ */


/* -----------------------------------------
   Operation 2: Basic Query
   -----------------------------------------
   Find all products in "Electronics" category
   with price less than 50000.
   Return only name, price, and stock.
------------------------------------------ */

/* Query */
db.products.find(
  { category: "Electronics", price: { $lt: 50000 } },
  { _id: 0, name: 1, price: 1, stock: 1 }
);

/* Output:
[
  { "name": "Sony WH-1000XM5 Headphones", "price": 29990, "stock": 200 },
  { "name": "Dell 27-inch 4K Monitor", "price": 32999, "stock": 60 },
  { "name": "OnePlus Nord CE 3", "price": 26999, "stock": 180 }
]
*/


/* -----------------------------------------
   Operation 3: Review Analysis
   -----------------------------------------
   Find all products that have an average
   rating greater than or equal to 4.0.
------------------------------------------ */

/* Query */
db.products.aggregate([
  { $unwind: "$reviews" },
  {
    $group: {
      _id: "$name",
      avg_rating: { $avg: "$reviews.rating" }
    }
  },
  { $match: { avg_rating: { $gte: 4.0 } } }
]);

/* Output:
[
  { "_id": "Nike Air Max 270 Sneakers", "avg_rating": 4.5 },
  { "_id": "Samsung 55-inch QLED TV", "avg_rating": 4.5 },
  { "_id": "Apple MacBook Pro 14-inch", "avg_rating": 5.0 },
  { "_id": "Samsung Galaxy S21 Ultra", "avg_rating": 4.5 },
  { "_id": "Sony WH-1000XM5 Headphones", "avg_rating": 4.67 },
  { "_id": "OnePlus Nord CE 3", "avg_rating": 4.0 },
  { "_id": "Levi's 511 Slim Fit Jeans", "avg_rating": 4.67 },
  { "_id": "Dell 27-inch 4K Monitor", "avg_rating": 4.0 },
  { "_id": "Adidas Originals T-Shirt", "avg_rating": 4.33 },
  { "_id": "Puma RS-X Sneakers", "avg_rating": 4.5 },
  { "_id": "Reebok Training Trackpants", "avg_rating": 4.5 }
]
*/


/* -----------------------------------------
   Operation 4: Update Operation
   -----------------------------------------
   Add a new review to product with
   product_id "ELEC001".
------------------------------------------ */

/* Query */
db.products.updateOne(
  { product_id: "ELEC001" },
  {
    $push: {
      reviews: {
        user: "U999",
        rating: 4,
        comment: "Good value",
        date: new Date()
      }
    }
  }
);

/* Output:
{
  "acknowledged": true,
  "matchedCount": 1,
  "modifiedCount": 1,
  "upsertedCount": 0
}
*/


/* -----------------------------------------
   Operation 5: Complex Aggregation
   -----------------------------------------
   Calculate average price and product count
   by category and sort by average price
   in descending order.
------------------------------------------ */

/* Query */
db.products.aggregate([
  {
    $group: {
      _id: "$category",
      avg_price: { $avg: "$price" },
      product_count: { $sum: 1 }
    }
  },
  {
    $project: {
      _id: 0,
      category: "$_id",
      avg_price: { $round: ["$avg_price", 2] },
      product_count: 1
    }
  },
  { $sort: { avg_price: -1 } }
]);

/* Output:
[
  { "category": "Electronics", "avg_price": 70830.83, "product_count": 6 },
  { "category": "Fashion", "avg_price": 5215.00, "product_count": 6 }
]
*/
