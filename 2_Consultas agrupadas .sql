Consultas agrupadas 

Utilizando el siguiente set de datos:


Select*from inscritos


CREATE TABLE IF NOT EXISTS INSCRITOS(cantidad INT, fecha DATE, fuente
VARCHAR);
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 44, '01/01/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 56, '01/01/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 39, '01/02/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 81, '01/02/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '01/03/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 91, '01/03/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 48, '01/04/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 45, '01/04/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 55, '01/05/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 33, '01/05/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 18, '01/06/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '01/06/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 34, '01/07/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 24, '01/07/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 83, '01/08/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 99, '01/08/2021', 'Página' );


1--- ¿Cuántos registros hay?

Select count (*) from inscritos 

Select fecha ,
sum (cantidad)
from inscritos 
group by fecha  ;

2---¿Cuántos inscritos hay en total?

Select count (fuente)
from inscritos ;

Select sum (cantidad) 
from inscritos ;

3--- ¿Cuál o cuáles son los registros de mayor antigüedad?

SELECT fuente, SUM(cantidad) AS suma_total
FROM inscritos
GROUP BY fuente
ORDER BY suma_total;

4--- ¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de
     ahora en adelante)

Select fecha , 
sum (cantidad) 
from inscritos 
group by fecha 
order by (fecha) 
asc ; 


6--- ¿Qué día se inscribió la mayor cantidad de personas? ¿Cuántas personas se
    inscribieron en ese día?

SELECT fecha, 
SUM(cantidad) 
AS suma_total
FROM inscritos
GROUP BY fecha
HAVING SUM(cantidad) = (SELECT MAX(cant_mayor) FROM (SELECT SUM(cantidad) AS cant_mayor FROM inscritos GROUP BY fecha) AS subquery)
ORDER BY suma_total DESC
LIMIT 1;

7--- ¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog? ¿Cuántas
     personas fueron?

Select fecha, cantidad, fuente 
from inscritos
where fuente = 'Blog'
group by fecha, cantidad, fuente
order by cantidad desc
limit 1;

8--- ¿Cuál es el promedio de personas inscritas por día?

select avg(cantidad) as promedio_total
from (
select fecha, sum(cantidad) as cantidad
from inscritos
group by fecha
)as subconsulta;

9--- ¿Qué días se inscribieron más de 50 personas?

select fecha, sum(cantidad) as inscritos_dia
from inscritos
group by fecha
having sum(cantidad) > 50;

10--- ¿Cuál es el promedio general de personas inscritas a partir del tercer día?

select avg(cantidad) as Promedio_G.
from 
(select fecha, sum(cantidad) as cantidad
from inscritos
where fecha >= '01/03/2021'
group by fecha)
as subconsulta;