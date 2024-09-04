SELECT "month", -- Задание 3 из 6
	EXTRACT(YEAR FROM s.date_sale) "year", 
	AVG(s.price)::NUMERIC(16, 2) price_avg
FROM GENERATE_SERIES(1, 12, 1) AS "month"
JOIN car_shop.sales s 
	ON "month" = EXTRACT (MONTH FROM s.date_sale)
WHERE EXTRACT (YEAR FROM s.date_sale) = '2022'
GROUP BY "month", EXTRACT(YEAR FROM s.date_sale);
