DELIMITER //

CREATE TRIGGER after_delete_ventas
AFTER DELETE ON ventas
FOR EACH ROW
BEGIN
 
    INSERT INTO ventas (id_venta, id_documento, id_sucursal, id_estado_documento, id_vendedor, fecha_venta, total_venta)
    VALUES (OLD.id_venta, OLD.id_documento, OLD.id_sucursal, OLD.id_estado_documento, OLD.id_vendedor, OLD.fecha_venta, OLD.total_venta);
END; //

DELIMITER ;


DELIMITER //

CREATE TRIGGER after_delete_documentos
AFTER DELETE ON documentos
FOR EACH ROW
BEGIN

    INSERT INTO documentos (id_documento, nombre_documento)
    VALUES (OLD.id_documento, OLD.nombre_documento);
END; //

DELIMITER ;

DELIMITER //

CREATE TRIGGER after_delete_estado_documentos
AFTER DELETE ON estado_documentos
FOR EACH ROW
BEGIN

    INSERT INTO estado_documentos (id_estado_documento, estado_documento)
    VALUES (OLD.id_estado_documento, OLD.estado_documento);
END; //

DELIMITER ;




