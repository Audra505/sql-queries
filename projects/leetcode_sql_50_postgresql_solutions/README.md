# LeetCode SQL 50 — PostgreSQL Solutions

A curated collection of 50 essential SQL interview questions from **LeetCode’s Top SQL 50 Study Plan**, solved using **PostgreSQL** with detailed explanations.

This repository documents my step-by-step journey to strengthen SQL fundamentals, analytical reasoning, and data problem-solving skills.


## Purpose & Focus

This repository is designed for:

- Practicing SQL queries from basic to intermediate levels  
- Strengthening data logic and query optimization  
- Learning PostgreSQL-specific syntax, functions, and techniques  
- Preparing for Data Analyst, Business Intelligence, and SQL interview questions  


## Topics Covered

| Category | Concepts |
|-----------|-----------|
| Window Functions | ```ROW_NUMBER()```, ```RANK()```, ```LEAD()```, ```LAG()``` |
| Aggregations | ```SUM()```, ```COUNT()```, ```AVG()```, ```MAX()```, ```MIN()``` |
| Filtering & Sorting | ```WHERE```, ```HAVING```, ```ORDER BY``` |
| Joins & Set Operations | ```INNER JOIN```, ```LEFT JOIN```, ```UNION ALL``` |
| Subqueries & CTEs | ```WITH``` statements, nested queries |
| Date Functions | ```EXTRACT```, ```DATE_TRUNC```, ```INTERVAL``` |
| String Functions | ```CONCAT```, ```SUBSTRING```, ```INITCAP```, ```LENGTH``` |
| Analytical Thinking | Multi-step reasoning through query design |

## Skills Strengthened

- SQL Programming: PostgreSQL syntax and logical query writing 
- Data Aggregation: Summarizing and analyzing structured datasets 
- Analytical Reasoning: Translating problem statements into queries 
- Query Optimization: Simplifying logic for readability and performance 


## Technical Summary

| Aspect | Details |
|---------|----------|
| SQL Engine | PostgreSQL |
| Skill Level | Beginner to Intermediate |
| Total Questions | 50 |
| Source | [LeetCode SQL 50](https://leetcode.com/studyplan/top-sql-50/) |
| Focus Areas | Aggregation, joins, subqueries, window functions, date & string logic |

---

## Example Problem Template

The solution file follows a consistent and well-documented structure for clarity and reusability.

```sql
-- Problem: 001. Recyclable and Low Fat Products
-- Question: Find the IDs of products that are both low fat ('Y') and recyclable ('Y').
-- Difficulty: Easy
-- Platform: LeetCode (https://leetcode.com/problems/recyclable-and-low-fat-products/description/?envType=study-plan-v2&envId=top-sql-50)

-- Logic:
-- 1. Filter products where both low_fats and recyclable = 'Y'
-- 2. Display product_id in ascending order

SELECT product_id
FROM Products
WHERE low_fats = 'Y'
  AND recyclable = 'Y'
ORDER BY product_id;
```
---

## Acknowledgment

All problems are sourced from the [LeetCode SQL 50 Study Plan](https://leetcode.com/studyplan/top-sql-50/).
This repository serves as both a learning resource and a public record of growth in SQL problem-solving and data reasoning using PostgreSQL.
