CREATE DATABASE insuranceBI;
USE insuranceBI;
/*1*/
SELECT 
    SUM(c.Claim_Amount) * 100.0 / SUM(p.Premium) AS Portfolio_Loss_Ratio
FROM claims c
LEFT JOIN policy p 
    ON c.Vehicle_ID = p.Vehicle_ID;
/*2*/
SELECT  
    p.Policy_Tenure,
    SUM(c.Claim_Amount) * 100.0 / SUM(p.Premium) AS Tenure_Loss_Ratio
FROM claims c
LEFT JOIN policy p 
    ON c.Vehicle_ID = p.Vehicle_ID
GROUP BY p.Policy_Tenure
ORDER BY Tenure_Loss_Ratio DESC;
/*3*/
SELECT 
    p.Vehicle_Category,
    COUNT(c.Claim_ID) AS Total_Claims,
    SUM(c.Claim_Amount) AS Total_Claim_Amount,
    SUM(p.Premium) AS Total_Premium,
    SUM(c.Claim_Amount) * 100.0 / SUM(p.Premium) AS Loss_Ratio
FROM policy p
LEFT JOIN claims c 
    ON p.Vehicle_ID = c.Vehicle_ID
GROUP BY p.Vehicle_Category
ORDER BY Loss_Ratio DESC;
/*4*/
SELECT 
    p.Vehicle_Category,
    COUNT(c.Claim_ID) AS Total_Claims,
    SUM(c.Claim_Amount) AS Total_Claim_Amount,
    SUM(p.Premium) AS Total_Premium,
    SUM(c.Claim_Amount) * 100.0 / SUM(p.Premium) AS Loss_Ratio
FROM policy p
LEFT JOIN claims c 
    ON p.Vehicle_ID = c.Vehicle_ID
GROUP BY p.Vehicle_Category
ORDER BY Loss_Ratio DESC;
/*5*/
SELECT 
    YEAR(c.Claim_Date)  AS Claim_Year,
    MONTH(c.Claim_Date) AS Claim_Month,
    COUNT(c.Claim_ID)   AS Total_Claims,
    SUM(c.Claim_Amount) AS Total_Claim_Amount
FROM claims c
GROUP BY YEAR(c.Claim_Date), MONTH(c.Claim_Date)
ORDER BY Claim_Year, Claim_Month;
/*6*/
SELECT
    COUNT(Claim_ID)                                                   AS Total_Claims,
    COUNT(CASE WHEN Is_Fraud_Flag = 1 THEN 1 END)                     AS Total_Fraud_Claims,
    COUNT(CASE WHEN Is_Fraud_Flag = 1 THEN 1 END) * 100.0 
        / COUNT(Claim_ID)                                              AS Fraud_Pct_of_Claims,
    SUM(Claim_Amount)                                                  AS Total_Claim_Amount,
    SUM(CASE WHEN Is_Fraud_Flag = 1 THEN Claim_Amount END)            AS Total_Fraud_Amount,
    SUM(CASE WHEN Is_Fraud_Flag = 1 THEN Claim_Amount END) * 100.0 
        / SUM(Claim_Amount)                                            AS Fraud_Pct_of_Amount
FROM claims;
/*7*/
SELECT 
    p.Vehicle_Category,
    COUNT(c.Claim_ID)                                                      AS Total_Claims,
    COUNT(CASE WHEN c.Is_Fraud_Flag = 1 THEN 1 END)                       AS Fraud_Claims,
    COUNT(CASE WHEN c.Is_Fraud_Flag = 1 THEN 1 END) * 100.0 
        / COUNT(c.Claim_ID)                                                AS Fraud_Pct,
    SUM(CASE WHEN c.Is_Fraud_Flag = 1 THEN c.Claim_Amount END)            AS Fraud_Amount,
    SUM(CASE WHEN c.Is_Fraud_Flag = 1 THEN c.Claim_Amount END) * 100.0 
        / SUM(c.Claim_Amount)                                              AS Fraud_Pct_of_Amount
FROM policy p
LEFT JOIN claims c 
    ON p.Vehicle_ID = c.Vehicle_ID
GROUP BY p.Vehicle_Category
ORDER BY Fraud_Amount DESC;
/*8*/
SELECT 
    p.City_Tier,
    COUNT(c.Claim_ID)                                                      AS Total_Claims,
    COUNT(CASE WHEN c.Is_Fraud_Flag = 1 THEN 1 END)                       AS Fraud_Claims,
    COUNT(CASE WHEN c.Is_Fraud_Flag = 1 THEN 1 END) * 100.0 
        / COUNT(c.Claim_ID)                                                AS Fraud_Pct,
    SUM(CASE WHEN c.Is_Fraud_Flag = 1 THEN c.Claim_Amount END)            AS Fraud_Amount,
    SUM(CASE WHEN c.Is_Fraud_Flag = 1 THEN c.Claim_Amount END) * 100.0 
        / SUM(c.Claim_Amount)                                              AS Fraud_Pct_of_Amount
FROM policy p
LEFT JOIN claims c 
    ON p.Vehicle_ID = c.Vehicle_ID
GROUP BY p.City_Tier
ORDER BY Fraud_Amount DESC;
/*9*/
SELECT 
    CASE 
    WHEN p.Customer_Age BETWEEN 18 AND 25 THEN '18-25'
    WHEN p.Customer_Age BETWEEN 26 AND 40 THEN '26-40'
    WHEN p.Customer_Age BETWEEN 41 AND 60 THEN '41-60'
    ELSE '61-70'
END AS Age_Group,
    COUNT(c.Claim_ID)                                                      AS Total_Claims,
    COUNT(CASE WHEN c.Is_Fraud_Flag = 1 THEN 1 END)                       AS Fraud_Claims,
    COUNT(CASE WHEN c.Is_Fraud_Flag = 1 THEN 1 END) * 100.0 
        / COUNT(c.Claim_ID)                                                AS Fraud_Pct,
    SUM(CASE WHEN c.Is_Fraud_Flag = 1 THEN c.Claim_Amount END)            AS Fraud_Amount,
    SUM(CASE WHEN c.Is_Fraud_Flag = 1 THEN c.Claim_Amount END) * 100.0 
        / SUM(c.Claim_Amount)                                              AS Fraud_Pct_of_Amount
FROM policy p
LEFT JOIN claims c 
    ON p.Vehicle_ID = c.Vehicle_ID
GROUP BY 
  CASE 
    WHEN p.Customer_Age BETWEEN 18 AND 25 THEN '18-25'
    WHEN p.Customer_Age BETWEEN 26 AND 40 THEN '26-40'
    WHEN p.Customer_Age BETWEEN 41 AND 60 THEN '41-60'
    ELSE '61-70'
END 
ORDER BY Fraud_Amount DESC;
/*10*/
SELECT 
    CASE 
        WHEN p.Customer_Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN p.Customer_Age BETWEEN 26 AND 40 THEN '26-40'
        WHEN p.Customer_Age BETWEEN 41 AND 60 THEN '41-60'
        ELSE '61-70'
    END AS Age_Group,
    COUNT(p.Customer_ID)                              AS Total_Customers,
    COUNT(DISTINCT c.Vehicle_ID)                      AS Customers_Who_Claimed,
    COUNT(DISTINCT c.Vehicle_ID) * 100.0 
        / COUNT(p.Customer_ID)                        AS Claim_Rate_Pct
FROM policy p
LEFT JOIN claims c 
    ON p.Vehicle_ID = c.Vehicle_ID
GROUP BY 
    CASE 
        WHEN p.Customer_Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN p.Customer_Age BETWEEN 26 AND 40 THEN '26-40'
        WHEN p.Customer_Age BETWEEN 41 AND 60 THEN '41-60'
        ELSE '61-70'
    END
ORDER BY Claim_Rate_Pct DESC;
/*11*/
SELECT 
    SUM(
        (Premium * 1.0 / (Policy_Tenure * 365)) * 
        DATEDIFF(DAY, Policy_Start_Date, '2026-02-28')
    ) AS Earned_Premium
FROM policy
WHERE Policy_Start_Date < '2026-02-28';
/*12*/
SELECT 
    COUNT(p.Vehicle_ID)                    AS Unclaimed_Vehicles,
    COUNT(p.Vehicle_ID) * 111492.0         AS Potential_Liability
FROM policy p
LEFT JOIN claims c 
    ON p.Vehicle_ID = c.Vehicle_ID
WHERE c.Vehicle_ID IS NULL;
