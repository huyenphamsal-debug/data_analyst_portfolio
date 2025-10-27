/* Problem 07:
Question: Write a dynamic SQL query to calculate the total profit for the last six quarters 
in the dataset, pivoted by quarter of the year for each state.
- Display total profit per state, broken down by quarter.
- Automatically adjust to always show the most recent six quarters.
- Why? To analyze quarterly profit trends across regions and detect recent performance shifts.
*/

DECLARE @cols NVARCHAR(MAX);
DECLARE @sql NVARCHAR(MAX);

-- 🧩 Step 1: Get the last six quarters dynamically
SELECT @cols = STRING_AGG(QUOTENAME(Quarter_Year), ',')
FROM (
    SELECT DISTINCT 
        CONCAT('Q', DATEPART(QUARTER, ORDER_DATE), '-', YEAR(ORDER_DATE)) AS Quarter_Year
        
    FROM ORDERS
    WHERE ORDER_DATE >= DATEADD(QUARTER, -6, (SELECT MAX(ORDER_DATE) FROM ORDERS))
) q
;

-- 🧠 Step 2: Build the dynamic pivot SQL
SET @sql = '
SELECT STATE, ' + @cols + '
FROM (
    SELECT 
        c.STATE,
        CONCAT(''Q'', DATEPART(QUARTER, o.ORDER_DATE), ''-'', YEAR(o.ORDER_DATE)) AS Quarter_Year,
        o.PROFIT
    FROM ORDERS o
    INNER JOIN CUSTOMER c 
        ON o.CUSTOMER_ID = c.ID
    WHERE o.ORDER_DATE >= DATEADD(QUARTER, -6, (SELECT MAX(ORDER_DATE) FROM ORDERS))
) src
PIVOT (
    SUM(PROFIT)
    FOR Quarter_Year IN (' + @cols + ')
) AS pvt
ORDER BY STATE;';

-- 🚀 Step 3: Execute the SQL
EXEC sp_executesql @sql;



/*

Key Findings:
- Profit distribution varies significantly by state, revealing clear regional leaders.
- Some states exhibit consistent growth, while others show volatility quarter to quarter.
- Q4 generally shows strong profit spikes, likely tied to seasonal demand peaks.

Why It Matters:
Dynamic quarter-based profit tracking provides visibility into regional performance trends,
supporting targeted marketing, regional strategy adjustments, and forecasting decisions.
*/
