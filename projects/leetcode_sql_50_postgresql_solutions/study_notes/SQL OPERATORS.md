# SQL Fundamentals  

> This note is part of my **LeetCode SQL 50 Study Notes**, focusing on `SQL Operators` the core building blocks that define logic, filtering, and expression handling within SQL queries.
---

## Overview
Operators in SQL are symbols or keywords that tell the database engine how to perform calculations, comparisons, or logical decisions. They allow you to manipulate data, evaluate conditions, and combine filters within `SELECT`, `WHERE`, `JOIN`, and `CASE` statements.

### Why It’s Important
SQL operators are the foundation for all query logic without them, you can retrieve data but you can’t analyze, compare, or transform it.
Operators are used to:
- Compare columns and constants (`=, !=, >`)
- Perform arithmetic (`+, -, %`)
- Combine conditions (`AND, OR, NOT`)
- Work with strings (`LIKE, ||`)
- Handle missing values (`IS NULL`)

---

## Main Categories of Operators

| Category | Description | Example |
|-----------|-----------|-------|
| **Arithmetic Operators**   | Perform mathematical calculations. | `+`, `-`, `*`, `/`, `%` |
| **Comparison Operators**   | Compare two values and return TRUE/FALSE. | `=`, `!=`, `>`, `<`, `>=`, `<=` |
| **Logical Operators**   | Combine or invert conditions. | `AND`, `OR`, `NOT`, `IN`, `BETWEEN`  |
| **String Operators**   | Finds the smallest value | `LIKE`,  |
| **NULL Operators**   | Handle missing or undefined values. | `IS NULL`, `IS NOT NULL`, `COALESCE()` |

---
