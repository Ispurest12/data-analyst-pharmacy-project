-- TOP 10 MEDICINE ON SALE
SELECT
    p.nombre_producto,
    SUM(dv.cantidad_vendida) AS total_vendido
FROM detalle_ventas dv
JOIN inventario i ON dv.id_lote = i.id_lote
JOIN productos p ON i.id_producto = p.id
GROUP BY p.nombre_producto
ORDER BY total_vendido DESC
LIMIT 10;



-- EXPIRATION DRUG DATA TO NEXT 2 MONTHS
SELECT
    p.nombre_producto,
    i.id_lote,
    i.cantidad,
    i.fecha_caducidad
FROM inventario i
JOIN productos p ON i.id_producto = p.id
WHERE
    i.fecha_caducidad BETWEEN CURRENT_DATE AND (CURRENT_DATE + INTERVAL '2 months')
ORDER BY i.fecha_caducidad ASC;

--TOTAL INCOME PER MONTH
SELECT
    DATE_TRUNC('month', v.fecha_venta) AS mes,
    SUM(dv.cantidad_vendida * dv.precio_venta_unitario) AS ventas_mensuales
FROM ventas v
JOIN detalle_ventas dv ON v.id_venta = dv.id_venta
GROUP BY mes
ORDER BY mes;

-- VALUE PER PROVIDER
SELECT
    pr.nombre_proveedor,
    SUM(i.cantidad * i.precio_compra) AS valor_inventario_actual
FROM inventario i
JOIN productos p ON i.id_producto = p.id
JOIN proveedores pr ON p.id_proveedor = pr.id
GROUP BY pr.nombre_proveedor
ORDER BY valor_inventario_actual DESC
LIMIT 5;

-- NO SALES MEDICINE
SELECT
    p.nombre_producto,
    COALESCE(SUM(dv.cantidad_vendida), 0) AS total_vendido
FROM
    productos p
LEFT JOIN
    inventario i ON p.id = i.id_producto
LEFT JOIN
    detalle_ventas dv ON i.id_lote = dv.id_lote
GROUP BY
    p.nombre_producto
ORDER BY
    total_vendido ASC
LIMIT 10;
