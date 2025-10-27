CREATE TABLE proveedores(
    id SERIAL PRIMARY KEY,
    nobmre_proveedor VARCHAR(100) NOT NULL
);
CREATE TABLE productos(
    id SERIAL PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    id_proveedor INT REFERENCES proveedores(id)
);
CREATE TABLE inventario(
    id_lote SERIAL PRIMARY KEY,
    id_producto INT REFERENCES productos(id),
    cantidad INT NOT NULL CHECK (cantidad >= 0),
    fecha_caducidad DATE NOT NULL,
    precio_compra DECIMAL(10,2)
);
CREATE TABLE ventas(
    id_venta SERIAL PRIMARY KEY,
    fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE detalle_Ventas(
  id SERIAL PRIMARY KEY,
  id_venta INT REFERENCES ventas(id_venta),
  id_lote INT REFERENCES inventario(id_lote),
  cantidad_vendida INT NOT NULL,
  precio_venta_unitario DECIMAL(10,2)
);