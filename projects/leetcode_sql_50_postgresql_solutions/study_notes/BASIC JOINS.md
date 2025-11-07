# SQL Fundamentals  

> This note is part of my **LeetCode SQL 50 Study Notes**, focusing on `Basic Joins` one of the most critical concepts for combining data across multiple tables.
---

## Overview
Joins are used to combine data from two or more tables based on a related column between them (often a key relationship such as `id` or `foreign key`). Without joins, data would remain isolated in separate tables making analysis incomplete.

### Why It’s Important:
In real-world databases, information is often normalized (split into multiple related tables).
For example:
- A `Customers` table might store customer details.
- An `Orders` table might store each purchase.

To analyze sales by customer, you need to join these tables on a shared column like `customer_id`.

---
## Common Types of Joins

| Join Type | Description | Use Case |
|-----------|-----------|-------|
| **INNER JOIN**   | Returns rows where there’s a match in both tables. | Retrieve customers who have placed at least one order. For example, show customer names with their order details (intersection between `Customer` Table and the `Order` Table) |
| **LEFT JOIN**   | Returns all rows from the left table and matching rows from the right table (a NULL value appears where there is no match). | Retrieve all customers, including those who haven’t placed any orders (grabs everything from the `Customer` table, matches orders from the `Order` table if no match exists, order info appears as NULL). |
| **RIGHT JOIN**   | Returns all rows from the right table and matching rows from the left table (same NULL value applies where there is no match) |Retrieve all orders, including those that have no matching customer record (grabs everything from the `Order` table, matches those orders to the `Customer` table if no customer exists for an order, customer info appears as NULL) |
| **FULL OUTER JOIN**   | Returns all rows when there’s a match in either table (both matched and unmatched values) | Retrieve a complete view of customers and orders, showing customers with and without orders, and orders with and without valid customers. |
| **SELF JOIN**   | Joins a table to itself. | Finding employees and their managers within one table (Retrieve employees and their managers from an `Employee` table (where `manager_id` refers to another `employee’s id`). Also useful for hierarchical data — e.g., finding parent-child relationships or comparing records in the same dataset. |
| **CROSS JOIN**   | Returns every combination of rows from both tables. | Generate all possible pairings (for instance, if each customer could choose multiple plans or delivery options, show every customer-plan combination). |
| **UNION**   | Combines results from two queries, removing duplicate rows. Both queries must have the same number and type of columns.  | Combine customers from two different regional tables (e.g., `US_Customers` and `EU_Customers`) into a single unique list -duplicates removed of customers. |
| **UNION ALL**   | Same as UNION, but keeps duplicates.  | Combine all customer data from multiple sources (e.g., when duplicates are meaningful — such as multiple store purchases or overlapping datasets). |

### Key Notes:
- Use `INNER JOIN` when you only care about matches.
- Use `LEFT` or `RIGHT JOIN` when you don’t want to lose unmatched rows.
- Use `FULL OUTER JOIN` for a complete data picture.
- `UNION` merges datasets **vertically (row-wise)**, while joins combine **horizontally (column-wise)**.
- `SELF JOIN` is the go-to for comparing rows within the same table.
- `CROSS JOIN` is rarely used in production but great for data generation or testing.

## Breakdown of SQL Joins
Each join type below includes its SQL definition, syntax pattern, and a real-world example using `Customers` and `Orders` tables refrenced above.

## INNER JOIN
Returns only the records that have matching values in both tables.

**Syntax & Example:**
```sql
-- Syntax
SELECT table1.column, table2.column
FROM table1
INNER JOIN table2
-- can also state is as JOIN
  ON table1.common_column = table2.common_column;

-- Example
SELECT c.customer_name, o.order_id
FROM Customers c
INNER JOIN Orders o
  ON c.customer_id = o.customer_id;

-- Returns customers who have placed at least one order.
```
**Learn More:** [W3Schools – INNER JOIN](https://www.w3schools.com/sql/sql_join_inner.asp)
                - [Mode SQL - INNER JOIN](https://mode.com/sql-tutorial/sql-inner-join)

                
<hr style="width:25%; border:1px solid #d3d3d3; margin-left:0;">

## LEFT JOIN
Returns all rows from the left table, and the matched rows from the right table. Unmatched rows get `NULL` values.

**Syntax & Example:**
```sql
-- Syntax
SELECT table1.column, table2.column
FROM table1
LEFT JOIN table2
  ON table1.common_column = table2.common_column;

-- Example
SELECT c.customer_name, o.order_id
FROM Customers c
LEFT JOIN Orders o
  ON c.customer_id = o.customer_id;

-- Returns all customers, including those without orders.
```
**Learn More:** [W3Schools – LEFT JOIN](https://www.w3schools.com/sql/sql_join_left.asp)
                - [Mode SQL - LEFT JOIN](https://mode.com/sql-tutorial/sql-left-join)

<hr style="width:25%; border:1px solid #d3d3d3; margin-left:0;">

## RIGHT JOIN
Returns all rows from the right table and matched rows from the left. It’s the mirror of `LEFT JOIN`.

**Syntax & Example:**
```sql
-- Syntax
SELECT table1.column, table2.column
FROM table1
RIGHT JOIN table2
  ON table1.common_column = table2.common_column;

-- Example
SELECT c.customer_name, o.order_id
FROM Customers c
RIGHT JOIN Orders o
  ON c.customer_id = o.customer_id;

-- Returns all orders, including those that have no matching customer record.
```
**Learn More:** [W3Schools – RIGHT JOIN](https://www.w3schools.com/sql/sql_join_right.asp)
                - [Mode SQL - RIGHT JOIN](https://mode.com/sql-tutorial/sql-right-join)

<hr style="width:25%; border:1px solid #d3d3d3; margin-left:0;">

## FULL OUTER JOIN
Combines `LEFT` and `RIGHT` joins, it returns all rows when there’s a match in either table.

**Syntax & Example:**
```sql
-- Syntax
SELECT table1.column, table2.column
FROM table1
FULL OUTER JOIN table2
  ON table1.common_column = table2.common_column;

-- Example
SELECT c.customer_name, o.order_id
FROM Customers c
FULL OUTER JOIN Orders o
  ON c.customer_id = o.customer_id;

-- Returns all cutomers and all orderss, including unmatched ones.
```
**Learn More:** [W3Schools – FULL OUTER JOIN](https://www.w3schools.com/sql/sql_join_full.asp)
                - [Mode SQL - FULL OUTER JOIN](https://mode.com/sql-tutorial/sql-full-outer-join)

<hr style="width:25%; border:1px solid #d3d3d3; margin-left:0;">

## SELF JOIN
Joins a table to itself, often used to compare rows or represent hierarchy.
**Syntax & Example:**
```sql
-- Syntax
SELECT a.column_name, b.column_name
FROM table_name AS a
JOIN table_name AS b
  ON a.common_field = b.common_field;

-- Example
SELECT e1.name AS employee,
       e2.name AS manager
FROM Employee e1
LEFT JOIN Employee e2
  ON e1.manager_id = e2.id;

/* Explanation:
- e1 represents the “employee” version of the table.
- e2 represents the “manager” version of the same table.
- The join condition e1.manager_id = e2.id links each employee to their manager.
- The LEFT JOIN ensures you see all employees even those who don’t have a manager (manager_id IS NULL).*/
```

**When to Use SELF JOIN**
- Comparing rows within the same table (e.g., employees vs. managers)
- Finding parent-child relationships (e.g., hierarchical data)
- Detecting duplicates or relative comparisons (e.g., employees in the same department earning more than others)
- Matching patterns within one dataset (e.g., customers who referred other customers)

**Learn More:** [W3Schools – SELF JOIN](https://www.w3schools.com/sql/sql_join_self.asp)
                - [Mode SQL - SELF JOIN](https://mode.com/sql-tutorial/sql-self-joins)

<hr style="width:25%; border:1px solid #d3d3d3; margin-left:0;">
