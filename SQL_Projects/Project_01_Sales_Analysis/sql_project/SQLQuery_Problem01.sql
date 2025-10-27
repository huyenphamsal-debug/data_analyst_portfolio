/* Problem 01: 
Question: Calculate total sales of furniture products grouped by each quarter of the year.
- Summarize total sales for furniture products across all quarters.
- Ensure results are chronologically ordered (Q1 → Q4 each year).
- Why? To identify quarterly sales trends and seasonality in the furniture category
*/
SELECT 
    CONCAT('q', DATEPART(quarter, order_date), '-', YEAR(order_date)) AS Quarter_Year,
    ROUND(SUM(sales), 2) AS Total_Sales
FROM orders
WHERE product_id LIKE 'FUR%'
GROUP BY YEAR(order_date), DATEPART(quarter, order_date)
ORDER BY YEAR(order_date), DATEPART(quarter, order_date);


/*
INSIGHTS
Focus: Furniture category sales performance across quarters.

Key Findings:
- Steady quarterly growth observed, consistent demand throughout the year.
- Seasonal pattern: Q4 outperforms other quarters, likely driven by holiday campaigns and seasonal purchases.
- Enables identification of high-performing quarters for inventory and marketing planning.

Why It Matters:
Understanding quarterly sales patterns helps optimize production, plan promotions,
and allocate resources effectively for peak sales periods.
*/