CREATE DATABASE IF NOT EXISTS ecommerce_dw;
USE ecommerce_dw;

DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_customer;
DROP TABLE IF EXISTS dim_product;
DROP TABLE IF EXISTS dim_delivery;

CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL UNIQUE,
    year SMALLINT NOT NULL,
    quarter TINYINT NOT NULL,
    month TINYINT NOT NULL,
    month_name VARCHAR(10) NOT NULL,
    week_of_year TINYINT NOT NULL,
    day_of_month TINYINT NOT NULL,
    day_name VARCHAR(10) NOT NULL,
    KEY idx_date_year_quarter (year, quarter),
    KEY idx_date_year_month (year, month)
) ENGINE=InnoDB;

CREATE TABLE dim_customer (
    customer_key INT AUTO_INCREMENT PRIMARY KEY,
    source_user_id INT NOT NULL UNIQUE,
    username VARCHAR(255) NOT NULL,
    customer_name VARCHAR(511) NOT NULL,
    city VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    gender VARCHAR(20) NOT NULL,
    birth_date DATE NULL,
    KEY idx_customer_location (country, city),
    KEY idx_customer_gender (gender)
) ENGINE=InnoDB;

CREATE TABLE dim_product (
    product_key INT AUTO_INCREMENT PRIMARY KEY,
    source_product_id INT NOT NULL UNIQUE,
    product_code VARCHAR(255) NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    category VARCHAR(255) NOT NULL,
    KEY idx_product_category (category),
    KEY idx_product_name (product_name)
) ENGINE=InnoDB;

CREATE TABLE dim_delivery (
    delivery_key INT AUTO_INCREMENT PRIMARY KEY,
    source_rider_id INT NULL UNIQUE,
    rider_name VARCHAR(511) NOT NULL,
    vehicle_type VARCHAR(255) NOT NULL,
    courier_name VARCHAR(255) NOT NULL,
    rider_gender VARCHAR(20) NOT NULL,
    KEY idx_delivery_courier (courier_name),
    KEY idx_delivery_vehicle (vehicle_type)
) ENGINE=InnoDB;

CREATE TABLE fact_sales (
    sales_key BIGINT AUTO_INCREMENT PRIMARY KEY,
    source_order_id INT NOT NULL,
    order_number VARCHAR(255) NOT NULL,
    date_key INT NOT NULL,
    customer_key INT NULL,
    product_key INT NOT NULL,
    delivery_key INT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(12,2) NOT NULL,
    line_total DECIMAL(14,2) NOT NULL,
    order_count TINYINT NOT NULL DEFAULT 1,
    UNIQUE KEY uq_fact_order_product (source_order_id, product_key),
    KEY idx_fact_date_product (date_key, product_key),
    KEY idx_fact_customer_date (customer_key, date_key),
    KEY idx_fact_delivery_date (delivery_key, date_key),
    CONSTRAINT fk_fact_date FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
    CONSTRAINT fk_fact_customer FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key),
    CONSTRAINT fk_fact_product FOREIGN KEY (product_key) REFERENCES dim_product(product_key),
    CONSTRAINT fk_fact_delivery FOREIGN KEY (delivery_key) REFERENCES dim_delivery(delivery_key)
) ENGINE=InnoDB;
