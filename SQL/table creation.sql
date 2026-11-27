create database mysql_project;
use mysql_project;

CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    gender VARCHAR(20),
    date_of_birth DATE,
    registration_date DATE,
    city VARCHAR(50),
    state VARCHAR(50),
    pincode VARCHAR(10),
    customer_status VARCHAR(20),
    preferred_payment_method VARCHAR(50)
);

CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    restaurant_id VARCHAR(20),
    order_date DATE,
    order_time TIME,
    delivery_address VARCHAR(255),
    payment_method VARCHAR(50),
    payment_status VARCHAR(30),
    order_status VARCHAR(30),
    delivery_status VARCHAR(30),
    delivery_partner_name VARCHAR(100),
    discount_amount DECIMAL(10,2),
    total_amount DECIMAL(10,2),

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

CREATE TABLE restaurants (
    restaurant_id VARCHAR(20) PRIMARY KEY,
    restaurant_name VARCHAR(100),
    cuisine_type VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    rating DECIMAL(2,1),
    price_range VARCHAR(30),
    opening_time TIME,
    closing_time TIME,
    restaurant_status VARCHAR(20)
);

CREATE TABLE menu_items (
    menu_item_id VARCHAR(20) PRIMARY KEY,
    restaurant_id VARCHAR(20),
    item_name VARCHAR(100),
    cuisine_type VARCHAR(50),
    item_category VARCHAR(50),
    price DECIMAL(10,2),
    preparation_time INT,
    vegetarian VARCHAR(10),
    availability VARCHAR(20),
    item_status VARCHAR(20),

    FOREIGN KEY (restaurant_id)
    REFERENCES restaurants(restaurant_id)
);

CREATE TABLE order_items (
    order_item_id VARCHAR(20) PRIMARY KEY,
    order_id VARCHAR(20),
    menu_item_id VARCHAR(20),
    quantity INT,
    unit_price DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    item_status VARCHAR(30),

    FOREIGN KEY (order_id)
    REFERENCES orders(order_id),

    FOREIGN KEY (menu_item_id)
    REFERENCES menu_items(menu_item_id)
);

select * from customers;
select * from restaurants;
select * from menu_items;
select * from orders;
select * from order_items;