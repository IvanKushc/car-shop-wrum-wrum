CREATE SCHEMA raw_data;

CREATE TABLE raw_data.sales (
id int,
auto TEXT,
gasoline_consumption NUMERIC,
price NUMERIC,
"date" timestamp,
person_name TEXT,
phone TEXT,
discount NUMERIC,
brand_origin TEXT);

COPY raw_data.sales(id, auto, gasoline_consumption, price, "date", person_name, phone, discount, brand_origin) FROM 'C:\Temp\cars.csv' CSV HEADER;
