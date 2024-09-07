-- This query helps us to get information about all the tables in this database.
SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_type = 'BASE TABLE'
AND table_schema NOT IN ('information_schema', 'pg_catalog');
--The database contains five tables which are: 1. accounts 2. orders 3. region 4. sales_rep 5. web_events


--1. The query below gives all the companies whose names do not start with 'C'.
SELECT id, name, website
FROM accounts
WHERE name NOT LIKE 'C%'
ORDER BY name;
--The query returned 314 companies.

--2. The query returns companies whose name do not contain the string 'one' somewhere in the name.
SELECT id, name, website
FROM accounts
WHERE name NOT ILIKE '%one%'
ORDER BY name;

--3. This query returns a list of only orders ids where either gloss_qty or poster_qty is greater than 4000.
SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000
ORDER BY id;

--4. This query returns company names that begin a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.
SELECT *
FROM accounts
WHERE name LIKE 'C%' OR name LIKE 'W%'
AND primary_poc ILIKE '%ana%' AND primary_poc NOT LIKE '%eana%'
ORDER BY name;


--5. This query joins the orders table and the accounts table in the database.
SELECT *
FROM accounts
JOIN orders ON accounts.id = orders.account_id;


--6. This query returns a table that provides reqion for each sales_rep along with their associated accounts.
-- The table contains only the region name, sales_rep name, and accounts name
SELECT r.name, s.name, a.name
FROM region r
JOIN sales_reps s ON r.id = s.region_id
JOIN accounts a ON s.id = a.sales_rep_id
ORDER BY a.name;


--7. This query returns the name of each region for every order, as well as the 
-- account name and the unit price they paid for the order.
SELECT r.name AS region, a.name AS account, total_amt_usd/total AS unit_price
FROM region r
JOIN sales_reps s ON r.id = s.region_id
JOIN accounts a ON s.id = a.sales_rep_id
JOIN orders o ON o.account_id = a.id
WHERE total != 0
ORDER BY a.name;


--8. This query counts the number of all rows in the account table.
SELECT COUNT(id) AS total_accounts
FROM accounts;


--9.This query gives the total amount of poster_qty paper ordered in the orders table.
SELECT SUM(poster_qty) AS total_poster_qty
FROM orders;


--10. This gives the most recent web_event
SELECT MAX(occurred_at) AS recent_web_event
FROM web_events;