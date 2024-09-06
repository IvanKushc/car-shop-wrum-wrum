CREATE SCHEMA car_shop;

CREATE TABLE car_shop.brand_origins (
	id SERIAL PRIMARY KEY,
	"name" VARCHAR(20) UNIQUE); -- Название страны производителя

CREATE TABLE car_shop.brands ( -- Таблица с моделями авто
	id SERIAL PRIMARY KEY, -- Идентификатор
	name VARCHAR(30) UNIQUE NOT NULL, -- Производителя длинне 30 символов я нагуглить не смог
	brand_origin_id int REFERENCES car_shop.brand_origins);

CREATE TABLE car_shop.models (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) UNIQUE NOT NULL, -- Судя по гуглу, самое длинное название "BMW 7 Series 740Li xDrive with M Sport Package" - 43 символа
	gasoline_consumption NUMERIC,
	brand_id int NOT NULL REFERENCES car_shop.brands);

CREATE TABLE car_shop.colors (
	id SERIAL PRIMARY KEY,
	name VARCHAR(40) UNIQUE NOT NULL); -- Самый длинный цвет 40 символов "Luminous Framework for the Color Red"

CREATE TABLE car_shop.cars (
	id SERIAL PRIMARY KEY,
	brand_id int REFERENCES car_shop.brands,
	model_id int REFERENCES car_shop.models,
	color_id int REFERENCES car_shop.colors);
	
CREATE TABLE car_shop.customers (
	id SERIAL PRIMARY KEY,
	first_name TEXT NOT NULL, -- Подразумевается ввод имени
	last_name TEXT NOT NULL, -- Подразумевает ввод фамилии
	phone TEXT); -- Подразумевает ввод телефона
	
CREATE TABLE car_shop.sales (
	id SERIAL PRIMARY KEY,
	car_id int REFERENCES car_shop.cars,
	customer_id int REFERENCES car_shop.customers,
	date_sale date NOT NULL DEFAULT CURRENT_DATE, -- Дата
	price int NOT NULL DEFAULT '0', -- Цена Число
	discount int NOT NULL DEFAULT '0'); -- Скидка число
