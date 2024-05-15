
CREATE DATABASE IF NOT EXISTS Patagonia;

USE Patagonia;

CREATE TABLE ubicacion_sucursales (
    id_ubicacion_sucursal INT AUTO_INCREMENT PRIMARY KEY,
    region VARCHAR(55),
    ciudad VARCHAR(55),
    direccion_sucursal VARCHAR(255)
);

CREATE TABLE vendedores (
    id_vendedor INT AUTO_INCREMENT PRIMARY KEY,
    rut_vendedor VARCHAR(20),
    nombre_vendedor VARCHAR(55)
);



CREATE TABLE documentos (
    id_documento INT AUTO_INCREMENT PRIMARY KEY,
    nombre_documento VARCHAR(100)
);

CREATE TABLE estado_documentos (
    id_estado_documento INT AUTO_INCREMENT PRIMARY KEY,
    estado_documento VARCHAR(55)
);



CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    categoria_producto VARCHAR(100),
    genero_producto VARCHAR(55),
    precio_producto DECIMAL(10, 2)
);



CREATE TABLE promociones (
    id_promocion INT AUTO_INCREMENT PRIMARY KEY,
    descuento_promocion VARCHAR(55),
    genero_promocion VARCHAR(55),
    fecha_promocion DATE 
);

CREATE TABLE proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre_proveedor VARCHAR(55),
    email_proveedor VARCHAR(55),
    compra_proveedor INT,
    fecha_compra_proveedor DATE 
);


CREATE TABLE documento_proveedor (
    id_documento_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT,
    fecha_emision DATE,
    total_factura INT,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
);


CREATE TABLE sucursales (
    id_sucursal INT AUTO_INCREMENT PRIMARY KEY,
    id_ubicacion_sucursal INT,
	nombre_sucursal VARCHAR(55),
    FOREIGN KEY (id_ubicacion_sucursal) REFERENCES ubicacion_sucursales(id_ubicacion_sucursal)
);

CREATE TABLE reclamos (
    id_reclamos INT AUTO_INCREMENT PRIMARY KEY,
    fecha_reclamos DATE,
    id_vendedor INT,
    descripcion_reclamo TEXT,
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor)
);

CREATE TABLE productos_ventas (
    id_producto_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    tipo_venta VARCHAR(55),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE TABLE stock (
    id_stock INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT,
    id_producto INT,
    id_promocion INT,
    fecha_stock DATE,
    cantidad_stock INT,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_promocion) REFERENCES promociones(id_promocion)
);

CREATE TABLE ventas (
	id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_documento INT,
    id_sucursal INT,
    id_estado_documento INT,
    id_vendedor INT,
    fecha_venta DATE,
    total_venta INT,
    FOREIGN KEY (id_documento) REFERENCES documentos(id_documento),
    FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal),
    FOREIGN KEY (id_estado_documento) REFERENCES estado_documentos(id_estado_documento),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor)
);
