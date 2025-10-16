/******************************************************************************************
Patient Health Utilization Project
Phase 1: Data Preparation & Cleaning
******************************************************************************************/

-- Objective:
-- In this section, we’ll prepare and clean the raw Synthea healthcare data before analysis.
-- Steps include:
--   1. Creating base tables for each dataset
--   2. Importing CSV files and preparing for updates
--   3. Adding and generating new columns (FIPS, Income, MRN)
--   4. Standardizing text and numeric formats across tables
--   5. Cleaning duplicates and validating missing data
--   6. Performing rounding and data consistency checks
--   7. Verifying relationships across tables
--   8. Final validation summary and data quality assurance

/******************************************************************************************
   STEP 1: CREATE TABLES
******************************************************************************************/

-- Create Conditions Table
CREATE TABLE conditions (
START DATE
,STOP DATE
,PATIENT VARCHAR(1000)
,ENCOUNTER VARCHAR(1000)
,CODE VARCHAR(1000)
,DESCRIPTION VARCHAR(200)
);

-- Create Encounters Table
CREATE TABLE encounters (
 Id VARCHAR(100)
,START TIMESTAMP
,STOP TIMESTAMP
,PATIENT VARCHAR(100)
,ORGANIZATION VARCHAR(100)
,PROVIDER VARCHAR(100)
,PAYER VARCHAR(100)
,ENCOUNTERCLASS VARCHAR(100)
,CODE VARCHAR(100)
,DESCRIPTION VARCHAR(100)
,BASE_ENCOUNTER_COST FLOAT
,TOTAL_CLAIM_COST FLOAT
,PAYER_COVERAGE FLOAT
,REASONCODE VARCHAR(100)
);

-- Create Immunizations Table
CREATE TABLE immunizations
(
 DATE TIMESTAMP
,PATIENT varchar(100)
,ENCOUNTER varchar(100)
,CODE int
,DESCRIPTION varchar(500)
);

-- Create Patients Table
CREATE TABLE patients
(
 Id VARCHAR(100)
,BIRTHDATE date
,DEATHDATE date
,SSN VARCHAR(100)
,DRIVERS VARCHAR(100)
,PASSPORT VARCHAR(100)
,PREFIX VARCHAR(100)
,FIRST VARCHAR(100)
,LAST VARCHAR(100)
,SUFFIX VARCHAR(100)
,MAIDEN VARCHAR(100)
,MARITAL VARCHAR(100)
,RACE VARCHAR(100)
,ETHNICITY VARCHAR(100)
,GENDER VARCHAR(100)
,BIRTHPLACE VARCHAR(100)
,ADDRESS VARCHAR(100)
,CITY VARCHAR(100)
,STATE VARCHAR(100)
,COUNTY VARCHAR(100)
,FIPS INT 
,ZIP INT
,LAT float
,LON float
,HEALTHCARE_EXPENSES float
,HEALTHCARE_COVERAGE float
,INCOME int
,Mrn int
);

/******************************************************************************************
   STEP 2: DROPPED COLUMNS
******************************************************************************************/

-- Dropped some columns in the patients table to ensure it gets imported correctly without any errors
ALTER TABLE public.patients
DROP COLUMN IF EXISTS fips,
DROP COLUMN IF EXISTS income,
DROP COLUMN IF EXISTS mrn;

/******************************************************************************************
  STEP 3: IMPORT DATA
******************************************************************************************/
-- Afterwards I imported the CSVs using pgAdmin Import Wizard or COPY command

/******************************************************************************************
  STEP 4: ADDED NEW COLUMNS AND GENERATED DATA FOR THEM
******************************************************************************************/

-- Added back the columns in the patients table once import was completed 
ALTER TABLE public.patients
ADD COLUMN fips INT,
ADD COLUMN income INT,
ADD COLUMN mrn INT;

-- Generated a regional segementation proxy by dividing the zip/10
UPDATE public.patients
SET fips = (zip / 10);

-- Generated Income data by creating randomized values between 30,000 and 150,000 to create a realistic range
UPDATE public.patients
SET income = FLOOR(RANDOM() * (150000 - 30000 + 1)) + 30000;

-- Generated unique MRNs by using a sequential ROW_NUMBER() ranking
UPDATE public.patients
SET mrn = sub.rownum
FROM (
    SELECT id, ROW_NUMBER() OVER (ORDER BY id) AS rownum
    FROM public.patients
) AS sub
WHERE patients.id = sub.id;

-- Lastly just Validated the enteries
SELECT *
FROM public.patients;

/******************************************************************************************
  STEP 5: DATA CLEANING & STANDARDIZATION
******************************************************************************************/

-- 1.Standardized casing and spacing in demographic columns for the tables 
-- 2.Performed Numeric Standardization and Rounding as well
-- 3.Checked for Duplicates and Removed if spotted
-- 4. Checked for Nulls and verified them

SELECT *
FROM public.patients;

-- Standardized for the Patients Table
UPDATE public.patients
SET 
    city = INITCAP(TRIM(city)),
    first = INITCAP(TRIM(first)),
    last = INITCAP(TRIM(last)),
    prefix = INITCAP(TRIM(prefix)),
    race = INITCAP(TRIM(race)),
	ethnicity = INITCAP(TRIM(ethnicity)),	
	birthplace = INITCAP(TRIM(birthplace)),
	state = INITCAP(TRIM(state)),
	county = INITCAP(TRIM(county));

-- Rounding Standardization for Patients Table
UPDATE public.patients
SET 
    lat = ROUND(lat::numeric, 4),
	lon = ROUND(lon::numeric, 4),
	healthcare_expenses = ROUND(healthcare_expenses::numeric, 2),
	healthcare_coverage = ROUND(healthcare_coverage::numeric, 2);

-- Duplicate Check in the Patients table
SELECT id, COUNT(id) 
FROM public.patients
GROUP BY id
HAVING COUNT(id) > 1;
-----------------------------------------------------------	

SELECT *
FROM public.conditions;

-- Standardized for the Conditions Table
UPDATE public.conditions
SET 
    description = INITCAP(TRIM(description));

-- Duplicate Check in the Conditions table
SELECT patient, description, start, stop, COUNT(patient)
FROM public.conditions
GROUP BY patient, description, start, stop
HAVING COUNT(patient) > 1;

------------------------------------------------------------

SELECT *
FROM public.encounters;

-- Standardized for the Encounters Table
UPDATE public.encounters
SET 
    description = INITCAP(TRIM(description)),
	encounterclass = INITCAP(TRIM(encounterclass));

-- Duplicate Check in the Encounters table
SELECT patient, description, start, stop, COUNT(patient)
FROM public.encounters
GROUP BY patient, description, start, stop
HAVING COUNT(patient) > 1;

-- Duplicate Found so need to confirm if its a True Duplicate
SELECT *
FROM public.encounters
WHERE patient = 'bab51ea9-2945-4f8a-8015-e430f80a908e'
  AND description = 'Encounter For Problem'
  AND start = '2014-05-27 09:39:29'
  AND stop = '2014-05-27 09:54:29';

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

-- Deleted one of the records after confirming
DELETE FROM encounters a
USING encounters b
WHERE a.ctid < b.ctid
  AND a.patient = b.patient
  AND a.description = b.description
  AND a.start = b.start
  AND a.stop = b.stop
  AND a.organization = b.organization;
------------------------------------------------------------------

SELECT *
FROM public.immunizations;

-- Standardized for the Immunizations Table
UPDATE public.immunizations
SET 
    description = INITCAP(TRIM(description));


-- Duplicate Check in the Immunizations table
SELECT patient, description, date, encounter, COUNT(patient)
FROM public.immunizations
GROUP BY patient, description, date, encounter
HAVING COUNT(patient) > 1;

/******************************************************************************************
  STEP 6: VALIDATION SUMMARY
******************************************************************************************/

-- Count of records per table
SELECT 'patients' AS table, COUNT(*) 
FROM public.patients
UNION ALL
SELECT 'conditions', COUNT(*) 
FROM public.conditions
UNION ALL
SELECT 'encounters', COUNT(*) 
FROM public.encounters
UNION ALL
SELECT 'immunizations', COUNT(*) 
FROM public.immunizations;

-- Check for nulls in key columns
SELECT 
    COUNT(*) FILTER (WHERE id IS NULL) AS null_id,
    COUNT(*) FILTER (WHERE gender IS NULL) AS null_gender,
    COUNT(*) FILTER (WHERE race IS NULL) AS null_race
FROM public.patients;