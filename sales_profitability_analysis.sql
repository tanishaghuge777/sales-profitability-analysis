-- =====================================================
-- PROJECT: SALES PROFITABILITY ANALYSIS
-- TOOL: SQL (SQLite)
-- TABLE: sales
-- OBJECTIVE: Analyze sales, profit, and profitability
-- =====================================================


-- 1. DATA OVERVIEW
-- Count the total number of records in the dataset.

SELECT COUNT(*) AS total_records
FROM sales;


-- 2. OVERALL BUSINESS PERFORMANCE
-- Calculate total sales and total profit.

SELECT
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales;


-- 3. OVERALL PROFIT MARGIN
-- Measure profit earned as a percentage of sales.

SELECT
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) * 100.0 / SUM(Sales),
        2
    ) AS profit_margin_percentage
FROM sales;


-- 4. EXPLORE PRODUCT CATEGORIES
-- Identify the distinct product categories.

SELECT DISTINCT Category
FROM sales;


-- 5. SALES AND PROFIT BY CATEGORY
-- Compare total sales and profit across categories.

SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales
GROUP BY Category
ORDER BY total_profit DESC;


-- 6. PROFIT MARGIN BY CATEGORY
-- Compare category profitability using profit margins.

SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) * 100.0 / SUM(Sales),
        2
    ) AS profit_margin_pct
FROM sales
GROUP BY Category
ORDER BY profit_margin_pct DESC;


-- 7. IDENTIFY LOSS-MAKING SUB-CATEGORIES
-- Rank sub-categories from lowest to highest total profit.

SELECT
    Category,
    "Sub-Category",
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales
GROUP BY Category, "Sub-Category"
ORDER BY total_profit ASC;


-- 8. PROFIT MARGIN BY SUB-CATEGORY
-- Identify sub-categories with the weakest profit margins.

SELECT
    Category,
    "Sub-Category",
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) * 100.0 / SUM(Sales),
        2
    ) AS profit_margin_pct
FROM sales
GROUP BY Category, "Sub-Category"
ORDER BY profit_margin_pct ASC;


-- 9. REGIONAL PERFORMANCE
-- Compare sales, profit, and profit margin across regions.

SELECT
    Region,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) * 100.0 / SUM(Sales),
        2
    ) AS profit_margin_pct
FROM sales
GROUP BY Region
ORDER BY total_profit DESC;


-- 10. CUSTOMER SEGMENT ANALYSIS
-- Evaluate profitability across customer segments.

SELECT
    Segment,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) * 100.0 / SUM(Sales),
        2
    ) AS profit_margin_pct
FROM sales
GROUP BY Segment
ORDER BY total_profit DESC;


-- 11. TOP 10 STATES BY PROFIT
-- Identify the ten most profitable states.

SELECT
    State,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales
GROUP BY State
ORDER BY total_profit DESC
LIMIT 10;


-- 12. INSPECT TABLE STRUCTURE
-- View column names and data types in the sales table.

PRAGMA table_info(sales);


-- 13. EXPLORE ORDER DATE VALUES
-- Inspect a sample of order dates.

SELECT
    "Order Date",
    COUNT(*) AS records
FROM sales
GROUP BY "Order Date"
LIMIT 20;


-- 14. CHECK ORDER DATE FORMATS
-- Count dates containing hyphens.

SELECT COUNT(*) AS hyphen_dates
FROM sales
WHERE "Order Date" LIKE '%-%';


-- Count dates containing slashes.

SELECT COUNT(*) AS slash_dates
FROM sales
WHERE "Order Date" LIKE '%/%';


-- 15. YEARLY SALES AND PROFITABILITY
-- Extract the year from order dates and compare performance.
-- This assumes the year appears in the final four characters.

SELECT
    SUBSTR("Order Date", -4) AS order_year,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) * 100.0 / SUM(Sales),
        2
    ) AS profit_margin_pct
FROM sales
GROUP BY SUBSTR("Order Date", -4)
ORDER BY order_year;
