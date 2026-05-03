-- ============================================================
-- Marketing Campaign Performance Analysis
-- Author: Swagata Barman
-- Tool: MySQL
-- Dataset: Customer Personality Analysis (Kaggle)
-- Description: 10 SQL queries analyzing customer behavior,
--              campaign performance, and segmentation
-- ============================================================

USE marketing_analysis;

-- ============================================================
-- QUERY 1: Overall Campaign Performance
-- Business Question: Which campaign converted the most customers?
-- ============================================================

SELECT 
    SUM(AcceptedCmp1) AS Campaign_1,
    SUM(AcceptedCmp2) AS Campaign_2,
    SUM(AcceptedCmp3) AS Campaign_3,
    SUM(AcceptedCmp4) AS Campaign_4,
    SUM(AcceptedCmp5) AS Campaign_5,
    SUM(Response)     AS Last_Campaign,
    COUNT(*)          AS Total_Customers
FROM customers;

-- Finding: Last campaign was strongest with 334 conversions.
-- Campaign 2 was the weakest with only 30 conversions.


-- ============================================================
-- QUERY 2: Conversion Rate by Education Level
-- Business Question: Does education level affect campaign response?
-- ============================================================

SELECT 
    Education,
    COUNT(*) AS Total_Customers,
    SUM(Response) AS Converted,
    ROUND(SUM(Response) * 100.0 / COUNT(*), 2) AS Conversion_Rate_Pct
FROM customers
GROUP BY Education
ORDER BY Conversion_Rate_Pct DESC;

-- Finding: PhD holders convert at 20.78% vs 3.70% for Basic education.


-- ============================================================
-- QUERY 3: Conversion Rate by Marital Status
-- Business Question: Does marital status influence campaign response?
-- ============================================================

SELECT 
    Marital_Status,
    COUNT(*) AS Total_Customers,
    SUM(Response) AS Converted,
    ROUND(SUM(Response) * 100.0 / COUNT(*), 2) AS Conversion_Rate_Pct
FROM customers
GROUP BY Marital_Status
ORDER BY Conversion_Rate_Pct DESC;

-- Finding: Single and widowed customers convert at ~2x the rate
-- of married or partnered customers.


-- ============================================================
-- QUERY 4: Average Spend by Product Category
-- Business Question: Which product categories drive the most revenue?
-- ============================================================

SELECT 
    ROUND(AVG(MntWines), 2)         AS Avg_Wines,
    ROUND(AVG(MntFruits), 2)        AS Avg_Fruits,
    ROUND(AVG(MntMeatProducts), 2)  AS Avg_Meat,
    ROUND(AVG(MntFishProducts), 2)  AS Avg_Fish,
    ROUND(AVG(MntSweetProducts), 2) AS Avg_Sweets,
    ROUND(AVG(MntGoldProds), 2)     AS Avg_Gold
FROM customers;

-- Finding: Wines ($303.94) and Meat ($166.95) account for
-- over 75% of total average customer spend.


-- ============================================================
-- QUERY 5: High Value vs Mid vs Low Value Customer Segments
-- Business Question: Which customer segment is most valuable and responsive?
-- ============================================================

SELECT 
    CASE 
        WHEN (MntWines + MntFruits + MntMeatProducts + 
              MntFishProducts + MntSweetProducts + MntGoldProds) >= 1000 
             THEN 'High Value'
        WHEN (MntWines + MntFruits + MntMeatProducts + 
              MntFishProducts + MntSweetProducts + MntGoldProds) >= 500 
             THEN 'Mid Value'
        ELSE 'Low Value'
    END AS Customer_Segment,
    COUNT(*) AS Total_Customers,
    ROUND(AVG(Income), 2) AS Avg_Income,
    ROUND(SUM(Response) * 100.0 / COUNT(*), 2) AS Conversion_Rate_Pct
FROM customers
GROUP BY Customer_Segment
ORDER BY Conversion_Rate_Pct DESC;

-- Finding: High-value customers convert at 28.41% vs 9.80% for low-value.
-- They also earn $74,686 avg income vs $38,064 for low-value customers.


-- ============================================================
-- QUERY 6: Campaign Response by Income Group
-- Business Question: Do higher-income customers respond more to campaigns?
-- ============================================================

SELECT 
    CASE 
        WHEN Income >= 70000 THEN 'High Income'
        WHEN Income >= 40000 THEN 'Mid Income'
        ELSE 'Low Income'
    END AS Income_Group,
    COUNT(*) AS Total_Customers,
    SUM(Response) AS Converted,
    ROUND(SUM(Response) * 100.0 / COUNT(*), 2) AS Conversion_Rate_Pct
FROM customers
WHERE Income IS NOT NULL
GROUP BY Income_Group
ORDER BY Conversion_Rate_Pct DESC;

-- Finding: High-income customers convert at 27.95% vs 10.86% for mid-income.


-- ============================================================
-- QUERY 7: Spending Behavior vs Campaign Efficiency
-- Business Question: Do high spenders make more purchases and convert more?
-- ============================================================

SELECT 
    CASE 
        WHEN (MntWines + MntFruits + MntMeatProducts + 
              MntFishProducts + MntSweetProducts + MntGoldProds) >= 1000 
             THEN 'High Spender'
        ELSE 'Low Spender'
    END AS Spender_Type,
    COUNT(*) AS Total_Customers,
    ROUND(AVG(NumWebPurchases + NumCatalogPurchases + NumStorePurchases), 2) AS Avg_Purchases,
    ROUND(SUM(Response) * 100.0 / COUNT(*), 2) AS Conversion_Rate_Pct
FROM customers
GROUP BY Spender_Type;

-- Finding: High spenders average 20 purchases vs 9.78 for low spenders
-- and convert at nearly 3x the rate (28.41% vs 9.95%).


-- ============================================================
-- QUERY 8: Recency vs Campaign Response Rate
-- Business Question: Do recently active customers respond better to campaigns?
-- ============================================================

SELECT 
    CASE 
        WHEN Recency <= 30  THEN 'Active (0-30 days)'
        WHEN Recency <= 60  THEN 'Warm (31-60 days)'
        WHEN Recency <= 90  THEN 'Cooling (61-90 days)'
        ELSE 'Inactive (90+ days)'
    END AS Recency_Segment,
    COUNT(*) AS Total_Customers,
    ROUND(SUM(Response) * 100.0 / COUNT(*), 2) AS Conversion_Rate_Pct
FROM customers
GROUP BY Recency_Segment
ORDER BY Conversion_Rate_Pct DESC;

-- Finding: Active customers (0-30 days) convert at 23.90% vs
-- only 5.56% for inactive customers (90+ days).


-- ============================================================
-- QUERY 9: Ideal Customer Profile (Top Spending Segments)
-- Business Question: What does the highest-spending customer look like?
-- ============================================================

SELECT 
    Education,
    Marital_Status,
    ROUND(AVG(Income), 2) AS Avg_Income,
    ROUND(AVG(MntWines + MntFruits + MntMeatProducts + 
              MntFishProducts + MntSweetProducts + MntGoldProds), 2) AS Avg_Total_Spend,
    COUNT(*) AS Total_Customers
FROM customers
GROUP BY Education, Marital_Status
ORDER BY Avg_Total_Spend DESC
LIMIT 5;

-- Finding: Master's + Single (75 customers, $746 avg spend) is the most
-- scalable high-value segment to target in future campaigns.


-- ============================================================
-- QUERY 10: Churn Risk Segment (Never Responded to Any Campaign)
-- Business Question: How large is the unactivated customer base?
-- ============================================================

SELECT 
    COUNT(*) AS Churn_Risk_Customers,
    ROUND(AVG(Income), 2) AS Avg_Income,
    ROUND(AVG(Recency), 2) AS Avg_Recency,
    ROUND(AVG(MntWines + MntFruits + MntMeatProducts + 
              MntFishProducts + MntSweetProducts + MntGoldProds), 2) AS Avg_Spend
FROM customers
WHERE AcceptedCmp1 = 0 
  AND AcceptedCmp2 = 0 
  AND AcceptedCmp3 = 0 
  AND AcceptedCmp4 = 0 
  AND AcceptedCmp5 = 0 
  AND Response = 0;

-- Finding: 1,631 customers (72.8% of total base) have never responded
-- to any campaign despite spending an average of $458.
-- This is the largest untapped opportunity in the dataset.
