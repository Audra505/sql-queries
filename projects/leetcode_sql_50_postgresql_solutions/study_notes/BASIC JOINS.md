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
| **INNER JOIN** | Returns rows where there’s a match in both tables. | Retrieve customers who have placed at least one order. For example, show customer names with their order details (intersection between `Customer` Table and the `Order` Table) |
| **LEFT JOIN** | Returns all rows from the left table and matching rows from the right table (a NULL value appears where there is no match). | Retrieve all customers, including those who haven’t placed any orders (grabs everything from the `Customer` table, matches orders from the `Order` table if no match exists, order info appears as NULL). |
| **RIGHT JOIN** | Returns all rows from the right table and matching rows from the left table (same NULL value applies where there is no match) |Retrieve all orders, including those that have no matching customer record (grabs everything from the `Order` table, matches those orders to the `Customer` table if no customer exists for an order, customer info appears as NULL) |
| **FULL OUTER JOIN** | Returns all rows when there’s a match in either table (both matched and unmatched values) | Retrieve a complete view of customers and orders, showing customers with and without orders, and orders with and without valid customers. |
| **SELF JOIN** | Joins a table to itself. | Finding employees and their managers within one table (Retrieve employees and their managers from an `Employee` table (where `manager_id` refers to another `employee’s id`). Also useful for hierarchical data — e.g., finding parent-child relationships or comparing records in the same dataset. |
| **CROSS JOIN** | Returns every combination of rows from both tables. | Generate all possible pairings (for instance, if each customer could choose multiple plans or delivery options, show every customer-plan combination). |
| **UNION** | Combines results from two queries, removing duplicate rows. Both queries must have the same number and type of columns.  | Combine customers from two different regional tables (e.g., `US_Customers` and `EU_Customers`) into a single unique list -duplicates removed of customers. |
| **UNION ALL** | Same as UNION, but keeps duplicates.  | Combine all customer data from multiple sources (e.g., when duplicates are meaningful — such as multiple store purchases or overlapping datasets). |

### Key Notes:
- Use `INNER JOIN` when you only care about matches.
- Use `LEFT` or `RIGHT JOIN` when you don’t want to lose unmatched rows.
- Use `FULL OUTER JOIN` for a complete data picture.
- `UNION` merges datasets **vertically (row-wise)**, while joins combine **horizontally (column-wise)**.
- `SELF JOIN` is the go-to for comparing rows within the same table.
- `CROSS JOIN` is rarely used in production but great for data generation or testing.
