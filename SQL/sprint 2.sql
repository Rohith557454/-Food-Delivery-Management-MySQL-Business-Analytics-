-- Basic Analysis/Data Exploration

use mysql_project;

-- 1. . What is the total number of customers?
select count(customer_id) as Total_Customers from customers;

-- 2  What is the total number of restaurants?
select count(restaurant_id) as Total_Restaurants from restaurants;

-- 3  What are the different cuisine types available?
select distinct cuisine_type from restaurants;

-- 4  How many customers are currently active?
select count(*) as Customers_Active from customers
where customer_status = "Active";

-- 5 What are the different payment methods available?
select distinct preferred_payment_method from customers;

-- 6  What is the total amount of delivered orders?
select count(*) as Delivered_Orders from orders
where order_status = "Delivered";

-- 7 What are the different menu item categories available?
select distinct item_name from menu_items;

-- 8 What is the total number of orders?
select distinct count(order_id) as Total_Orders from orders;

-- 9  What are the different order statuses available?
select distinct order_status from orders;

-- 10 What is the total discount amount?
select sum(discount_amount) as Total_discount_amount from orders;

