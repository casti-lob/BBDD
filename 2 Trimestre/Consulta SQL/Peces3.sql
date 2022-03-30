/*
 * 1 Nombre y teléfono de todos los afiliados 
 * que sean hombres.
*/
SELECT a.NOMBRE , a.TELF 
FROM AFILIADOS a 
WHERE a.SEXO ='H';

/*
 * Peso y talla de todos los peces que se han 
 * pescado por libre antes de las 10:00 de la 
 * mañana, con talla inferior o igual a 45.
 */
SELECT c.PESO , c.TALLA 
FROM CAPTURASSOLOS c 
WHERE EXTRACT (HOUR FROM c.HORA_PESCA)<10




































