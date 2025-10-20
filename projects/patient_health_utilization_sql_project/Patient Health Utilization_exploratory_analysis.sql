/******************************************************************************************
Patient Health Utilization Project
Phase 2: Exploratory Data Analysis (EDA)
******************************************************************************************
Objective:
To explore patient demographics, encounters, chronic conditions, and immunization trends
prior to visualization in Power BI.

Key Focus Areas:
   1. Demographics Distribution
   2. Encounter Utilization
   3. Chronic Disease Trends
   4. Immunization Insights
   5. Geographic and Racial Health Patterns
******************************************************************************************/

/******************************************************************************************
   POPULATION OVERVIEW METRICS
******************************************************************************************/

-- Total Number of Patients
SELECT COUNT(id) 
FROM patients;

-- Total Number of Encounters
SELECT COUNT(DISTINCT patient) 
FROM encounters;

-- Total Number of Conditions
SELECT COUNT(DISTINCT patient) 
FROM conditions;

-- Total Number of Immunizations
SELECT COUNT(DISTINCT patient) 
FROM immunizations;

/******************************************************************************************
   PATIENT DEMOGRAPHICS OVERVIEW
******************************************************************************************/

-- How many patients are there per gender?
-- Sort by highest to lowest count.

SELECT *
FROM patients;

SELECT gender, COUNT(id) AS total_patients
FROM patients
GROUP BY gender 
ORDER BY total_patients DESC;

-- Find the number of patients per city in DESC order, 
-- it has to have at least 10 patients from that city

SELECT *
FROM patients;

SELECT city, COUNT(id) AS total_patients
FROM patients
GROUP BY city
HAVING COUNT(id) >= 10
ORDER BY total_patients DESC;

-- What is the age group for the population?
SELECT
    CASE
        WHEN DATE_PART('year', AGE(birthdate)) < 18 THEN 'Under 18'
        WHEN DATE_PART('year', AGE(birthdate)) BETWEEN 18 AND 39 THEN '18–39'
        WHEN DATE_PART('year', AGE(birthdate)) BETWEEN 40 AND 65 THEN '40–65'
        ELSE '66+'
    END AS age_group,
    COUNT(*) AS total_patients
FROM patients
GROUP BY age_group
ORDER BY total_patients DESC;

/******************************************************************************************
   COMMON CONDITIONS & CHRONIC DISEASE ANALYSIS
******************************************************************************************/

-- What is the most common condition, afterwards find the top 10 with occurences/cases greater than 100
SELECT *
FROM conditions;

-- Most common condition overall
SELECT description, COUNT(description) AS Occurrences
FROM conditions
GROUP BY description
ORDER BY Occurrences DESC;

-- Top 10 common conditions (occurrences > 100, excluding BMI obesity)
SELECT description, COUNT(description) AS Occurrences
FROM conditions
WHERE description <> 'Body Mass Index 30+ - Obesity (Finding)'
GROUP BY description
HAVING COUNT(description) > 100
ORDER BY Occurrences DESC
LIMIT 10;

-- Identify the chronic conditions as well(occurrences > 100, excluding BMI obesity)
SELECT description, COUNT(description) AS Occurrences
FROM conditions
WHERE description <> 'Body Mass Index 30+ - Obesity (Finding)' AND description ILIKE '%chronic%'
GROUP BY description
ORDER BY Occurrences DESC;

-- Find all patients diagnosed with Chronic Kidney with the respective condition codes
SELECT *
FROM conditions;

SELECT DISTINCT description
FROM conditions;

SELECT patient, code
FROM conditions
WHERE description ILIKE '%Chronic kidney%';


/******************************************************************************************
  ENCOUNTER UTILIZATION
******************************************************************************************/

-- How many encounters happened under each encounter type/ which care setting is used the most? (order by desc)
SELECT *
FROM encounters;

SELECT encounterclass, COUNT(id) AS total_encounters
FROM encounters
GROUP BY encounterclass
ORDER BY total_encounters DESC;

--How many patients have more than 5 encounters?
SELECT *
FROM encounters;

SELECT patient, COUNT(*) AS total_encounters
FROM encounters
GROUP BY patient
HAVING COUNT(*) > 5
ORDER BY total_encounters DESC;

-- What is the first and last name of the patient with the most encounter we want to follow up? (extra insight)
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

-- Encounter Frequency by Month
SELECT DATE_TRUNC('month', start) AS month, COUNT(*) AS total_encounters
FROM encounters
GROUP BY month
ORDER BY month DESC;

/******************************************************************************************
   IMMUNIZATION INSIGHTS
******************************************************************************************/

-- Which immunizations were administered the most?

SELECT *
FROM immunizations;

SELECT description, COUNT(*) AS total_given
FROM immunizations
GROUP BY description
ORDER BY total_given DESC;

-- What is the average age for vaccinations?
-- create a grouped by range as well

WITH vaccine_age AS
    (SELECT i.description AS Vaccinations,
       ROUND(AVG(EXTRACT(YEAR FROM AGE(date, p.birthdate))), 0) AS avg_age
FROM immunizations i
JOIN patients p
	ON i.patient = p.id
GROUP BY Vaccinations)
SELECT 
    Vaccinations,
    avg_age,
    CASE
        WHEN avg_age < 1 THEN 'Infants (0–1)'
        WHEN avg_age BETWEEN 1 AND 4 THEN 'Toddlers (1–4)'
        WHEN avg_age BETWEEN 5 AND 12 THEN 'Children (5–12)'
        WHEN avg_age BETWEEN 13 AND 19 THEN 'Teens (13–19)'
        WHEN avg_age BETWEEN 20 AND 39 THEN 'Adults (20–39)'
        ELSE 'Older Adults (40+)'
    END AS age_group
FROM vaccine_age
ORDER BY avg_age;

-- What does vaccinations look like by gender
SELECT p.gender, COUNT(i.patient) AS total_vaccinations
FROM immunizations i
JOIN patients p ON i.patient = p.id
GROUP BY p.gender
ORDER BY total_vaccinations DESC;

/******************************************************************************************
  DEMOGRAPHIC & RACIAL HEALTH TRENDS
******************************************************************************************/

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
    COUNT(*) AS total_conditions
FROM patients p
JOIN conditions c
 ON p.id = c.patient
GROUP BY p.race
ORDER BY total_conditions DESC;

-- Write another query that accounts for population size giving more information on the above numbers
SELECT 
    p.race,
    ROUND(COUNT(c.*)::numeric / COUNT(DISTINCT p.id), 0) AS avg_conditions_per_patient,
    COUNT(DISTINCT p.id) AS num_patients,
    COUNT(c.*) AS total_conditions
FROM patients p
JOIN conditions c
    ON p.id = c.patient
GROUP BY p.race
HAVING COUNT(DISTINCT p.id) >= 10
ORDER BY avg_conditions_per_patient DESC;

/******************************************************************************************
  GEOGRAPHIC INSIGHTS
******************************************************************************************/

-- For each city, how many patients have a chronic conditions?

SELECT *
FROM patients;

SELECT *
FROM conditions;


SELECT 
    p.city,
    COUNT(DISTINCT p.id) AS Chronic_patients
FROM patients p
JOIN conditions c
    ON p.id = c.patient
WHERE c.description ILIKE '%chronic%'
GROUP BY p.city
ORDER BY Chronic_patients DESC;

-- What is the total number of Chronic conditions?
SELECT COUNT(*) AS chronic_conditions
FROM conditions
WHERE description ILIKE '%chronic%';


/******************************************************************************************
  VALIDATION SUMMARY
******************************************************************************************/

-- Record counts per table
SELECT 'patients' AS table_name, COUNT(*) AS record_count 
FROM patients
UNION ALL
SELECT 'conditions', COUNT(*) 
FROM conditions
UNION ALL
SELECT 'encounters', COUNT(*) 
FROM encounters
UNION ALL
SELECT 'immunizations', COUNT(*) 
FROM immunizations;

-- Distinct patient coverage across datasets (relationship validation)
SELECT 
    COUNT(DISTINCT p.id) AS total_patients,
    COUNT(DISTINCT e.patient) AS with_encounters,
    COUNT(DISTINCT c.patient) AS with_conditions,
    COUNT(DISTINCT i.patient) AS with_immunizations
FROM patients p
LEFT JOIN encounters e ON p.id = e.patient
LEFT JOIN conditions c ON p.id = c.patient
LEFT JOIN immunizations i ON p.id = i.patient;
