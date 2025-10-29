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
 
