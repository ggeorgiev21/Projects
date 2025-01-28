/*
Glassdoor Data-Related Job Postings Project
*/

--Selecting and clearing the data 

SELECT * FROM ds_jobs;
SELECT * FROM idk.ds_jobs;
SELECT 
    `Job Description`, 
    `Salary Estimate`, 
    `Company Name`, 
    COUNT(*) AS duplicate_count
FROM
    ds_jobs
GROUP BY 
    `Job Description`, 
    `Salary Estimate`, 
    `Company Name`
HAVING 
    COUNT(*) > 1;
    
DELETE t1
FROM ds_jobs t1
JOIN ds_jobs t2
ON t1.`Job Description` = t2.`Job Description`
   AND t1.`Salary Estimate` = t2.`Salary Estimate`
   AND t1.`Company Name` = t2.`Company Name`
   AND t1.row_index > t2.row_index
WHERE t1.row_index IS NOT NULL;


--Deleting the NULL Values which were "-1" in my case

DELETE FROM idk.ds_jobs
WHERE 
    Rating = -1 AND
    Headquarters = -1 AND
    Size = -1 AND
    Founded = -1 AND
    `Type of ownership` = -1 AND
    Industry = -1 AND
    Sector = -1 AND
    Revenue = -1;
    
    DELETE FROM idk.ds_jobs
WHERE 
    Rating = -1 OR
    Industry = -1;
    SELECT * FROM idk.ds_jobs 
    

--- ADDED A NEW COLUMN NAMED AVERAGE SALARY

ALTER TABLE idk.ds_jobs
ADD COLUMN `Average Salary` DECIMAL(12, 2);

UPDATE idk.ds_jobs
SET `Average Salary` = (
    
    CAST(REGEXP_REPLACE(SUBSTRING_INDEX(`Salary Estimate`, '-', 1), '[^0-9]', '') AS DECIMAL(12, 2)) * 1000 +
    
    CAST(REGEXP_REPLACE(SUBSTRING_INDEX(`Salary Estimate`, '-', -1), '[^0-9]', '') AS DECIMAL(12, 2)) * 1000
) / 2
WHERE `Salary Estimate` LIKE '%-%';


--CREATED TABLE FOR THE TOP 5 JOBS ACROSS ALL GLASSDOOR JOB POSTINGS

CREATE TABLE idk.top_5_jobs AS
SELECT 
    `Job Title`, 
    COUNT(*) AS `Job Count`, 
    ROUND(AVG(`Average Salary`)) AS `Average Salary`
FROM 
    idk.ds_jobs
GROUP BY 
    `Job Title`
ORDER BY 
    `Job Count` DESC
LIMIT 5;


--CREATED TABLE FOR THE SKILLS REQUIRED FOR EACH JOB TITLE 

CREATE TABLE `Skills_needed_for_particular_job_title` 
SELECT 
    `Job Title` AS Job_Title,
    SUM(CASE WHEN `job description` LIKE '%SQL%' THEN 1 ELSE 0 END) AS `SQL`,
    SUM(CASE WHEN `job description` LIKE '%Python%' THEN 1 ELSE 0 END) AS Python,
    SUM(CASE WHEN `job description` LIKE '%Data Visualization%' THEN 1 ELSE 0 END) AS Data_Visualization,
    SUM(CASE WHEN `job description` LIKE '%Tableau%' THEN 1 ELSE 0 END) AS Tableau,
    SUM(CASE WHEN `job description` LIKE '%Power BI%' THEN 1 ELSE 0 END) AS Power_BI,
    SUM(CASE WHEN `job description` LIKE '%Machine Learning%' THEN 1 ELSE 0 END) AS Machine_Learning,
    SUM(CASE WHEN `job description` LIKE '%R Programming%' THEN 1 ELSE 0 END) AS R_Programming,
    SUM(CASE WHEN `job description` LIKE '%Excel%' THEN 1 ELSE 0 END) AS Excel,
    SUM(CASE WHEN `job description` LIKE '%Statistical Analysis%' THEN 1 ELSE 0 END) AS Statistical_Analysis,
    SUM(CASE WHEN `job description` LIKE '%Hadoop%' THEN 1 ELSE 0 END) AS Hadoop,
    SUM(CASE WHEN `job description` LIKE '%Spark%' THEN 1 ELSE 0 END) AS Spark,
    SUM(CASE WHEN `job description` LIKE '%ETL%' THEN 1 ELSE 0 END) AS ETL,
    SUM(CASE WHEN `job description` LIKE '%AWS%' THEN 1 ELSE 0 END) AS AWS,
    SUM(CASE WHEN `job description` LIKE '%Google Cloud%' THEN 1 ELSE 0 END) AS Google_Cloud
FROM 
    ds_jobs
WHERE 
    `Job Title` IN (
        SELECT `Job Title`
        FROM (
            SELECT `Job Title`, COUNT(*) AS Position_Count
            FROM ds_jobs
            GROUP BY `Job Title`
            ORDER BY Position_Count DESC
            LIMIT 5
        ) AS Top_Positions
    )
    AND `job description` IS NOT NULL
GROUP BY 
    `Job Title`
ORDER BY 
    `Job Title` ASC;


--Created table for the biggest industries based on the job postings and their average rating

CREATE TABLE `biggest industries by job count and average rating`
WITH IndustryPopularity AS (
    SELECT 
        `Industry`,
        COUNT(*) AS JobCount
    FROM ds_jobs
    WHERE `Industry` IS NOT NULL AND `Industry` != '-1'
    GROUP BY `Industry`
),
TopIndustries AS (
    SELECT 
        `Industry`,
        JobCount
    FROM IndustryPopularity
    ORDER BY JobCount DESC
    LIMIT 10
)
SELECT 
    j.`Industry`,
    COUNT(*) AS JobCount,
    ROUND(AVG(j.Rating), 2) AS AverageRating
FROM ds_jobs j
JOIN TopIndustries t
ON j.`Industry` = t.`Industry`
WHERE j.Rating IS NOT NULL
GROUP BY j.`Industry`
ORDER BY JobCount DESC;


--Created a table for the general skills needed across all job postings

CREATE TABLE `General_Skills_Needed` AS
SELECT 
    'SQL' AS `Skill`, 
    SUM(CASE WHEN `job description` LIKE '%SQL%' THEN 1 ELSE 0 END) AS `Occurrences`
FROM ds_jobs
UNION ALL
SELECT 
    'Python' AS `Skill`, 
    SUM(CASE WHEN `job description` LIKE '%Python%' THEN 1 ELSE 0 END) AS `Occurrences`
FROM ds_jobs
UNION ALL
SELECT 
    'Data Visualization' AS `Skill`, 
    SUM(CASE WHEN `job description` LIKE '%Data Visualization%' THEN 1 ELSE 0 END) AS `Occurrences`
FROM ds_jobs
UNION ALL
SELECT 
    'Tableau' AS `Skill`, 
    SUM(CASE WHEN `job description` LIKE '%Tableau%' THEN 1 ELSE 0 END) AS `Occurrences`
FROM ds_jobs
UNION ALL
SELECT 
    'Power BI' AS `Skill`, 
    SUM(CASE WHEN `job description` LIKE '%Power BI%' THEN 1 ELSE 0 END) AS `Occurrences`
FROM ds_jobs
UNION ALL
SELECT 
    'Machine Learning' AS `Skill`, 
    SUM(CASE WHEN `job description` LIKE '%Machine Learning%' THEN 1 ELSE 0 END) AS `Occurrences`
FROM ds_jobs
UNION ALL
SELECT 
    'R Programming' AS `Skill`, 
    SUM(CASE WHEN `job description` LIKE '%R Programming%' THEN 1 ELSE 0 END) AS `Occurrences`
FROM ds_jobs
UNION ALL
SELECT 
    'Excel' AS `Skill`, 
    SUM(CASE WHEN `job description` LIKE '%Excel%' THEN 1 ELSE 0 END) AS `Occurrences`
FROM ds_jobs
UNION ALL
SELECT 
    'Statistical Analysis' AS `Skill`, 
    SUM(CASE WHEN `job description` LIKE '%Statistical Analysis%' THEN 1 ELSE 0 END) AS `Occurrences`
FROM ds_jobs
UNION ALL
SELECT 
    'Hadoop' AS `Skill`, 
    SUM(CASE WHEN `job description` LIKE '%Hadoop%' THEN 1 ELSE 0 END) AS `Occurrences`
FROM ds_jobs
UNION ALL
SELECT 
    'Spark' AS `Skill`, 
    SUM(CASE WHEN `job description` LIKE '%Spark%' THEN 1 ELSE 0 END) AS `Occurrences`
FROM ds_jobs
UNION ALL
SELECT 
    'ETL' AS `Skill`, 
    SUM(CASE WHEN `job description` LIKE '%ETL%' THEN 1 ELSE 0 END) AS `Occurrences`
FROM ds_jobs
UNION ALL
SELECT 
    'AWS' AS `Skill`, 
    SUM(CASE WHEN `job description` LIKE '%AWS%' THEN 1 ELSE 0 END) AS `Occurrences`
FROM ds_jobs
UNION ALL
SELECT 
    'Google Cloud' AS `Skill`, 
    SUM(CASE WHEN `job description` LIKE '%Google Cloud%' THEN 1 ELSE 0 END) AS `Occurrences`
FROM ds_jobs;


--Created a table for the states that hired the most data-related job titles

CREATE TABLE `States_Hiring_the_Most` AS
SELECT 
    `Job Title`, 
    `Location`, 
    COUNT(*) AS total_job_titles, 
    COUNT(DISTINCT `Location`) AS total_locations, 
    CAST(AVG(`Average Salary`) AS UNSIGNED) AS average_salary
FROM 
    ds_jobs
GROUP BY 
    `Job Title`, `Location`;


--Created table for the industries which hire only data scientists

CREATE TABLE `Industries_Hiring_Data_Scientists` AS
SELECT 
    `Industry`, 
    COUNT(*) AS total_job_titles, 
    COUNT(DISTINCT `Location`) AS total_locations, 
    CAST(AVG(`Average Salary`) AS UNSIGNED) AS average_salary
FROM 
    ds_jobs
WHERE 
    `Job Title` LIKE '%Data Scientist%'
GROUP BY 
    `Industry`
LIMIT 11;