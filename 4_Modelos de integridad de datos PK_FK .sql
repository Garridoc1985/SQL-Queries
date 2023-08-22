
Modelos de integridad de datos Primary key _ Foreign key 


1----Revisa el tipo de relación y crea el modelo correspondiente. Respeta las claves
----primarias, foráneas y tipos de datos

Create table peliculas 
( ID INT, 
 NOMBRE VARCHAR ( 255) ,
 ANO INT,
 Primary key (id));

Create table TAGS 
( ID INT, 
 TAG VARCHAR (32) ,
 Primary key (id));
 
 Create table PELICULAS_TAGS ( peliculas_id INT,tags_id int,
 foreign key ( peliculas_id ) references  peliculas ( id),
 foreign key ( tags_id) references tags ( id));
 
 select *from peliculas_tags

2---Inserta 5 películas y 5 tags; la primera película debe tener 3 tags asociados, la
---segunda película debe tener 2 tags asociados


Insert into peliculas (ID,nombre, ano)
Values ('1','panico y locura en las vegas', '1985'),
		('2','carretera perdida','1990'), 
		('3','in_to the wild', '2000') ,
		('4','Matrix','1997') ,
		('5','jhonny cien pesos','1980');
		
INSERT INTO Tags (id ,tag )
VALUES   ('1',' terror '), 
		 ('2',' drama '), 
		 ('3',' accion '),
		 ('4',' ciencia ficcion'),
		 ('5',' suspenso');

INSERT INTO peliculas_tags (peliculas_id , tags_id)
Values ( 1,1), ( 1,2), (1,3),(2,4),(2,5);		 
		 	
SELECT*FROM peliculas_tags
			
3---Cuenta la cantidad de tags que tiene cada película. Si una película no tiene tags debe
---mostrar 0.		
	
	
select peliculas.nombre, count (peliculas_tags.peliculas_id) as numero_tags  
from  peliculas 
left join peliculas_tags on peliculas.id = peliculas_tags.peliculas_id
group by peliculas.nombre;
		
4---Crea las tablas correspondientes respetando los nombres, tipos, claves primarias y
---foráneas y tipos de datos


 
 CREATE TABLE preguntas
(ID INT,
  pregunta VARCHAR(255),
  respuesta_correcta VARCHAR,
  PRIMARY KEY (ID) );

CREATE TABLE usuarios
(ID INT,
  nombre VARCHAR(255),
  edad INT,
  PRIMARY KEY (ID));

 
CREATE TABLE respuestas (
id int ,
respuesta varchar(255),
usuario_id int,
pregunta_id int,
FOREIGN KEY (usuario_id) REFERENCES usuarios (id),
FOREIGN KEY (pregunta_id) REFERENCES preguntas (id),
primary key (id)
);

select * from respuestas
	
5--- Agrega 5 usuarios y 5 preguntas.
--- a. La primera pregunta debe estar respondida correctamente dos veces, por dos
---usuarios diferentes.
---b. La segunda pregunta debe estar contestada correctamente solo por un
---usuario.
---c. Las otras dos preguntas deben tener respuestas incorrectas
		
Insert into usuarios (id,nombre,edad)
Values  ('1','hernan','30'),
		('2','santiago','20'), 
		('3','ana','49') ,
		('4','ignacio','38') ,
		('5','javiera','37');		
		
Insert into preguntas (id,pregunta,respuesta_correcta) 
Values  ('1','color del cielo','azul'),
		('2','color del cielo','azul'), 
		('3','cumbre mas alta RM ','cerro el plomo') ,
		('4','presidente de chile','gabriel boric') ,
		('5','numero 1 del mundo en tenis chileno','marcelo rios');
	
		
Insert into respuestas (id,respuesta,usuario_id,pregunta_id)
Values  ('1','azul','1','1'),
		('2','azul','2','1'), 
		('3','cerro el plomo' ,'3','3') ,
		('4','alberto plaza','4','4') ,
		('5','carcuro','5','5');		
		
	select *from respuestas
6---Cuenta la cantidad de respuestas correctas totales por usuario (independiente de la
---pregunta).

Select respuestas.usuario_id,
count (respuestas.respuesta) filter (where preguntas.respuesta_correcta = respuestas.respuesta ) 
as Total_correctas 
from respuestas 
join preguntas on preguntas.id = respuestas.pregunta_id 
group by respuestas.usuario_id order by respuestas.usuario_id asc;


7---Por cada pregunta, en la tabla preguntas, cuenta cuántos usuarios respondieron
---correctamente.


SELECT preguntas.id as pregunta_id, 
COUNT(respuestas.usuario_id) FILTER (WHERE preguntas.respuesta_correcta = respuestas.respuesta) 
as Total_correctas 
FROM preguntas 
JOIN respuestas ON preguntas.id = respuestas.pregunta_id 
GROUP BY preguntas.id 
ORDER BY preguntas.id ASC;

8---Implementa un borrado en cascada de las respuestas al borrar un usuario. Prueba la
---implementación borrando el primer usuario.

drop table if exists respuestas ;

create table respuestas
(id int,
 respuesta varchar(255),
 usuario_id int ,
pregunta_id int,  
foreign key ( usuario_id)references usuarios ( id) on delete cascade,
foreign key (pregunta_id)references preguntas ( id));


DELETE FROM usuarios WHERE id = 1


select * from usuarios
select*from respuestas
9---Crea una restricción que impida insertar usuarios menores de 18 años en la base de
---datos.



ALTER TABLE usuarios
ADD CONSTRAINT check_edad CHECK (edad >= 18);

select * from usuarios

10---Altera la tabla existente de usuarios agregando el campo email. Debe tener la
---restricción de ser único

ALTER TABLE usuarios
ADD COLUMN email varchar(255) UNIQUE;