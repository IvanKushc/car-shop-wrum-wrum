SELECT cu.first_name || ' ' || cu.last_name person, -- Задание 4 из 6
	string_agg(b."name" || m."name", ', ') cars
FROM car_shop.sales s 
JOIN car_shop.cars c 
ON s.car_id = c.id 
JOIN car_shop.brands b 
ON c.brand_id = b.id 
JOIN car_shop.models m 
ON c.model_id = m.id 
JOIN car_shop.customers cu 
ON s.customer_id = cu.id 
GROUP BY cu.first_name || ' ' || cu.last_name;
