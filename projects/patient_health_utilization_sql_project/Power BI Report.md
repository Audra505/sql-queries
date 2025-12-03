## Overview
This file contains the interactive **Power BI dashboard** for Patient Health Utilization (2010-2020). It visualizes the insights derived from SQL-based analysis of the **Synthea synthetic healthcare dataset** and it highlights **patient utilization**, **conditions/chronic**, **immunization coverage**, and **regional health patterns** across Massachusetts.  
The report demonstrates **data storytelling**, **dynamic measures**, and **context-aware tooltips** to simulate a real-world healthcare analytics workflow.


## Live Report (Web View)
[**View Published Dashboard on Power BI**](https://app.powerbi.com/view?r=eyJrIjoiMzg5ZjAyN2QtNzBmNS00MDM4LThlNTEtYjdiZDRjZDVmNmY5IiwidCI6ImY0ZTI5ODFhLWVlMjctNDhkZi05NDM1LWM0NmJiZDRmMWU3ZCJ9)  


## Instructions
- Click the link above to open the live dashboard.  
- Use slicers to explore **Year**, **Race**, **Gender**, and **City** dimensions.  
- Hover over visuals to reveal **custom tooltips** featuring contextual narratives (e.g., “Encounter activity rose this month by 7.7 %”).  
- Use the **navigation buttons** to move across visuals to get more insights.

## Navigate Through the Report to Explore:
- **Patient Overview:** Global KPIs and healthcare utilization summary 
- **Encounter Trends:** Monthly and categorical encounter patterns 
- **Conditions Explorer:** Top 10 dimensions + Chronic conditions frequency and burden 
- **City Insights:** Regional health distribution 

## Feature Highlights
- **Custom DAX measures** for dynamic KPI cards, growth percentages, and multi-table filtering logic.  
- **Field Parameters** for switching between *Encounter Type*, *Race*, and *Gender* dynamically.  
- **Narrative Tooltips** displaying encounter changes, category breakdowns, and ranking-based commentary.  
- **Shape Map Visualization** for regional chronic disease density (city-level granularity).  
- **Dynamic Navigation Buttons** linking Patients ↔ Encounters ↔ Conditions ↔ Immunizations.

## Technical Stack
- **Data Source:** PostgreSQL (Synthea-generated patient records)  
- **ETL & Querying:** SQL (data cleaning, transformations, joins)  
- **Visualization:** Power BI (DAX modeling, storytelling design)  
- **Integration:** GitHub + Power BI Service (web publication)
