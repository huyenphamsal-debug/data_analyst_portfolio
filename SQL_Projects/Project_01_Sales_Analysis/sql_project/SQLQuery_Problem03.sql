/* 
Problem 03
Determine the top-performing product categories within each customer segment based on sales and profit.
- identify which product categories generate the highest sales and profit per customer segment.
- focus only on the top two categories for profitability within each segment.
- why? to pinpoint which categories contribute most to revenue and profit for each type of customer, guiding future marketing and product strategies.


*/
with category_summary as (
    select
        c.segment,
        p.category,
        sum(o.sales) as total_sales,
        sum(o.profit) as total_profit
    from orders as o
    inner join product as p
        on o.product_id = p.id
    inner join customer as c
        on o.customer_id = c.id
    group by c.segment, p.category
),
ranked as (
    select
        segment,
        category,
        rank() over (partition by segment order by total_sales desc) as sales_rank,
        rank() over (partition by segment order by total_profit desc) as profit_rank
    from category_summary
)
select
    *
from ranked
where profit_rank <= 2
order by segment, profit_rank;


/*
Insights
========
Focus: identifies the most profitable product categories for each customer segment.

Key findings
- Consumer Segment: Copiers and Phones lead profitability — high-value personal purchases.
- Corporate Segment: Copiers remain the strongest, followed by Accessories — driven by office procurement needs.
- Home Office Segment: Copiers again dominate, showing consistent performance across all segments.-

why it matters:
- Copiers are the universal profit driver across all customer types.
- Phones appeal more to consumers, while Accessories perform well in corporate markets.
- Insights help target marketing campaigns by segment such as  tech promotions for consumers, office supply bundles for corporate clients.
*/