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


