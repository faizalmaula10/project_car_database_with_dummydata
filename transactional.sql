SELECT 
	product_id,
	brand,
	model,
	year,
	price
FROM 
	cars
WHERE 
	year >= 2015;
INSERT INTO 
	bids
VALUES
	('B-051', 44, 8, 155550000, '2024-05-11',1);

WITH car_ads AS (
SELECT 
	a.user_id,
	a.car_id,
	c.brand,
	c.model,
	c.year,
	c.price,
	a.date_post
FROM ads as a
JOIN cars as c
ON a.car_id = c.product_id
)

SELECT 
	u.user_id,
	u.name,
	ca.car_id,
	ca.brand,
	ca.model,
	ca.year,
	ca.price,
	ca.date_post
FROM car_ads as ca
JOIN users as u
ON ca.user_id = u.user_id
WHERE 
	u.name = 'Harjaya Fujiati';
