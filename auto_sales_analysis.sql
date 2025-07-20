 Database Setup
CREATE DATABASE IF NOT EXISTS sale_db;
USE sale_db;

-- Assuming 'auto sales data' is imported into a table.
-- If your table name is different, please adjust the following line.
-- For example, if you imported the CSV as 'auto_sales_raw', you might rename it:
-- ALTER TABLE `auto sales data` RENAME TO `auto_sales`;

-- Verify table content (for initial review)
SELECT * FROM `auto_sales`;

-- 1. Total Sales and Quantity by Product Line
-- Business Problem: The sales department wants to understand which product lines are performing best in terms of total sales revenue and quantity sold. This information helps in inventory management, marketing focus, and strategic planning.
-- SQL Question: Calculate the total sales and total quantity ordered for each product line.
SELECT
    ROUND(SUM(Sales), 2) AS TotalSales,
    SUM(QuantityOrdered) AS TotalQuantity,
    ProductLine
FROM
    `auto_sales`
GROUP BY
    ProductLine
ORDER BY
    TotalSales DESC;
-- Explanation: This query aggregates data by `ProductLine`, calculating the sum of `Sales` and `QuantityOrdered` for each.
-- The `ORDER BY TotalSales DESC` clause ensures that the product lines with the highest sales appear first, providing an immediate overview of top performers.


-- 2. Top 5 Customers by Total Sales
-- Business Problem: The marketing team needs to identify the most valuable customers to develop targeted loyalty programs or special offers.
-- SQL Question: Find the top 5 customers who have generated the highest total sales revenue.
SELECT
    CustomerName,
    ROUND(SUM(Sales), 2) AS TotalSales
FROM
    `auto_sales`
GROUP BY
    CustomerName
ORDER BY
    TotalSales DESC
LIMIT 5;
-- Explanation: This query aggregates sales by `CustomerName` and orders them in descending order.
-- The `LIMIT 5` clause restricts the output to only the top 5 customers, making it easy to identify the most significant revenue contributors.


-- 3. Monthly Sales Trend
-- Business Problem: Management wants to analyze sales trends over time to identify seasonal patterns, growth, or decline. This helps in forecasting and resource allocation.
-- SQL Question: Calculate the total sales for each month and year.
SELECT
    MONTH(OrderDate) AS SalesMonth,
    YEAR(OrderDate) AS SalesYear,
    ROUND(SUM(Sales), 2) AS TotalSales
FROM
    `auto_sales`
GROUP BY
    SalesYear,
    SalesMonth
ORDER BY
    SalesYear,
    SalesMonth;
-- Explanation: This query extracts the year and month from the `OrderDate` column to create `SalesYear` and `SalesMonth` fields.
-- It then groups by these fields to sum `Sales`, providing a clear monthly sales trend.


-- 4. Order Status Distribution
-- Business Problem: The operations team needs to monitor the efficiency of order fulfillment and identify any bottlenecks. Understanding the distribution of order statuses is crucial.
-- SQL Question: Determine the count of orders for each order status (e.g., Shipped, In Process, Cancelled, Disputed, Resolved).
SELECT
    Status,
    COUNT(ORDERNUMBER) AS NumberOfOrders
FROM
    `auto_sales`
GROUP BY
    Status
ORDER BY
    NumberOfOrders DESC;
-- Explanation: This query groups orders by their `Status` and counts the `ORDERNUMBER` for each status.
-- This provides a quick overview of how many orders are in each stage, highlighting areas that might require attention
-- (e.g., a high number of 'Disputed' or 'On Hold' orders).


-- 5. Sales Performance by Country
-- Business Problem: The international sales team needs to assess sales performance across different countries to identify top-performing regions and areas needing improvement or targeted expansion.
-- SQL Question: Calculate the total sales for each country.
SELECT
    Country,
    ROUND(SUM(Sales), 2) AS TotalSales
FROM
    `auto_sales`
GROUP BY
    Country
ORDER BY
    TotalSales DESC;
-- Explanation: This query groups sales data by `Country` and sums the `Sales` for each.
-- It helps in geographical sales analysis, enabling businesses to understand market penetration and allocate resources effectively.


-- 6. Average Order Value by Deal Size
-- Business Problem: The sales strategy team wants to understand the average value of orders based on their 'Deal Size' (Small, Medium, Large). This can inform pricing strategies and sales approach for different customer segments.
-- SQL Question: Calculate the average sales value for each deal size.
SELECT
    DealSize,
    ROUND(AVG(Sales), 2) AS AverageSales
FROM
    `auto_sales`
GROUP BY
    DealSize
ORDER BY
    AverageSales DESC;
-- Explanation: This query calculates the average `Sales` for each `DealSize` category.
-- This insight helps in understanding the typical revenue generated from different types of deals,
-- which can guide sales efforts and customer targeting.


-- 7. Top 3 Products by Sales
-- Business Problem: The product management team needs to identify the best-selling products to prioritize production, marketing campaigns, or even product development efforts.
-- SQL Question: Find the top 3 products (by PRODUCTCODE) based on their total sales.
SELECT
    ProductCode,
    ProductLine,
    ROUND(SUM(Sales), 2) AS TotalSales
FROM
    `auto_sales`
GROUP BY
    ProductCode,
    ProductLine
ORDER BY
    TotalSales DESC
LIMIT 3;
-- Explanation: This query groups sales by `ProductCode` and `ProductLine`, sums the `Sales`, and then limits the result to the top 3.
-- This quickly highlights the most successful products, allowing for data-driven decisions on inventory and promotion.


-- 8. Customers with 'Disputed' Orders
-- Business Problem: The customer service team needs a quick list of customers who have orders with a 'Disputed' status to initiate follow-up and resolve issues promptly, improving customer satisfaction.
-- SQL Question: List all unique customer names who have at least one order with a 'Disputed' status.
SELECT DISTINCT
    CustomerName
FROM
    `auto_sales`
WHERE
    Status = 'Disputed'
ORDER BY
    CustomerName;
-- Explanation: This query selects distinct `CustomerName` entries from the `auto_sales` table where the `Status` is 'Disputed'.
-- This provides a clear, de-duplicated list of customers who require immediate attention from customer service.
