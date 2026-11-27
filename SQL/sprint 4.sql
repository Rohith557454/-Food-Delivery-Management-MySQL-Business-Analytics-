-- Sprint 4: Objective-Based Analysis
use mysql_project;
-- 4.1 Understand Customer Profile and Segmentation

-- Compare customers across different customer statuses
select customer_status, count(customer_id) as Total_Customers
from customers
group by customer_status;

-- Look at customer demographics.
SELECT
    gender,
    COUNT(customer_id) AS total_customers,
    ROUND(
        COUNT(customer_id) * 100.0 /
        (SELECT COUNT(*) FROM customers), 2
    ) AS percentage
FROM customers
GROUP BY gender
ORDER BY total_customers DESC;

-- Compare customers across cities and states.
select state,city,count(customer_id) as Total_Customers
from customers
group by state,city
order by Total_Customers desc;

-- Examine ordering frequency and order value

-- Who are the customers placing the highest number of orders?
select 
	c.customer_id,
	c.first_name,
    c.last_name,
    COUNT(o.order_id) AS total_orders
    from customers c join orders o on c.customer_id = o.customer_id
    group by c.customer_id,c.first_name,c.last_name
    order by total_orders desc;

-- Who are the customers spending the highest amount?
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_spent DESC;

-- What is the average order value for each customer?
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS total_orders,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY avg_order_value DESC;

-- Which payment method is most preferred by customers?
select preferred_payment_method, count(customer_id) as Total_Customers from customers
group by preferred_payment_method
order by Total_Customers desc;

-- What is the total revenue generated through each payment method?
select payment_method,SUM(total_amount) AS total_spent
from orders group by payment_method order by total_spent desc;

-- How long have customers been associated with the platform?
SELECT
    customer_id,
    first_name,
    last_name,
    registration_date,
    TIMESTAMPDIFF(
        month,
        registration_date,
        CURDATE()
    ) AS tenure_months
FROM customers
ORDER BY tenure_months DESC;

-- How many customers belong to each tenure group?
SELECT
    CASE
        WHEN TIMESTAMPDIFF(MONTH, registration_date, CURDATE()) < 6
            THEN 'New Customers'
        WHEN TIMESTAMPDIFF(MONTH, registration_date, CURDATE()) BETWEEN 6 AND 12
            THEN '6-12 Months'
        WHEN TIMESTAMPDIFF(MONTH, registration_date, CURDATE()) BETWEEN 13 AND 24
            THEN '1-2 Years'
        ELSE 'Above 2 Years'
    END AS customer_tenure,
    COUNT(customer_id) AS total_customers
FROM customers
GROUP BY customer_tenure
ORDER BY total_customers DESC;



-- Understand Restaurant and Menu Activity

-- 1. Compare different restaurant cuisines.

-- How many restaurants are available under each cuisine type?
select cuisine_type,count(restaurant_id) as Total_Restaurants
from restaurants group by cuisine_type order by Total_Restaurants desc;

-- Which cuisine types have the highest average restaurant ratings?
SELECT
    cuisine_type,
    COUNT(restaurant_id) AS total_restaurants,
    ROUND(AVG(rating), 2) AS avg_rating
FROM restaurants
GROUP BY cuisine_type
ORDER BY avg_rating DESC;

-- 2. Compare restaurant activity across cities and states.

-- Which cities have the highest number of restaurants?
select city, count(restaurant_id) as Total_Restaurants from restaurants
group by city order by Total_Restaurants desc;

-- which cities have the highest number of active restaurants?
select city, count(restaurant_id) as Total_Restaurants from restaurants
where restaurant_status = 'Active'
group by city order by Total_Restaurants desc;

-- 3. Examine restaurant ratings and price ranges.

-- which restaurants has the highest ratings?
SELECT
    restaurant_id,
    restaurant_name,
    cuisine_type,
    city,
    rating
FROM restaurants
ORDER BY rating DESC;

-- How many restaurants belong to each price range?
select price_range,count(restaurant_id) as Total_Restaurants
from restaurants group by price_range order by Total_Restaurants desc;

-- 4. Compare menu categories and vegetarian options

-- How many menu items are available in each category?
select item_category,count(item_name) as Total_menu_items
from menu_items group by item_category order by Total_menu_items desc;

-- How many vegetarian and non-vegetarian items are available?
SELECT
    vegetarian,
    COUNT(menu_item_id) AS total_items
FROM menu_items
GROUP BY vegetarian
ORDER BY total_items DESC;

-- Which cuisine offers the highest number of vegetarian items?
SELECT
    cuisine_type,
    COUNT(menu_item_id) AS vegetarian_items
FROM menu_items
WHERE LOWER(vegetarian) = 'yes'
GROUP BY cuisine_type
ORDER BY vegetarian_items DESC;

-- 5. Examine menu-item availability and status

-- How many menu items are available and unavailable?
SELECT
    availability,
    COUNT(menu_item_id) AS total_items
FROM menu_items
GROUP BY availability
ORDER BY total_items DESC;

-- Which restaurants have the highest number of available menu items?
SELECT
    r.restaurant_id,
    r.restaurant_name,
    COUNT(m.menu_item_id) AS available_items
FROM restaurants r
JOIN menu_items m
    ON r.restaurant_id = m.restaurant_id
WHERE LOWER(m.availability) = 'yes'
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY available_items DESC;

-- What is the distribution of menu-item statuses?
SELECT
    item_status,
    COUNT(menu_item_id) AS total_items
FROM menu_items
GROUP BY item_status
ORDER BY total_items DESC;


-- 6. Identify differences between active and inactive restaurants or menu items

-- How many restaurants are active and inactive?
SELECT
    restaurant_status,
    COUNT(restaurant_id) AS total_restaurants
FROM restaurants
GROUP BY restaurant_status
ORDER BY total_restaurants DESC;

-- How many menu items are active and inactive?
SELECT
    item_status,
    COUNT(menu_item_id) AS total_items
FROM menu_items
GROUP BY item_status
ORDER BY total_items DESC;

-- Which restaurants have inactive menu items?
SELECT
    r.restaurant_name,
    COUNT(m.menu_item_id) AS inactive_items
FROM restaurants r
JOIN menu_items m
    ON r.restaurant_id = m.restaurant_id
WHERE LOWER(m.item_status) = 'inactive'
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY inactive_items DESC;

-- 4.3 Analyze Order Patterns

-- Compare different order statuses.

-- How many orders are in each order status and what is the percentage distribution?
select order_status,count(order_id) as Total_Orders,ROUND(
        COUNT(order_id) * 100.0 /
        (SELECT COUNT(*) FROM orders), 2
    ) AS percentage
from orders group by order_status order by Total_Orders desc;

-- 2. Compare orders across restaurants and cuisines
select r.cuisine_type,r.restaurant_name,count(o.order_id) as Total_orders,ROUND(SUM(o.total_amount), 2) AS total_revenue
from restaurants r join orders o on r.restaurant_id = o.restaurant_id
group by r.cuisine_type,r.restaurant_name
order by Total_orders desc;

-- 3. Examine order amounts and discounts
-- What is the total, minimum, maximum, and average order value?
SELECT
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS avg_order_value,
    ROUND(MIN(total_amount), 2) AS minimum_order_value,
    ROUND(MAX(total_amount), 2) AS maximum_order_value
FROM orders;

-- Which orders received the highest discounts?
select order_id,round(sum(discount_amount),2) as Total_discount from orders
group by order_id order by Total_discount desc limit 10;

-- Which restaurants provide the highest average discounts?
SELECT
    r.restaurant_name,
    ROUND(AVG(o.discount_amount), 2) AS avg_discount,
    ROUND(SUM(o.discount_amount), 2) AS total_discount
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
GROUP BY
    r.restaurant_id,
    r.restaurant_name
ORDER BY avg_discount DESC;

-- 4. Analyze order activity over time
-- 1: How many orders are placed each day?
select day(order_date),count(order_id) as Total_orders
from orders group by day(order_date) order by Total_orders desc;

-- 2: Which months have the highest number of orders?
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY total_orders DESC;

-- 3: Which days of the week receive the highest orders?
SELECT
    DAYNAME(order_date) AS day_name,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY
    DAYOFWEEK(order_date),
    DAYNAME(order_date)
ORDER BY total_orders DESC;

-- what are the peak order hours?
SELECT
    HOUR(order_time) AS order_hour,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY HOUR(order_time)
ORDER BY total_orders DESC;

-- 5. Compare order activity across customer groups

-- Which customers place the highest number of orders?
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_orders DESC;

-- Which customer statuses generate the highest number of orders?
SELECT
    c.customer_status,
    COUNT(o.order_id) AS total_orders,
    COUNT(DISTINCT c.customer_id) AS total_customers
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_status
ORDER BY total_orders DESC;

-- Which cities generate the highest order volume?
SELECT
    c.city,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.total_amount), 2) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_orders DESC;

-- 6. Analyze the relationship between order items, quantity, subtotal, and total order value

-- Which menu items are ordered in the highest quantities?
select m.item_name,count(oi.quantity) as Total_quantity from menu_items m join order_items oi
on m.menu_item_id = oi.menu_item_id group by m.menu_item_id order by Total_quantity desc;

-- Which menu items generate highest revenue?
SELECT
    m.item_name,
    SUM(oi.quantity) AS total_quantity,
    ROUND(SUM(oi.subtotal), 2) AS total_revenue
FROM order_items oi
JOIN menu_items m
    ON oi.menu_item_id = m.menu_item_id
GROUP BY
    m.menu_item_id,
    m.item_name
ORDER BY total_revenue DESC;

-- What is the total quantity and subtotal for each order?
SELECT
    order_id,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(subtotal), 2) AS total_subtotal
FROM order_items
GROUP BY order_id
ORDER BY total_subtotal DESC;

-- Compare order-item subtotal with order total amount.
SELECT
    o.order_id,
    SUM(oi.subtotal) AS item_subtotal,
    o.discount_amount,
    o.total_amount,
    ROUND(
        SUM(oi.subtotal) - o.discount_amount,
        2
    ) AS calculated_total
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    o.order_id,
    o.discount_amount,
    o.total_amount
ORDER BY o.total_amount DESC;

-- 4.4 Evaluate Payment and Delivery Performance

-- Compare different payment methods.
select payment_method,count(order_id) as Total_orders,ROUND(SUM(total_amount), 2) AS total_revenue,ROUND(AVG(total_amount), 2) AS avg_order_value
from orders
group by payment_method order by Total_revenue desc;

-- Examine successful, failed, and pending payments
select payment_status,count(order_id) as Total_orders,ROUND(
        COUNT(order_id) * 100.0 /
        (SELECT COUNT(*) FROM orders), 2
    ) AS percentage
from orders
group by payment_status order by Total_orders desc;

-- Which payment methods have the highest payment failure counts?
select payment_method,count(order_id) as Failed_Payments
from orders
where payment_status='Failed'
group by payment_method order by Failed_payments desc;

-- 3. Compare delivery statuses
select delivery_status,count(order_id) as Total_orders,ROUND(
        COUNT(order_id) * 100.0 /
        (SELECT COUNT(*) FROM orders), 2
    ) AS percentage
from orders
group by delivery_status order by Total_orders desc;

-- 4. Identify cancelled orders
select delivery_status, count(order_id) as Total_orders,ROUND(
        COUNT(order_id) * 100.0 /
        (SELECT COUNT(*) FROM orders), 2) as Percentage
from orders 
where delivery_status='Cancelled'
group by delivery_status;

-- Which restaurants have the highest number of cancelled orders?
SELECT
    r.restaurant_name,
    COUNT(o.order_id) AS cancelled_orders
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
WHERE LOWER(o.order_status) = 'cancelled'
GROUP BY
    r.restaurant_id,
    r.restaurant_name
ORDER BY cancelled_orders DESC;

-- Which payment methods are associated with the most cancelled orders?
SELECT
    payment_method,
    COUNT(order_id) AS cancelled_orders
FROM orders
WHERE LOWER(order_status) = 'cancelled'
GROUP BY payment_method
ORDER BY cancelled_orders DESC;

-- Compare delivery partner workload
-- Which delivery partners handle the highest number of orders?
select delivery_partner_name,count(order_id) as total_orders from orders
group by delivery_partner_name order by total_orders desc;

-- Which delivery partners have completed the highest number of deliveries?
select delivery_partner_name,count(order_id) as completed_deliveries from orders 
where delivery_status='Delivered'
group by delivery_partner_name order by completed_deliveries desc;

-- Which delivery partners have the highest pending deliveries?
select delivery_partner_name,count(order_id) as pending_deliveries from orders 
where delivery_status='Pending'
group by delivery_partner_name order by pending_deliveries desc;

-- Compare delivered and cancelled orders handled by delivery partners.
SELECT
    delivery_partner_name,
    COUNT(order_id) AS total_orders,

    SUM(
        CASE
            WHEN LOWER(delivery_status) = 'delivered'
            THEN 1 ELSE 0
        END
    ) AS delivered_orders,

    SUM(
        CASE
            WHEN LOWER(order_status) = 'cancelled'
            THEN 1 ELSE 0
        END
    ) AS cancelled_orders

FROM orders
WHERE delivery_partner_name IS NOT NULL
GROUP BY delivery_partner_name
ORDER BY delivered_orders DESC;

-- 6. Examine operational patterns by date and time
-- Which months have the highest delivery volume?
SELECT
    YEAR(order_date) AS order_year,
    MONTHNAME(order_date) AS order_month,
    COUNT(order_id) AS total_deliveries
FROM orders
WHERE LOWER(delivery_status) = 'delivered'
GROUP BY
    YEAR(order_date),
    MONTH(order_date),
    MONTHNAME(order_date)
ORDER BY total_deliveries DESC;

-- 4.5 Understand Menu Item Usage and Product Engagement

-- Compare different menu item categories.
-- How many menu items are available in each category?
SELECT
    item_category,
    COUNT(menu_item_id) AS total_items
FROM menu_items
GROUP BY item_category
ORDER BY total_items DESC;

-- Which menu categories generate the highest revenue?
SELECT
    m.item_category,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    SUM(oi.quantity) AS total_quantity,
    ROUND(SUM(oi.subtotal), 2) AS total_revenue
FROM menu_items m
JOIN order_items oi
    ON m.menu_item_id = oi.menu_item_id
GROUP BY m.item_category
ORDER BY total_revenue DESC;

-- 2. Examine quantity sold and sales value
-- Which menu items are sold in the highest quantities?
SELECT
    m.menu_item_id,
    m.item_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM menu_items m
JOIN order_items oi
    ON m.menu_item_id = oi.menu_item_id
GROUP BY
    m.menu_item_id,
    m.item_name
ORDER BY total_quantity_sold DESC;

-- Which menu items generate the highest revenue?
SELECT
    m.item_name,
    SUM(oi.quantity) AS total_quantity,
    ROUND(SUM(oi.subtotal), 2) AS total_revenue
FROM menu_items m
JOIN order_items oi
    ON m.menu_item_id = oi.menu_item_id
GROUP BY
    m.menu_item_id,
    m.item_name
ORDER BY total_revenue DESC;

-- What is the average revenue generated per menu item?
SELECT
    m.item_name,
    ROUND(AVG(oi.subtotal), 2) AS avg_subtotal,
    SUM(oi.quantity) AS total_quantity
FROM menu_items m
JOIN order_items oi
    ON m.menu_item_id = oi.menu_item_id
GROUP BY
    m.menu_item_id,
    m.item_name
ORDER BY avg_subtotal DESC;

-- 3. Compare vegetarian and non-vegetarian items

-- How many vegetarian and non-vegetarian menu items are available?
SELECT
    vegetarian,
    COUNT(menu_item_id) AS total_items
FROM menu_items
GROUP BY vegetarian
ORDER BY total_items DESC;

-- Which category generates the highest revenue: vegetarian or non-vegetarian?
SELECT
    m.vegetarian,
    SUM(oi.quantity) AS total_quantity_sold,
    ROUND(SUM(oi.subtotal), 2) AS total_revenue
FROM menu_items m
JOIN order_items oi
    ON m.menu_item_id = oi.menu_item_id
GROUP BY m.vegetarian
ORDER BY total_revenue DESC;

-- Which vegetarian items are most popular?
SELECT
    m.item_name,
    SUM(oi.quantity) AS total_quantity_sold,
    ROUND(SUM(oi.subtotal), 2) AS total_revenue
FROM menu_items m
JOIN order_items oi
    ON m.menu_item_id = oi.menu_item_id
WHERE LOWER(m.vegetarian) = 'yes'
GROUP BY
    m.menu_item_id,
    m.item_name
ORDER BY total_quantity_sold DESC;

-- Which non-vegetarian items are most popular?
SELECT
    m.item_name,
    SUM(oi.quantity) AS total_quantity_sold,
    ROUND(SUM(oi.subtotal), 2) AS total_revenue
FROM menu_items m
JOIN order_items oi
    ON m.menu_item_id = oi.menu_item_id
WHERE LOWER(m.vegetarian) = 'no'
GROUP BY
    m.menu_item_id,
    m.item_name
ORDER BY total_quantity_sold DESC;

-- 4. Compare active and inactive menu items
SELECT
    item_status,
    COUNT(menu_item_id) AS total_items
FROM menu_items
GROUP BY item_status
ORDER BY total_items DESC;

-- Which active menu items generate the highest revenue?
SELECT
    m.item_name,
    SUM(oi.quantity) AS total_quantity,
    ROUND(SUM(oi.subtotal), 2) AS total_revenue
FROM menu_items m
JOIN order_items oi
    ON m.menu_item_id = oi.menu_item_id
WHERE LOWER(m.item_status) = 'active'
GROUP BY
    m.menu_item_id,
    m.item_name
ORDER BY total_revenue DESC;

-- 5. Examine availability and preparation time
-- How many menu items are available and unavailable?
SELECT
    availability,
    COUNT(menu_item_id) AS total_items
FROM menu_items
GROUP BY availability
ORDER BY total_items DESC;

-- Which menu items have the longest preparation time?
SELECT
    item_name,
    preparation_time
FROM menu_items
ORDER BY preparation_time DESC
limit 10;

-- What is the average preparation time for each menu category?
SELECT
    item_category,
    ROUND(AVG(preparation_time), 2) AS avg_preparation_time,
    MIN(preparation_time) AS min_preparation_time,
    MAX(preparation_time) AS max_preparation_time
FROM menu_items
GROUP BY item_category
ORDER BY avg_preparation_time DESC;

-- Which available menu items have the shortest preparation time?
SELECT
    item_name,
    price,
    preparation_time,
    availability
FROM menu_items
WHERE LOWER(availability) = 'Yes'
ORDER BY preparation_time ASC
limit 10;

-- 6. Identify high-demand menu items and their associated restaurants
-- Which restaurants offer the most popular menu items?
SELECT
    r.restaurant_name,
    m.item_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM restaurants r
JOIN menu_items m
    ON r.restaurant_id = m.restaurant_id
JOIN order_items oi
    ON m.menu_item_id = oi.menu_item_id
GROUP BY
    r.restaurant_id,
    r.restaurant_name,
    m.menu_item_id,
    m.item_name
ORDER BY total_quantity_sold DESC;

-- What are the top 10 highest revenue-generating menu items and their restaurants?
SELECT
    r.restaurant_name,
    m.item_name,
    SUM(oi.quantity) AS total_quantity,
    ROUND(SUM(oi.subtotal), 2) AS total_revenue
FROM restaurants r
JOIN menu_items m
    ON r.restaurant_id = m.restaurant_id
JOIN order_items oi
    ON m.menu_item_id = oi.menu_item_id
GROUP BY
    r.restaurant_id,
    r.restaurant_name,
    m.menu_item_id,
    m.item_name
ORDER BY total_revenue DESC
LIMIT 10;