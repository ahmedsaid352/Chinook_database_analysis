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