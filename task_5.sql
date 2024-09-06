SELECT bo."name",
	MIN(s.price + (s.discount::NUMERIC / 100 * s.price)::NUMERIC) price_min,
	MAX(s.price + (s.discount::NUMERIC / 100 * s.price)::NUMERIC) price_max
FROM car_shop.sales s 
JOIN car_shop.cars c 
	ON s.car_id = c.id
JOIN car_shop.brands b 
	ON c.brand_id = b.id
JOIN car_shop.brand_origins bo 
	ON b.brand_origin_id = bo.id 
WHERE bo."name" IS NOT NULL
GROUP BY bo."name"
ORDER BY bo."name" ;
