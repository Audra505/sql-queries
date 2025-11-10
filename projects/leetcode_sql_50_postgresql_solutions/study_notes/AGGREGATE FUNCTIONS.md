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



