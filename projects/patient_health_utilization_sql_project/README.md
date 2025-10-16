# Patient Health Utilization 
---

## Table of Contents
- [Project Overview](#project-overview)
- [Database Structure](#database-structure)
- [Phase 1:Data Preparation & Cleaning](#phase-1-data-preparation--cleaning)
- [Phase 2: Exploratory Data Analysis (EDA)](#phase-2-exploratory-data-analysis-eda)
- [Key Takeaways](##key-takeaways)
- [Project Files](##project-files)
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

## Verify True Duplicates
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
