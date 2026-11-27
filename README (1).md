# 🍕 Food Delivery Management: MySQL Business Analytics

A SQL project that turns food delivery data (customers, restaurants, menus, orders, payments and delivery) into business insights using MySQL.

> **Note:** This is a learning project built on a practice dataset.

## 📌 Project Overview

**Role:** Data Analyst supporting a food delivery team
**Goal:** Turn raw customer, order, payment and delivery data into business insights using MySQL.

**Project flow**
1. Business and data understanding
2. Database setup: 5 tables, CSV import
3. Basic exploration with 10 queries
4. Objective-based analysis of 5 business goals

## 🗂️ Database Overview

| Table | Rows | Columns | What it holds |
|---|---|---|---|
| `customers` | 500 | 13 | Customer profile and status |
| `restaurants` | 40 | 10 | Cuisine, location, rating |
| `menu_items` | 300 | 10 | Items, category, price |
| `orders` | 2,000 | 13 | Order, payment, delivery |
| `order_items` | 5,000 | 7 | Items per order, quantity |

**5 tables · 7,840 records · 5 foreign-key links**

### Relationships (all one-to-many)
- One customer → many orders
- One restaurant → many orders
- One restaurant → many menu_items
- One order → many order_items
- One menu_item → many order_items

### ER Diagram

## 🎯 Business Objectives

| # | Objective | Key question |
|---|---|---|
| 4.1 | Customer Profile & Segmentation | Who are our customers and how do groups differ? |
| 4.2 | Restaurant & Menu Activity | How do cuisines, locations and categories compare? |
| 4.3 | Order Patterns | How do orders change over time? |
| 4.4 | Payment & Delivery Performance | Where do payments fail and deliveries get cancelled? |
| 4.5 | Menu Item Usage & Engagement | Which items drive demand? |

## 🛠️ SQL Concepts Used
- Database creation and table design
- Primary Keys and Foreign Keys
- Data import and validation
- INNER JOIN and LEFT JOIN
- Aggregations: SUM, COUNT, AVG, GROUP BY
- Subqueries
- Date functions (DATE_FORMAT)
- Conditional calculations

## 📊 Key Insights
- Orders grew 76% year on year
- 83% of customers are active, and the top 50 customers contribute 31% of revenue
- North Indian and Street Food lead with 29% of orders; restaurant rating shows almost no link to demand
- Cash on Delivery has the highest payment failure rate (8.7%, vs 5.3% for Net Banking)
- Just 9 delivery partners account for 225 of 246 cancellations
- Vegetarian items make up 70% of units sold
- 57 of 300 menu items were never ordered

## 💡 Recommendations
- Retain high-value customers with loyalty rewards
- Reduce payment friction with retry and fallback options
- Review workload and training for high-cancellation delivery partners
- Clean up or promote menu items that never sell

## 📁 Repository Structure
```
food-delivery-sql-project/
│
├── README.md
├── data/                  # CSV files
│   ├── customers.csv
│   ├── restaurants.csv
│   ├── menu_items.csv
│   ├── orders.csv
│   └── order_items.csv
├── sql/
│   ├── 01_create_database_and_tables.sql
│   ├── 02_basic_queries.sql
│   └── 03_objective_analysis.sql
├── images/
│   └── er_diagram.png
└── presentation/
    └── sql_project.pptx
```

## ▶️ How to Run
1. Install MySQL and MySQL Workbench
2. Run `sql/01_create_database_and_tables.sql` to create the database and tables
3. Import the CSV files from `data/` into the matching tables (Table Data Import Wizard)
4. Run `sql/02_basic_queries.sql` and `sql/03_objective_analysis.sql`

## 👤 Author

**NAREDDY ROHITH**
B.Tech (CSM), Fresher | Innomatics Research Labs

🔗 [LinkedIn](https://linkedin.com/in/harinatheega) · 💻 [GitHub](https://github.com/Rohith557454)

## 🙏 Acknowledgment
Thanks to my trainer Shaheer Shaik Sir and mentor Gogula Vinay Sir, and to Innomatics Research Labs for the guidance and learning environment.
