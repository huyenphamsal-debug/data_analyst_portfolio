# Excel Data Jobs Salary Dashboard

 Image

## Introduction
This Excel dashboard explores salary patterns for various data-related careers—helping job seekers evaluate compensation and make informed career choices.

The dataset, sourced from an Excel training course, contains comprehensive information on job titles, salaries, locations, and key technical skills. This project demonstrates how Excel can be used for data cleaning, analysis, and visualization to uncover real-world insights.

### Dashboard File 
My dashboard is in [Salary_Dashboard.xlsx](Salary_Dashboard.xlsx).

### Excel Skills Used 
- **📉 Charts** — to visualize job and regional salary comparisons
- **🧮 Formulas & Functions** — for salary analysis and filtering
- **❎ Data Validation** — to ensure consistent and user-friendly interactivity

### Dataset Overview 
The dataset includes 2023 data science job listings, featuring details such as:
- **👨‍💼 Job Titles**
- **💰 Salaries (Annual Average)**
- **📍 Locations**
- **🛠️ Skills**

This dataset forms the foundation of the dashboard and enables comparative analysis across roles and countries.

## Dashboard Build 

### 📉 Charts

### 💰 Median Salaries by Job Title
**Excel Features:**
- Horizontal bar chart used for comparing median salaries.
- Jobs sorted high to low for readability.
- Salary values formatted for clarity.
  
**💡 Insight:** Senior roles and engineering positions consistently show higher pay than analyst-level jobs.

### 🌍 Country Median Salaries
**Excel Features:**
- Used Map Chart to visualize global salary trends.
- Applied color scale for intuitive regional comparison.

**💡 Insight:** Clear salary disparities between regions — North America and Western Europe lead globally.


### 🧮 Formulas and Functions 


### 🔢 Median Salary Calculation
```
=MEDIAN(
IF(
 (jobs[job_title_short]=A2)*
 (jobs[job_country]=country)*
 (ISNUMBER(SEARCH(type,jobs[job_schedule_type])))*
 (jobs[salary_year_avg]<>0),
 jobs[salary_year_avg]
)
)
```
**Purpose:** Calculates the median salary for a specific combination of job title, country, and schedule type while excluding blanks.

**Result:** Produces tailored salary insights per selected filters.


### ⏰ Job Schedule Type Filter
```
=FILTER(J2#,(NOT(ISNUMBER(SEARCH("and",J2#))+ISNUMBER(SEARCH(",",J2#))))*(J2#<>0))
```
**Purpose:** Creates a unique, clean list of job schedule types by removing combined or invalid entries.

**💡 Result:** Makes dropdown filters simpler and more accurate for users.


### 🔒 Data Validation

Enhanced the dashboard interactivity by setting data validation lists for Job Title, Country, and Type — ensuring only valid, consistent selections.

**Benefits:**
- 🎯 Accurate user input
- 🚫 Prevents inconsistent data entry
- 👥 Improves dashboard usability


## 🏁 Conclusion
This project demonstrates how Excel can deliver professional-grade data insights through formulas, visualization, and interactivity. The dashboard helps users explore salary variations by role, country, and job type—empowering better career and compensation decisions.















