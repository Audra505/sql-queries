# SQL Fundamentals  

> This note is part of my **LeetCode SQL 50 Study Notes**, focusing on `Aggregate Functions` one of the most essential SQL concepts for summarizing and analyzing data.
---

## Overview
Aggregate functions perform calculations on multiple rows and return a single summarized value (such as totals, averages, counts, or maximums). They are frequently used with the `GROUP BY` clause to summarize data by categories.

### Why It’s Important
In real-world datasets, analyzing patterns requires summarizing data not just retrieving individual records.
For instance:
- To find total sales per region, you use `SUM()` with `GROUP BY region`.
- To find average customer spending, you use `AVG(amount)` grouped by `customer_id`.
- To count how many employees per department, you use `COUNT()` grouped by `department`.

Without aggregate functions, large-scale insights would be impossible. You would only see raw data, not meaningful trends.

---
## Common Aggregate Functions

| Function | Description | Use Case |
|-----------|-----------|-------|
| **COUNT()**   | Counts the number of rows (ignores NULLs unless `COUNT(*)`) | Count total customers or orders |
| **SUM()**   | Adds all numeric values | Calculate total revenue |
| **AVG()**   | Computes the average of numeric values (this also ignores NULLs completely) | Find average salary per department  |
| **MIN()**   | Finds the smallest value | Get the earliest order date |
| **MAX()**   | Finds the largest value | Get the highest product price |

---

## Key Clauses with Aggregates

| Clause | Purpose | Example |
|-----------|-----------|-------|
| **GROUP BY**   | Groups rows by one or more columns before aggregation | `GROUP BY department` |
| **HAVING**   | Filters grouped results (this works after aggregation) | `HAVING COUNT(id) > 5` |
| **WHERE**   | Filters rows before aggregation | `WHERE status = 'Active'`  |

---

## SQL Query Structure
```sql
SELECT 
    column_name(s),
    AGGREGATE_FUNCTION(column_name)
FROM table_name
[WHERE condition]
GROUP BY column_name
[HAVING aggregate_condition]
ORDER BY column_name;
```
---

## Aggregate Function Breakdown
Each aggregate function and clause below includes its SQL definition, syntax pattern, and a real-world example.

## COUNT()
Counts rows or non-null values.

**Syntax & Example:**
```sql
-- Syntax
SELECT COUNT(column_name)
FROM table_name;

-- Example
SELECT COUNT(*) AS total_orders
FROM Orders;

-- Counts all orders in the table.
```
**Learn More:** [W3Schools – COUNT](https://www.w3schools.com/sql/sql_count.asp)
                - [Mode SQL - COUNT](https://mode.com/sql-tutorial/sql-count)

                
<hr style="width:25%; border:1px solid #d3d3d3; margin-left:0;">

## SUM()
Adds up all numeric values in a column.

**Syntax & Example:**
```sql
-- Syntax
SELECT SUM(column_name)
FROM table_name;

-- Example
SELECT SUM(amount) AS total_sales
FROM Sales;

-- Finds the total sales revenue.
```
**Learn More:** [W3Schools – SUM](https://www.w3schools.com/sql/sql_sum.asp)
                - [Mode SQL - SUM](https://mode.com/sql-tutorial/sql-sum)

                
<hr style="width:25%; border:1px solid #d3d3d3; margin-left:0;">

## AVG()
Calculates the mean (average) of numeric data.

**Syntax & Example:**
```sql
-- Syntax
SELECT AVG(column_name)
FROM table_name;

-- Example
SELECT department, ROUND(AVG(salary), 2) AS avg_salary
FROM Employees
GROUP BY department;

-- Finds the average salary per department rounded to two decimals.
```
**Learn More:** [W3Schools – AVG](https://www.w3schools.com/sql/sql_avg.asp)
                - [Mode SQL - AVG](https://mode.com/sql-tutorial/sql-avg)

                
<hr style="width:25%; border:1px solid #d3d3d3; margin-left:0;">

## MIN() and MAX()
Returns the smallest and largest values in a column.

**Syntax & Example:**
```sql
-- Syntax
SELECT MIN(column_name), MAX(column_name)
FROM table_name;

-- Example
SELECT 
    MIN(order_date) AS first_order,
    MAX(order_date) AS latest_order
FROM Orders;

-- Finds the earliest and latest order.
```
**Learn More:** [W3Schools – MIN and MAX](https://www.w3schools.com/sql/sql_min_max.asp)
                - [Mode SQL - MIN/MAX](https://mode.com/sql-tutorial/sql-min-max)

<hr style="width:25%; border:1px solid #d3d3d3; margin-left:0;">

## GROUP BY
This groups rows that share the same values in one or more columns and allows applying aggregates to each group.

**Syntax & Example:**
```sql
-- Syntax
SELECT column_name(s), AGGREGATE_FUNCTION(column_name)
FROM table_name
GROUP BY column_name(s);

-- Example
SELECT department, COUNT(employee_id) AS num_employees
FROM Employees
GROUP BY department;

-- Counts how many employees each department has.
```
**Learn More:** [W3Schools – GROUP BY](https://www.w3schools.com/sql/sql_groupby.asp)
                - [Mode SQL - GROUP BY](https://mode.com/sql-tutorial/sql-group-by)

<hr style="width:25%; border:1px solid #d3d3d3; margin-left:0;">

## HAVING
Filters groups after aggregation (unlike `WHERE`, which filters before grouping).

**Syntax & Example:**
```sql
-- Syntax
SELECT 
    column_name(s),
    AGGREGATE_FUNCTION(column_name)
FROM table_name
GROUP BY column_name
HAVING aggregate_condition;

-- Example
SELECT department, AVG(salary) AS avg_salary
FROM Employees
GROUP BY department
HAVING AVG(salary) > 60000;

-- Returns departments where the average salary is greater than 60,000.
```
**Learn More:** [W3Schools – HAVING](https://www.w3schools.com/sql/sql_having.asp)
                - [Mode SQL - HAVING](https://mode.com/sql-tutorial/sql-having)

<hr style="width:25%; border:1px solid #d3d3d3; margin-left:0;">

### Key Differences Between WHERE and HAVING
- WHERE CLAUSE: This is applied **before** grouping and works with **regular columns.**
- HAVING CLAUSE: This is applied **after** grouping and works with **aggregate results.**

---
## Conditional Aggregation with `CASE`
The `CASE` expression becomes powerful when used inside aggregate functions. This allows you to apply calculations only under certain conditions known as conditional aggregation.

**Syntax & Example:**
```sql
-- Syntax
SELECT column_name(s),
       AGGREGATE_FUNCTION(column_name)
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    WHEN conditionN THEN resultN
    ELSE result END
FROM table_name
GROUP BY column_name;

-- Example
SELECT 
    department,
    SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS female_count,
    SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS male_count
FROM Employees
GROUP BY department;

/* Explanation:
- The query counts how many males and females exist in each department.
- CASE converts a condition into a numeric result (1 or 0) so it can be aggregated.
- SUM() adds up the 1s — effectively counting rows that meet each condition.*/
```
**When to Use CASE**
- To count or sum values conditionally within grouped data.
- To avoid multiple subqueries when summarizing categories.
- To calculate percentages or ratios based on conditions.

**Learn More:** [W3Schools – CASE](https://www.w3schools.com/sql/sql_case.asp)
                - [Mode SQL - CASE](https://mode.com/sql-tutorial/sql-case)

<hr style="width:25%; border:1px solid #d3d3d3; margin-left:0;">

## Common Mistakes to Avoid
- Using `WHERE` to filter aggregates instead of `HAVING`.
- Selecting columns not listed in `GROUP BY`, every non-aggregated column in `SELECT` must appear in `GROUP BY`.
- Using aggregates on non-numeric data (for SUM or AVG), only use them on numeric columns.
- Forgetting that `COUNT(column)` ignores NULLs, use `COUNT(*)` when you want to include all rows.

---

## Summary Table

| Function | Description | Example |
|-----------|-----------|-------|
| **COUNT()**   |Returns the number of rows in the table (use COUNT(column) to exclude NULLs). | `SELECT COUNT(*) 
FROM Orders;`|
| **SUM()**   | Calculates the total of a numeric column such as sales, revenue, or quantity. | `SELECT SUM(amount) FROM Sales;` |
| **AVG()**   | Returns the mean of a numeric column (ignores NULLs by default). | `SELECT AVG(salary) FROM Employees;`  |
| **MIN()**   | Identifies the minimum or earliest value in a column. | `SELECT MIN(price) FROM Products;` |
| **MAX()**   | Identifies the maximum or latest value in a column. | `SELECT MAX(price) FROM Products;` |
| **GROUP BY**   | Segments data by category before applying an aggregate function. | `GROUP BY department` |
| **HAVING**   | Used to filter aggregated results (post-GROUP BY). | `HAVING COUNT(id) > 5` |
| **ROUND()**   | Rounds decimal outputs to a specified number of places. | `ROUND(AVG(price), 2)`  |

---

## Key Takeaways
- Aggregate functions summarize large datasets into key insights (categorize data).
- Always use `GROUP BY` when combining aggregate and non-aggregate columns.
- Use `HAVING` for post-aggregation filtering.
- Use `ROUND()` to format decimal results.
- Combine with `ORDER BY` for ranked summaries.

---

## Helpful Resources
- [W3Schools – SQL Aggregate Functions](https://www.w3schools.com/sql/sql_aggregate_functions.asp)
- [Mode SQL — SQL Aggregate Functions](https://mode.com/sql-tutorial/sql-aggregate-functions)
- [SQLBolt — Aggregations](https://sqlbolt.com/lesson/select_queries_with_aggregates)

