-- ============================================
-- APPLE SUPPLY CHAIN ANALYTICS PROJECT
-- ============================================

CREATE DATABASE IF NOT EXISTS APPLE_PROJECT;

USE APPLE_PROJECT;

-- ============================================
-- DROP TABLE IF EXISTS
-- ============================================

DROP TABLE IF EXISTS apple_supply_chain_master;

-- ============================================
-- TABLE CREATION
-- ============================================

CREATE TABLE apple_supply_chain_master (
    order_id                     VARCHAR(20),
    order_date                   DATE,
    year                         INT,
    month                        INT,
    quarter                      VARCHAR(5),

    product_category             VARCHAR(30),
    product_name                 VARCHAR(60),
    product_launch_year          INT,

    region                       VARCHAR(30),
    country                      VARCHAR(30),
    city                         VARCHAR(40),

    sales_channel                VARCHAR(30),

    supplier_name                VARCHAR(50),
    supplier_country             VARCHAR(30),

    warehouse_region             VARCHAR(30),
    warehouse_name               VARCHAR(40),

    shipping_mode                VARCHAR(15),
    shipment_status              VARCHAR(20),

    lead_time_days               INT,
    delay_days                   INT,

    units_sold                   INT,

    unit_cost                    DECIMAL(10,2),
    selling_price                DECIMAL(10,2),

    total_revenue                DECIMAL(14,2),
    total_cost                   DECIMAL(14,2),
    profit                       DECIMAL(14,2),

    inventory_level              INT,
    reorder_level                INT,
    stock_status                 VARCHAR(20),

    transportation_cost          DECIMAL(10,2),

    supplier_defect_rate         DECIMAL(6,4),
    supplier_rating              DECIMAL(3,1),

    return_quantity              INT,
    return_reason                VARCHAR(40),

    customer_satisfaction_score  DECIMAL(3,1)
);

-- ============================================
-- LOAD DATA
-- ============================================

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/apple_supply_chain_master.csv'
INTO TABLE apple_supply_chain_master
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    order_id,
    order_date,
    year,
    month,
    quarter,

    product_category,
    product_name,
    product_launch_year,

    region,
    country,
    city,

    sales_channel,

    supplier_name,
    supplier_country,

    warehouse_region,
    warehouse_name,

    shipping_mode,
    shipment_status,

    lead_time_days,
    delay_days,

    units_sold,

    unit_cost,
    selling_price,

    total_revenue,
    total_cost,
    profit,

    inventory_level,
    reorder_level,
    stock_status,

    transportation_cost,

    supplier_defect_rate,
    supplier_rating,

    return_quantity,
    return_reason,

    customer_satisfaction_score
);

-- ============================================
-- DATA VALIDATION
-- ============================================

-- Total Rows
SELECT COUNT(*) AS total_rows
FROM apple_supply_chain_master;

-- Null Value Check
SELECT
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS null_order_id,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS null_order_date,
    SUM(CASE WHEN product_name IS NULL THEN 1 ELSE 0 END) AS null_product_name,
    SUM(CASE WHEN supplier_name IS NULL THEN 1 ELSE 0 END) AS null_supplier_name,
    SUM(CASE WHEN total_revenue IS NULL THEN 1 ELSE 0 END) AS null_revenue,
    SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END) AS null_profit
FROM apple_supply_chain_master;

-- Duplicate Orders
SELECT
    order_id,
    COUNT(*) AS duplicate_count
FROM apple_supply_chain_master
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Negative Values Check
SELECT COUNT(*) AS negative_values
FROM apple_supply_chain_master
WHERE units_sold < 0
   OR total_revenue < 0
   OR profit < 0
   OR unit_cost < 0;

-- Invalid Date Check
SELECT COUNT(*) AS invalid_dates
FROM apple_supply_chain_master
WHERE order_date < '2023-01-01'
   OR order_date > '2026-05-17';

-- Invalid Customer Satisfaction Score
SELECT COUNT(*) AS invalid_csat
FROM apple_supply_chain_master
WHERE customer_satisfaction_score < 1
   OR customer_satisfaction_score > 5;

-- ============================================
-- OVERVIEW ANALYSIS
-- ============================================

-- Total Revenue
SELECT
    ROUND(SUM(total_revenue)/1e9,2) AS total_revenue_billion
FROM apple_supply_chain_master;

-- Total Profit
SELECT
    ROUND(SUM(profit)/1e9,2) AS total_profit_billion
FROM apple_supply_chain_master;

-- Total Units Sold
SELECT
    SUM(units_sold) AS total_units_sold
FROM apple_supply_chain_master;

-- Revenue by Product Category
SELECT
    product_category,
    ROUND(SUM(total_revenue)/1e9,2) AS revenue_billion
FROM apple_supply_chain_master
GROUP BY product_category
ORDER BY revenue_billion DESC;

-- Revenue by Region
SELECT
    region,
    ROUND(SUM(total_revenue)/1e9,2) AS revenue_billion
FROM apple_supply_chain_master
GROUP BY region
ORDER BY revenue_billion DESC;

-- Monthly Revenue Trend
SELECT
    year,
    month,
    ROUND(SUM(total_revenue)/1e6,2) AS revenue_million
FROM apple_supply_chain_master
GROUP BY year, month
ORDER BY year, month;

-- ============================================
-- INVENTORY ANALYSIS
-- ============================================

-- Overstock Products
SELECT
    product_name,
    inventory_level,
    reorder_level
FROM apple_supply_chain_master
WHERE stock_status = 'Overstock';

-- Understock Products
SELECT
    product_name,
    inventory_level,
    reorder_level
FROM apple_supply_chain_master
WHERE stock_status = 'Understock';

-- Inventory Status Distribution
SELECT
    stock_status,
    COUNT(*) AS total_records
FROM apple_supply_chain_master
GROUP BY stock_status;

-- Warehouse Inventory Analysis
SELECT
    warehouse_name,
    ROUND(AVG(inventory_level),2) AS avg_inventory
FROM apple_supply_chain_master
GROUP BY warehouse_name
ORDER BY avg_inventory DESC;

-- ============================================
-- SUPPLIER PERFORMANCE ANALYSIS
-- ============================================

-- Supplier Defect Analysis
SELECT
    supplier_name,
    ROUND(AVG(supplier_defect_rate)*100,2) AS defect_percent
FROM apple_supply_chain_master
GROUP BY supplier_name
ORDER BY defect_percent DESC;

-- Supplier Rating Analysis
SELECT
    supplier_name,
    ROUND(AVG(supplier_rating),2) AS avg_rating
FROM apple_supply_chain_master
GROUP BY supplier_name
ORDER BY avg_rating DESC;

-- Suppliers Causing Delays
SELECT
    supplier_name,
    ROUND(AVG(delay_days),2) AS avg_delay
FROM apple_supply_chain_master
GROUP BY supplier_name
ORDER BY avg_delay DESC;

-- Supplier Return Analysis
SELECT
    supplier_name,
    SUM(return_quantity) AS total_returns
FROM apple_supply_chain_master
GROUP BY supplier_name
ORDER BY total_returns DESC;

-- ============================================
-- LOGISTICS ANALYSIS
-- ============================================

-- Shipping Mode Analysis
SELECT
    shipping_mode,
    ROUND(AVG(transportation_cost),2) AS avg_transport_cost,
    ROUND(AVG(lead_time_days),2) AS avg_delivery_days
FROM apple_supply_chain_master
GROUP BY shipping_mode;

-- Shipment Status Distribution
SELECT
    shipment_status,
    COUNT(*) AS total_shipments
FROM apple_supply_chain_master
GROUP BY shipment_status;

-- Transportation Cost Trend
SELECT
    year,
    month,
    ROUND(SUM(transportation_cost)/1e6,2) AS transport_million
FROM apple_supply_chain_master
GROUP BY year, month
ORDER BY year, month;

-- Most Expensive Shipping Routes
SELECT
    country,
    shipping_mode,
    ROUND(SUM(transportation_cost),2) AS total_cost
FROM apple_supply_chain_master
GROUP BY country, shipping_mode
ORDER BY total_cost DESC
LIMIT 10;

-- ============================================
-- SALES ANALYSIS
-- ============================================

-- Top Products by Revenue
SELECT
    product_name,
    ROUND(SUM(total_revenue)/1e6,2) AS revenue_million
FROM apple_supply_chain_master
GROUP BY product_name
ORDER BY revenue_million DESC
LIMIT 10;

-- Top Countries by Revenue
SELECT
    country,
    ROUND(SUM(total_revenue)/1e9,2) AS revenue_billion
FROM apple_supply_chain_master
GROUP BY country
ORDER BY revenue_billion DESC;

-- Customer Satisfaction Analysis
SELECT
    shipment_status,
    ROUND(AVG(customer_satisfaction_score),2) AS avg_csat
FROM apple_supply_chain_master
GROUP BY shipment_status;

-- Return Reason Analysis
SELECT
    return_reason,
    COUNT(*) AS total_returns
FROM apple_supply_chain_master
GROUP BY return_reason
ORDER BY total_returns DESC;

-- ============================================
-- ADVANCED SQL ANALYSIS
-- ============================================

-- Product Revenue Ranking
SELECT
    product_name,
    SUM(total_revenue) AS revenue,
    RANK() OVER(ORDER BY SUM(total_revenue) DESC) AS revenue_rank
FROM apple_supply_chain_master
GROUP BY product_name;

-- Running Revenue Total
SELECT
    order_date,
    total_revenue,
    SUM(total_revenue)
    OVER(ORDER BY order_date) AS running_total
FROM apple_supply_chain_master;

-- High Profit Products Using CTE
WITH high_profit_products AS (
    SELECT
        product_name,
        SUM(profit) AS total_profit
    FROM apple_supply_chain_master
    GROUP BY product_name
)
SELECT *
FROM high_profit_products
WHERE total_profit > 1000000;

-- ============================================
-- VIEWS
-- ============================================

-- Executive Summary View
CREATE VIEW executive_summary AS
SELECT
    ROUND(SUM(total_revenue)/1e9,2) AS total_revenue_billion,
    ROUND(SUM(profit)/1e9,2) AS total_profit_billion,
    SUM(units_sold) AS total_units_sold,
    ROUND(AVG(customer_satisfaction_score),2) AS avg_customer_satisfaction
FROM apple_supply_chain_master;

-- Supplier Performance View
CREATE VIEW supplier_performance AS
SELECT
    supplier_name,
    ROUND(AVG(supplier_defect_rate)*100,2) AS defect_percent,
    ROUND(AVG(delay_days),2) AS avg_delay_days,
    ROUND(AVG(supplier_rating),2) AS avg_supplier_rating
FROM apple_supply_chain_master
GROUP BY supplier_name;

-- Logistics Performance View
CREATE VIEW logistics_performance AS
SELECT
    shipping_mode,
    ROUND(AVG(lead_time_days),2) AS avg_lead_time,
    ROUND(AVG(transportation_cost),2) AS avg_transport_cost
FROM apple_supply_chain_master
GROUP BY shipping_mode;

-- ============================================
-- VIEW CHECKS
-- ============================================

SELECT * FROM executive_summary;

SELECT * FROM supplier_performance;

SELECT * FROM logistics_performance;

-- ============================================
-- END OF PROJECT
-- ============================================