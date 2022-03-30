/*
 * Mostrar el nombre y apellidos de todos los afiliados que 
 * tengan una licencia que empieza por A.
*/
SELECT a.NOMBRE , a.APELLIDOS 
FROM AFILIADOS a , PERMISOS p 
WHERE a.FICHA = p.FICHA 
AND p.LICENCIA LIKE 'A%';

/*
 * 2 Mostrar los nombres de los peces que se han capturado en 
 * los eventos celebrados durante el año de 1998 indicando el 
 * nombre de la comunidad en la que se celebraron junto con el 
 * nombre y apellido del afiliado que lo capturó. La información 
 * debe aparecer ordenada por comunidad, luego por peces y por
 * último por apellido del afiliado.
 */

SELECT DISTINCT c.PEZ , l.COMUNIDAD , a.NOMBRE , a.APELLIDOS 
FROM CAPTURASEVENTOS c ,EVENTOS e, LUGARES l , AFILIADOS a 
WHERE c.FICHA = a.FICHA 
AND c.EVENTO = e.EVENTO 
AND e.LUGAR = l.LUGAR 
AND  EXTRACT (YEAR FROM e.FECHA_EVENTO)=1998;

/*
 * 3 Mostrar los eventos, el lugar y los cauces en los que se 
 * han celebrado eventos internacionales (el nombre del evento 
 * contiene la palabra internacional en mayúsculas o minúsculas). 
 * Hay que hacer esta sentencia con JOIN.
 */
SELECT e.EVENTO , e.LUGAR , l.CAUCE 
FROM EVENTOS e , LUGARES l 
WHERE e.LUGAR = l.LUGAR 
AND LOWER(e.EVENTO) like'%internacional%'; 

/*
 * 4 Para cada uno de los peces que ha sido pescado por un afiliado 
 * en solitario, mostrar el nombre del pez, la talla, la fecha de 
 * pesca y la hora de la pesca, mostrando los datos ordenador por 
 * peces y luego los más grandes.
 */
SELECT  DISTINCT c.PEZ ,c.TALLA ,c.FECHA_PESCA  ,c.HORA_PESCA 
FROM CAPTURASSOLOS c 
ORDER BY c.PEZ , c.TALLA DESC;

/*
 * 5 Mostrar todos los cauces en los que alguna vez algún afiliado 
 * ha pescado alguna vez un pez en solitario, siempre que el la 
 * relación talla/peso sea mayor que 3.
 */

SELECT DISTINCT l.CAUCE 
FROM CAPTURASSOLOS c , LUGARES l 
WHERE c.LUGAR = l.LUGAR 
AND c.TALLA /c.PESO >3;

/*
 * 6 Mostrar el nombre y el apellido de los afiliados que han 
 * pescado algún pez en un evento y que en el campo de 
 * observaciones esté recogido que su hábitat es ríos.
 */
SELECT DISTINCT a.NOMBRE , a.APELLIDOS 
FROM PECES p , CAPTURASEVENTOS c , AFILIADOS a 
WHERE p.PEZ = c.PEZ 
AND c.FICHA = a.FICHA 
AND LOWER(p.OBSERVACIONES)LIKE '%rio%';

/*
 * 7 Mostrar el nombre y el apellido del afiliado o afiliados 
 * que ha sido el primer avalador del afiliado con código 1000. 
 */
SELECT DISTINCT a.NOMBRE , a.APELLIDOS 
FROM CAPTURASSOLOS c , AFILIADOS a , AFILIADOS a2 
WHERE c.AVAL1 = a.FICHA 
AND a2.FICHA ='1000';

/*
 * 8 Mostrar los eventos que se han celebrado en un lugar en 
 * el que el campo de observaciones no tiene valor.
 */
SELECT e.EVENTO 
FROM EVENTOS e , LUGARES l 
WHERE e.LUGAR = l.LUGAR 
AND l.OBSERVACIONES IS NULL;

/*
 * 9 Muestra el nombre y apellidos de todos las parejas de
 * avales que existen en la base de datos. Es decir, debes 
 * mostrar el nombre y apellido del primer aval y el nombre y 
 * apellido del segundo aval.
 */
SELECT DISTINCT a.NOMBRE ||' '||a.APELLIDOS AS aval1, a2.NOMBRE ||' '||a2.APELLIDOS AS aval2
FROM AFILIADOS a , CAPTURASSOLOS c , AFILIADOS a2 
WHERE a.FICHA = c.AVAL1 
AND c.AVAL2 = a2.FICHA ;

/*
 * 10 Mostrar el nombre y apellido del afiliado o afiliados que 
 * han quedado en algunas de las cuatro primeras posiciones en 
 * algún evento o que participado en algún evento celebrado en 
 * el Coto De Dilar  o en el Coto De Fardes. (hay que hacer 
 * esta consulta sin utilizar JOIN)
 */


SELECT DISTINCT a.NOMBRE , a.APELLIDOS 
FROM AFILIADOS a , PARTICIPACIONES p , EVENTOS e 
WHERE p.FICHA  = a.FICHA 
AND p.EVENTO = e.EVENTO 
AND e.EVENTO = p.EVENTO 
AND (p.POSICION <=4)
OR LOWER(e.LUGAR)LIKE 'coto de dilar' 
OR LOWER(e.LUGAR)LIKE 'coto de fardes';

SELECT DISTINCT a.NOMBRE , a.APELLIDOS 
FROM AFILIADOS a 
WHERE a.FICHA in (
				SELECT p.FICHA 
				FROM PARTICIPACIONES p 
				WHERE p.POSICION <=4
				or p.EVENTO in(
								SELECT e.EVENTO 
								FROM EVENTOS e 
								WHERE LOWER(e.LUGAR)LIKE 'coto de dilar'
								OR LOWER(e.LUGAR)LIKE 'coto de fardes'
								)
								
				);

























