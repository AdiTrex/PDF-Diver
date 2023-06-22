-- write query to return email,first name,last name & Genre of all 
--rock Music listeners.
--Return your list ordered alphabetically by email starting with A.

select Distinct email,first_name,last_name
from customer as c
JOIN invoice as p ON c.customer_id = p.customer_id
JOIN invoice_line as t ON p.invoice_id = t.invoice_id
WHERE track_id IN (
             SELECT track_id from track
	         JOIN genre ON track.genre_id = genre.genre_id
	         WHERE genre.name LIKE 'Rock'
)
ORDER BY email

-- another approach
select customer.email,customer.first_name,customer.last_name,genre.name
from customer,genre
where genre.name='Rock'
order by customer.email

--Let's invite the artists who have written the most rock music in our 
--dataset. Write a query that returns the Artist name and total track 
--count of the top 10 rock bands


SELECT artist.artist_id,artist.name,COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id=track.album_id
JOIN artist ON artist.artist_id=album.artist_id
JOIN genre ON genre.genre_id=track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;


--Return all the track names that have a song length longer than the 
--average song length.Return the Name and Milliseconds for each track. 
--Order by the song length with the longest songs listed first


select track.name,track.milliseconds
FROM track 
WHERE track.milliseconds > ( SELECT avg(track.milliseconds)
						     FROM track
						   )

ORDER BY track.milliseconds desc

