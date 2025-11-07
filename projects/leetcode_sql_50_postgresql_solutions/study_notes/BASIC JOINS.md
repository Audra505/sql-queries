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
| **INNER JOIN** | Returns rows where there’s a match in both tables. | Customers who made orders. |
| **LEFT JOIN** | Returns all rows from the left table and matching rows from the right table (a NULL value appears where there is no match). | All customers, even those with no orders. |
| **RIGHT JOIN** | Returns all rows from the right table and matching rows from the left table (same NULL value applies where there is no match) |All orders, even if some have no customer record. |
| **FULL OUTER JOIN** | Returns all rows when there’s a match in either table (both matched and unmatched values) | All customers and orders, including unmatched ones. |
| **SELF JOIN** | Joins a table to itself. | Finding employees and their managers within one table. |
| **CROSS JOIN** | Returns every combination of rows from both tables. | Generate all possible pairings (e.g., colors × sizes). |
| **UNION** |  | |
| **UNION ALL** |  | |
