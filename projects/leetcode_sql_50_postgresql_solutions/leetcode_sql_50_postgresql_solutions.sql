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
-- Problem: 005. Invalid Tweets
-- Question: Write a solution to find the IDs of the invalid tweets. (The tweet is invalid if the number of characters used in the content of the tweet is greater than 15).
   Return the result table in any order.          
-- Difficulty: Easy
-----------------------------------------------------
-- Logic:
-- 1. Select tweet_id from the Tweets table.
-- 2. Use LENGTH() to count the number of characters.
-- 3. Filter for invalid tweets that is greater than 15 characters.
===================================================== */

SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15;

Link to View Answer: (https://leetcode.com/problems/invalid-tweets/description/?envType=study-plan-v2&envId=top-sql-50)

/* =====================================================
-- Problem: 006. Replace Employee ID With The Unique Identifier
-- Question: Write a solution to show the unique ID of each user, If a user does not have a unique ID replace just show null.
   Return the result table in any order.          
-- Difficulty: Easy
-----------------------------------------------------
-- Logic:
-- 1. Get all employees from the Employees table.
-- 2. Use LEFT JOIN with EmployeeUNI on matching id.
-- 3. Select unique_id (nullable) and employee name.
===================================================== */

SELECT unique_id, name
FROM Employees e
LEFT JOIN EmployeeUNI ei
    ON e.id = ei.id;

Link to View Answer: (https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/?envType=study-plan-v2&envId=top-sql-50)

/* =====================================================
-- Problem: 007. Product Sales Analysis I
-- Question: Write a solution to report the product_name, year, and price for each sale_id in the Sales table.
   Return the resulting table in any order.          
-- Difficulty: Easy
-----------------------------------------------------
-- Logic:
-- 1. Join Sales with Product table on product_id.
-- 2. Use INNER JOIN because every sale has a matching product.
-- 3. Select product_name, year, and price for each sale.
===================================================== */

SELECT p.product_name,
       s.year,
       s.price
FROM Sales s
JOIN Product p
ON s.product_id = p.product_id;

Link to View Answer: (https://leetcode.com/problems/product-sales-analysis-i/?envType=study-plan-v2&envId=top-sql-50)

/* =====================================================
-- Problem: 008. Customer Who Visited but Did Not Make Any Transactions
-- Question: Write a solution to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.
   Return the result table sorted in any order.          
-- Difficulty: Easy
-----------------------------------------------------
-- Logic:
-- 1. Join Visits with Transactions on visit_id using LEFT JOIN.
-- 2. Identify rows where transaction_id IS NULL (no purchase made).
-- 3. Group by customer_id to count how many no-transaction visits each made.
===================================================== */

SELECT v.customer_id, 
       COUNT(v.visit_id) AS count_no_trans
FROM Visits v
LEFT JOIN Transactions t
    ON v.visit_id = t.visit_id
WHERE t.transaction_id IS NULL
GROUP BY v.customer_id;

Link to View Answer: (https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/description/?envType=study-plan-v2&envId=top-sql-50)

/* =====================================================
-- Problem: 009. Rising Temperature
-- Question: Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).
   Return the result table in any order.          
-- Difficulty: Easy
-----------------------------------------------------
-- Logic:
-- 1. Compare each day’s temperature with the previous day.
-- 2. Use a SELF JOIN where the date difference is exactly 1 day.
-- 3. Keep only rows where today’s temperature is greater than the previous day.
===================================================== */

SELECT w.id
FROM Weather w1
JOIN Weather w2
 ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
 WHERE w1.temperature > w2.temperature;

Link to View Answer: (https://leetcode.com/problems/rising-temperature/?envType=study-plan-v2&envId=top-sql-50)

/* =====================================================
-- Problem: 010. Average Time of Process per Machine
-- Question: Write a solution to find the average time each machine takes to complete a process.
             (1) The time to complete a process is the 'end' timestamp minus the 'start' timestamp. 
                 The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run.
             (2) The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places.
             (3) Return the result table in any order.         
-- Difficulty: Easy
-----------------------------------------------------
-- Logic:
-- 1. Use SELF JOIN to match each process’s 'start' and 'end' rows.
-- 2. Calculate time difference (end - start) for each process.
-- 3. Group by machine_id to find the average duration.
-- 4. Round the result to 3 decimal places.
===================================================== */

SELECT 
    a1.machine_id,
    ROUND(AVG(a2.timestamp - a1.timestamp), 3) AS processing_time
FROM Activity a1
JOIN Activity a2
  ON a1.machine_id = a2.machine_id
  AND a1.process_id = a2.process_id
  AND a1.activity_type = 'start'
  AND a2.activity_type = 'end'
  GROUP BY a1.machine_id;

Link to View Answer: (https://leetcode.com/problems/average-time-of-process-per-machine/?envType=study-plan-v2&envId=top-sql-50)

/* =====================================================
-- Problem: 011. Employee Bonus
-- Question: Write a solution to report the name and bonus amount of each employee with a bonus less than 1000.
   Return the result table in any order.
-- Difficulty: Easy
-----------------------------------------------------
-- Logic:
-- 1. Start with Employee since all employees should appear.
-- 2. Use LEFT JOIN on Bonus using empId.
-- 3. Filter for employees whose bonus is less than 1000 
      OR have no bonus record (bonus IS NULL).
===================================================== */

SELECT e.name, b.bonus AS bonus
FROM Employee e
LEFT JOIN Bonus b
    ON e.empId = b.empId
WHERE b.bonus < 1000
    OR b.bonus IS NULL;
  
Link to View Answer: (https://leetcode.com/problems/employee-bonus/?envType=study-plan-v2&envId=top-sql-50)

/* =====================================================
-- Problem: 012. Students and Examinations
-- Question: Write a solution to find the number of times each student attended each exam.
   Return the result table ordered by student_id and subject_name.
-- Difficulty: Easy
-----------------------------------------------------
-- Logic:
-- 1. Generate all possible (student, subject) pairs using CROSS JOIN to ensures that even if a student did not attend an exam, the row still appears in the result.
-- 2. Use LEFT JOIN on the Examinations table to count actual exam attendance.
-- 3. Use COUNT(e.subject_name) to count the number of attendances (COUNT ignores NULLs, so missing exams count as 0).
-- 4. Group by both student_id and subject_name.
-- 5. Order the result by student_id and subject_name as required.
===================================================== */

SELECT s.student_id, 
       s.student_name,
       su.subject_name, 
       COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects su
LEFT JOIN Examinations e
  ON s.student_id = e.student_id
 AND su.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, su.subject_name
ORDER BY s.student_id, su.subject_name;

Link to View Answer: (https://leetcode.com/problems/students-and-examinations/?envType=study-plan-v2&envId=top-sql-50)
