INSERT INTO car_shop.brand_origins ("name")
SELECT DISTINCT brand_origin
FROM raw_data.sales s;

INSERT INTO car_shop.brands ("name", brand_origin_id) -- Заполняем таблицу brands
SELECT DISTINCT split_part(auto, ' ', 1), bo.id 
FROM raw_data.sales s 
LEFT JOIN car_shop.brand_origins bo 
	ON s.brand_origin = bo."name" ;

INSERT INTO car_shop.models (name, gasoline_consumption, brand_id) -- Заполняем таблицу models
SELECT DISTINCT substr(split_part(auto, ', ', 1), strpos(split_part(auto, ', ', 1), ' ')), s.gasoline_consumption ,b.id 
FROM raw_data.sales s
LEFT JOIN car_shop.brands b 
ON split_part(s.auto, ' ', 1) = b."name" ;

INSERT INTO car_shop.colors (name)
SELECT DISTINCT split_part(auto, ' ', -1)
FROM raw_data.sales s ;

INSERT INTO car_shop.cars (brand_id, model_id, color_id) -- Наполнение таблицы cars
SELECT DISTINCT 
	b.id,
	m.id,
	c.id
FROM raw_data.sales s
JOIN car_shop.brands b 
	ON split_part(auto, ' ', 1) = b."name"
JOIN car_shop.models m 
	ON substr(split_part(auto, ', ', 1), strpos(split_part(auto, ', ', 1), ' ')) = m."name" 
JOIN car_shop.colors c 
	ON split_part(auto, ' ', -1) = c."name" ;

INSERT INTO car_shop.customers (first_name, last_name, phone) -- Добавляем данные о имени и фамилии
SELECT DISTINCT split_part(person_name, ' ', 1), split_part(person_name, ' ', 2), phone 
FROM raw_data.sales s ;

UPDATE car_shop.customers c
SET phone = CASE 
				WHEN c.phone LIKE '%x%' THEN REPLACE(c.phone, 'x', '-')
				WHEN c.phone LIKE '%.%' THEN REPLACE(c.phone, '.', '-')
				ELSE c.phone 
	END
WHERE phone IS NOT NULL;

INSERT INTO car_shop.sales (car_id, customer_id, date_sale, price, discount)
SELECT ca.id, cu.id, s."date" , s.price , s.discount 
FROM car_shop.brands b
JOIN raw_data.sales s 
	ON b."name" = split_part(auto, ' ', 1)
JOIN car_shop.models m
	ON m.name = substr(split_part(s.auto, ', ', 1), strpos(split_part(s.auto, ', ', 1), ' '))
JOIN car_shop.colors c 
	ON c."name" = split_part(auto, ' ', -1)
JOIN car_shop.cars ca 
	ON ca.brand_id = b.id AND ca.model_id = m.id AND ca.color_id = c.id
JOIN car_shop.customers cu
	ON cu.first_name = split_part(s.person_name, ' ', 1)
	AND cu.last_name = split_part(s.person_name,' ', 2);
