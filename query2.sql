-- outputs data5.csv
SELECT round(SUM(il.Quantity*il.UnitPrice),2) AS AmountSpent,
       c.FirstName ||' '|| c.LastName AS CustomerName
FROM Artist a
JOIN Album al ON a.ArtistId = al.ArtistId
JOIN Track t ON t.AlbumId = al.AlbumId
JOIN InvoiceLine il ON t.TrackId = il.Trackid
JOIN Invoice i ON il.InvoiceId = i.InvoiceId
JOIN Customer c ON c.CustomerId = i.CustomerId
WHERE a.Name = 'Iron Maiden'
GROUP BY c.CustomerId
ORDER BY AmountSpent DESC;