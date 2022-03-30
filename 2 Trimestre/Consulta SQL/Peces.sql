
/*
 * 1 Nombre, apellido y teléfono de todos 
 * los afiliados que sean hombres y que 
 * hayan nacido antes del 1 de enero de 
 * 1070
 */
SELECT a.NOMBRE , a.APELLIDOS , a.TELF 
FROM AFILIADOS a 
WHERE a.NACIMIENTO  < to_date('01-01-1070','DD-MM-YYYY');

/*
 * 2 Peso, talla  y nombre de todos los 
 * peces que se han pescado por con talla 
 * inferior o igual a 45. Los datos deben 
 * salir ordenados por el nombre del pez, 
 * y para el mismo pez por el peso 
 * (primero los más grandes) y para el 
 * mismo peso por la talla (primero los 
 * más grandes).
 */
SELECT DISTINCT PESO ,TALLA ,PEZ 
FROM CAPTURASEVENTOS 
WHERE TALLA <= 45
UNION 
SELECT DISTINCT PESO ,TALLA ,PEZ 
FROM CAPTURASEVENTOS 
WHERE TALLA <= 45
ORDER BY PEZ , PESO desc, TALLA DESC;

/*
 * 3 Obtener los nombres y apellidos de los afiliados que o bien 
 * tienen la licencia de pesca que comienzan con una A 
 * (mayúscula o minúscula), o bien el teléfono empieza en 9 y 
 * la dirección comienza en Avda.
 */

SELECT DISTINCT  a.NOMBRE , a.APELLIDOS 
FROM AFILIADOS a , PERMISOS p 
WHERE a.FICHA = p.FICHA 
AND UPPER(p.LICENCIA) LIKE 'A%'
OR (a.TELF  like'9%' AND a.DIRECCION LIKE 'Avda.%');

/*
 * 4 Lugares del cauce “Rio Genil” que en el campo de 
 * observaciones no tengan valor.
 */

SELECT l.LUGAR 
FROM CAUCES c , LUGARES l 
WHERE c.CAUCE = l.CAUCE 
AND LOWER( c.CAUCE) LIKE 'rio genil'
AND c.OBSERVACIONES IS NULL;

/*
 * 5 Mostrar el nombre y apellidos de cada afiliado, junto con 
 * la ficha de los afiliados que lo han avalado alguna vez 
 * como primer avalador.
 */

SELECT DISTINCT  a.NOMBRE ||' '|| a.APELLIDOS AS afiliado, a2.FICHA AS aval1 , a3.FICHA AS aval2 
FROM AFILIADOS a ,CAPTURASSOLOS c, AFILIADOS a2  ,AFILIADOS a3 
WHERE a.FICHA =c.FICHA 
AND a2.FICHA = c.AVAL1 
AND a3.FICHA = c.AVAL2 

/*
 * 6 Obtén los cauces y en qué lugar de ellos han encontrado
 *	tencas (tipo de pez) cuando nuestros afiliados han ido a 
 *pescar solos, indicando la comunidad a la que pertenece 
 *dicho lugar. (no deben salir valores repetidos)
 */


SELECT DISTINCT l.CAUCE , l.COMUNIDAD 
FROM LUGARES l , CAPTURASSOLOS c 
WHERE l.LUGAR = c.LUGAR 
AND LOWER(c.PEZ) LIKE 'tenca';

/*
 * 7 Mostrar el nombre y apellido de los afiliados que han 
 * conseguido alguna copa. Los datos deben salir ordenador por 
 * la fecha del evento, mostrando primero los eventos más 
 * antiguos.
 */

SELECT DISTINCT a.NOMBRE , a.APELLIDOS 
FROM AFILIADOS a , PARTICIPACIONES p , EVENTOS e 
WHERE a.FICHA = p.FICHA 
AND p.EVENTO = e.EVENTO 
AND p.TROFEO IS NOT NULL
ORDER BY e.FECHA_EVENTO ;

/*
 * 8 
 */

SELECT a.FICHA , a.NOMBRE , a.APELLIDOS , p.POSICION , nvl(p.TROFEO, 'nada') 
FROM  PARTICIPACIONES p , AFILIADOS a 
WHERE p.FICHA = a.FICHA 
AND LOWER(p.EVENTO) LIKE 'super barbo' 
ORDER BY p.POSICION ;

/*
 * 9 Mostrar el nombre y apellidos de cada afiliado, junto con 
 * el nombre y apellidos de los afiliados que lo han avalado 
 * alguna vez como segundo avalador.
 */

SELECT DISTINCT  a.NOMBRE ||' '||a.APELLIDOS AS afiliado ,a2.NOMBRE ||' '||a2.APELLIDOS AS aval2
FROM AFILIADOS a , CAPTURASSOLOS c , AFILIADOS a2 
WHERE a.FICHA = c.FICHA 
AND c.AVAL2 = a2.FICHA ;

/*
 * 10 Indica todos los eventos en los que participó el afiliado 
 * 3796 en 1995 que no consiguió trofeo, ordenados 
 * descendentemente por fecha.
 */

SELECT e.EVENTO 
FROM EVENTOS e , PARTICIPACIONES p 
WHERE e.EVENTO = p.EVENTO 
AND p.FICHA like'3796'
AND p.TROFEO IS NULL
AND EXTRACT(YEAR FROM e.FECHA_EVENTO)=1995
ORDER BY e.FECHA_EVENTO desc;





