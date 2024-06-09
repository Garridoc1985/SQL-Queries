

DELIMITER $$

CREATE FUNCTION obtener_documentos_por_proveedor(id_proveedor INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM documento_proveedor
    WHERE id_proveedor = id_proveedor;
    RETURN total;
END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION promedio_ventas_por_anio_y_region(anio_param INT, region_param VARCHAR(255))
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE promedio DECIMAL(10,2) DEFAULT 0.00;

    -- Calcula el promedio de ventas para el año y la región especificados
    SELECT AVG(total_venta) INTO promedio
    FROM vista_ventas_sucursales
    WHERE anio = anio_param AND region = region_param;

    RETURN promedio;
END$$

DELIMITER ;


DELIMITER $$

CREATE FUNCTION sucursal_con_mas_ventas(id_producto INT)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE nombre_sucursal_max VARCHAR(255);
    DECLARE categoria_producto_max VARCHAR(255);
    DECLARE genero_producto_max VARCHAR(50);
    DECLARE total_venta_max DECIMAL(10, 2);
    
    SELECT s.nombre_sucursal, p.categoria_producto, p.genero_producto, SUM(v.total_venta)
    INTO nombre_sucursal_max, categoria_producto_max, genero_producto_max, total_venta_max
    FROM sucursales s
    JOIN ventas v ON s.id_sucursal = v.id_sucursal
    JOIN productos_ventas pv ON v.id_venta = pv.id_venta
    JOIN productos p ON pv.id_producto = p.id_producto
    WHERE pv.id_producto = id_producto
    GROUP BY s.id_sucursal, s.nombre_sucursal, p.categoria_producto, p.genero_producto
    ORDER BY SUM(v.total_venta) DESC
    LIMIT 1;
    
    RETURN CONCAT('Sucursal: ', nombre_sucursal_max, ', Categoría Producto: ', categoria_producto_max, ', Género: ', genero_producto_max, ', Total Venta: ', total_venta_max);
END$$

DELIMITER ;





