SELECT b.brand_origin, -- Задание 5 из 6
	MIN(s.price) price_max, 
	MAX(s.price) price_min
FROM car_shop.sales s
JOIN car_shop.cars c 
	ON s.car_id = c.id 
JOIN car_shop.brands b 
	ON c.brand_id = b.id 
WHERE s.discount != '0' AND b.brand_origin IS NOT NULL 
GROUP BY b.brand_origin;
