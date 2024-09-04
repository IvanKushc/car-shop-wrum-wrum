INSERT INTO car_shop.brands (name, brand_origin) -- Заполняем таблицу brands
SELECT DISTINCT split_part(auto, ' ', 1), brand_origin 
FROM raw_data.sales s ;

TRUNCATE TABLE car_shop.models RESTART IDENTITY CASCADE; -- Не с первого раза получилось)

INSERT INTO car_shop.models (name) -- Заполняем таблицу models
SELECT DISTINCT substr(split_part(auto, ', ', 1), strpos(split_part(auto, ', ', 1), ' '))
FROM raw_data.sales s ;

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

UPDATE car_shop.models m -- Дозаполнение таблицы с моделями
SET gasoline_consumption = s.gasoline_consumption 
FROM raw_data.sales s
WHERE substr(split_part(s.auto, ', ', 1), strpos(split_part(s.auto, ', ', 1), ' ')) = m.name ;

INSERT INTO car_shop.customers (first_name, last_name) -- Добавляем данные о имени и фамилии
SELECT split_part(person_name, ' ', 1), split_part(person_name, ' ', 2)
FROM raw_data.sales s ;

UPDATE car_shop.customers c
SET phone = CASE 
				WHEN s.phone LIKE '%x%' THEN REPLACE(s.phone, 'x', '-')
				WHEN s.phone LIKE '%.%' THEN REPLACE(s.phone, '.', '-')
				ELSE s.phone 
END
FROM raw_data.sales s
WHERE split_part(s.person_name, ' ', 1) = c.first_name AND split_part(s.person_name, ' ', 2) = c.last_name;

UPDATE car_shop.customers c
SET phone = CASE 
				WHEN c.phone LIKE '%x%' THEN REPLACE(c.phone, 'x', '-')
				WHEN c.phone LIKE '%.%' THEN REPLACE(c.phone, '.', '-')
				ELSE c.phone 
END;

INSERT INTO car_shop.sales (car_id, date_sale, price, discount)
SELECT ca.id, s."date" , s.price , s.discount 
FROM car_shop.brands b
JOIN raw_data.sales s 
ON b."name" = split_part(auto, ' ', 1)
JOIN car_shop.models m
ON m.name = substr(split_part(s.auto, ', ', 1), strpos(split_part(s.auto, ', ', 1), ' '))
JOIN car_shop.colors c 
ON c."name" = split_part(auto, ' ', -1)
JOIN car_shop.cars ca 
ON ca.brand_id = b.id AND ca.model_id = m.id AND ca.color_id = c.id;

UPDATE car_shop.sales se
SET customer_id = c.id 
FROM raw_data.sales s 
JOIN car_shop.customers c 
ON c.first_name = split_part(s.person_name, ' ', 1)
AND c.last_name = split_part(s.person_name,' ', 2)
WHERE se.date_sale = s."date"::date;
