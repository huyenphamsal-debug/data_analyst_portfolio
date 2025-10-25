# 🍕 Pizza Sales Analysis Dashboard (Power BI)
Image

## 🧭 Business Context
As a Data Analyst for a pizza manufacturing and distribution company, my role was to transform 2015 transactional sales data into actionable insights that could guide strategic business decisions.
The project aimed to analyse key operational metrics, identify sales trends, evaluate product performance, and assess order efficiency using Power BI.

**📂 Dataset:**
- Data_pizza.xlsx – transactional records (2015)
- Data_dictionary.xlsx – metadata for fields and relationships

### Dashboard File
You can find the file for the dashboard here: [`Pizza Analysis_Dashboard.pbix`](Pizza Analaysis_Dashboard.pbix).

## 🧠 Tools & Techniques
Power BI | Power Query | DAX | Data Modeling | Excel | ETL | Data Storytelling | Dashboard Design

## 💡 Skills Showcased
- 🎨 Dashboard Design: Crafted a dark-themed, executive-style interface with clear KPIs and navigation tabs.
- 🧩 Data Modeling: Built a star schema linking 7 tables (FactSales, DimPizza, DimIngredient, DimDate, DimOrderSummary, MergeOrderInterval, PreviousOrder) for scalability.
- ⚙️ Power Query ETL: Performed data cleaning, column extraction, and datetime transformation.
- 🧮 DAX Measures: Created metrics for Total Revenue, Average Order Value, Order Intervals, and Pizza per Order.
- 📊 Visualisation Techniques: Bar & Line Charts (trends), Scatter Plots (correlation quadrants), Donuts (distribution), and Cards (KPIs).
- 🎛️ Interactive Features: Slicers (by Month, Weekday, Category), buttons for page navigation, and dynamic tooltips for data drill-down.

## ❓ Problem
The management team lacked a unified, data-driven view of their business performance.
Key business challenges included:
- 📊 Unclear revenue trends: No understanding of daily, weekly, or seasonal sales behaviour.
- 🍕 Unidentified top-performing products: The company couldn’t tell which pizzas or ingredients drove the most profit.
- 🧀 Inventory inefficiency: Over-purchasing of low-demand ingredients, understocking high-demand ones.
- ⏱️ Operational blind spots: No visibility into order frequency, service gaps, or staff timing needs.
The goal was to build a Power BI dashboard that could answer the seven analytical tasks outlined in the brief — from KPI creation to trend analysis — and deliver a single source of truth for decision-making.

## 🧩 Approach / Methodology

### **1. Data Preparation**
- Imported raw files directly into Power BI (per business rule: no source alteration).
- Cleaned and transformed fields in Power Query, standardising date/time and extracting Hour, Weekday, and Month.
- Split ingredient strings into separate rows to form an Ingredient Dimension — enabling granular ingredient-level analysis.


### **2. Data Modeling (Star Schema)**

Structured an analytical model linking one fact table (data_pizza) with multiple dimension tables for Date, Pizza, Ingredient, and Order Summary, supported by operational tables for order intervals.

All relationships were one-to-many flowing toward the fact table to maintain query efficiency.
Schema highlights:
- data_pizz (FactSales) – transactional core
- Date dim – generated via DAX
- pizza dim – pizza details (category, size, price)
- Ingredient dim – ingredient breakdown
- OrderSummary – order-level aggregation
- MergeOrderInterval & PreviousOrder – operational tables for time-gap analysis

### **3. DAX Implementation**

**3.1 Date Dimension Table**
```
Date dim =
ADDCOLUMNS(
    CALENDAR(MIN(data_pizza[date]), MAX(data_pizza[date])),
    "Year", YEAR([Date]),
    "Month Number", MONTH([Date]),
    "Month Name", FORMAT([Date], "MMMM"),
    "Weekday Name", FORMAT([Date], "DDDD"),
    "Date Key", FORMAT([Date], "YYYYMMDD"),
    "Week Number", WEEKNUM([Date], 2),
    "Weekday Number", WEEKDAY([Date], 2)
)
```
✅ Enables time-intelligence functions for daily, weekly, and monthly analysis.

**3.2 Ingredient Normalisation**

Split multi-ingredient strings (e.g., “Tomato, Garlic, Cheese”) into separate rows using Split Row by Delimiter in Power Query.
Linked Ingredient dim → pizza dim via pizza_id, enabling scatter-plot analysis between **quantity** and **revenue contribution** by ingredient.

**3.3 Order Classification Logic**

```
OrderSummary =
SUMMARIZE(
    data_pizza,
    data_pizza[order_id],
    "TotalQuantity", SUM(data_pizza[quantity])
)

OrderType =
IF(OrderSummary[TotalQuantity] = 1, "Single-item Order", "Multi-item Order")

% of Orders =
DIVIDE(
    COUNTROWS(OrderSummary),
    CALCULATE(COUNTROWS(OrderSummary), ALL(OrderSummary)),
    0
)
```
✅ Differentiates single vs multi-item orders and drives frequency charts.

**3.4 Average Order Interval**

To calculate the average time gap between consecutive orders:
- Duplicate Table → Copy data_pizza and rename it PreviousOrder.
- Add Index Column → Add sequential index columns in both tables.
- Shift Index → In PreviousOrder, create a column Index Prev + 1 = [Index Prev] + 1 to align each order with its previous one.
- Merge Tables → Merge data_pizza[Index] with PreviousOrder[Index Prev + 1] to bring in PrevOrderDateTime.
- Calculate Time Difference → Add a custom column:
```
= Duration.TotalMinutes([OrderDateTime] - [PrevOrderDateTime])
```
- Clean Up → Remove null rows (the first order has no previous one).

The resulting TimeDifference_Minutes column was then used to determine the Average Order Interval.

### **4. Dashboard Overview** REDO 

Built a 4-page interactive dashboard with consistent dark theme and teal-yellow palette:
- Sales Performance: KPI cards, daily/weekly/monthly trends, weekday analysis
- Product Performance: Category rankings, top/bottom pizza comparison
- Size & Ingredient Analysis: Ingredient correlation, size-volume relationship
- Order Frequency & Timing: Order types Fequency, interval metrics
Added slicers (Month, Weekday, Category) and annotation storytelling for professional presentation.


This report is split into four pages to provide both a high-level summary and focused analysis on specific business areas.

**Page 1: Sales Performance Overview**

![Data Jobs Dashboard Page 1](../Resources/images/Project1_Dashboard_Page1.gif) 

This is your mission control for the pizza business. It presents key KPIs such as Total Revenue, Orders, Average Order Value, and Quantity Sold, along with daily, weekly, and monthly sales trends. Users can quickly identify peak days (Friday & Saturday) and key operating hours (12–2 PM, 6–9 PM).

**Page 2: Product Performance**

This page ranks pizzas by sales and revenue, highlighting top categories like Classic and Supreme while identifying underperforming items for potential menu optimization.

**Page 3: Size & Ingredient Insights**

This is the deep-dive page for product composition. It analyses the relationship between pizza size, ingredient usage, and sales performance, revealing that Large and Medium pizzas dominate and ingredients like Garlic, Tomato, and Red Onion drive the highest returns.

**Page 4: Order Frequency & Timing**

This operational view explores customer order behaviour and service efficiency, comparing single vs multi-item orders and tracking average order intervals (10.8 mins) to assess kitchen performance and demand peaks.

## 💡 Insights & Findings

**📅 Sales Trends**
- Friday = strongest day with $136K total revenue; Sunday = weakest ($99K).
- Average order value = $38.31, with stable daily revenue around $2.5K/day.
- Peak months: May & July ( $71-$73K/month) due to national holidays and promotions.

**🍕 Product Performance**
- Classic & Supreme pizzas dominate with combined ~$428K revenue.
- Top sellers: The Thai Chicken, BBQ Chicken and Classic Deluxe.
- Low performers: Brie Carre & Spinach Supreme — niche appeal.


**🧀 Ingredient & Size Analysis**
- Large and Medium sizes = 80% of total sales volume.
- Core ingredients (Garlic, Tomato, Red Onion, Red Pepper, Mozzarella) drive profitability.
- Premium ingredients (Thyme, Prosciutto) show low demand.


**⏱️ Order Behavior**
- 62% of orders are multi-item, showing strong group buying.
- Avg. order interval = 10.8 minutes, stable year-round.
- Occasional quiet periods (Sept & Dec) signal staffing or demand dips.





## 🚀 Business Impact
- Informed staff scheduling aligned with demand peaks (12–2 PM, 6–9 PM).
- Guided promotion timing on high-volume days (Fridays & weekends).
- Supported menu optimisation by focusing on high-margin, high-volume items.
- Identified inventory priorities for key ingredients and reduced waste from low-performers.
- Improved operational efficiency by quantifying order frequency and service intervals.




## 🏁 Conclusion

This project demonstrates full-cycle analytics capability — from data preparation and modeling through DAX logic to interactive storytelling — delivering actionable business recommendations.
It showcases how Power BI can translate raw operational data into strategic insight for manufacturing and retail decision-making.









































