CREATE SCHEMA raw_data;

CREATE TABLE raw_data.sales (
id int,
auto TEXT,
gasoline_consumption NUMERIC,
price INTEGER,
"date" timestamp,
person_name TEXT,
phone TEXT,
discount NUMERIC,
brand_origin TEXT);

COPY clients_copy_start(id, name, phone, city) FROM 'C:\Temp\clients.csv' CSV HEADER;
