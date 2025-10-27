/*
Problem 05 : Develop a user-defined function in sql server to calculate the profitability ratio 
for each product category an employee has sold, and then apply this function to generate a report 
that sorts each employee's product categories by their profitability ratio.
- Profitability ratio = total profit / total sales.
- why? to measure how efficiently each employee converts sales into profit across various product categories.
*/

--  step 1: create the user-defined function (UDF)
create function dbo.fn_profitability_ratio
(
    @employee_id int,
    @category varchar(255)
)
returns decimal(10,2)
as
begin
    declare @profit_ratio decimal(10,2);

    select 
        @profit_ratio = 
            case 
                when sum(o.sales) = 0 then 0
                else (sum(o.profit) / sum(o.sales))
            end
    from orders o
    join product p on o.product_id = p.id
    where o.id_employee = @employee_id
      and p.category = @category;

    return @profit_ratio;
end;
go


-- ✅ step 2: apply the function to generate the profitability report
SELECT
    o.id_employee,
    p.category,
    ROUND(SUM(o.sales), 2) AS total_sales,
    ROUND(SUM(o.profit), 2) AS total_profit,
    dbo.fn_profitability_ratio(o.id_employee, p.category) AS profitability_ratio
FROM orders AS o
JOIN product AS p 
    ON o.product_id = p.id
GROUP BY 
    o.id_employee, 
    p.category
ORDER BY 
    o.id_employee, 
    profitability_ratio DESC;



/*
Insights

Focus: evaluates each employee’s efficiency in turning sales into profit across product categories.

Key findings:
- Labels, Paper, and Envelopes show the highest profitability ratios (≈0.40–0.48) — proving they’re the most efficient categories in converting sales into profit.
- Copiers consistently maintain a strong ratio (~0.45), indicating high-margin performance and reliable sales returns.
- Accessories and Fasteners remain moderately profitable (~0.30–0.35), suggesting steady but limited margin potential.
- Chairs, Tables, and Supplies often show negative or near-zero ratios, pointing to poor profitability and potential over-discounting or high costs.
- The overall pattern is consistent across employees — indicating shared product focus and pricing strategy within the sales team.

Key Takeaway:
- High-margin categories (Labels, Paper, Copiers) should be prioritized in promotions, stock planning, and employee sales focus.
- Low-margin products (Furniture & Supplies) require pricing review or cost optimization to avoid losses.
- The profitability ratio metric is more insightful than sales volume — it highlights efficiency and profit quality, not just quantity.
- Managers can use this ratio to reward top performers, refine sales incentives, and guide training efforts toward underperforming product categories.
*/