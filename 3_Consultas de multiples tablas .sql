
Consultas en Múltiples Tablas 

1--- Crea y agrega al entregable las consultas para completar el setup de acuerdo a lo
---pedido.

CREATE TABLE usuarios  
(ID SERIAL,
 email varchar (100),
 Nombre VARCHAR(100),
 Apellido VARCHAR(50),
Rol varchar(50));	
	
insert into usuarios ( email, Nombre, Apellido, Rol ) values ('diego@gmail.com','diego', 'undurraga ', 'administrador');	
insert into usuarios ( email, Nombre, Apellido, Rol ) values ( 'rodrigo@gmail.com', 'rodrigo', 'garrido ', 'usuario');	
insert into usuarios ( email, Nombre, Apellido, Rol ) values ( 'gaston@gmail.com' ,'gaston', 'mayor ', 'usuario');	
insert into usuarios ( email, Nombre, Apellido, Rol ) values ( 'ana@gmail.com','ana', 'edwards ', 'usuario');	
insert into usuarios ( email, Nombre, Apellido, Rol ) values ( 'alberto@gmail.com','alberto', 'palmero ', null);	
	



 
CREATE TABLE Posts 
(Id SERIAL,
Titulo VARCHAR(100),
Contenido TEXT,
Fecha_creacion TIMESTAMP,
Fecha_actualizacion TIMESTAMP,
Destacado BOOLEAN,
Usuario_ID BIGINT ); 
	
INSERT INTO Posts (titulo, contenido, fecha_creacion, Fecha_actualizacion, destacado, usuario_id)
VALUES ('Ultimos dias', 'cyber day', '2023-06-12 10:20', '2023-06-13 09:38', '0', 1);

INSERT INTO Posts (titulo, contenido, fecha_creacion, Fecha_actualizacion, destacado, usuario_id)
VALUES ('Gana refiriendo', 'Referidos', '2023-06-14 09:46', '2023-06-15 11:36', '1', 1);

INSERT INTO Posts (titulo, contenido, fecha_creacion, Fecha_actualizacion, destacado, usuario_id)
VALUES ('Cliente prime', 'Prime', '2023-06-16 10:43', '2023-06-17 16:15', '0', 2);

INSERT INTO Posts (titulo, contenido, fecha_creacion, Fecha_actualizacion, destacado, usuario_id)
VALUES ('Galgo express', 'compra express', '2023-06-18 16:15', '2023-06-19 16:00', '1', 3);

INSERT INTO Posts (titulo, contenido, fecha_creacion, Fecha_actualizacion, destacado, usuario_id)
VALUES ('Regala una moto', 'dia del padre', '2023-06-20 20:15', '2023-06-21 17:15','0', null );
	



Select *  from usuarios
Select *  from Posts 
Select *  from Comentarios

 CREATE TABLE Comentarios  
 (Id SERIAL,
    Contenido TEXT,
    Fecha_creacion TIMESTAMP,
    Usuario_id bigint ,
    Post_ID bigint );

INSERT INTO comentarios ( contenido, fecha_creacion, Usuario_id, Post_id) 
VALUES ( 'las mejores ofertas ', '2023-06-12 10:20', 1, 1),
( ' que barato el auto', '2023-06-14 09:46', 1,1),
( 'que economica la moto', '2023-06-16 10:43', 2, 1),
('muy rapida la compra ', '2023-06-18 16:15', 2, 4),
( 'buenos productos prime', '2023-06-20 20:15',null, 2 );

2----Cruza los datos de la tabla usuarios y posts mostrando las siguientes columnas.
----nombre e email del usuario junto al título y contenido del post.

SELECT usuarios.nombre, usuarios.email, posts.titulo, posts.contenido
FROM usuarios
INNER JOIN posts ON usuarios.id = posts.usuario_id


3--Muestra el id, título y contenido de los posts de los administradores. El
---administrador puede ser cualquier id.

SELECT posts.id, posts.titulo, posts.contenido
FROM posts
INNER JOIN usuarios ON posts.usuario_id = usuarios.id
WHERE usuarios.rol = 'administrador';	
	
4---Cuenta la cantidad de posts de cada usuario. La tabla resultante debe mostrar el id
---e email del usuario junto con la cantidad de posts de cada usuario.



SELECT usuarios.id, usuarios.email, COUNT(posts.usuario_id) AS cantidad_posts
FROM usuarios
INNER JOIN posts ON posts.usuario_id = usuarios.id
GROUP BY usuarios.id, usuarios.email;

5---Muestra el email del usuario que ha creado más posts. Aquí la tabla resultante tiene
---un único registro y muestra solo el email

SELECT usuarios.id, usuarios.email, COUNT(posts.usuario_id) AS cantidad_posts
FROM usuarios
INNER JOIN posts ON posts.usuario_id = usuarios.id
GROUP BY usuarios.id, usuarios.email
order by  COUNT(posts.usuario_id) desc ; 

6---Muestra la fecha del último post de cada usuario

SELECT usuarios.id, usuarios.email, MAX(posts.fecha_actualizacion) AS ultima_fecha_post
FROM usuarios
LEFT JOIN posts ON usuarios.id = posts.usuario_id
GROUP BY usuarios.id, usuarios.email;

7---Muestra el titulo y contenido del post (artículo) con más comentarios


SELECT p.titulo, p.contenido
FROM posts p
 inner JOIN (
    SELECT c.post_id, COUNT(c.post_id) AS cantidad_comentarios
    FROM comentarios c
    GROUP BY c.post_id
    ORDER BY COUNT(c.post_id) desc
    LIMIT 1) AS subquery ON p.id = subquery.post_id; 
	
8---Muestra en una tabla el título de cada post, el contenido de cada post y el contenido
---de cada comentario asociado a los posts mostrados, junto con el email del usuario
---que lo escribió

SELECT posts.titulo, posts.contenido, comentarios.contenido AS contenido_comentario, usuarios.email
FROM posts
LEFT JOIN comentarios ON posts.id = comentarios.post_id
LEFT JOIN usuarios ON comentarios.usuario_id = usuarios.id;

9---Muestra el contenido del último comentario de cada usuario

SELECT comentarios.usuario_id, comentarios.contenido
FROM comentarios 
INNER JOIN (
    SELECT usuario_id, MAX(fecha_creacion) AS ultimo_comentario_id
    FROM comentarios
    GROUP BY usuario_id
) AS subquery ON comentarios.fecha_creacion = subquery.ultimo_comentario_id;
    

10---Muestra los emails de los usuarios que no han escrito ningún comentario.

SELECT usuarios.email
FROM usuarios 
LEFT JOIN comentarios  ON usuarios.id = comentarios.usuario_id
WHERE comentarios.usuario_id IS NULL;