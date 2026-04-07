![Dashboard](Global%20Workforce%20Data%20Integrity%20&%20Impact%20Excel%20Dashboard.png)

# World-Layoffs-ETL-and-EDA Summary:
A comprehensive SQL project focused on cleaning a messy dataset of global tech layoffs followed by Exploratory Data Analysis (EDA) to identify high-impact trends and top-performing companies.

Project Overview
**This project involves a comprehensive data pipeline using MySQL. I transformed a raw, unstructured dataset of global tech layoffs into a clean, query-ready format and then performed an Exploratory Data Analysis (EDA) to uncover historical layoff trends.**

Part 1: Data Cleaning (ETL)
  Key technical steps included:

    Deduplication: Utilized Window Functions (ROW_NUMBER) inside a CTE to identify and remove redundant records.

    Standardization: Cleaned industry labels (e.g., merging variations of 'Crypto'), trimmed white spaces, and fixed geographic anomalies.

    Date Conversion: Transformed string-based date columns into proper SQL DATE objects using STR_TO_DATE.

    Null Handling: Executed Self-Joins to populate missing categorical values based on related company data.

Part 2: Exploratory Data Analysis (EDA)
  I queried the cleaned data to find:

    Total layoffs by industry and location.

    Annual progression of layoffs.

    Advanced Analytics: Used Nested CTEs and DENSE_RANK() to identify the Top 5 companies with the highest layoffs for every year in the dataset.

Part 3: Interactive Data Integrity Dashboard
I developed an Excel dashboard to serve as the front-end for the cleaned dataset, focusing on audit-ready visualization and stakeholder accessibility.
Key Features:

    Implemented a custom validation metric (82% completeness) using structured table references to monitor and report record-level missingness, a critical requirement for compliance-driven data review.

    Utilized Slicers with multi-chart report connections, allowing users to perform deep-dive audits into specific industries.

    Constructed secondary-axis combo charts to visualize the correlation between corporate funding cycles and workforce reductions over a 3-year period.
