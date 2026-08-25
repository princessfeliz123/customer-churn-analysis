--create database CustomerChurn
USE CustomerChurn;

ALTER TABLE CustomerChurn ALTER COLUMN CustomerID INT NOT NULL;

ALTER TABLE CustomerChurn
    ADD CONSTRAINT PK_CustomerChurn_CustomerID PRIMARY KEY (CustomerID);

--Amount of customers
SELECT count(*) AS TotalClients
FROM   CustomerChurn;

--Duplicated customers
SELECT   CustomerID,
         count(*) AS AmountDuplicated
FROM     CustomerChurn
GROUP BY CustomerID
HAVING   count(*) > 1;

--NULL Values
SELECT COUNT(*) AS Total,
       COUNT(CustomerID) AS CustomerID,
       COUNT(Age) AS Age,
       COUNT(Gender) AS Gender,
       COUNT(Tenure) AS Tenure,
       COUNT([Usage_Frequency]) AS UsageFrequency,
       COUNT([Support_Calls]) As SupportCalls,
       COUNT([Payment_Delay]) AS PaymentDelay,
       COUNT([Subscription_Type]) As SubcriptionType,
       COUNT([Contract_Length]) AS ContractLength,
       COUNT([Total_Spend]) AS TotalSpend,
       COUNT([Last_Interaction]) AS LastInteraction,
       COUNT(Churn) AS Churn FROM CustomerChurn;

--Categorics values
  -----GENDER-----
SELECT Gender,
       COUNT(*) AS Customers
       FROM CustomerChurn 
       GROUP BY Gender;

 -----Subscription Type-----
SELECT Subscription_Type,
       COUNT(*) AS SubscriptionType
       FROM CustomerChurn
       GROUP BY Subscription_Type;

-----Contract Length-----
SELECT Contract_Length,
       COUNT(*) AS ContractLength
       FROM CustomerChurn
       GROUP BY Contract_Length;

-----Churn-----
SELECT Churn,
       COUNT(*) AS Churn
       FROM CustomerChurn
       GROUP BY Churn;


-----Churn Analysis-----
SELECT Churn,
       COUNT(*) AS Customers,
       COUNT(*) * 100.0 / SUM(COUNT(*))
OVER() AS Porcentage
FROM CustomerChurn
GROUP BY Churn;

SELECT Churn, Contract_Length AS ContractLength,
       COUNT(*) AS Customers
       FROM CustomerChurn
       GROUP BY Contract_Length, Churn;


SELECT Support_Calls,
       COUNT(*) AS Customers,
       SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS ChurnedCustomers,
       SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS ChurnRate
       FROM CustomerChurn
       GROUP BY Support_Calls
       ORDER BY Support_Calls;


-----Numerics Variables-----
SELECT Churn,
       AVG(Age) AS AverageAge,
       AVG(Tenure) AS AverageTenure,
       AVG(Usage_Frequency) AS AverageFrequency,
       AVG(Support_Calls) AS AverageCalls,
       AVG(Payment_Delay) AS AveragePaymentDelay,
       AVG(Total_Spend) AS AverageSpend
       FROM CustomerChurn
       GROUP BY Churn;

-----Customers-----
SELECT COUNT(*) AS TotalCustomers
FROM CustomerChurn;

-----Customers Left-----
SELECT SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) 
       AS CustomerLeft FROM CustomerChurn;


-----Churn Rate-----
SELECT SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
       AS ChurnRate FROM CustomerChurn;

-----Churn by Subscription-----
SELECT Subscription_Type,
       COUNT(*) AS Customers,
       SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS ChurnedCustomers,
       SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS ChurnRate
       FROM CustomerChurn
       GROUP BY Subscription_Type
       ORDER BY ChurnRate DESC;
        
-----Churn by Contracts-----
SELECT Contract_Length,
       COUNT(*) AS Customers,
         SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS ChurnedCustomers,
       SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS ChurnRate
       FROM CustomerChurn
       GROUP BY Contract_Length
       ORDER BY ChurnRate DESC;

-----Churn by gender-----
SELECT
    Gender,
    COUNT(*) AS Customers,
    SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS ChurnedCustomers,
    SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS ChurnRate
FROM CustomerChurn
GROUP BY Gender
ORDER BY ChurnRate DESC;

-----Churn by Payment Delay-----
SELECT
    Payment_Delay,
    COUNT(*) AS Customers,
    SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS ChurnedCustomers,
    SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS ChurnRate
FROM CustomerChurn
GROUP BY Payment_Delay
ORDER BY Payment_Delay;

-----Churn by Tenure-----
SELECT
    Tenure,
    COUNT(*) AS Customers,
    SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS ChurnedCustomers,
    SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS ChurnRate
FROM CustomerChurn
GROUP BY Tenure
ORDER BY Tenure;

------VIEWS-----
CREATE VIEW vw_ChurnOverview As 
SELECT Churn,
       AVG(Age) AS AverageAge,
       AVG(Tenure) AS AverageTenure,
       AVG(Usage_Frequency) AS AverageFrequency,
       AVG(Support_Calls) AS AverageCalls,
       AVG(Payment_Delay) AS AveragePaymentDelay,
       AVG(Total_Spend) AS AverageSpend
       FROM CustomerChurn
       GROUP BY Churn;

CREATE VIEW vw_ChurnBySubscription AS
SELECT
    Subscription_Type,
    COUNT(*) AS Customers,
    SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS ChurnedCustomers,
    SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS ChurnRate
FROM CustomerChurn
GROUP BY Subscription_Type;


CREATE VIEW vw_ChurnByContracts AS
SELECT Contract_Length,
       COUNT(*) AS Customers,
         SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS ChurnedCustomers,
       SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS ChurnRate
       FROM CustomerChurn
       GROUP BY Contract_Length;

CREATE VIEW vw_ChurnByPaymentDelay AS
SELECT
    Payment_Delay,
    COUNT(*) AS Customers,
    SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS ChurnedCustomers,
    SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS ChurnRate
FROM CustomerChurn
GROUP BY Payment_Delay;

CREATE VIEW vw_ChurnBySupportCalls AS
SELECT
    Support_Calls,
    COUNT(*) AS Customers,
    SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS ChurnedCustomers,
    SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS ChurnRate
FROM CustomerChurn
GROUP BY Support_Calls;

