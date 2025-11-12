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
|  `%`   | Modulo (remainder): Returns remainder useful for odd/even checks. | `id % 2 != 0` |

## Operator Spotlight: Modulus (`%`)
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

**Learn More:** [W3resource – Arithmetic Operators](https://www.w3resource.com/sql/arithmetic-operators/sql-arithmetic-operators.php)
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

## Operator Spotlight: `= vs IS (NULL)`
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
## Operator Spotlight: BETWEEN (Inclusive Ranges)
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

**Learn More:** [W3resource – Comparison Operators](https://www.w3resource.com/sql/comparison-operators/sql-comparison-operators.php)
                - [Mode SQL - Comparison Operators](https://mode.com/sql-tutorial/sql-operators)
                - [W3Schools – BETWEEN](https://www.w3schools.com/sql/sql_between.asp)

<hr style="width:25%; border:1px solid #d3d3d3; margin-left:0;">

## Logical Operators
Used to combine or negate multiple conditions.

| Operator| Description | Example |
|-----------|-----------|-------|
| `AND`   | Returns TRUE if both conditions are true. | `age > 18 AND city = 'NY'` |
| `OR`   | Returns TRUE if any condition is true. | `age < 18 OR city = 'LA'` |
| `NOT` | Negates the condition. | `NOT (status = 'Active')`  |
| `BETWEEN`  | Checks range inclusively.  | `price BETWEEN 10 AND 50`  |
| `IN`  | Checks if value exists in a list. | `country IN ('US','UK','CA')`  |
| `EXISTS`  | TRUE if subquery returns any rows. | `WHERE EXISTS (SELECT * FROM Sales)`  |
| `ALL`  | TRUE if all subquery results match condition. | `salary > ALL (SELECT avg(salary) FROM dept)`  |
| `ANY` / `SOME`  | TRUE if any subquery result matches condition. | `salary > ANY (SELECT salary FROM dept)`  |

## Operator Spotlight: AND / OR / NOT (Logic Order & Parentheses)
Logical operators combine multiple conditions. SQL evaluates them in this order:
1. `NOT`
2. `AND`
3. `OR`

**Syntax & Example (Without Parentheses):**
```sql
-- Syntax
SELECT *
FROM Employees
WHERE department = 'Sales' OR department = 'Finance' AND salary > 70000;

-- Returns all Sales employees, and only Finance employees with salary > 70000 (AND has higher precedence than OR).
```

**Syntax & Example (With Parentheses):**
```sql
-- Syntax
SELECT *
FROM Employees
WHERE (department = 'Sales' OR department = 'Finance')
  AND salary > 70000;

-- Returns both Sales and Finance employees, but only if salary > 70000.
```

**Notation**
Always use parentheses `()` to make logic clear and avoid confusion especially in complex `WHERE` clauses.

**Learn More:** [W3resource – Logical Operators](https://www.w3resource.com/sql/boolean-operator/sql-boolean-operators.php)
                - [Mode SQL - Logical Operators](https://mode.com/sql-tutorial/sql-logical-operators)
                - [W3Schools – IN](https://www.w3schools.com/sql/sql_in.asp)

<hr style="width:25%; border:1px solid #d3d3d3; margin-left:0;">

## String Operators
Used for matching and concatenating text.

| Operator| Description | Example |
|-----------|-----------|-------|
| `LIKE`   | Match patterns using wildcards. | `name LIKE 'A%' → names starting with A` |
| `CONCAT()`  | Combine information from different columns. | `CONCAT(first, ' ', last)` |
| `LOWER()` / `UPPER()`  | Converts text case for matching. | `LOWER(email)` |

Full list is in the **Learn More** resources.

## Operator Spotlight: LIKE & Wildcards
`LIKE` operator allows pattern matching in text data using wildcards.

| Wildcard | Description | Example |
|-----------|-----------|-------|
| `%`   | Any number of characters. | `'A%'` → Alice, Adam, Andrew |
| `_`  | Exactly one character. | `'A_'` → Al, An, Ax |
| `'%@gmail.com'`   | Ends with.... | any Gmail address |

**Syntax & Example:**
```sql
-- Syntax
SELECT name, email
FROM Customers
WHERE email LIKE '%@gmail.com';

/* Explanation:
% before @gmail.com allows any username.
Useful for partial matches, flexible filtering, and searching unstructured text. */
```
**Notation**
- Combine `LIKE` with `LOWER()` or `UPPER()` for case-insensitive searches.
- PostgreSQL also supports `ILIKE` for case-insensitive matching directly.

**Learn More:** [Datacamp – String Operators](https://www.datacamp.com/tutorial/sql-string-functions)
                - [Geekforgeeks - String Operators](https://www.geeksforgeeks.org/sql/sql-string-functions/)
                - [Coginiti - String Operators](https://www.coginiti.co/tutorials/intermediate/string-functions-in-sql/)
                - [W3Schools – LIKE](https://www.w3schools.com/sql/sql_like.asp)
                - [W3Schools – Wildcards](https://www.w3schools.com/sql/sql_wildcards.asp)

<hr style="width:25%; border:1px solid #d3d3d3; margin-left:0;">

## NULL Operators
Handle missing or undefined values.

| Operator| Description | Example |
|-----------|-----------|-------|
| `IS NULL`   | Checks if a value is NULL. | `manager_id IS NULL` |
| `IS NOT NULL`   | Checks if a value exists. | `bonus IS NOT NULL` |
| `COALESCE()` | Replaces NULL with a default value. | `COALESCE(bonus, 0)`  |
| `NULLIF()`  | Returns NULL if a = b (else returns a). | `NULLIF(a, b)`  |

**COALESCE() Syntax & Example:**
```sql
-- Syntax
COALESCE(value1, value2, value3, ...)

/*Explanation:
Returns the first non-NULL value in the list.
If all values are NULL, it returns NULL.
Commonly used to replace NULL with a default value for display or calculation.*/

-- Example
SELECT 
    name,
    COALESCE(bonus, 0) AS adjusted_bonus
FROM Employees;

-- If bonus is NULL, it will display 0 instead, ensuring totals or averages don’t break due to missing data.
   (Give me the first thing that’s not missing.)
```

**NULLIF() Syntax & Example:**
```sql
-- Syntax
NULLIF(expression1, expression2)

/*Explanation:
Compares two expressions.
Returns NULL if they are equal.
If not equal, returns the first expression.
Often used to prevent division by zero or handle special-case comparisons.*/

-- Example
SELECT 
    revenue / NULLIF(units_sold, 0) AS avg_price
FROM Sales;

-- If units_sold = 0, then NULLIF(0, 0) returns NULL, avoiding a division error. If units_sold = 10, then the expression behaves normally.
   (Return NULL instead of crashing when values are equal.)
```

**Learn More:** [GeekforGeeks - COALESCE](https://www.geeksforgeeks.org/sql/use-of-coalesce-function-in-sql-server/)
               - [W3Schools – NULLIF](https://www.w3schools.com/sql/func_sqlserver_nullif.asp)


<hr style="width:25%; border:1px solid #d3d3d3; margin-left:0;">

## Conditional Expressions: CASE WHEN THEN ELSE END
The `CASE` statement in SQL allows you to perform conditional logic directly inside your queries. It functions similarly to an IF–ELSE structure in programming evaluating conditions in order and returning specific values depending on which one is true.

**Syntax & Example:**
```sql
-- Syntax
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ...
    ELSE resultN
END

-- Example
SELECT 
    product_name,
    CASE
        WHEN price > 100 THEN 'High'
        WHEN price BETWEEN 50 AND 100 THEN 'Medium'
        ELSE 'Low'
    END AS price_category
FROM Products;

/* Explanation:
Categorizes products based on price range.
Each row is evaluated in order; the first true condition determines the returned label.
The ELSE clause is optional if it is omitted and no condition matches, SQL returns NULL.*/
```

**When to Use:**
- To label or bucket data into categories (e.g., high vs. low performers, risk levels, etc.).
- To replace IF logic for inline evaluations.
- To simplify reporting logic without needing multiple queries.

**Learn More:** [W3Schools – CASE Statement](https://www.w3schools.com/sql/sql_case.asp)
               - [Mode SQL – CASE](https://mode.com/sql-tutorial/sql-case)


<hr style="width:25%; border:1px solid #d3d3d3; margin-left:0;">

## Common Mistakes to Avoid
- Using `=` to compare with `NULL`. Use `IS NULL` instead.
- Forgetting parentheses in `AND`/`OR` combinations this change logic order.
- Mixing string and numeric comparisons. Ensure your data types are consistent.
- Expecting `NULL !=` value to return TRUE. Any comparison with `NULL` returns NULL (unknown).

---

## Summary Table

| Category        | Operator / Function                         | Use Case                                   |
|-----------------|---------------------------------------------|--------------------------------------------|
| **Arithmetic**  | `+`, `-`, `*`, `/`, `%` | Perform math calculations on numeric data. |
| **Comparison**  | `=`, `!=`, `>`, `<`, `>=`, `<=`   | Compare values in conditions.    |
| **Logical**     | `AND`, `OR`, `NOT`, `BETWEEN`, `IN` | Combine and filter conditions. |
| **String**      | `LIKE`, `||`, `CONCAT()` | Match or combine text strings. |
| **NULL Handling** | `IS NULL`, `IS NOT NULL`, `COALESCE()`, `NULLIF()`  | Manage missing or undefined values. |

---

## Key Takeaways
- Operators are the decision-makers in SQL they control filtering, logic, and expression building.
- Use parentheses to maintain correct logic order in combined conditions.
- Use `COALESCE()` and `NULLIF()` to handle NULL values safely.
- `%` (modulus) is great for even/odd checks or numeric grouping.
- SQL syntax varies slightly across databases for example, PostgreSQL uses `||` for concatenation, while MySQL uses `CONCAT()`.

---

## Helpful Resources
- [W3Schools – SQL Operators](https://www.w3schools.com/sql/sql_operators.asp)
- [GeekforGeeks - SQL Operators](https://www.geeksforgeeks.org/sql/sql-operators/)
