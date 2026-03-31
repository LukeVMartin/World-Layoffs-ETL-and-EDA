SELECT *
FROM layoffs;	

-- 1. Remove Duplicates (Done)
-- 2. Standardize the Data (Done)
-- 3. Null Values/Blank Values (Done)
-- 4. Remove 'Useless' Columns (Done)

#Create new table that is not Raw table (Do not Want to mess with the Raw data)
CREATE TABLE layoffs_duplicate
LIKE layoffs;

INSERT layoffs_duplicate
SELECT *
FROM layoffs;

#Finding Duplicates

WITH duplicate_cte AS
(
Select *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS ROW_NUM
FROM layoffs_duplicate
)
SELECT * 
FROM duplicate_cte
WHERE ROW_NUM > 1;

#Checking if they are duplicates
SELECT *
FROM layoffs_duplicate
WHERE company = 'Casper';


# Need To Make New Table to make a new column called row_num so we can delete it.

CREATE TABLE `layoffs_cleaned` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT #Added Column in order to delete duplicates
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_cleaned
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS ROW_NUM
FROM layoffs_duplicate;

SELECT * 
FROM layoffs_cleaned;

SELECT * 
FROM layoffs_cleaned
WHERE row_num > 1;

SET SQL_SAFE_UPDATES = 0;

DELETE
FROM layoffs_cleaned
WHERE row_num > 1;

SET SQL_SAFE_UPDATES = 1;

-- Standardizing Data

#Looking at the companys and we see some have a blank space in front of the name
SELECT company,  TRIM(company)
FROM layoffs_cleaned;

#Trimming anything that has blank spaces
UPDATE layoffs_cleaned
SET company = TRIM(company);

#Finding if any industry has similar/same name
SELECT DISTINCT(industry)
From layoffs_cleaned
ORDER BY 1;

SELECT *
From layoffs_cleaned
WHERE industry LIKE 'Crypto%';

#Updated the Crpyto Currency industrys to just say Crypto. 
UPDATE layoffs_cleaned
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

#Checking all columns including Country
SELECT DISTINCT Country
FROM layoffs_cleaned
ORDER BY 1;

#Fixing a duplication of United States that added a period United States.
UPDATE layoffs_cleaned
SET country = TRIM(TRAILING '.' FROM country)
WHERE country  LIKE 'United States%';

#Changing Date to time column
SELECT `date`
FROM layoffs_cleaned
ORDER BY `date`;

#Converted the date into the proper format
UPDATE layoffs_cleaned
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

#Alter the date column so it is considered a date column and not a text columna (Should check if there are any NULLS before altering the column)
ALTER TABLE layoffs_cleaned
MODIFY COLUMN `date` DATE;

#Step 3 Null and Blank Values
#Checking Nulls
SELECT * 
FROM layoffs_cleaned
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

#Checking Nulls and blanks
SELECT *
FROM layoffs_cleaned
WHERE industry IS NULL OR industry = '';

#Checking companys that have a blank in industry for one row but not another row.
SELECT *
FROM layoffs_cleaned
WHERE company = 'Airbnb';

SELECT *
FROM layoffs_cleaned AS st2
JOIN layoffs_cleaned AS st3
	ON st2.company = st3.company
WHERE (st2.industry IS NULL OR st2.industry = '')
AND st3.industry IS NOT NULL;

#Turning blanks into NULL in order for us to make sure there are no errors
UPDATE layoffs_cleaned
SET industry = null
WHERE industry = '';

UPDATE layoffs_cleaned AS st2
JOIN layoffs_cleaned AS st3
	ON st2.company = st3.company
SET st2.industry = st3.industry
WHERE (st2.industry IS NULL)
AND st3.industry IS NOT NULL;


SELECT * 
FROM layoffs_cleaned
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

#Delete all the data that can be seen as "useless" and might mess up our work. (Do not delete unless it seems meaningful/told to do so)
DELETE
FROM layoffs_cleaned
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

#Getting rid of row num
ALTER TABLE layoffs_cleaned
DROP COLUMN row_num;

SELECT *
FROM layoffs_cleaned;



