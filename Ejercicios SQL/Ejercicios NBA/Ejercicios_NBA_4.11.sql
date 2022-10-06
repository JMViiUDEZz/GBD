SELECT NOMBRE,CIUDAD FROM EQUIPOS WHERE NOMBRE IN (SELECT NOMBRE_EQUIPO FROM JUGADORES WHERE PROCEDENCIA='SPAIN')
SELECT DISTINCT E.NOMBRE,E.CIUDAD FROM EQUIPOS E INNER JOIN JUGADORES J ON E.`Nombre`=J.`Nombre_equipo` WHERE J.PROCEDENCIA='SPAIN'
SELECT NOMBRE FROM EQUIPOS WHERE NOMBRE LIKE 'H%S'
SELECT j.`Nombre`,AVG(e.Puntos_por_partido) FROM estadisticas e INNER JOIN jugadores j ON e.jugador=j.`codigo` WHERE j.`Nombre`='Pau Gasol'
SELECT * FROM equipos WHERE Conferencia='west'
SELECT COUNT(*) FROM equipos WHERE Conferencia='west'
SELECT * FROM JUGADORES WHERE PROCEDENCIA='ARIZONA' AND PESO>220 AND ALTURA>6
SELECT j.`Nombre`,AVG(e.Puntos_por_partido) FROM estadisticas e INNER JOIN jugadores j ON e.jugador=j.`codigo` WHERE J.`Nombre_equipo`='CAVALIERS'
SELECT NOMBRE FROM jugadores WHERE NOMBRE LIKE '__v%'
SELECT e.`Nombre`,COUNT(j.`codigo`) FROM equipos e INNER JOIN jugadores j ON e.`Nombre`=j.`Nombre_equipo` WHERE Conferencia='west' GROUP BY e.`Nombre`
SELECT COUNT(*) FROM jugadores WHERE Procedencia='argentina'
SELECT j.`Nombre`,MAX(e.Puntos_por_partido) FROM estadisticas e INNER JOIN jugadores j ON e.jugador=j.`codigo` WHERE j.`Nombre`='Lebron James'
SELECT j.`Nombre`,e.asistencias_por_partido FROM estadisticas e INNER JOIN jugadores j ON e.jugador=j.`codigo` WHERE j.`Nombre`='jose calderon' AND e.temporada='07/08'
SELECT j.`Nombre`,e.Puntos_por_partido FROM estadisticas e INNER JOIN jugadores j ON e.jugador=j.`codigo` WHERE j.`Nombre`='Lebron James' AND e.temporada BETWEEN '03/04' AND '05/06'
SELECT e.`Nombre`,COUNT(j.`codigo`) FROM equipos e INNER JOIN jugadores j ON e.`Nombre`=j.`Nombre_equipo` WHERE Conferencia='east' GROUP BY e.`Nombre`
SELECT j.`Nombre`,AVG(e.tapones_por_partido) FROM estadisticas e INNER JOIN jugadores j ON e.jugador=j.`codigo` WHERE J.`Nombre_equipo`='trail blazers' GROUP BY j.`codigo`,j.`Nombre`
SELECT j.`Nombre`,AVG(es.rebotes_por_partido) FROM estadisticas es INNER JOIN equipos eq INNER JOIN jugadores j ON eq.`Nombre`=j.`Nombre_equipo` ON es.`jugador`=j.`codigo` WHERE Conferencia='east' GROUP BY j.`codigo`,j.`Nombre`
SELECT e.Nombre,COUNT(j.codigo) FROM jugadores j INNER JOIN equipos e ON e.`Nombre`=j.`Nombre_equipo` WHERE Division='NorthWest' GROUP BY e.Nombre
SELECT Procedencia,COUNT(*) FROM jugadores WHERE Procedencia='spain' OR Procedencia='france' GROUP BY Procedencia
SELECT nombre_equipo,COUNT(*) FROM jugadores WHERE Posicion LIKE '%c%' GROUP BY Nombre_equipo
SELECT MAX(altura) FROM jugadores WHERE Posicion LIKE '%c%'
SELECT nombre,peso,peso*0,45 FROM jugadores WHERE Altura = (SELECT MAX(altura) FROM jugadores)
SELECT COUNT(*) FROM jugadores WHERE nombre LIKE 'y%'
select distinct * from jugadores where codigo in(select jugador from estadisticas where Puntos_por_partido=0)
SELECT division,COUNT(j.codigo) FROM jugadores j INNER JOIN equipos e ON j.`Nombre_equipo`=e.`Nombre`  GROUP BY division
SELECT AVG(peso) libras ,AVG(peso*0.45) kilos FROM jugadores WHERE Nombre_equipo='raptors'
SELECT CONCAT (nombre,'(',Nombre_equipo,')') FROM jugadores
Select * from jugadores order by nombre limit 10
SELECT j.`Nombre_equipo`,COUNT(j.codigo) "NUMERO DE BASES" FROM jugadores j INNER JOIN equipos e ON j.`Nombre_equipo`=e.`Nombre` WHERE e.`Conferencia`='EAST' AND j.`Posicion` LIKE '%g%' GROUP BY j.`Nombre_equipo`
SELECT conferencia,COUNT(*) FROM equipos GROUP BY Conferencia
SELECT distinct division FROM equipos WHERE Conferencia='east'
SELECT j.`Nombre` FROM jugadores j INNER JOIN estadisticas e ON j.`codigo`=e.`jugador` WHERE Nombre_equipo='suns' AND Rebotes_por_partido= (SELECT MAX(rebotes_por_partido) FROM jugadores j INNER JOIN estadisticas e ON j.`codigo`=e.`jugador` WHERE Nombre_equipo='suns')
SELECT j.`Nombre` FROM jugadores j INNER JOIN estadisticas e ON j.`codigo`=e.`jugador` WHERE puntos_por_partido= (SELECT MAX(puntos_por_partido) FROM jugadores j INNER JOIN estadisticas e ON j.`codigo`=e.`jugador`)
SELECT nombre,LENGTH(nombre) FROM jugadores WHERE Nombre_equipo='grizzlies'
SELECT MAX(LENGTH(nombre)+LENGTH(ciudad)) FROM equipos

