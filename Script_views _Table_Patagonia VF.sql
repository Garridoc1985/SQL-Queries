CREATE VIEW vista_proveedores_activos AS
SELECT p.id_proveedor, p.nombre_proveedor, COUNT(dp.id_documento_proveedor) AS total_documentos
FROM proveedores p
JOIN documento_proveedor dp ON p.id_proveedor = dp.id_proveedor
WHERE dp.fecha_emision >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY p.id_proveedor, p.nombre_proveedor;


CREATE VIEW vista_facturas_detalladas AS
SELECT dp.id_documento_proveedor, p.nombre_proveedor, dp.fecha_emision, dp.total_factura
FROM documento_proveedor dp
JOIN proveedores p ON dp.id_proveedor = p.id_proveedor;

CREATE VIEW vista_resumen_anual AS
SELECT YEAR(fecha_emision) AS año, SUM(total_factura) AS total_facturado
FROM documento_proveedor
GROUP BY YEAR(fecha_emision);

CREATE VIEW vista_vendedores_reclamos AS
SELECT
    ven.id_vendedor,
    ven.rut_vendedor,
    ven.nombre_vendedor,
    r.id_reclamo,
    r.fecha_reclamo,
    r.descripcion_reclamo,
    r.estado_reclamo
FROM
    vendedores ven
LEFT JOIN
    reclamos r ON ven.id_vendedor = r.id_vendedor;

CREATE VIEW vista_ventas_sucursales AS
SELECT
    vendedores.nombre_vendedor AS nombre_vendedor,
    sucursales.nombre_sucursal AS nombre_sucursal,
    ubicacion_sucursales.region AS region_sucursal,
    ubicacion_sucursales.direccion_sucursal AS direccion_sucursal,
    SUM(ventas.monto_total) AS total_ventas
FROM
    ventas
JOIN
    vendedores ON ventas.id_vendedor = vendedores.id
JOIN
    sucursales ON ventas.id_sucursal = sucursales.id
JOIN
    ubicacion_sucursales ON sucursales.id_ubicacion = ubicacion_sucursales.id
GROUP BY
    vendedores.nombre_vendedor, sucursales.nombre_sucursal, ubicacion_sucursales.region, ubicacion_sucursales.direccion_sucursal;





