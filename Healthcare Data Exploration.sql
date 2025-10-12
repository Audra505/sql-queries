--------------------------------------------------------------------
-- Exploratory Data Questions 
--------------------------------------------------------------------

-- How many patients are there per gender?
-- Sort by highest to lowest count.

SELECT *
FROM patients;

SELECT gender, COUNT(id) AS No_of_patients
FROM patients
GROUP BY gender 
ORDER BY No_of_patients DESC;

-- Find the number of patients per city in DESC order, 
-- it should not include Boston and has to have at least 10 patients from that city

SELECT *
FROM patients;

SELECT city, COUNT(id) AS No_of_patients
FROM patients
WHERE city <> 'Boston'
GROUP BY city
HAVING COUNT(id) >= 10
ORDER BY No_of_patients DESC;

-- What is the most common condition, afterwards find the top 5 with occurences/cases greater than 500
SELECT *
FROM conditions;

SELECT description, COUNT(description) AS Occurences
FROM conditions
GROUP BY description
ORDER BY Occurences DESC;

SELECT description, COUNT(description) AS Occurences
FROM conditions
GROUP BY description
HAVING COUNT(description) > 500
ORDER BY Occurences DESC;

-- Limit 5 conditions
SELECT description, COUNT(description) AS Occurences
FROM conditions
WHERE description <> 'Body mass index 30+ - obesity (finding)'
GROUP BY description
ORDER BY Occurences DESC
LIMIT 5;

-- Find all the patients that live in Boston
SELECT *
FROM patients;

SELECT first, last
FROM patients
WHERE city = 'Boston';

-- Find all patients diagnosed with Chronic Kidney with the resspective condition codes
SELECT *
FROM conditions;

SELECT DISTINCT description
FROM conditions;

SELECT patient, code
FROM conditions
WHERE description ILIKE '%Chronic kidney%';

-- How many encounters happened under each encounter type/ which care setting is used the most? (order by desc)
SELECT *
FROM encounters;

SELECT encounterclass, COUNT(id) AS No_of_encounters
FROM encounters
GROUP BY encounterclass
ORDER BY No_of_encounters DESC;

--How many patients have had more than 5 encounters?
SELECT *
FROM encounters;

SELECT patient, COUNT(*) AS total_encounters
FROM encounters
GROUP BY patient
HAVING COUNT(*) > 5
ORDER BY total_encounters DESC;

-- What is the first and last name of the patient with the most encounter we want to follow up?
SELECT *
FROM patients;

SELECT *
FROM encounters;

SELECT 
    p.first, 
    p.last, 
    COUNT(e.id) AS total_encounters
FROM patients p
JOIN encounters e
    ON p.id = e.patient
GROUP BY p.first, p.last
ORDER BY total_encounters DESC
LIMIT 1;

-- Which immunizations were administered the most?

SELECT *
FROM immunizations;

SELECT description, COUNT(*) AS Total_given
FROM immunizations
GROUP BY description
ORDER BY Total_given DESC;
--------------------------------------------------------------------------

-- List the patient’s first name, last name, city, and condition description.
SELECT *
FROM patients;

SELECT *
FROM conditions;

SELECT 
    p.first,
    p.last,
    p.city,
    STRING_AGG(c.description, ', ') AS conditions
FROM patients p
JOIN conditions c
    ON p.id = c.patient
GROUP BY p.first, p.last, p.city
ORDER BY p.last
LIMIT 20;

-- Which racial group accounts for the most recorded conditions overall? 
SELECT *
FROM patients;

SELECT *
FROM conditions;

SELECT 
    p.race,
    COUNT(*) AS num_conditions
FROM patients p
JOIN conditions c
 ON p.id = c.patient
GROUP BY p.race
ORDER BY num_conditions DESC;

-- Write another query that accounts for the skew and give more information on the above numbers
SELECT 
    p.race,
    COUNT(c.*)::float / COUNT(DISTINCT p.id) AS avg_conditions_per_patient,
    COUNT(DISTINCT p.id) AS num_patients,
    COUNT(c.*) AS total_conditions
FROM patients p
JOIN conditions c
    ON p.id = c.patient
GROUP BY p.race
ORDER BY avg_conditions_per_patient DESC;

-- For each state, how many patients have a chronic disease?

SELECT *
FROM patients;

SELECT *
FROM conditions;

SELECT 
    p.state,
    COUNT(DISTINCT p.id) AS Chronic_conditions
FROM patients p
JOIN conditions c
    ON p.id = c.patient
WHERE c.description ILIKE '%chronic%'
GROUP BY p.state
ORDER BY Chronic_conditions DESC;


-----------------------------------------------------------------
