/*
World Data 2023: Global Economic & Social Insights 
*/

-- **1. Tax-rev-and-gdp:**  
-- Creates a table listing countries along with their GDP and tax revenue, sorted by highest tax revenue.
CREATE TABLE `Tax-rev-and-gdp`
SELECT Country, GDP_Cleaned, Tax_revenue____ 
FROM `world_data_2023`
WHERE Tax_revenue____ IS NOT NULL 
ORDER BY Tax_revenue____ DESC;

-- **2. gdpandco2emm:**  
-- Generates a table showing countries' GDP and CO2 emissions, ranked by CO2 emissions to analyze environmental impact.
CREATE TABLE `gdpandco2emm`
SELECT Country, GDP_Cleaned, Co2_Emissions 
FROM `world_data_2023`
WHERE Co2_Emissions IS NOT NULL AND GDP_Cleaned IS NOT NULL
ORDER BY CO2_Emissions DESC;

-- **3. urb.pop and gdp:**  
-- Lists countries with their urban population size and GDP, ordered by urban population to explore urbanization trends.
CREATE TABLE `urb.pop and gdp`
SELECT Country, Urban_Population, GDP_Cleaned 
FROM `world_data_2023`
WHERE Urban_Population IS NOT NULL AND GDP_Cleaned IS NOT NULL
ORDER BY Urban_Population DESC;

-- **4. Unempl.rate and CPI-change:**  
-- Displays countries with their unemployment rates and Consumer Price Index (CPI) changes, sorted by CPI change to observe inflation trends.
CREATE TABLE `Unempl.rate and CPI-change`
SELECT Country, Unemployment_Rate, CPI_Change____ 
FROM `world_data_2023`
WHERE CPI_Change____ IS NOT NULL AND Unemployment_Rate IS NOT NULL
ORDER BY CPI_Change____ DESC;

-- **5. The Most Economically Sustainable Countries:**  
-- Compiles a table with various economic indicators such as GDP, life expectancy, education enrollment, tax revenue, and unemployment rate to identify economically sustainable countries.
CREATE TABLE `The Most Economically Sustainable Countries`
SELECT Country, GDP_cleaned, Life_Expectancy, Gross_tertiary_education_enrollment____, Tax_revenue____, Unemployment_Rate 
FROM `world_data_2023`
WHERE GDP_cleaned IS NOT NULL AND Life_Expectancy IS NOT NULL AND Gross_tertiary_education_enrollment____ IS NOT NULL AND Tax_revenue____ IS NOT NULL AND Unemployment_Rate IS NOT NULL
ORDER BY GDP_cleaned DESC;

-- **6. Tax Rates in Rich vs. Poor Countries:**  
-- Creates a comparison of total tax rates between countries of varying GDP levels, sorted by tax rate.
CREATE TABLE `Tax Rates in Rich vs. Poor Countries`
SELECT Country, GDP_Cleaned, Total_Tax_Rate 
FROM `world_data_2023`
ORDER BY Total_Tax_Rate DESC;

-- **7. GDP and Gasoline Prices:**  
-- Lists countries by GDP along with their gasoline prices, sorted by GDP, for economic analysis of fuel costs.
SELECT Country, GDP_cleaned, Gasoline_Price 
FROM `world_data_2023`
WHERE GDP_cleaned IS NOT NULL AND Gasoline_Price IS NOT NULL
ORDER BY GDP_cleaned DESC;

-- **8. GDP and Armed Forces Size:**  
-- Shows countries' GDP and the size of their armed forces, ordered by GDP to understand defense spending in relation to economic size.
SELECT Country, GDP_Cleaned, Armed_Forces_Size 
FROM `world_data_2023`
WHERE Armed_Forces_Size IS NOT NULL AND GDP_Cleaned IS NOT NULL
ORDER BY GDP_cleaned DESC;

-- **9. Unemployment Rate and Life Expectancy:**  
-- Orders countries by unemployment rate, along with life expectancy data, to examine the relationship between employment and health.
SELECT Country, Unemployment_Rate, Life_Expectancy 
FROM `world_data_2023`
WHERE Unemployment_Rate IS NOT NULL AND Life_Expectancy IS NOT NULL
ORDER BY Unemployment_Rate ASC;

-- **10. Education and Tax Revenue:**  
-- Lists countries' tax revenue and education enrollment rates (primary and tertiary), sorted by tax revenue to study the link between taxation and education.
SELECT Country, Tax_revenue____, Gross_primary_education_enrollment____, Gross_tertiary_education_enrollment____ 
FROM `world_data_2023`
WHERE Tax_revenue____ IS NOT NULL AND Gross_primary_education_enrollment____ IS NOT NULL AND Gross_tertiary_education_enrollment____ IS NOT NULL
ORDER BY Tax_revenue____ DESC;

-- **11. Latitude and Life Expectancy:**  
-- Ranks countries by latitude and life expectancy, providing insights into geographic and health correlations.
SELECT Country, Latitude, Life_Expectancy 
FROM `world_data_2023`
WHERE Latitude IS NOT NULL AND Life_Expectancy IS NOT NULL
ORDER BY Latitude DESC;

-- **12. Avg Latitude and Life Expectancy (Top 10 by Latitude):**  
-- Calculates the average latitude and life expectancy of the top 10 northernmost countries.
SELECT AVG(Latitude) AS Avg_Latitude, AVG(Life_Expectancy) AS Avg_Life_Expectancy
FROM (
    SELECT Latitude, Life_Expectancy 
    FROM `world_data_2023`
    ORDER BY Latitude DESC
    LIMIT 10
) AS Last_10_Countries;

-- **13. Avg Latitude and Life Expectancy (Bottom 10 by Latitude):**  
-- Calculates the average latitude and life expectancy of the bottom 10 southernmost countries.
SELECT AVG(Latitude) AS Avg_Latitude, AVG(Life_Expectancy) AS Avg_Life_Expectancy
FROM (
    SELECT Latitude, Life_Expectancy 
    FROM `world_data_2023`
    ORDER BY Latitude ASC
    LIMIT 10
) AS Last_10_Countries;

-- **14. Education and Labor Force Participation:**  
-- Lists countries with their primary and tertiary education enrollment rates, unemployment rates, and labor force participation, ordered by tertiary education enrollment.
SELECT Country, Gross_primary_education_enrollment____, Gross_tertiary_education_enrollment____, Unemployment_Rate, Population__Labor_force_participation____
FROM `world_data_2023`
WHERE Gross_tertiary_education_enrollment____ IS NOT NULL AND Unemployment_Rate IS NOT NULL AND Gross_primary_education_enrollment____ IS NOT NULL AND Population__Labor_force_participation____ IS NOT NULL
ORDER BY Gross_tertiary_education_enrollment____ DESC;

-- **15. Maternal and Infant Mortality with GDP:**  
-- Displays countries with their GDP, maternal mortality ratio, and infant mortality rate, sorted by GDP to analyze health outcomes relative to economic strength.
SELECT Country, Maternal_mortality_ratio, Infant_Mortality, GDP_cleaned 
FROM `world_data_2023`
ORDER BY GDP_Cleaned DESC;
