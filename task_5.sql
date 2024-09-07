SELECT bo."name",
	MIN(s.price / (1 - (s.discount / 100))) price_min,
	MAX(s.price / (1 - (s.discount / 100))) price_max
FROM car_shop.sales s 
JOIN car_shop.cars c 
	ON s.car_id = c.id
JOIN car_shop.brands b 
JOIN car_shop.models m 
	ON m.brand_id = b.id 
	ON c.model_id = m.id 
JOIN car_shop.brand_origins bo 
	ON b.brand_origin_id = bo.id
WHERE bo."name" IS NOT NULL
GROUP BY bo."name"
ORDER BY bo."name";
