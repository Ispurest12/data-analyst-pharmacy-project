-- We need to change the varchar(100) to TEXT because data's Mockaroo has poor information
ALTER TABLE productos ALTER COLUMN nombre_producto TYPE TEXT;
ALTER TABLE productos ALTER COLUMN categoria TYPE TEXT
-- I have my pc on spanish and location mexico so my type of date is dd/mm/yyyy and the information was i download it has a format mm/dd/yy
-- So i need to change the type of location from my Postgresql
SET datestyle TO 'MDY';
-- If this does not work we need to apply a temporal solution with a temporal column
ALTER TABLE ventas ADD COLUMN fecha_temp TEXT;
-- Then we are going to load the information using copy. Before using copy
\copy ventas(id_venta, fecha_temp) FROM 'C:/Users/......../Downloads/ventas.csv' DELIMITER ',' CSV HEADER
-- With the information load we need to update the column using UPDATE from postgresql and method to_date()
UPDATE ventas SET fecha_venta = to_date(fecha_temp, 'MM/DD/YYYY');
-- Now with the updated column we can drop the temporal column
ALTER TABLE ventas DROP COLUMN fecha_temp;
-- This method is functionally because the type TEXT can absorb all information no matter what contains
-- We need to apply this with inventory because has date too and in this part we have other issue the money's Mockaroo information has a $ symbol
-- Our database precio its a DECIMAL number not a TEXT(STRING) TYPE of data so need to clean that symbol with REPLACE() METHOD
-- First need to create a column precio_temp with type data TEXT
ALTER TABLE inventario ADD COLUMN precio_temp TEXT;
-- And another fecha_temp
ALTER TABLE inventario ADD COLUMN  fecha_temp TEXT;
--Then we are load our data with copy
\copy inventario(id_lote, id_producto, cantidad, fecha_temp, precio_temp) FROM 'C:/Users/....../Downloads/inventario.csv' DELIMITER ',' CSV HEADER
-- Now we are going to use to_date method and replace method
UPDATE inventario SET
    fecha_caducidad = to_date(fecha_temp, 'MM/DD/YYYY'),
    precio_compra = REPLACE(precio_temp, '$', '')::DECIMAL;
-- OH but that does not function because we have NOT NULL in our fecha_caducidad so first we need to change that attribute
ALTER TABLE inventario ALTER COLUMN fecha_caducidad DROP NOT NULL;
-- Now the step back
    UPDATE inventario SET
    fecha_caducidad = to_date(fecha_temp, 'MM/DD/YYYY'),
    precio_compra = REPLACE(precio_temp, '$', '')::DECIMAL;
 --Now drop the temporally columns
ALTER TABLE inventario DROP COLUMN fecha_temp, DROP COLUMN precio_temp;
 -- This step with the detalle_ventas only to replace the $ symbol
 ALTER TABLE detalle_ventas ADD COLUMN precio_temp TEXT;
\copy detalle_ventas(id, id_venta, id_lote, cantidad_vendida, precio_temp) FROM 'C:/Users/...../Downloads/detalle_ventas.csv' DELIMITER ',' CSV HEADER
 UPDATE detalle_ventas SET precio_venta_unitario = REPLACE(precio_temp, '$', '')::DECIMAL;
ALTER TABLE detalle_ventas DROP COLUMN precio_temp;
--Finally you have all your loaded database
