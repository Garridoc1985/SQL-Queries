CREATE TABLE auditoria_ventas (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT,
    accion VARCHAR(10),
    fecha_accion DATETIME,
    columna_cambiada VARCHAR(50),
    valor_anterior VARCHAR(255),
    valor_nuevo VARCHAR(255)
);

DELIMITER //

CREATE TRIGGER after_update_ventas
after UPDATE ON ventas
FOR EACH ROW
BEGIN
    -- Comparar y registrar cambios en cada columna relevante
    IF NEW.total_venta <> OLD.total_venta THEN
        INSERT INTO auditoria_ventas (id_venta, accion, fecha_accion, columna_cambiada, valor_anterior, valor_nuevo)
        VALUES (OLD.id_venta, 'UPDATE', NOW(), 'total_venta', OLD.total_venta, NEW.total_venta);
    END IF;

    IF NEW.fecha_venta <> OLD.fecha_venta THEN
        INSERT INTO auditoria_ventas (id_venta, accion, fecha_accion, columna_cambiada, valor_anterior, valor_nuevo)
        VALUES (OLD.id_venta, 'UPDATE', NOW(), 'fecha_venta', OLD.fecha_venta, NEW.fecha_venta);
    END IF;

    IF NEW.id_documento <> OLD.id_documento THEN
        INSERT INTO auditoria_ventas (id_venta, accion, fecha_accion, columna_cambiada, valor_anterior, valor_nuevo)
        VALUES (OLD.id_venta, 'UPDATE', NOW(), 'id_documento', OLD.id_documento, NEW.id_documento);
    END IF;

    IF NEW.id_sucursal <> OLD.id_sucursal THEN
        INSERT INTO auditoria_ventas (id_venta, accion, fecha_accion, columna_cambiada, valor_anterior, valor_nuevo)
        VALUES (OLD.id_venta, 'UPDATE', NOW(), 'id_sucursal', OLD.id_sucursal, NEW.id_sucursal);
    END IF;

    IF NEW.id_estado_documento <> OLD.id_estado_documento THEN
        INSERT INTO auditoria_ventas (id_venta, accion, fecha_accion, columna_cambiada, valor_anterior, valor_nuevo)
        VALUES (OLD.id_venta, 'UPDATE', NOW(), 'id_estado_documento', OLD.id_estado_documento, NEW.id_estado_documento);
    END IF;

    IF NEW.id_vendedor <> OLD.id_vendedor THEN
        INSERT INTO auditoria_ventas (id_venta, accion, fecha_accion, columna_cambiada, valor_anterior, valor_nuevo)
        VALUES (OLD.id_venta, 'UPDATE', NOW(), 'id_vendedor', OLD.id_vendedor, NEW.id_vendedor);
    END IF;
END; //

DELIMITER ;

DELIMITER //

CREATE TRIGGER before_insert_ventas
BEFORE INSERT ON ventas
FOR EACH ROW
BEGIN
    IF NEW.total_venta < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El total de la venta no puede ser negativo';
    END IF;
END; //

DELIMITER ;






