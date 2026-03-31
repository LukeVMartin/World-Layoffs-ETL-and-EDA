-- Exploratory Data Analysis

SELECT *
FROM layoffs_cleaned;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_cleaned;

SELECT *
FROM layoffs_cleaned
WHERE percentage_laid_off = 1;

SELECT company, SUM(total_laid_off)
FROM layoffs_cleaned
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_cleaned;

SELECT industry, SUM(total_laid_off)
FROM layoffs_cleaned
GROUP BY industry
ORDER BY 2 DESC;

SELECT country, SUM(total_laid_off)
FROM layoffs_cleaned
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_cleaned
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

SELECT MONTH(`date`) AS MONTH, SUM(total_laid_off)
FROM layoffs_cleaned
WHERE MONTH(`date`) IS NOT NULL
GROUP BY MONTH(`date`)
ORDER BY MONTH(`date`);

#If you want to include year as well (Which is probably as much if not more important)
SELECT SUBSTRING(`date`,1,7) AS `MONTH`
FROM layoffs_cleaned
ORDER BY `MONTH`;

#Rolling total of just the Months without taking years into consideration
WITH Rolling_Total AS
(
SELECT MONTH(`date`) AS MONTH, SUM(total_laid_off) AS total_off
FROM layoffs_cleaned
WHERE MONTH(`date`) IS NOT NULL
GROUP BY MONTH(`date`)
ORDER BY MONTH(`date`)
)
SELECT MONTH, total_off, SUM(total_off) OVER(ORDER BY MONTH)
FROM Rolling_Total;

SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_cleaned
GROUP BY company, year(`date`)
ORDER BY 3 DESC;

#Finding the ranking of which companys laid off the most employees per year then including the top 5 per year
WITH Ranking_Company (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_cleaned
GROUP BY company, year(`date`)
), Company_Year_Rank AS
(SELECT *, 
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS RANKING
FROM Ranking_Company
WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5;