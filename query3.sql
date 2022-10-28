-- outputs data3.csv
WITH t1 AS
  (SELECT COUNT(i.invoiceid) AS purchases,
          c.country,
          g.name,
          g.genreid
   FROM Genre g
   JOIN Track t ON g.GenreId = t.GenreId
   JOIN InvoiceLine il ON t.trackid = il.TrackId
   JOIN Invoice i ON il.InvoiceId = i.InvoiceId
   JOIN Customer c ON i.customerid = c.CustomerId
   GROUP BY 2,
            3
   ORDER BY 2,
            1 DESC)
SELECT t1.*
FROM t1
JOIN
  (SELECT Country,
          Name,
          GenreId,
          max(purchases) AS mp
   FROM t1
   GROUP BY country) t2 ON t1.country = t2.country
WHERE t1.purchases = t2.mp