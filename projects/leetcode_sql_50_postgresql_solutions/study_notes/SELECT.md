# SQL Fundamentals  

> This note is part of my **LeetCode SQL 50 Study Notes**, focusing on the `SELECT` statement and its related clauses.

---

## Overview 
```SELECT``` statements are used to retrieve data from one or more tables in a database. You can either use the statement to view specific columns or **all columns** using the wildcard `*`. This statement forms the foundation of almost every SQL query.

### Why It’s Important:
Everything else in SQL (joins, grouping, subqueries, etc.) starts with a SELECT statement. Understanding how to filter, sort, and project data correctly is essential for analysis and reporting.

---

## SELECT Query Structure
A basic SQL query follows this structure:

```sql
SELECT column1, column2, or SELECT *
FROM table_name
WHERE condition
GROUP BY column
HAVING condition
ORDER BY column
LIMIT number;
```
--- 

## SQL Query Execution Order
There is a logical order that SQL follows when running queries:
1. **FROM** – Identify tables or joins.
2. **WHERE** – Filter rows.
3. **GROUP BY** – Aggregate data.
4. **HAVING** – Filter aggregates.
5. **SELECT** – Choose columns.
6. **ORDER BY** – Sort results.
7. **LIMIT** – Restrict output rows.
--- 

## Common Clauses Used with SELECT
There are several useful SQL clauses that often accompany `SELECT`. Each clause helps refine, organize, or limit the data returned from a query.


## SELECT DISTINCT
Removes duplicate rows from the result set. `DISTINCT` ensures that only unique (different) values appear in the output.

 **Example:**
```sql
-- Syntax
SELECT DISTINCT column1, column2, ...
FROM table_name;
--
SELECT DISTINCT city
FROM Customers;

-- Returns each city only once, even if multiple customers live there.
```
**Learn More:** [W3Schools – DISTINCT](https://www.w3schools.com/sql/sql_distinct.asp)
                - [Mode SQL - DISTINCT](https://mode.com/sql-tutorial/sql-distinct)

                
<hr style="width:25%; border:1px solid #d3d3d3; margin-left:0;">


## WHERE
Filters rows based on a specified condition. `WHERE` restricts which rows are returned by the query.

**Example:**
```sql
-- Syntax
SELECT column1, column2, ...
FROM table_name
WHERE condition;
--
SELECT name, age
FROM Students
WHERE age > 18;

-- Returns only students older than 18.
```
**Learn More:** [W3Schools – WHERE](https://www.w3schools.com/sql/sql_where.asp)
                - [Mode SQL – WHERE Clause](https://mode.com/sql-tutorial/sql-where)

<hr style="width:25%; border:1px solid #d3d3d3; margin-left:0;">


## AND / OR
Combines multiple filtering conditions. `AND` returns rows where both conditions are true while `OR` returns rows where at least one condition is true.

**Example:**
```sql
-- Syntax for AND (you can replace AND with OR, or do both but use parenthesis to get the correct result)
SELECT column1, column2, ...
FROM table_name
WHERE condition1 AND condition2 AND condition3 ...;

-- Example
SELECT name, city, grade
FROM Students
WHERE grade > 90 AND city = 'LA';

- Returns students with grades above 90 who live in LA.
```
**Learn More:** [W3Schools – AND](https://www.w3schools.com/sql/sql_and.asp)
                - [W3Schools – OR](https://www.w3schools.com/sql/sql_or.asp)
                - [Mode SQL – AND Operator](https://mode.com/sql-tutorial/sql-and-operator)
                - [Mode SQL – OR Operator](https://mode.com/sql-tutorial/sql-or-operator)
                - [SQLBolt – Multiple Conditions](https://sqlbolt.com/lesson/select_queries_with_constraints)

<hr style="width:25%; border:1px solid #d3d3d3; margin-left:0;">

## IS NULL
Checks for missing (NULL) values. `NULL` represents unknown or missing data. You must use IS NULL or IS NOT NULL comparison operators like `=` or `!=` do not work with it.

**Example:**
```sql
-- Syntax (you can replace IS NULL with IS NOT NULL depeding on the condition)
SELECT column_names
FROM table_name
WHERE column_name IS NULL;

-- Example
SELECT name, department
FROM Employees
WHERE manager_id IS NULL;

- Returns employees without a manager.
```
**Learn More:**  [W3Schools – IS NULL](https://www.w3schools.com/sql/sql_null_values.asp)
                - [Mode SQL – IS NULL](https://mode.com/sql-tutorial/sql-is-null)

<hr style="width:25%; border:1px solid #d3d3d3; margin-left:0;">

## ORDER BY
Sorts the result set in ascending or descending order. You can specify one or more columns to order by.

**Example:**
```sql
-- Syntax
SELECT column1, column2, ...
FROM table_name
ORDER BY column1, column2, ... ASC|DESC;

-- Example
SELECT name, salary
FROM Employees
ORDER BY salary DESC;

- Returns employees sorted by highest salary first.
```
**Learn More:** [W3Schools – ORDER BY](https://www.w3schools.com/sql/sql_orderby.asp)
                - [Mode SQL – ORDER BY](https://mode.com/sql-tutorial/sql-order-by)

<hr style="width:25%; border:1px solid #d3d3d3; margin-left:0;">

## LIMIT
Restricts the number of rows returned. `LIMIT` is useful for sampling or previewing results.

**Example:**
```sql
-- Syntax
SELECT column_name(s)
FROM table_name
WHERE condition
LIMIT number;

-- Example
SELECT *
FROM Orders
LIMIT 10;

- Returns only the first 10 rows from the Orders table.
```
**Learn More:** [W3Schools – LIMIT](https://www.w3schools.com/sql/sql_top.asp)
                - [Mode SQL – LIMIT](https://mode.com/sql-tutorial/sql-limit)

---

## Commom Mistakes to Avoid 
- Forgetting quotes around strings (e.g., ```WHERE country = 'USA'```).
- Using `=` instead of `IS` with `NULL`.
- Mixing ```AND```/```OR``` without parentheses — it can change logic order.

---

## Summary Table 

| Use Case | Keyword | Example |
|-----------|-----------|-------|
| Return specific columns | ```SELECT``` | ```SELECT name, age FROM Students;``` |
| Filter results | ```WHERE``` | ```WHERE age > 18;``` |
| Combine filters | ```AND```, ```OR```| ```WHERE grade > 90 AND city = 'LA';``` |
| Remove duplicates | ```DISTINCT``` | ```SELECT DISTINCT city FROM Customers;``` |
| Sort results | ```ORDER BY``` | ```ORDER BY salary DESC;``` |
| Limit output | ```LIMIT``` | ```LIMIT 10;```|

---

## Key Takeaways
- `SELECT` defines what data to retrieve; `WHERE` defines which rows.
- Always specify columns instead of `SELECT *` in production queries.
- Use `DISTINCT` to remove duplicates.
- Combine filters thoughtfully with `AND`/`OR`.
  
---

## Helpful Resources
- [W3Schools — SQL SELECT Statement](https://www.w3schools.com/sql/sql_select.asp)
- [Mode SQL SELECT](https://mode.com/sql-tutorial/sql-select-statement)
