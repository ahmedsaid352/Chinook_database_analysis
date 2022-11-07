# Chinook database analysis

### In this project,wrote query the Chinook Database. The Chinook Database holds information about a music store. For this project,assisted the Chinook team with understanding the media in their store, their customers and employees, and their invoice information.
### then analyse it using python, pandas and matplotlib

<br>

## question 1: 
### Who is writing the rock music? Now that we know that our customers love rock music, we can decide which musicians to invite to play at the concert.

![image](https://user-images.githubusercontent.com/91634431/200401017-a4e777ae-e914-49da-90c0-b2150d7cbc4d.png)

<br>

### the artists who have written the most rock music in our dataset. These are the top ten on the list led zeppelin is in the lead, behind him, U2, and they leave a safe distance for those who come after them

## my solution

```SQL
SELECT a.name,
       COUNT(t.TrackId) AS songs
FROM Artist AS a
JOIN Album AS al ON a.ArtistId = al.ArtistId
JOIN Track AS t ON al.AlbumId = t.AlbumId
JOIN Genre AS g ON t.genreid = g.GenreId
WHERE g.Name = 'Rock'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;
```
#### related data: data1.csv

## question 2:
### Highest 10 customers spent the most on iron maiden

![image](https://user-images.githubusercontent.com/91634431/200402586-0acc8cf2-5242-49e8-bac6-bc7fe5dca0e5.png)

<br>

### Highest 10 customers spent the most on iron maiden who has earned the most according to the Invoice Lines

## my solution
```SQL
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
```

#### related data: data5.csv

## question 3 
### the most popular music Genre for each country

![image](https://user-images.githubusercontent.com/91634431/200403806-ce16b759-5d09-4059-a589-e5819954930e.png)
<br>

### the most popular music Genre for each country. We determine the most popular genre as the genre with the highest amount of purchases.

## my solution

```sql
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
```

#### related data: data3.csv

## question 4
### the customer that has spent the most on music for each country

![image](https://user-images.githubusercontent.com/91634431/200404402-9251b100-1ffd-4ae9-a376-8304d20fca72.png)

<br>

### the country along with the top customer and how much they spent
## my solution
```sql
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
```

related data : data4.csv
