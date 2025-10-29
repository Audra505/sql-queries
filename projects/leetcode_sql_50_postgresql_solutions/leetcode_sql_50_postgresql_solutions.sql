/* =====================================================
-- Problem: 001. Recyclable and Low Fat Products
-- Question: Find the IDs of products that are both low fat ('Y') and recyclable ('Y').
-- Difficulty: Easy
-----------------------------------------------------
-- Logic:
-- 1. Filter products where both low_fats and recyclable = 'Y'
-- 2. Display product_id in ascending order
===================================================== */

SELECT product_id
FROM Products
WHERE low_fats = 'Y'
  AND recyclable = 'Y'
ORDER BY product_id;

Link to View Answer: (https://leetcode.com/problems/recyclable-and-low-fat-products/description/?envType=study-plan-v2&envId=top-sql-50)
 
/* =====================================================
-- Problem: 002. Find Customer Referee
-- Question: Find the names of the customer that are either:
          (1) referred by any customer with id != 2
          (2) not referred by any customer
    Return the result table in any order.
-- Difficulty: Easy
-----------------------------------------------------
-- Logic:
-- 1. Select customer names from the Customer table.
-- 2. Filter where referee_id is not equal to 2.
-- 3. Include customers with NULL referee_id (not referred).
===================================================== */

SELECT name
FROM Customer
WHERE referee_id != 2
 OR referee_id IS NULL;

Link to View Answer: (https://leetcode.com/problems/find-customer-referee/?envType=study-plan-v2&envId=top-sql-50)

/* =====================================================
-- Problem: 003. Big Countries
-- Question: Write a solution to find the name, population, and area of countries that meet either of the following:
         (1) an area of at least 3,000,000
          OR
         (2) a population of at least 25,000,000          
    Return the result table in any order.
-- Difficulty: Easy
-----------------------------------------------------
-- Logic:
-- 1. Select name, population and area from the World table.
-- 2. Filter where area is greater than or equal to 3000000 or population is greater than or equal to 25000000 
===================================================== */

SELECT name, population, area
FROM World
WHERE area >= 3000000
 OR population >= 25000000;

Link to View Answer: (https://leetcode.com/problems/big-countries/description/?envType=study-plan-v2&envId=top-sql-50)

/* =====================================================
-- Problem: 004. Article Views I
-- Question: Write a solution to find all the authors that viewed at least one of their own articles.
   Return the result table sorted by id in ascending order.          
-- Difficulty: Easy
-----------------------------------------------------
-- Logic:
-- 1. Select author_id from the Views table.
-- 2. Filter where author_id = viewer_id (same person).
-- 3. Return distinct author IDs (no duplicates).
-- 4. Sort results by id ascending.
===================================================== */

SELECT DISTINCT author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY id;

Link to View Answer: (https://leetcode.com/problems/article-views-i/description/?envType=study-plan-v2&envId=top-sql-50)

/* =====================================================
-- Problem: 005. Article Views I
-- Question: Write a solution to find all the authors that viewed at least one of their own articles.
   Return the result table sorted by id in ascending order.          
-- Difficulty: Easy
-----------------------------------------------------
-- Logic:
-- 1. Select author_id from the Views table.
-- 2. Filter where author_id = viewer_id (same person).
-- 3. Return distinct author IDs (no duplicates).
-- 4. Sort results by id ascending.
===================================================== */
