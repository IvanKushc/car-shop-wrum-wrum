SELECT b."name" brand_name,  -- Задание 2 из 6
	EXTRACT (YEAR FROM s.date_sale) "year", AVG(s.price)::NUMERIC(16, 2) price_avg
FROM car_shop.sales s 
JOIN car_shop.cars c 
	ON s.car_id = c.id 
JOIN car_shop.brands b 
	ON c.id = b.id 
GROUP BY b."name", EXTRACT (YEAR FROM s.date_sale)
ORDER BY b.name;
