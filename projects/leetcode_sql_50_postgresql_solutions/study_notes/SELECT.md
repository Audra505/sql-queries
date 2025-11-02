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
There are several useful SQL clauses that often accompany `SELECT`:
- `SELECT DISTINCT`
- `WHERE`
- `AND`/`OR`
- `IS NULL`
- `ORDER BY`
- `LIMIT`

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
