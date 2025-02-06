-- Financial Health Analysis of InterDigital, Inc. (IDCC)
-- Description: This project provides a comprehensive analysis of InterDigital, Inc.'s financial health using key metrics 
-- such as revenue growth, net profit margin, return on equity (ROE), and debt-to-equity ratio. 
-- The analysis identifies financial strengths, such as high profitability and robust revenue growth, 
-- alongside weaknesses like high leverage and tight liquidity. 
-- Visualized in Power BI, the dashboard offers actionable insights to evaluate the company’s performance trends 
-- and support strategic decision-making.

-- Table: Revenue Growth Percentage
-- Description: Measures the percentage change in total revenue over time.
CREATE TABLE Revenue_Growth AS
SELECT 
    Date,
    (`Total Revenue` - LAG(`Total Revenue`) OVER (ORDER BY Date)) / LAG(`Total Revenue`) OVER (ORDER BY Date) * 100 AS Revenue_Growth_Percentage
FROM IDCC_income_statement_wide;

-- Table: Gross Margin Percentage
-- Description: Shows the percentage of revenue that remains after accounting for the cost of goods sold.
CREATE TABLE Gross_Margin AS
SELECT 
    Date,
    (`Gross Profit` / `Total Revenue`) * 100 AS Gross_Margin_Percentage
FROM IDCC_income_statement_wide;

-- Table: Operating Margin Percentage
-- Description: Indicates the percentage of revenue left after deducting operating expenses.
CREATE TABLE Operating_Margin AS
SELECT 
    Date,
    (`Operating Income` / `Total Revenue`) * 100 AS Operating_Margin_Percentage
FROM IDCC_income_statement_wide;

-- Table: Net Profit Margin Percentage
-- Description: Represents the percentage of revenue that becomes net profit after all expenses.
CREATE TABLE Net_Profit_Margin AS
SELECT 
    Date,
    (`Net Income` / `Total Revenue`) * 100 AS Net_Profit_Margin_Percentage
FROM IDCC_income_statement_wide;

-- Table: Return on Equity (ROE) Percentage
-- Description: Measures profitability by comparing net income to stockholders' equity.
CREATE TABLE ROE AS
SELECT 
    i.Date,
    (i.`Net Income` / b.`Stockholders Equity`) * 100 AS ROE_Percentage
FROM IDCC_income_statement_wide i
JOIN IDCC_balance_sheet_wide b ON i.Date = b.Date;

-- Table: Return on Assets (ROA) Percentage
-- Description: Evaluates how efficiently a company generates profit from its assets.
CREATE TABLE ROA AS
SELECT 
    i.Date,
    (i.`Net Income` / b.`Total Assets`) * 100 AS ROA_Percentage
FROM IDCC_income_statement_wide i
JOIN IDCC_balance_sheet_wide b ON i.Date = b.Date;

-- Table: Current Ratio
-- Description: Assesses a company's ability to pay short-term liabilities with short-term assets.
CREATE TABLE Current_Ratio AS
SELECT 
    Date, 
    (`Current Assets` / `Current Liabilities`) AS Current_Ratio
FROM IDCC_balance_sheet_wide;

-- Table: Debt-to-Equity Ratio
-- Description: Indicates financial leverage by comparing total liabilities to stockholders' equity.
CREATE TABLE Debt_to_Equity AS
SELECT 
    Date, 
    (`Total Liabilities Net Minority Interest` / `Stockholders Equity`) AS Debt_to_Equity_Ratio
FROM IDCC_balance_sheet_wide;

-- Table: Operating Cash Flow Margin (Annual)
-- Description: Measures how much of a company's revenue is converted into operating cash flow.
CREATE TABLE Operating_Cash_Flow_Margin AS
SELECT 
    YEAR(cf.Date) AS Year,
    (`Operating Cash Flow` / `Total Revenue`) AS `Operating_Cash_Flow_Margin`
FROM 
    `idcc_cash_flow_wide` cf
JOIN 
    `idcc_income_statement_wide` i_s
    ON cf.Date = i_s.Date;

-- Table: Free Cash Flow (FCF)
-- Description: Calculates the cash available after capital expenditures.
CREATE TABLE Free_Cash_Flow AS
SELECT 
    Date,
    (`Operating Cash Flow` + `Capital Expenditure`) AS `Free_Cash_Flow`
FROM 
    `idcc_cash_flow_wide`;
