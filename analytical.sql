WITH ad_bid AS(
	SELECT
		a.car_id,
		b.bid_status
	FROM
		ads a
	JOIN 
		bids b
	ON 
		a.ad_id = b.ad_id
)

SELECT 
	c.model,
	COUNT(c.product_id) AS count_product,
	COUNT(ab.bid_status) AS count_bid
FROM 
	cars c
JOIN
	ad_bid ab
ON 
	c.product_id = ab.car_id
WHERE 
	bid_status = 1
GROUP BY
	1
ORDER BY
	3 DESC
LIMIT
	5;



-- Soal 2 - Membandingkan harga mobil berdasarkan harga rata2 per kota
WITH ad_car AS (
	SELECT
		a.car_id,
		ci.nama_kota
	FROM
		ads a
	JOIN 
		city ci
	ON 
		a.location_id = ci.kota_id
)

SELECT 
	ac.nama_kota,
	c.brand,
	c.model,
	c.year,
	c.price,
	ROUND(AVG(c.price) OVER (PARTITION BY ac.nama_kota)) AS avg_car_city 
FROM 
	ad_car ac
JOIN
	cars c
ON 
	ac.car_id = c.product_id
ORDER BY
	avg_car_city DESC;
-- Soal 3 - Membandingkan tgl bid user dengan bid selanjutnya
WITH ranked_bid AS (
    SELECT 
        b.bid_id,
        b.user_id,
        b.bid_amount,
        b.bid_date,
        c.model,
        b.ad_id,
        LAG(b.bid_date) OVER (PARTITION BY b.user_id, c.model ORDER BY b.bid_date) AS previous_bid_date,
        LAG(b.bid_amount) OVER (PARTITION BY b.user_id, c.model ORDER BY b.bid_date) AS previous_bid_amount
    FROM 
        bids b
    JOIN 
        ads a 
        ON b.ad_id = a.ad_id
    JOIN 
        cars c 
        ON a.car_id = c.product_id
)
SELECT 
    model,
	user_id,
	previous_bid_date AS first_bid_date,
	bid_date AS next_bid_date,
    previous_bid_amount AS first_bid_price,
	bid_amount AS next_bid_price
FROM 
    ranked_bid
WHERE 
    previous_bid_date IS NOT NULL
ORDER BY 
    user_id, bid_date;


