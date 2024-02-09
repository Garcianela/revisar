DROP DATABASE IF EXISTS mi_basededatos;
CREATE DATABASE mi_basededatos;

USE mi_basededatos;

SELECT *
FROM censo c
JOIN covid19 cv ON c.State = cv.State
JOIN sin_seguro_t sst ON c.State = sst.`State Name`;


-- Consulta 1: Mostrar los estados con la mayor oportunidad de venta de seguros (Esta consulta te mostrará los cinco estados 
-- con la mayor oportunidad de venta de seguros, calculada como la proporción de población que no tiene seguro)
SELECT c.state,
       (c.`Total population` - sst.`Uninsured Population (Excluding Undocumented)`) / c.`Total population` AS Insurance_Opportunity
FROM censo c
JOIN sin_seguro_t sst ON c.state = sst.`State Name`
ORDER BY Insurance_Opportunity DESC
LIMIT 5;


-- Los estados con menor impacto por covid
SELECT c19.state,
       c19.`Observed Number` / c.`Total population` AS COVID_Impact
FROM covid19 c19
JOIN censo c ON c19.state = c.state
ORDER BY COVID_Impact ASC
LIMIT 5;

