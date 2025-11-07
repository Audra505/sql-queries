# SQL Fundamentals  

> This note is part of my **LeetCode SQL 50 Study Notes**, focusing on focusing on `Basic Joins` one of the most critical concepts for combining data across multiple tables.
---

## Overview
Joins are used to combine data from two or more tables based on a related column between them (often a key relationship such as `id` or `foreign key`). Without joins, data would remain isolated in separate tables making analysis incomplete.

### Why It’s Important:
In real-world databases, information is often normalized (split into multiple related tables).
For example:
- A `Customers` table might store customer details.
- An `Orders` table might store each purchase.

To analyze sales by customer, you need to join these tables on a shared column like `customer_id`.
