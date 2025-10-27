/* Problem 06
Write a stored procedure to calculate the total sales and profit 
for a specific employee within a given date range.
- Purpose: allow quick performance analysis for any employee across custom time periods.
- Why? To measure how well each employee performs within specific time frames and assist management 
  in monitoring seasonal or campaign-based performance changes.
*/

-- ✅ Step 1: Create the stored procedure
USE [SQL_Sales_Analysis];
GO

CREATE PROCEDURE GetEmployeeSalesProfit
    @EmployeeID INT,
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SET NOCOUNT ON;

SELECT
        e.NAME AS Employee_Name,
        ROUND(SUM(o.SALES),2) AS Total_Sales,
        ROUND(SUM(o.PROFIT),2) AS Total_Profit
    FROM [ORDERS] AS o
    INNER JOIN [EMPLOYEES] AS e
        ON o.ID_EMPLOYEE = e.ID_EMPLOYEE
    WHERE
        o.ID_EMPLOYEE = @EmployeeID
        AND o.ORDER_DATE BETWEEN @StartDate AND @EndDate
    GROUP BY e.NAME;
END;


-- ✅ Step 2: Execute the procedure to get the result
EXEC GetEmployeeSalesProfit 
    @EmployeeID = 8,
    @StartDate = '2016-12-01',
    @EndDate = '2016-12-31';

/*
Insights

Focus: evaluates an employee’s total sales and profit within a selected date range, 
helping to measure short-term and long-term performance.

Key findings:
- The stored procedure dynamically adapts to any employee or date range — enabling deeper month-to-month 
  or quarter-to-quarter comparisons.
- Useful for identifying top performers, low-performing periods, or employees who excel during 
  promotional campaigns or holidays.

  Key Takeaway:
- Sales managers can reuse this procedure to monitor performance trends by employee and timeframe.
- Enables fast decision-making for bonuses, training focus, or sales strategy adjustments.
- Supports integration into dashboards for real-time performance tracking across teams.
*/