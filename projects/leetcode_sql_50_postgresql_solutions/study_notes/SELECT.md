# Topic: SELECT  
### Category: SQL Fundamentals  

> This note is part of my **LeetCode SQL 50 Study Notes**, focusing on the `SELECT` statement and its related clauses.

---

## Overview 
```SELECT``` statements are used to retrieve data from one or more tables in a database. You can either use the statement to view specific columns or **all columns** using the wildcard `*`. This statement forms the foundation of almost every SQL query.

### Why It’s Important:
Everything else in SQL (joins, grouping, subqueries, etc.) starts with a SELECT statement. Understanding how to filter, sort, and project data correctly is essential for analysis and reporting.

---

# SELECT Query Structure
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
## What Does the Execution Order Look Like When Running A SQL Query?
There is a logical order that is used as seen below:
1. FROM (tables joined or selected)
2. WHERE (filters rows)
3. GROUP BY (aggregates)
4. HAVING (filters aggregates)
5. SELECT (returns columns)
6. ORDER BY (sorts results)
7. LIMIT (restricts output rows)

# Statements that Accompany SELECT
There are different sql statements that can follow after the SELECT Statement like SELECT DISTINCT, WHERE, AND, OR, IS NULL these will be covered with examples to bring more clarity

# Commom Mistakes To Look Out For 
- Forgetting quotes around strings (e.g., ```WHERE country = 'USA'```).
- Using = instead of IS with NULL.
- Mixing ```AND```/```OR``` without parentheses — it can change logic order.

# Summary Table 

| Use Case | Keyword | Example |
|-----------|-----------|-------|
| Return specific columns | ```SELECT``` | ```SELECT name, age FROM Students;``` |
| Filter results | ```WHERE``` | ```WHERE age > 18;``` |
| Combine filters | ```AND```, ```OR```| ```WHERE grade > 90 AND city = 'LA';``` |
| Remove duplicates | ```DISTINCT``` | ```SELECT DISTINCT city FROM Customers;``` |
| Sort results | ```ORDER BY``` | ```ORDER BY salary DESC;``` |
| Limit output | ```LIMIT``` | ```LIMIT 10;```|


# For More Information check out these helpful resources:
- [W3Schools — SQL SELECT Statement](https://www.w3schools.com/sql/sql_select.asp)
- [Mode SQL SELECT](https://mode.com/sql-tutorial/sql-select-statement)
