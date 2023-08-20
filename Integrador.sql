-- INTEGRADOR BACKEND EGG (NBA)--

select * from nba.equipos;
select * from nba.estadisticas;
select * from nba.partidos;
select * from nba.jugadores;

/*Teniendo el máximo de asistencias por partido, muestre cuantas veces se logró dicho máximo.
CANDADO A: -------------------------------------------------------------------------------------- */
select count(Asistencias_por_partido) asistencias, Asistencias_por_partido
from estadisticas group by Asistencias_por_partido
order by Asistencias_por_partido desc
limit 1;
 -- EL RESULTADO ES 2--
 
 /*Muestre la suma total del peso de los jugadores, donde la conferencia sea Este y la posición sea
centro o esté comprendida en otras posiciones.*/
select sum(b.peso) as pesoTotal from jugadores b inner join equipos a on b.Nombre_equipo = a.Nombre
where a.Conferencia like "%east%" and (b.Posicion like "%c%");
-- EL RESULTADO ES 14043 --------------------------------------------------------------------

-- CANDADO B-----------------------------------------------------------------------------------: 
/*Muestre la cantidad de jugadores que poseen más asistencias por partidos, que el numero de
jugadores que tiene el equipo Heat.*/
select count(b.codigo) as cantJugadores
from estadisticas a
inner join jugadores b
on a.jugador = b.codigo
where a.Asistencias_por_partido > (
select count(b.codigo)
from jugadores x
where x.Nombre_equipo like "%heat%");
-- EL RESULTADO ES 3

-- La clave será igual al conteo de partidos jugados durante las temporadas del año 1999.
select count(temporada)
from partidos
where temporada like "%99%";
-- El resultado es 3480 --------------------------------------------------------------------------------------

-- CANDADO C------------------------------------------------------------------------------------------: 
-- La posición del código será igual a la cantidad de jugadores que proceden de Michigan y forman
-- parte de equipos de la conferencia oeste.
/*Al resultado obtenido lo dividiremos por la cantidad de jugadores cuyo peso es mayor o igual a
195, y a eso le vamos a sumar 0.9945.*/

select round(count(codigo) / (select count(codigo)
from jugadores 
where peso >= 195) + 0.9945) cuenta
from jugadores a
inner join equipos b on a.Nombre_equipo = b.Nombre
where a.Procedencia like "%Michigan%"
and b.Conferencia like "%East%";
-- EL RESULTADO ES 1

/*Para obtener el siguiente código deberás redondear hacia abajo el resultado que se devuelve de
sumar: el promedio de puntos por partido, el conteo de asistencias por partido, y la suma de
tapones por partido. Además, este resultado debe ser, donde la división sea central.*/

select round( avg(c.Puntos_por_partido) + count(c.Asistencias_por_partido) + sum(c.Tapones_por_partido))
from jugadores a 
inner join equipos b on a.Nombre_equipo = b.Nombre
inner join estadisticas c on a.codigo = c.jugador
where b.Division like "%Central%";
-- El resultado es 631 ----------------------------------------------------------------------------------

-- Muestre los tapones por partido del jugador Corey Maggette durante la temporada 00/01. Este
-- resultado debe ser redondeado. Nota: el resultado debe estar redondeado
select round(Tapones_por_partido)
from jugadores a 
inner join estadisticas b on a.codigo = b.jugador
where a.Nombre like "Corey Maggette" and b.temporada like "00/01" ;
-- El resultado es 4

-- Para obtener el siguiente código deberás redondear hacia abajo, la suma de puntos por partido
-- de todos los jugadores de procedencia argentina.

select round(sum(b.Puntos_por_partido))
from jugadores a
inner join estadisticas b on a.codigo = b.jugador
where a.Procedencia like "%arg%";
-- El resultado es 191




