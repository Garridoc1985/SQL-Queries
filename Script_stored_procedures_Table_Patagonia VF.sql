DELIMITER //

CREATE PROCEDURE eliminar_documento_proveedor(IN id_documento INT)
BEGIN
    DELETE FROM documento_proveedor
    WHERE id_documento_proveedor = id_documento;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE actualizar_proveedor(IN id_proveedor_parametro INT, IN nuevo_nombre VARCHAR(100))
BEGIN
    UPDATE proveedores
    SET nombre_proveedor = nuevo_nombre
    WHERE id_proveedor = id_proveedor_parametro;
END//

DELIMITER ;


DELIMITER //

CREATE PROCEDURE obtener_facturas_por_fecha(IN fecha_inicio DATE, IN fecha_fin DATE)
BEGIN
    SELECT * 
    FROM documento_proveedor
    WHERE fecha_emision BETWEEN fecha_inicio AND fecha_fin;
END//

DELIMITER ;











