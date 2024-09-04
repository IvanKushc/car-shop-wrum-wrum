SELECT ((SELECT COUNT(*) -- Задание 1 из 6
FROM car_shop.models 
WHERE car_shop.models.gasoline_consumption IS NULL) / COUNT(*)::real * 100)::NUMERIC (4, 2)
	AS nulls_percentage_gasoline_consumption
FROM car_shop.models m ;
