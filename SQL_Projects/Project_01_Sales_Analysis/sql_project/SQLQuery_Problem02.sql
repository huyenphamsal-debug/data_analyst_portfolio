/*
Problem 02 : analyze the impact of different discount levels on sales performance across product categories.
- categorize discounts into four levels: no, low, medium, and high.
- measure performance by counting total orders and total profit in each category.
- why? to identify which discount levels drive higher profits and sales volume.

discount level conditions:
------------------------------------
no discount       = 0
low discount      = 0 < discount <= 0.2
medium discount   = 0.2 < discount <= 0.5
high discount     = discount > 0.5
*/

SELECT 
    p.Category,
    CASE 
        WHEN o.discount = 0 THEN 'No Discount'
        WHEN o.discount > 0 AND o.discount <= 0.2 THEN 'Low Discount'
        WHEN o.discount > 0.2 AND o.discount <= 0.5 THEN 'Medium Discount'
        WHEN o.discount > 0.5 THEN 'High Discount'
    END AS Discount_class,
    COUNT(DISTINCT o.order_id) AS Number_of_orders,
    ROUND(SUM(o.profit), 2) AS Total_profit
FROM orders AS o
INNER JOIN product AS p
    ON o.product_id = p.id
GROUP BY 
    p.category,
    CASE 
        WHEN o.discount = 0 THEN 'No Discount'
        WHEN o.discount > 0 AND o.discount <= 0.2 THEN 'Low Discount'
        WHEN o.discount > 0.2 AND o.discount <= 0.5 THEN 'Medium Discount'
        WHEN o.discount > 0.5 THEN 'High Discount'
    END
ORDER BY 
    p.category, 
    discount_class;

/* Insights

Focus: evaluates how different discount strategies impact order volume and profitability across product categories.

Key findings:
- no discount generates the highest total orders and profit across all categories, proving strong customer demand even without incentives.
- low discounts (≤0.2) bring a slight volume increase but reduce overall profit margins.
- medium and high discounts (>0.2) result in declining profits, with some categories turning negative due to over-discounting.
- categories like phones and binders remain profitable without discounts, highlighting their inelastic demand.

📊 why it matters:
understanding how discount levels affect performance enables data-driven pricing strategies —
maximize profitability by maintaining regular pricing for high-demand products and applying limited discounts
only for clearance or slow-moving inventory.
*/