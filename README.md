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
