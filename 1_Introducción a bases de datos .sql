
Introduccion a bases de datos 

-----Crea una tabla llamada clientes, con una columna llamada email de tipo varchar(50),
una columna llamada nombre de tipo varchar sin limitación, una columna llamada
teléfono de tipo varchar(16), un campo llamado empresa de tipo varchar(50) y una
columna de tipo smallint, para indicar la prioridad del cliente. Ahí se debe ingresar un
valor entre 1 y 10, donde 10 es más prioritario.

----No hay que limitar el valor de la columna de prioridad, como tipo de dato se
recomienda ocupar smallint

create table cliente (
email varchar ( 50),
nombre Varchar ,
telefono varchar (16),
empresa varchar (50),
prioridad smallint);

select*from cliente

insert into cliente ( email, nombre, telefono, empresa, prioridad)
values ('andres@gmail.com', 'andres', 937465, 'wom', 10  );

insert into cliente ( email, nombre, telefono, empresa, prioridad)
values ('ignacio@gmail.com', 'ignacio', 224356 , 'vtr', 5  );

insert into cliente ( email, nombre, telefono, empresa, prioridad)
values ('matias@gmail.com', 'matias', 374925 , 'entel', 8  );

insert into cliente ( email, nombre, telefono, empresa, prioridad)
values ('camila@gmail.com', 'camila', 946284 , 'claro', 3  );

insert into cliente ( email, nombre, telefono, empresa, prioridad)
values ('felipe@gmail.com', 'felipe', 637480, 'movistar', 1  );

select*from cliente
order by prioridad desc 
limit 3 ;

Select*from cliente
where empresa = 'vtr'or empresa = 'entel';