-- data4.csv
WITH t1 AS
  (SELECT c.country,
          sum(i.total) AS TotalSpent,
          c.FirstName,
          c.LastName,
          c.CustomerId
   FROM Invoice i
   JOIN Customer c ON i.customerid = c.customerid
   GROUP BY 5
   ORDER BY 1)
SELECT t1.*
FROM t1
JOIN
  (SELECT max(TotalSpent) AS mts,
          country
   FROM t1
   GROUP BY country) t2 ON t1.country = t2.country
WHERE t1.TotalSpent = t2.mts