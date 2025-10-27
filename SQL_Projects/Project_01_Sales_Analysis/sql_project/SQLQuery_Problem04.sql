/*
Problem 04:
create a report showing each employee's performance across product categories.
- display total profit (in $) for each category handled by every employee.
- calculate the percentage each category contributes to that employee’s total profit.
- order results by total profit in descending order per employee.
- why? to understand which product categories drive the most profit for each employee and identify their strongest sales focus areas.

*/
SELECT
    o.id_employee,
    p.category,
    ROUND(SUM(o.profit), 2) AS rounded_total_profit,
    ROUND(
        SUM(o.profit) * 100.0 / SUM(SUM(o.profit)) OVER (PARTITION BY o.id_employee),
        2
    ) AS profit_percentage
FROM [orders] AS o
JOIN [product] AS p
    ON o.product_id = p.id
GROUP BY 
    o.id_employee, 
    p.category
ORDER BY 
    o.id_employee, 
    rounded_total_profit DESC;

/*
Here’s the breakdown of employee profit distribution across product categories:
**Category Performance:**
- Copiers consistently deliver the highest profit percentage (~19%), making them the most profitable category for employees.
- Phones and Binders follow closely with ~14% profit share, indicating strong secondary performance.
- Accessories and Paper show moderate profit contributions, while other categories remain comparatively lower.

**Employee Performance:**
- All employees demonstrate similar profit patterns — relying heavily on Copiers and Phones for most of their profit.
- Consistency across employees suggests uniform sales focus or shared product allocation strategy.

**Key Takeaway:**
- Copiers are the top profit driver across all employees and should remain the core focus in product sales strategy.
- To balance revenue streams, employees could increase cross-selling efforts in mid-performing categories like Binders and Accessories.
- Management can use these insights to tailor employee incentive plans around high-profit products.

*/