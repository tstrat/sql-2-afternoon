-- ==============   PART 1   ============== --

-- Get all invoices where the UnitPrice on the InvoiceLine is greater than $0.99.
SELECT Invoice.*, InvoiceLine.UnitPrice 
FROM Invoice JOIN InvoiceLine 
ON Invoice.InvoiceId = InvoiceLine.InvoiceId
WHERE InvoiceLine.UnitPrice > 0.99;

-- Get the InvoiceDate, customer FirstName and LastName, and Total from all invoices.
SELECT i.InvoiceDate, c.FirstName, c.LastName, i.Total
FROM Invoice i JOIN Customer c
ON i.CustomerId = c.CustomerId;

-- Get the customer FirstName and LastName and the support rep's FirstName and LastName from all customers.
SELECT c.FirstName, c.LastName, e.FirstName, e.LastName
FROM Customer c JOIN Employee e
ON c.SupportRepId = e.EmployeeId;

-- Get the album Title and the artist Name from all albums.
SELECT alb.title, art.name
FROM Album alb JOIN Artist art
ON alb.ArtistId = art.ArtistId;

-- Get all PlaylistTrack TrackIds where the playlist Name is Music.
SELECT track.TrackId
FROM PlaylistTrack track JOIN playlist play
ON track.PlayListId = play.PlayListId
WHERE play.Name = "Music";

-- Get all Track Names for PlaylistId 5.
SELECT track.Name
FROM Track track JOIN PlayListTrack plist
ON track.TrackId = plist.TrackId
WHERE plist.PlayListId = 5;

-- Get all Track Names and the playlist Name that they're on ( 2 joins ).
SELECT track.Name, play.Name
FROM Track track JOIN PlayListTrack plist
ON track.TrackId = plist.TrackId
JOIN Playlist play
ON plist.PlayListId = play.PlayListId;

-- Get all Track Names and Album Titles that are the genre "Alternative" ( 2 joins ).
SELECT track.Name, alb.Title
FROM Track track JOIN Album alb
ON track.AlbumId = alb.AlbumId
JOIN Genre g
ON track.GenreId = g.GenreId
WHERE g.Name = "Alternative";

--  BLACK DIAMOND --
-- Get all tracks on the playlist(s) called Music and show their name, genre name, album name, and artist name.
SELECT t.Name, g.Name, alb.Name, art.Name
FROM Track t JOIN Genre g
ON t.GenreId = g.GenreId
JOIN Album alb
ON t.AlbumId = alb.AlbumId
JOIN Artist
ON t.ArtistId = art.ArtistId
JOIN PlayListTrack plist
ON track.TrackId = plist.TrackId
JOIN Playlist play
ON plist.PlayListId = play.PlayListId
WHERE play.Name = 'Music';

-- ==============   PART 2   ============== --

-- Get all invoices where the UnitPrice on the InvoiceLine is greater than $0.99.
SELECT * FROM Invoice
WHERE Invoice.InvoiceId IN (
    SELECT InvoiceLine.InvoiceId FROM InvoiceLine
    WHERE InvoiceLine.UnitPrice > .99
);

-- Get all Playlist Tracks where the playlist name is Music.
SELECT * FROM PlaylistTrack
WHERE PlaylistId IN (
    SELECT PlayListId FROM Playlist
    WHERE Name = 'Music'
);

-- Get all Track names for PlaylistId 5.
SELECT Name FROM Track
WHERE TrackId In (
    SELECT TrackId FROM PlayListTrack
    WHERE PlayListId = 5;
);

-- Get all tracks where the Genre is Comedy.
SELECT * FROM Track
WHERE GenreId In (
    SELECT GenreId FROM Genre
    WHERE Name = 'Comedy'
);

-- Get all tracks where the Album is Fireball.
SELECT * FROM Track
WHERE AlbumId In (
    SELECT AlbumId FROM Album
    WHERE Title = 'Fireball'
);

-- Get all tracks for the artist Queen ( 2 nested subqueries ).
SELECT * FROM Track
WHERE AlbumId In (
    SELECT AlbumId FROM Album
    WHERE ArtistId In (
        SELECT ArtistId FROM Artist
        WHERE Name LIKE 'Queen'
    )
);

-- ==============   PART 2   ============== --

-- Find all customers with fax numbers and set those numbers to null.
UPDATE Customer SET Fax = null;

-- Find all customers with no company (null) and set their company to "Self".
UPDATE Customer SET company = 'Self' WHERE company IS NOT NULL;

-- Find the customer Julia Barnett and change her last name to Thompson.
UPDATE Customer SET LastName = 'Thompson'
WHERE FirstName LIKE 'Julia' AND LastName LIKE 'Barnett';

-- Find the customer with this email luisrojas@yahoo.cl and change his support rep to 4.
UPDATE Customer SET SupportRepId = 4
WHERE Email LIKE 'luisrojas@yahoo.cl';

-- Find all tracks that are the genre Metal and have no composer. Set the composer to "The darkness around us".
UPDATE Track SET Composer = 'The darkness around us'
WHERE Composer IS NULL AND GenreId IN (
    SELECT GenreId FROM Genre
    WHERE Name LIKE 'Metal'
)
-- Refresh your page to remove all database changes.

-- ==============   PART 3   ============== --

-- Find a count of how many tracks there are per genre. Display the genre name with the count.
Select g.Name, count(Track.trackId) FROM Track
JOIN Genre g ON Track.GenreId = g.GenreId
GROUP BY g.GenreId;

-- Find a count of how many tracks are the "Pop" genre and how many tracks are the "Rock" genre.
Select g.Name, count(Track.trackId) FROM Track
JOIN Genre g ON Track.GenreId = g.GenreId
WHERE g.Name LIKE 'PoP' OR g.Name LIKE 'Rock'
GROUP BY g.GenreId;

-- Find a list of all artists and how many albums they have.
Select art.Name, count(alb.AlbumId)
FROM Artist art
JOIN Album alb ON art.ArtistId = alb.ArtistId
GROUP BY art.ArtistId;

-- ==============   PART 4   ============== --

-- From the Track table find a unique list of all Composers.
SELECT DISTINCT Composers FROM Track;

-- From the Invoice table find a unique list of all BillingPostalCodes.
SELECT DISTINCT BillingPostalCodes FROM Invoice;

-- From the Customer table find a unique list of all Companys.
SELECT DISTINCT Company FROM Customer;

-- ==============   PART 5   ============== --

-- Copy, paste, and run the SQL code from the summary.
CREATE TABLE practice_delete ( Name string, Type string, Value integer );
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "bronze", 50);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "bronze", 50);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "bronze", 50);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "silver", 100);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "silver", 100);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "gold", 150);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "gold", 150);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "gold", 150);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "gold", 150);

SELECT * FROM practice_delete;

-- Delete all "bronze" entries from the table.
DELETE FROM practice_delete WHERE Type LIKE 'bronze';
-- Delete all "silver" entries from the table.
DELETE FROM practice_delete WHERE Type LIKE 'silver';

-- Delete all entries whose value is equal to 150.
DELETE FROM practice_delete WHERE Value = 150;

-- ==============   PART 6   ============== --

-- E COMMERCE

-- Create 3 tables following the criteria in the summary.
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT,
    email TEXT
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name TEXT,
    price DECIMAL
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products (id),
    user_id INTEGER REFERENCES users (id)
);

-- Add some data to fill up each table.
    -- At least 3 users, 3 products, 3 orders.
INSERT INTO users (name, email)
VALUES 
('Travis', 't@$'),
('Bob','b@ob'),
('Billy', 'Piano@man');

INSERT INTO products (name, price)
VALUES
('rubber duck', 4),
('rubber chicken', 5),
('rubber band', 0.5);

INSERT INTO orders (product_id, user_id)
VALUES 
(1, 1),
(2, 2),
(3, 3);
-- Run queries against your data.

    -- Get all products for the first order.  
    SELECT products.* FROM products
    JOIN orders ON products.id = orders.product_id
    WHERE orders.id = 1;

    -- Get all orders.
    SELECT * FROM orders;

    -- Get the total cost of an order ( sum the price of all products on an order ).
    SELECT orders.id, sum(products.price) FROM products
    JOIN orders ON products.id = orders.product_id
    GROUP BY orders.id;

-- Add a foreign key reference from Orders to Users.
--      I already did in creation

-- Update the Orders table to link a user to each order.
--      Already done in creation
-- Run queries against your data.
    -- Get all orders for a user.
    SELECT * FROM orders
    JOIN users ON orders.user_id = users.id;
    -- specify WHERE user.id = ____ for one user

    -- Get how many orders each user has.
    SELECT count(orders.id) FROM orders
    JOIN users ON orders.user_id = users.id
    GROUP BY orders.id;
    --  Again, specify user it in where clause.

-- BLACK DIAMOND
-- Get the total amount on all orders for each user.

SELECT users.id, sum(products.price) FROM orders
JOIN users ON orders.user_id = users.id
JOIN products ON orders.product_id = products.id
GROUP BY orders.id, users.id;