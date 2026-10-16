-- E-commerce Sales Analysis Project
-- Dataset: ecommerce_sales_data.csv (synthetic sample data, 500 order records)
-- Suggested database: MySQL 8+
CREATE DATABASE IF NOT EXISTS ecommerce_analysis;
USE ecommerce_analysis;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    Order_ID VARCHAR(12) PRIMARY KEY,
    Order_Date DATE NOT NULL,
    Region VARCHAR(30),
    Sales_Channel VARCHAR(30),
    Category VARCHAR(50),
    Product VARCHAR(100),
    Quantity INT,
    Unit_Price_INR DECIMAL(12,2),
    Discount_Pct DECIMAL(5,2),
    Revenue_INR DECIMAL(14,2),
    Cost_INR DECIMAL(14,2),
    Profit_INR DECIMAL(14,2),
    Payment_Method VARCHAR(40),
    Order_Status VARCHAR(30)
);

-- Import ecommerce_sales_data.csv into the sales table using MySQL Workbench's Table Data Import Wizard.
-- Ensure Order_Date is parsed as DATE and Discount_Pct is stored as a decimal (e.g., 0.10 = 10%).

-- 1. KPI summary
SELECT
    COUNT(*) AS total_orders,
    SUM(Quantity) AS units_sold,
    ROUND(SUM(Revenue_INR), 2) AS total_revenue_inr,
    ROUND(SUM(Profit_INR), 2) AS total_profit_inr,
    ROUND(100 * SUM(Profit_INR) / NULLIF(SUM(Revenue_INR), 0), 2) AS profit_margin_pct
FROM sales
WHERE Order_Status = 'Delivered';

-- 2. Monthly revenue and profit
SELECT DATE_FORMAT(Order_Date, '%Y-%m') AS month,
       ROUND(SUM(Revenue_INR), 2) AS revenue_inr,
       ROUND(SUM(Profit_INR), 2) AS profit_inr,
       COUNT(*) AS order_count
FROM sales
WHERE Order_Status = 'Delivered'
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY month;

-- 3. Category performance
SELECT Category,
       ROUND(SUM(Revenue_INR), 2) AS revenue_inr,
       ROUND(SUM(Profit_INR), 2) AS profit_inr,
       SUM(Quantity) AS units_sold
FROM sales
WHERE Order_Status = 'Delivered'
GROUP BY Category
ORDER BY revenue_inr DESC;

-- 4. Top 10 products by revenue
SELECT Product, Category,
       ROUND(SUM(Revenue_INR), 2) AS revenue_inr,
       SUM(Quantity) AS units_sold
FROM sales
WHERE Order_Status = 'Delivered'
GROUP BY Product, Category
ORDER BY revenue_inr DESC
LIMIT 10;

-- 5. Regional performance
SELECT Region,
       ROUND(SUM(Revenue_INR), 2) AS revenue_inr,
       ROUND(SUM(Profit_INR), 2) AS profit_inr
FROM sales
WHERE Order_Status = 'Delivered'
GROUP BY Region
ORDER BY revenue_inr DESC;

-- 6. Sales channel performance
SELECT Sales_Channel,
       COUNT(*) AS orders,
       ROUND(SUM(Revenue_INR), 2) AS revenue_inr,
       ROUND(SUM(Profit_INR), 2) AS profit_inr
FROM sales
WHERE Order_Status = 'Delivered'
GROUP BY Sales_Channel
ORDER BY revenue_inr DESC;

-- 7. Return/cancellation rate
SELECT Order_Status, COUNT(*) AS order_count,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM sales), 2) AS pct_of_all_records
FROM sales
GROUP BY Order_Status
ORDER BY order_count DESC;

-- 8. Discount impact (delivered orders)
SELECT CASE
         WHEN Discount_Pct = 0 THEN 'No discount'
         WHEN Discount_Pct <= 0.10 THEN '1-10%'
         ELSE 'Above 10%'
       END AS discount_band,
       COUNT(*) AS orders,
       ROUND(AVG(Revenue_INR), 2) AS avg_order_revenue,
       ROUND(AVG(Profit_INR), 2) AS avg_order_profit
FROM sales
WHERE Order_Status = 'Delivered'
GROUP BY discount_band
ORDER BY orders DESC;
