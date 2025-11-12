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
| **String Operators**   | Used for text pattern matching and concatenation. | `LIKE`, `||`, `CONCAT()`  |
| **NULL Operators**   | Handle missing or undefined values. | `IS NULL`, `IS NOT NULL`, `COALESCE()` |

**Learn More:** [W3Schools –SQL Operators](https://www.w3schools.com/sql/sql_operators.asp)
                - [GeekforGeeks - SQL Operators](https://www.geeksforgeeks.org/sql/sql-operators/)
                
---

## Detailed Breakdown

## Arithmetic Operators
Used to perform numeric calculations.

| Operator| Description | Example |
|-----------|-----------|-------|
| `+`   | Adds two numbers. | `salary + bonus` |
| `-`   | Subtracts one number from another. | `price - discount` |
| `*` | Multiplies numbers. | `quantity * price`  |
| `/`  | Divides numbers (watch for 0). | `total / count`  |
|  `%`   | Returns remainder useful for odd/even checks. | `id % 2 != 0` |

### Operator Spotlight: Modulus (`%`)
Returns the remainder after one number is divided by another. It’s especially useful for identifying even and odd numbers, detecting patterns, or working with cyclical data (like every 7th day, every 5th record, etc.).

**Syntax & Example:**
```sql
-- Syntax
SELECT number1 % number2 AS remainder;

-- number1 is the value to be divided.
-- number2 is the divisor.
-- The result is the remainder of the division.

-- Example
SELECT 10 % 3 AS remainder;

-- Result is 1 because 10 ÷ 3 = 3 remainder 1
```

### Why Using 2 is Common
Because the concept of odd and even is based on divisibility by 2:
- Even: divides evenly (remainder 0)
- Odd: leaves a remainder of 1

So % 2 is the quickest way to check whether a number divides evenly by 2.

### More Practical Uses

| Use Case | Description | Example |
|-----------|-----------|-------|
| Even/Odd checks | Identify odd/even IDs or records. | `id % 2` |
| Grouping patterns  | Repeat logic every 7 days (like week cycles). | `day % 7` |
| Sampling data | Take every 10th record. | `id % 10 = 0`  |
| Rotation logic  | Rotate quarterly (Jan–Mar–Jun–Sep pattern). | `month_id % 4`  |

**Learn More:** [w3resource – Arithmetic Operators](https://www.w3resource.com/sql/arithmetic-operators/sql-arithmetic-operators.php)
                - [GeekforGeeks - Arithmetic Operators](https://www.geeksforgeeks.org/sql/sql-arithmetic-operators/)

<hr style="width:25%; border:1px solid #d3d3d3; margin-left:0;">

## Comparison Operators
Used inside `WHERE` and `JOIN` clauses to compare values.

| Operator| Description | Example |
|-----------|-----------|-------|
| `=`   | Equal to. | `city = 'London'` |
| `!=` or `<>`   | Not equal to. | `department != 'HR'` |
| `>` / `<` | Greater than / Less than. | `salary > 50000`  |
| `>=` / `<=`  | Greater than or equal / Less than or equal. | `hire_date >= '2022-01-01'`  |

### Operator Spotlight: `= vs IS (NULL)`
`NUL`L represents an unknown or missing value, not zero or empty text. Because `NULL` is unknown, any comparison (`=`, `!=`, `>`, etc.) involving `NULL` always returns NULL (unknown) not TRUE or FALSE.

**Incorrect Syntax & Example:**
```sql
-- Syntax
SELECT *
FROM Employees
WHERE manager_id = NULL;

-- Returns nothing because NULL = NULL is not TRUE in SQL logic.
```

**Correct Syntax & Example:**
```sql
-- Syntax
SELECT *
FROM Employees
WHERE manager_id IS NULL;

/* Explanation:
Use IS NULL and IS NOT NULL to test for missing values
Use = or != for actual comparisons (non-nullable data) */
```
### Operator Spotlight: BETWEEN (Inclusive Ranges)
Returns filters data within a range, including both the lower and upper limits.

**Syntax & Example:**
```sql
-- Syntax
SELECT *
FROM Products
WHERE price BETWEEN 50 AND 100;

-- Equivalent To:

WHERE price >= 50 AND price <= 100;
```

**Notation**
- `BETWEEN` is inclusive of both ends.
- Works with numbers, dates, and text (alphabetical ranges).
- For string comparisons they use alphabetical order, not numeric logic.

**Learn More:** [w3resource – Comparison Operators](https://www.w3resource.com/sql/comparison-operators/sql-comparison-operators.php)
                - [Mode SQL - Comparison Operators](https://mode.com/sql-tutorial/sql-operators)
