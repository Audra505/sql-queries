# Patient Health Utilization 
---

## Table of Contents
- [Project Overview](#project-overview)
- [Database Structure](#database-structure)
- [Phase 1: Data Preparation & Cleaning](#phase-1-data-preparation--cleaning)
- [Phase 2: Exploratory Data Analysis (EDA)](#phase-2-exploratory-data-analysis-eda)
- [Key Takeaways](#key-takeaways)
- [Project Files](#project-files)
---

## Project Overview 

[Back to Table of Contents](#table-of-contents)

This project analyzes **synthetic patient health records** generated using the **Synthea Open Dataset**, a realistic simulation of U.S. healthcare data.  
The objective was to perform **end-to-end SQL analysis** in **PostgreSQL** — from raw data preparation and cleaning to exploratory queries that uncover trends in **patient demographics, healthcare utilization, chronic conditions, and immunization patterns**.  

These insights will be visualized in a **Power BI dashboard** to demonstrate real-world healthcare analytics.  

### Project Goals  
Through this analysis, I explored questions such as:
- Which demographics experience the most healthcare encounters?
- What are the most common and chronic health conditions?
- Which cities have higher chronic disease prevalence?
- How do immunization rates vary by age group?
- What is the overall utilization rate across patients?

---

## Database Structure

[Back to Table of Contents](#table-of-contents)

| **Table**       | **Description**                                                                                           |
|------------------|-----------------------------------------------------------------------------------------------------------|
| **patients**     | Demographics and personal health details (gender, race, ethnicity, city, birthdate, income, etc.).        |
| **encounters**   | Patient visit records with encounter type, cost, payer, and organization data.                            |
| **conditions**   | Diagnoses assigned per patient, including chronic and acute conditions.                                   |
| **immunizations**| Records of vaccines administered with dates and vaccine names.                                            |

---
## Phase 1: Data Preparation & Cleaning

[Back to Table of Contents](#table-of-contents)

### Key Steps
1. Created base tables (patients, encounters, conditions, immunizations) in PostgreSQL.
2. Imported CSVs using pgAdmin Import Wizard with UTF-8 encoding.
3. Standardized and cleaned data, including:
    - Trimmed whitespace and corrected capitalization using INITCAP().
    - Rounded numerical columns (lat, lon, healthcare_expenses, etc.).
    - Added derived columns:
       - fips (regional proxy derived from ZIP)
       - income (randomized between 30,000–150,000)
       - mrn (unique patient ID using ROW_NUMBER()).
4. Validated record counts, nulls, and duplicates across all tables.
5. Removed true duplicates using a SELF JOIN method on the encounters table.

### Example Cleaning Step
### Data Standardization
```sql
UPDATE patients
SET 
    city = INITCAP(TRIM(city)),
    race = INITCAP(TRIM(race)),
    healthcare_expenses = ROUND(healthcare_expenses::numeric, 2);
```

### Duplicate Check in Encounters Table
```sql
-- Identify potential duplicates
SELECT patient, description, start, stop, COUNT(patient)
FROM public.encounters
GROUP BY patient, description, start, stop
HAVING COUNT(patient) > 1;
```

### Verify True Duplicates
```sql
-- Confirm if its a True Duplicate
SELECT *
FROM public.encounters
WHERE patient = 'bab51ea9-2945-4f8a-8015-e430f80a908e'
  AND description = 'Encounter For Problem'
  AND start = '2014-05-27 09:39:29'
  AND stop = '2014-05-27 09:54:29';
```

### Self-Join Preview Before Deletion
```sql
-- Previewed Duplicate before DELETING by doing a SELF JOIN to return value 
SELECT a.*
FROM encounters a
JOIN encounters b
  ON a.patient = b.patient
  AND a.description = b.description
  AND a.start = b.start
  AND a.stop = b.stop
  AND a.organization = b.organization
  AND a.ctid < b.ctid;
```

### Delete Confirmed Duplicates
```sql
-- Deleted one of the records after confirming
DELETE FROM encounters a
USING encounters b
WHERE a.ctid < b.ctid
  AND a.patient = b.patient
  AND a.description = b.description
  AND a.start = b.start
  AND a.stop = b.stop
  AND a.organization = b.organization;
```
To view the complete data cleaning process, see the full SQL script here: [`Healthcare Data Preparation.sql`](./Patient%20Health%20Utilization_data_preparation_cleaning.sql)

## Phase 2: Exploratory Data Analysis (EDA)

[Back to Table of Contents](#table-of-contents)

### Key Steps
1. **Defined baseline population metrics** — total patients, encounters, conditions, and immunizations for KPI benchmarking.
2. **Explored patient demographics** to identify gender, race, and city-level population distributions.
3. **Analyzed healthcare utilization patterns**, including encounter types and high-frequency patients.
4. **Investigated chronic conditions** by filtering for long-term diagnoses and ranking by frequency.
5. **Examined immunization coverage**, identifying the most common vaccines and average patient age at administration.
6. **Measured racial and geographic health disparities**, comparing average conditions per patient across groups.
7. **Validated dataset relationships** across all tables using ```LEFT JOIN``` integrity checks.

### Population Overview Metrics
```sql
SELECT COUNT(id) FROM patients;                -- Total Patients  
SELECT COUNT(DISTINCT patient) FROM encounters;  -- Active Patients with Encounters  
SELECT COUNT(DISTINCT patient) FROM conditions;  -- Patients Diagnosed  
SELECT COUNT(DISTINCT patient) FROM immunizations;  -- Patients Immunized
```
**Insight:** Established baseline counts for KPI cards in Power BI.

### Patient Demographics
```sql
SELECT gender, COUNT(id) AS total_patients
FROM patients
GROUP BY gender
ORDER BY total_patients DESC;
```
**Insight:** Identified population composition by gender.

### Encounter Utilization
```sql
SELECT encounterclass, COUNT(id) AS total_encounters
FROM encounters
GROUP BY encounterclass
ORDER BY total_encounters DESC;
```
**Insight:** Outpatient and emergency encounters dominate utilization patterns.

### Chronic Conditions Explorer
```sql
SELECT description, COUNT(description) AS occurrences
FROM conditions
WHERE description <> 'Body Mass Index 30+ - Obesity (Finding)'
  AND description ILIKE '%chronic%'
GROUP BY description
ORDER BY occurrences DESC;
```
**Insight:** Chronic sinusitis, heart failure, and chronic pain are the most frequent chronic disorders.

### Immunization Trends
```sql
WITH vaccine_age AS (
  SELECT i.description AS vaccine,
         ROUND(AVG(EXTRACT(YEAR FROM AGE(date, p.birthdate))), 0) AS avg_age
  FROM immunizations i
  JOIN patients p ON i.patient = p.id
  GROUP BY i.description
)
SELECT vaccine, avg_age,
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
```
**Insight:** Early childhood immunizations (Rotavirus, DTaP, MMR) dominate the dataset.

### Racial & Geographic Health Trends
```sql
SELECT 
    p.race,
    ROUND(COUNT(c.*)::numeric / COUNT(DISTINCT p.id), 0) AS avg_conditions_per_patient,
    COUNT(DISTINCT p.id) AS num_patients,
    COUNT(c.*) AS total_conditions
FROM patients p
JOIN conditions c ON p.id = c.patient
GROUP BY p.race
HAVING COUNT(DISTINCT p.id) >= 10
ORDER BY avg_conditions_per_patient DESC;
```
**Insight:** Certain racial groups show higher chronic burden per patient — a useful metric for population health dashboards.

### Geographic Insights
```sql
SELECT city, COUNT(DISTINCT p.id) AS chronic_patients
FROM patients p
JOIN conditions c ON p.id = c.patient
WHERE c.description ILIKE '%chronic%'
GROUP BY city
ORDER BY chronic_patients DESC;
```
**Insight:** Cities such as Boston, Springfield, and Worcester record the highest chronic case counts.

To view the complete exploratory analysis process, see the full SQL script here: [`Healthcare Exploratory Analysis.sql`](./Patient%20Health%20Utilization_exploratory_analysis.sql)

## Key Takeaways

[Back to Table of Contents](#table-of-contents)

- SQL can uncover healthcare utilization and prevention trends directly from raw patient data.
- Chronic condition tracking reveals how disease burden differs by demographics and geography.
- Data preparation (standardization, cleaning, derived features) is critical before visualization.
- These insights form the foundation for a Power BI dashboard showcasing patient utilization trends.

## Project Files

[Back to Table of Contents](#table-of-contents)

| **File**       | **Description**                                                                                           |
|------------------|-----------------------------------------------------------------------------------------------------------|
| ```Patient Health Utilization_data_preparation_cleaning.sql```     | Full cleaning and transformation script        |
| ```Patient Health Utilization_exploratory_analysis.sql```  | All EDA queries grouped by category                           |
| exploration_screenshots/   | Screenshots of SQL query results.                                   |
| README.md | This documentation and project overview.                                            |
