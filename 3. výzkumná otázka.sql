

SELECT DISTINCT 
	tzvpspf.name , tzvpspf.year, tzvpspf2.year AS previous_year,
	tzvpspf.average_price_per_year ,
	tzvpspf2.average_price_per_year AS average_price_per_previous_year,
	ROUND (( tzvpspf.average_price_per_year - tzvpspf2.average_price_per_year) / tzvpspf2.average_price_per_year * 100, 2) AS price_growth_percent
FROM t_Zuzana_Vseteckova_project_SQL_primary_final tzvpspf
JOIN t_Zuzana_Vseteckova_project_SQL_primary_final tzvpspf2 
	ON tzvpspf.name = tzvpspf2.name 
	AND tzvpspf.year = tzvpspf2.year + 1
	AND tzvpspf2.year < 2018
WHERE tzvpspf.year IS NOT NULL
ORDER BY tzvpspf.name, tzvpspf.year;













